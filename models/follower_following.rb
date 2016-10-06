class Follower_followings > ActiveRecord::Base
  belongs_to :user
  belongs_to :followed_user
end
