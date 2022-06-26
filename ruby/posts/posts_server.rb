
this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'pry'
require_relative '../environment/env'
require 'posts_services_pb'
require './db/query'

include Posts

class DataEnum
  def initialize(feature_db)
    @feature_db = feature_db
  end

  def each
    return enum_for(:each) unless block_given?
    @feature_db.each_entry do |id, title, text, user_id, user_table_id,
      username, first_name, last_name, email, bio, age|

      yield Posts::Data.new(
        username: username,
        first_name: first_name,
        last_name: last_name,
        email: email,
        title: title,
        text: text
      )
    end
  end
end

class ServerImpl < GetPosts::Service
  def initialize(feature_db)
    @feature_db = feature_db
  end

  def list_data(limit, _call)
    DataEnum.new(@feature_db.data[0..(limit.to_h[:limit] - 1)]).each
  end
end

def main
  feature_db = PostsQuery.new
  port = 'localhost:50051'
  s = GRPC::RpcServer.new
  s.add_http2_port(port, :this_port_is_insecure)
  GRPC.logger.info("... running insecurely on #{port}")
  s.handle(ServerImpl.new(feature_db))
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main