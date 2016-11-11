require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require 'active_record'
require 'byebug'
require 'time'
require 'faker'

# require apis
Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/users/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/tweets/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/test/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/service/*.rb'].each { |file| require file }

configure :production do
    require 'newrelic_rpm'
end
enable :sessions

include BCrypt

def authenticate!
    if session[:user_id].nil?
        session[:original_request] = request.path_info
        redirect '/signin'
    end
end

def create
    newpassword = Password.create(params[:password])
    username = params[:username]
    user = User.new
    user.username = username
    user.password = newpassword
    user.follower_number = 0
    user.following_number = 0
    user.nickname = ''
    user.save
    session[:user_id] = user.id
    session[:username] = username
end

def redirect_to_original_request
    user = session[:user]
    original_request = session[:original_request]
    session[:original_request] = nil
    redirect original_request
end

get '/' do
    # @sessionUserId
    if session[:user_id].nil?
        not_log_in_home
    else
        log_in_home
    end
end

get '/home' do
    if session[:user_id].nil?
        not_log_in_home
    else
        # print User.not_follow_by(session[:user_id])[0][:username]
        log_in_home
    end
end

get '/signup' do
    erb :signUp
end

post '/signup' do
    username = params['username']
    user = User.find_by username: username
    @errorString = ''
    if user.nil?
        create
        redirect to('/home')
    else
        @errorString = ' ------ Username existed! Please try another name!'
        erb :signUp
    end
end

get '/signin/?' do
    erb :signin
end

post '/signin/?' do
    current_user_id, current_username = User.authenticate(params)
    @errorMessage = ''
    if current_user_id.nil?
        @errorMessage = 'You could not be signed in. Did you enter the correct username and password?'
        erb :signin
    else
        session[:user_id] = current_user_id
        session[:username] = current_username
        redirect '/home'
        # redirect_to_original_request
    end
end

get '/signout/?' do
    session.clear
    session[:user_id] = nil
    redirect '/'
end

get '/protected/?' do
    authenticate!
    erb :protected, locals: { title: 'Protected Page' }
end
