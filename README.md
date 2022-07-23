# gRPC
gRPC investigate

* install gems:

$ bundle install

* Generate the gRPC client and server interfaces from .proto service definition
  using the protocol buffer compiler protoc with a special gRPC Ruby plugin:

(from /gRPC)
$ grpc_tools_ruby_protoc -I protos --ruby_out=ruby/lib --grpc_out=ruby/lib protos/api.proto

** Starting servers (from /ruby)

RPC API

* Start RPC server
  $ bundle exec ruby rpc/server/main.rb 
* Start RPC client
  $ bundle exec ruby rpc/client/config.rb

REST API

* Start web server
 $ rackup posts_rest/posts_server.ru
* Start REST client
 $ bundle exec ruby posts_rest/posts_client.rb
 
