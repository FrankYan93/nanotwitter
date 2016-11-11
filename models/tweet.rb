class Tweet < ActiveRecord::Base
    belongs_to :users
    has_many :replies
    has_many :hashtags, through: :tweethashtags
    has_many :likes
    has_many :mentions
    has_many :liked_user, through: :likes, source: :user
    has_many :replied_user, through: :replies, source: :user
end
