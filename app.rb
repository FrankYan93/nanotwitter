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


def create
  @user = User.new(params[:user])
  @user.password = params[:password]
  @user.save!
end

def redirect_to_original_request
  user = session[:user]
#  puts "Welcome back #{user.name}."
  original_request = session[:original_request]
  session[:original_request] = nil
  redirect original_request
end

get '/' do
	erb :index
end

get '/home' do
  erb :home
end

post '/signup' do
	username = params['username']
	user = User.find_by username: username
  @errorString=""
	unless user.nil?
		@errorString="Username existed!"
		puts @errorString
		erb :index
	else
		create
		redirect to('/home')
	end
end

get '/signin/?' do
  erb :signin
end

post '/signin/?' do
  if user = User.authenticate(params)
    session[:user] = user
    redirect '/home'
  else
#    puts 'You could not be signed in. Did you enter the correct username and password?'
    redirect '/signin'
  end
end

get '/signout' do
  session[:user] = nil
#  puts 'You have been signed out.'
  redirect '/'
end

get '/protected/?' do
  authenticate!
  erb :protected, locals: { title: 'Protected Page' }
end
