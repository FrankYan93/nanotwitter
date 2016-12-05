get '/:username/editProfile' do
    @username = params[:usename]
    currentUser = User.find_by(username: session[:username])

    @password_hash = Password.new currentUser.password

    @birthday = currentUser.birthday
    @nickname = currentUser.nickname
    @description = currentUser.description
    erb :editProfile
end

post '/editProfile' do
    currentUser = User.find_by(id: session[:user_id])
    currentUser.birthday = params[:birthday] unless params[:birthday].nil?
    currentUser.nickname = params[:nickname] unless params[:nickname].nil?
    currentUser.description = params[:description] unless params[:description].nil?
    currentUser.save

    tweets = Tweet.where(user_id: session[:user_id])
    tweets.each do |tweet|
        tweet.nickname = currentUser.nickname
        tweet.save
    end

    $redis.del session[:user_id].to_s + '_tweet'
    $redis.del session[:user_id]
    updateProfileTweets(session[:user_id], 50)
    updateUserInfo(session[:user_id])
    modifyRedis(session[:user_id])
    log_in_home
end

get '/:username/followers' do
    currentUser = User.find_by(username: params[:username])
    @user_name = params[:username]
    @user = currentUser
    @followers = hisFollowers(currentUser.id)
    @n = params[:n].to_i || 0
    erb :userfollowers
end

get '/:username/followings' do
    currentUser = User.find_by(username: params[:username])

    @user_name = params[:username]

    @user = currentUser

    @followings = hisFollowings(currentUser.id)
    @unfollowings = []
    @count_number = 10
    users = User.not_follow_by(currentUser.id)
    @unfollowings = shuffle users.to_a, @count_number

    @n = params[:n].to_i || 0
    erb :userfollowings
end

get '/showProfile' do
    if session[:user_id].nil?
        not_log_in_home
    else
        @username = params[:usename]
        @user = User.find_by(username: session[:username])

        erb :showProfile
    end
end

def iffollow(id, following_id)
    !Followerfollowing.find_by(user_id: id, followed_user_id: following_id).nil?
end

def determine_status(id)
    if session[:user_id].nil?
        @status = 'unable to follow'
    else
        @iffollow = iffollow(session[:user_id], id)
        @status = if @iffollow
                      '  Following  '
                  else
                      'Not following'
                  end
    end
end
