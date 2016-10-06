require 'sinatra'
require 'sinatra/activerecord'
require './models/follower_following.rb'
require './models/hashtag.rb'
require './models/like.rb'
require './models/mention.rb'
require './models/notification.rb'
require './models/reply.rb'
require './models/tweet_hashtag.rb'
require './models/tweet.rb'
require './models/user.rb'


get '/' do
	erb :index
end
