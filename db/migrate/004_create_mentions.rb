class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :tweet_id
      t.integer :user_mentioned_id
    end
  end
end
