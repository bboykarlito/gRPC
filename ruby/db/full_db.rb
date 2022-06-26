require 'faker'
require_relative '../environment/env'
require 'pry'

1500.times do 
  query = "INSERT INTO users (username, first_name, last_name, email, bio, age) VALUES 
  	('#{Faker::Lorem.characters(number: 10)}', 
  	 '#{Faker::Name.first_name.gsub(/[']/, "\\'")}', 
  	 '#{Faker::Name.last_name.gsub(/[']/, "\\'")}',
  	 '#{Faker::Internet.email}',
  	 '#{Faker::Hobby.activity}',
  	 #{Faker::Number.number(digits: 2)});"
  CONN.exec(query).values
  query = "SELECT id FROM users ORDER BY id DESC LIMIT 1;"
  data = CONN.exec(query).values
  query = "INSERT INTO posts (title, text, user_id) VALUES
    ('#{Faker::Beer.name}',
     '#{Faker::Lorem.sentences(number: 2000).join(" ")}',
     #{data.first.first});"
  CONN.exec(query)
end