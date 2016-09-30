class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.date   :create_time
      t.integer :user_id
      t.boolean :is_forwarding
      t.integer :forward_id
      t.boolean :is_mentioning
      t.boolean :has_hashtag
      t.integer :like_numbers
      t.integer :forwarded_number
      t.integer :reply_number
    end
  end
end
