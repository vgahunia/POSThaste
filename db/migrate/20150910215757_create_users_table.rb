class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_users_table
  	create_posts_table
  	create_friendships_table
  end

  def create_users_table
  	create_table :users do |t|
  		t.string :username
  		t.string :password
  		t.string :email
  	end
  end

  def create_posts_table
  	create_table :posts do |t|
  		t.string :title
  		t.string :post
      t.integer :user_id
  	end
  end

  def create_friendships_table
  	create_table :friendship do |t|
  		t.integer :user_id
  		t.integer :friend_id
    end
  end
end

