def insertIntoAllFollower(theId, tweet)
    theFollowers = hisFollowers theId
    user=JSON.parse $redis.get("User"+theId.to_s)
    if user.nil?
      user=User.find(theId)
      $redis.set("User"+theId.to_s,user)
    end
    theFollowers<<user
    theFollowers.each do |x|
      print x,"\n"

        next if $redis.ttl(x["id"]) == -2
        print x['id'],"\n"

        n = 100
        # tweet is the whole record
        $redis.lpush(x['id'], tweet.to_json)
        $redis.rpop x if $redis.llen(x) > n
    end
end

get '/:username/likes/tweets' do
    @user_name = params[:username]
    user = User.find_by username: @user_name

    if user.nil?
        "user dosen't exit!"
    else
        @user = user

        n = 50
        all_likes = Like.where(user_id: user[:id]).order(create_time: :desc).limit(n)
        al_tweets = []
        all_likes.each do |like|
            al_tweets << Tweet.find_by(id: like.tweet_id).to_json
        end
        @all_tweets = al_tweets

        @n = params[:n].to_i || 0
        erb :userlikes
    end
end
