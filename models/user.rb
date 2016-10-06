class User < ActiveRecord::Base
  has_many :tweets
  has_many :followerfollowings
  has_many :followed_users, :through => :followerfollowings
  has_many :followings, :class_name => "Followerfollowing", :foreign_key => :followed_user_id
  has_many :followers, :through => :followings, :source => :user
  has_many :notifications
  has_many :likes
  has_many :mentions
end
