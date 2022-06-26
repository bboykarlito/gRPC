require 'rack/lobster'
require_relative '../environment/env'
require 'pry'
require './db/query'


class Posts
  def call(env)
    req = Rack::Request.new(env)
    data = PostsQuery.new
    limit = req.params["limit"].to_i - 1
    resp = data.data[0..limit].map do |id, title, text, user_id, user_table_id,
      username, first_name, last_name, email, bio, age|
      {
        username: username,
        first_name: first_name,
        last_name: last_name,
        email: email,
        title: title,
        text: text
      }
    end
    [
      '200',
      {'Content-Type' => 'application/json'},
      [resp.to_json]
    ]
  end
end

use Rack::CommonLogger
use Rack::ShowExceptions
run Posts.new