require 'grpc'
require './lib/api_services_pb'

require_relative '../environment/env'
require './db/query'

require './rpc/server_impl'

include Api

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