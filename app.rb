require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require 'active_record'
require 'byebug'
require 'time'
require 'faker'
require 'redis'
require 'resque'
require 'bunny'
require 'thread'
require 'net/http'
# require apis, services, models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/users/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/tweets/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/api/test/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/service/*.rb'].each { |file| require file }
#initialize redis
require_relative 'config/initializers/redis.rb'
#config new relic
configure :production do
    require 'newrelic_rpm'
end

enable :sessions
#flush redis if necessary
require_relative 'cache_redis.rb' if $redis.llen('nonlogin_timeline').zero? && !$rakedb

include BCrypt
#just check session
def authenticate!
    if session[:user_id].nil?
        session[:original_request] = request.path_info
        redirect '/signin'
    end
end

def redirect_to_original_request
    user = session[:user]
    original_request = session[:original_request]
    session[:original_request] = nil
    redirect original_request
end

get '/' do
    params['username'] = params['email'] if params['username'].nil?
    #print params
    n = params['p'].to_i || 0
    if rand(100) < n
        tmp=$redis.get("User"+params[:username].to_s)
        bonnie=JSON.parse tmp unless tmp.nil?
        if bonnie.nil?
          bonnie = User.find_by(username: params[:username])
          $redis.set("User"+params[:username].to_s,bonnie.to_json)
        end
        print bonnie
        x={}
        x['user_id']= bonnie[:id]
        x['content']= 'Hello,bonnie'
        hisNewTweet(x)
    end
    check_log_in params
end

get '/home' do
    check_log_in params
end

get '/signup' do
    erb :signUp
end

post '/signup' do
    response_reg = heRegister params
    if response_reg.class == String
        @errorString = ' ------ Username existed! Please try another name!'
        erb :signUp
    else
        session[:user_id] = response_reg.id
        session[:username] = response_reg.username
        redirect to('/home')
    end
end

get '/signin/?' do
    erb :signin
end

get 'loaderio-f1055ee771fe308ab55cc3be88736038' do
    'loaderio-f1055ee771fe308ab55cc3be88736038'
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
        # @currentUser=User.find_by(username: params[:username])
        redirect '/home'
        # redirect_to_original_request
    end
end

get '/signout/?' do
    session.clear
    redirect '/'
end



def check_log_in(params)
    if session[:user_id].nil?
        if params[:username].nil?
            not_log_in_home
        else
            id, name = User.authenticate params
            # puts id,name
            if id.nil?
                not_log_in_home
            else
                session[:user_id] = id
                session[:username] = name

                log_in_home
            end
        end
    else
        log_in_home
    end
end
