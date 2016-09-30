class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string  :content
      t.string  :type
      t.integer :like_id
      t.integer :follower_id
      t.integer :reply_id
      t.boolean :read_mark
      t.date    :create_time
    end
  end
end
