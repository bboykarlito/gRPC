# gRPC
gRPC investigate

* Generate the gRPC client and server interfaces from .proto service definition
  using the protocol buffer compiler protoc with a special gRPC Ruby plugin:

$ grpc_tools_ruby_protoc -I protos --ruby_out=ruby/lib --grpc_out=ruby/lib protos/users.proto

RPC API

* Start RPC server
  $ bundle exec ruby posts/posts_server.rb 
* Start RPC client
  $ bundle exec ruby posts/posts_client.rb

REST API

* Start web server
 $ rackup posts_rest/posts_server.ru
* Start REST client
 $ bundle exec ruby posts_rest/posts_client.rb
 
