require './lib/api_services_pb'

include Api

class ServerImpl < UserPosts::Service
  def initialize(db)
    @db = db
  end

  def get_post(obj, _call)
    post = @db.data.find { |post| post.first == obj.post_id }
    Api::Post.new(
      user: Api::User.new(
        username: post[5],
        first_name: post[6],
        last_name: post[7],
        email: post[8]
      ),
      title: post[1],
      text: post[2]
    )
  end

  def get_objects(limit, _call)
    DataEnum.new(@db.data[0..(limit.to_h[:limit] - 1)]).each
  end

  def get_best_post(call)
    ids = []
    call.each_remote_read { |obj| ids << obj.post_id }
    post = @db.data.find { |post| post.first == ids.max }
    Api::Post.new(
      user: Api::User.new(
        username: post[5],
        first_name: post[6],
        last_name: post[7],
        email: post[8]
      ),
      title: post[1],
      text: post[2]
    )
  end

  def get_objects_by_ids(notes)
    binding.pry
    notes.each do |note|
      binding.pry
      posts = @db.data.all { |post| post.first == note.post_id }
    end
    binding.pry
  end
end

class DataEnum
  def initialize(db)
    @db = db
  end

  def each
    return enum_for(:each) unless block_given?
    @db.each_entry do |id, title, text, user_id, user_table_id,
      username, first_name, last_name, email, bio, age|
      binding.pry
      yield Api::Post.new(
        user: Api::User.new(
          username: username,
          first_name: first_name,
          last_name: last_name,
          email: email
        ),
        title: title,
        text: text
      )
    end
  end
end