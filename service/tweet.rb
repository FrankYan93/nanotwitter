def insertIntoAllFollower theId,tweet
  theFollowers=hisFollowers theId
  theFollowers.each{|x|
    next if $redis.ttl(x)==-2
    n=100
    #tweet is the whole record
    $redis.lpush(x,tweet)
    if $redis.llen(x)>n
      $redis.rpop x
    end
  }
end

get '/:username/likes/tweets' do
    @user_name = params[:username]
    user = User.find_by username: @user_name

    if user.nil?
        "user dosen't exit!"
    else
        @follower_number = user.follower_number
        @following_number = user.following_number
        n = 100;
        all_likes = Like.where(user_id: user[:id]).order(create_time: :desc).limit(n);
        al_tweets = []
        all_likes.each do |like|
          al_tweets << Tweet.find_by(id: like.tweet_id).to_json
        end
        @all_tweets = al_tweets

        @n = params[:n].to_i || 0
        erb :userlikes
    end
end
