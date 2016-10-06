class Follower_following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followed_user
end
