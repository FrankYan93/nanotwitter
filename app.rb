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

use Rack::Auth::Basic do |username, password|
  username == 'admin' and password == 'admin'
end

get '/protected' do
  "You're welcome"
end



get '/' do
	erb :index
end
