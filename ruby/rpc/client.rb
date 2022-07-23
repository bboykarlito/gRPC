this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'pry'
require 'grpc'
require 'api_services_pb'
require 'benchmark'
require './rpc/ids_send'

include Api

def print_data(resp)
  resp.each do |v|
    p "--------------------"
    p v.first_name
    p v.last_name
    p v.email
    p v.username
    p v.title
    p v.text
  end
  p "=============================="
end

def main
  response = []
  # Benchmark.bm do |op|
  #   op.report{
  #     stub = UserPosts::Stub.new('localhost:50051', :this_channel_is_insecure)
  #     request = Request.new(limit: 1200)
  #     response = stub.get_posts(request)
  #   }
  # end
  
  stub = UserPosts::Stub.new('localhost:50051', :this_channel_is_insecure)

  limit = Request.new(limit: 1200)
  # post_id = PostId.new(post_id: 2676)
  # posts_ids = [2676, 2677, 2678]
  binding.pry
  # req = IdsSend.new(posts_ids)
  # binding.pry
  response = stub.get_posts(limit) { |post| post }
  binding.pry
  # print_data(response)
end

main