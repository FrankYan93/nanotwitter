# require_relative '../app.rb'
def updateUserRedis(userId)
    # userId=session[:user_id]
    return 'no need to update' unless $redis.ttl(userId) == -2
    $redis.expire(userId, 3600)
    modifyRedis(userId)
end

def modifyRedis(userId)
    # userId=session[:user_id]
    n = 100
    join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: session[:user_id])
    all_tweets = join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('tweets.id,tweets.nickname,tweets.username,tweets.content,tweets.create_time')
    all_tweets.each do |x|
        $redis.rpush(userId, x.to_json)
    end
    'update success'
end

def updatePersonalTweets(userId, n)
    label = userId.to_s + '_tweet'
    return 1 unless $redis.ttl(label) == -2
    # update empty personal tweets list
    updateProfileTweets(userId, n)
end

def updateProfileTweets(userId, n)
    label = userId.to_s + '_tweet'
    # update empty personal tweets list
    tmp = userRecentTweets(userId, n)
    for i in 0...n # the number is same as n-1 in getusertweets api
        # print tmp[i].to_json
        # puts
        break if tmp[i].nil?
        $redis.rpush(label, tmp[i].to_json)
        $redis.lpop(label) if $redis.llen(label) > n
    end
end
# updatePersonalTweets
# puts $redis.lindex('128_tweet',0)

def updateLike(userId)
    label = userId.to_s + '_like'
    return nil unless $redis.ttl(label) == -2
    hislikes = userLike userId
    hislikes.each do |x|
        $redis.sadd(label, x[:tweet_id])
    end
end

def updateUserInfo(id)
    user = User.find(id)
    $redis.set('User' + id.to_s, user.to_json)
end
