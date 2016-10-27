get '/user/:username' do
  @user_name = params[:username]
  user = User.find_by username: @user_name
  if user == nil
    "user dosen't exit!"
  else
    n = 100
    @user_tweets = Tweet.where(user_id: user[:id]).order(create_time: :desc).limit(n)
    @n = params[:n].to_i || 0
    erb :userTimeline
  end
end

def log_in_home
  if session[:user_id].nil?
    not_log_in_home
  else
    user_id = session[:user_id]
    n = 100
    join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: user_id)
    @time_line_tweets = join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('tweets.nickname,tweets.username,tweets.content,tweets.create_time')
    @n = params[:n].to_i || 0
    erb :home
  end
end

def not_log_in_home
  unless session[:user_id].nil?
    log_in_home
  end
    @n = params[:n].to_i || 0
    @all_recent_tweets = Tweet.all.order(create_time: :desc).limit(100)
    erb :index
  end
