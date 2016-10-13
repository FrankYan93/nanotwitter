require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require './models/followerfollowing.rb'
require './models/hashtag.rb'
require './models/like.rb'
require './models/mention.rb'
require './models/notification.rb'
require './models/reply.rb'
require './models/tweethashtag.rb'
require './models/tweet.rb'
require './models/user.rb'
require './lib/authentication.rb'
require './api/test/status.rb'
require './api/test/reset.rb'


User.create(:username => 'Bobb').update_column(:id, 2)
bob = User.find_by username: 'Bobb'
puts bob[:id]
