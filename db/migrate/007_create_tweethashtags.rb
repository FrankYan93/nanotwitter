class CreateTweethashtags < ActiveRecord::Migration
  def change
    create_table :tweethashtags do |t|
      t.integer :tweet_id
      t.integer :hashtag_id
    end
  end
end
