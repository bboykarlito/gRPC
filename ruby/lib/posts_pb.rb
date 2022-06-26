# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: posts.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("posts.proto", :syntax => :proto3) do
    add_message "posts.Request" do
      optional :limit, :int32, 1
    end
    add_message "posts.Data" do
      optional :username, :string, 1
      optional :first_name, :string, 2
      optional :last_name, :string, 3
      optional :email, :string, 4
      optional :title, :string, 5
      optional :text, :string, 6
    end
  end
end

module Posts
  Request = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("posts.Request").msgclass
  Data = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("posts.Data").msgclass
end
