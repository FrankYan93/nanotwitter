class CreateFollower_followings < ActiveRecord::Migration
  def change
    create_table :follower_followings do |t|
      t.integer :user_id
      t.integer :followed_user_id
      t.date    :follow_date
    end
  end
end
