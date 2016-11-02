get '/:username/tweets' do
    @user_name = params[:username]
    user = User.find_by username: @user_name

    if user.nil?
        "user dosen't exit!"
    else
        @follower_number = user.follower_number
        @following_number = user.following_number

        n = 100
        @all_tweets = Tweet.where(user_id: user[:id]).order(create_time: :desc).limit(n)
        @n = params[:n].to_i || 0
        erb :userTimeline
    end
end

def log_in_home
    if session[:user_id].nil?
        not_log_in_home
    else
        user_id = session[:user_id]

        currentUser = User.find_by(id: session[:user_id])
        @follower_number = currentUser.follower_number
        @following_number = currentUser.following_number

        n = 100
        join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: user_id)
        @all_tweets = join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('tweets.id,tweets.nickname,tweets.username,tweets.content,tweets.create_time')
        @n = params[:n].to_i || 0
        erb :home
    end
end

def not_log_in_home
    if !session[:user_id].nil?
      log_in_home
    else
      @n = params[:n].to_i || 0
      @all_tweets = Tweet.all.order(create_time: :desc).limit(100)
      erb :index
    end
end

def control_bar
    @page_user_name = params[:username]
    @x = "location='/#{@page_user_name}/editProfile'"
    @y = "location='/#{@page_user_name}/followers'"
    @z = "location='/#{@page_user_name}/followings'"
    @user_tweets = "location='/#{@page_user_name}/tweets'"

    if @page_user_name == session[:username]
        erb :my_control_bar
    else
        erb :other_control_bar
    end
end

def time_line
    for i in (0+@n*20)..(19+@n*20)
      if @all_tweets[i] == nil
        break
      end
      @tweet = @all_tweets[i]
#      @Nickname = @all_recent_tweets[i][:nickname]
#      puts @tweet.to_json
      erb :singleTweet
    end
end
