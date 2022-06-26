require_relative '../environment/env'

class PostsQuery
  attr_accessor :data

  def initialize
  	query = "SELECT * FROM posts JOIN users ON users.id = posts.user_id;"
  	@data = CONN.exec(query).values
  end
end