this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'pry'
require 'grpc'
require 'posts_services_pb'
require 'benchmark'

include Posts

def print_data(resp, time)
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
  puts time
end

def main
  response = []
  Benchmark.bm do |op|
    op.report{
      stub = GetPosts::Stub.new('localhost:50051', :this_channel_is_insecure)
      request = Request.new(limit: 1200)
      response = stub.list_data(request)
    }
  end
  #print_data(response, time)
end

main