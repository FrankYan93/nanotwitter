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

Dir[File.dirname(__FILE__) + '/api/users/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/api/tweets/*.rb'].each {|file| require file }


enable :sessions
include BCrypt

def authenticate!
  if session[:user_id] == nil
    session[:original_request] = request.path_info
    redirect '/signin'
  end
end

def create
    newpassword = Password.create(params[:password])
    puts newpassword
    #  @user = User.new(params[:user])
    #  @user.password=params[:password]
    #  @user.save!
    username = params[:username]
    puts username
    #  user = User.new(username,newpassword)
    #  user.save
    user = User.new
    user.username = username
    user.password = newpassword
    user.follower_number=0
    user.followering_number=0
    user.nickname=""
    user.save
    session[:user_id] = user.id
    session[:username] = username
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
    authenticate!
    'Welcome Home!'
    erb :home
end

post '/signup' do
    username = params['username']
    user = User.find_by username: username
    @errorString = ''
    if user.nil?
        puts 'create user!'
        puts username
        puts params[:password]
        create
        redirect to('/home')
    else
        @errorString = 'Username existed!'
        puts @errorString
        erb :index
    end
end

get '/signin/?' do
    erb :signin
end

post '/signin/?' do
    current_user_id,current_username = User.authenticate(params)
    @errorMessage=''
    if current_user_id.nil?
        puts 'You could not be signed in. Did you enter the correct username and password?'
        @errorMessage = 'You could not be signed in. Did you enter the correct username and password?'
        erb :signin
    else
        session[:user_id] = current_user_id
        session[:username] = current_username
        puts current_user_id
        redirect '/home'
        redirect_to_original_request
    end
end

get '/signout/?' do
    session[:user_id] = nil
    #  puts 'You have been signed out.'
    redirect '/'
end

get '/protected/?' do
    authenticate!
    erb :protected, locals: { title: 'Protected Page' }
end
