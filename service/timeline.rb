get '/:username/tweets' do
    @user_name = params[:username]
    user = User.find_by username: @user_name

    if user.nil?
        "user dosen't exit!"
    else
        @user = user
        n = 100
        label = user[:id].to_s + '_tweet'

        # print $redis.lrange(label,0,-1),"\n"
        # if his tweet redis expire update!
        updatePersonalTweets(user[:id], n)

        @all_tweets = $redis.lrange(label, 0, -1) # Tweet.where(user_id: user[:id]).order(create_time: :desc).limit(n)
        @n = params[:n].to_i || 0
        erb :userTimeline
    end
end

def log_in_home
    if session[:user_id].nil?
        not_log_in_home
    else
        currentUser = User.find_by(id: session[:user_id])
        @user = currentUser
        updateUserRedis session[:user_id]
        @n = params[:n].to_i || 0
        erb :home
    end
end

def not_log_in_home
    if !session[:user_id].nil?
        log_in_home
    else
        @n = params[:n].to_i || 0
        # @all_tweets = Tweet.all.order(create_time: :desc).limit(100)
        erb :index
    end
end

def control_bar(user_name)
    @page_user_name = user_name
    @x = "location='/#{@page_user_name}/editProfile'"
    @y = "location='/#{@page_user_name}/followers'"
    @z = "location='/#{@page_user_name}/followings'"
    @user_tweets = "location='/#{@page_user_name}/tweets'"
    @user_likestweets = "location='/#{@page_user_name}/likes/tweets'"

    if @page_user_name == session[:username]
        erb :my_control_bar
    else
        erb :other_control_bar
    end
end

def time_line
    for i in (0 + @n * 20)..(19 + @n * 20)
        break if @all_tweets[i].nil?
        @tweet = @all_tweets[i]
        #      @Nickname = @all_recent_tweets[i][:nickname]
        #      puts @tweet.to_json
        erb :singleTweet
    end
end

def determine_status(id)
    if session[:user_id].nil?
        @status = 'unable to follow'
    else
        @iffollow = iffollow(session[:user_id], id)
        @status = if @iffollow
                      'Following'
                  else
                      'Not following'
                  end
    end
end
