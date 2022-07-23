

require 'pry'
require 'grpc'
require './lib/api_services_pb'
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
  # response = []
  # Benchmark.bm do |op|
  #   op.report{
  #     stub = UserPosts::Stub.new('localhost:50051', :this_channel_is_insecure)
  #     request = Request.new(limit: 50)
  #     response = stub.get_posts(request)
  #   }
  # end
  
  stub = UserPosts::Stub.new('localhost:50051', :this_channel_is_insecure)

  limit = Request.new(limit: 50)
  post_id = PostId.new(post_id: 2676)

  posts_ids = [2676, 2677, 2678]
  posts_ids_enum = IdsSend.new(posts_ids)
  # binding.pry
  post_by_id = stub.get_post(post_id)
  best_post = stub.get_best_post(posts_ids_enum)
  binding.pry
  posts_by_ids = stub.get_objects(limit)
  # response = stub.get_posts(limit)
  #   pp response
  # end
  # t = Thread.new do
  #   op.execute
  # rescue GRPC::Cancelled => e
  #   puts "this will terminate with an exception when we hit cancel - #{e}"
  # end
  #print_data(response)
  binding.pry
  # print_data([response])
end

main