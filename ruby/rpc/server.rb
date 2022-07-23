
this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'pry'
require_relative '../environment/env'
require 'api_services_pb'
require './db/query'

include Api

class DataEnum
  def initialize(db)
    @db = db
  end

  def each
  	binding.pry
    return enum_for(:each) unless block_given?
    @db.each_entry do |id, title, text, user_id, user_table_id,
      username, first_name, last_name, email, bio, age|

      yield Api::Post.new(
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

class ServerImpl < UserPosts::Service
  def initialize(db)
    @db = db
  end

  def get_post(post_id, _call)
    binding.pry
  end

  def get_posts(limit, _call)
    binding.pry
    DataEnum.new(@db.data[0..(limit.to_h[:limit] - 1)]).each
  end

  def get_best_post(call)
    binding.pry
  end

  def get_posts_by_ids(notes)

  end
end

def main
  db = PostsQuery.new
  port = 'localhost:50051'
  s = GRPC::RpcServer.new
  s.add_http2_port(port, :this_port_is_insecure)
  GRPC.logger.info("... running insecurely on #{port}")
  s.handle(ServerImpl.new(db))
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main