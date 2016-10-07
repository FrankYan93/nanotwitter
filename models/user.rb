require 'bcrypt'

class User < ActiveRecord::Base
  has_many :tweets
  has_many :followerfollowings
  has_many :followed_users, :through => :followerfollowings
  has_many :followings, :class_name => "Followerfollowing", :foreign_key => :followed_user_id
  has_many :followers, :through => :followings, :source => :user
  has_many :notifications
  has_many :likes
  has_many :mentions

  include BCrypt
  attr_reader :name
  attr_reader :last_signin


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def initialize(username)
    @name = username
  end

  def self.authenticate(config, params = {})
    return nil if params[:username].blank? || params[:password].blank?

    username = params[:username]
    user_record = User.find_by username: username
    return nil if user_record == nil

    password_hash = Password.new(user_record[:password])
    Userr.new(username) if password_hash == params[:password]
  end






end
