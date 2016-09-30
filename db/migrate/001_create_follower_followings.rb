class CreateFollower_followings < ActiveRecord::Migration
  def change
    create_table :follower_followings do |t|
      t.integer :user_follower_id
      t.integer :user_following_id
      t.date    :follow_date
    end
  end
end
