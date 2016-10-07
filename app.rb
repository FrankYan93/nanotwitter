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

enable :sessions
include BCrypt

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
    user.save
    session[:user_id] = user.id
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
    # Authentication.authenticate!
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
    current_user_id = User.authenticate(params)
    if current_user_id.nil?
        puts 'You could not be signed in. Did you enter the correct username and password?'
        @errorMessage = 'You could not be signed in. Did you enter the correct username and password?'
        redirect '/signin'
    else
        session[:user_id] = current_user_id
        puts current_user_id
        redirect '/home'
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
