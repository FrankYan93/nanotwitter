class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.date    :create_time
    end
  end
end
