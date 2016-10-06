class User < ActiveRecord::Base
  has_many :tweets
  has_many :follower_followings
  has_many :followed_users :through => :follower_followings
  has_many :followings, :class_name => "Follower_following", :foreign_key => :followed_user_id
  has_many :followers, :through => :followings, :source => :user
  has_many :notifications
  has_many :likes
  has_many :mentions
end
