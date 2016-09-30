class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :like
  belongs_to :reply
  belongs_to :follower_following 
end
