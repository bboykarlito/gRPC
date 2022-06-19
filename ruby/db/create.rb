require_relative '../environment/env'

create_users_table = <<SQL_BLOCK
CREATE TABLE IF NOT EXISTS users (
	id serial PRIMARY KEY,
	username text,
	first_name text,
	last_name text,
	email text,
	bio text,
	age int
);
SQL_BLOCK

create_posts_table = <<SQL_BLOCK
CREATE TABLE IF NOT EXISTS posts (
	id serial PRIMARY KEY,
	title text,
	text text,
	user_id int references users(id)
);
SQL_BLOCK

[create_users_table, create_posts_table].each do |sql|
	CONN.exec(sql)
end