put '/api/v1/users/:user_id/tweets/:content' do
    hisNewTweet(params).to_json
end

def hisNewTweet(params)
    user = User.find(params['user_id'])
    newtweet = Tweet.new
    newtweet.username = user.username
    newtweet.nickname = user.nickname
    newtweet.content = params['content']
    newtweet.user_id = params['user_id']
    newtweet.create_time = Time.now
    newtweet.save!
    $redis.lpush('nonlogin_timeline', newtweet.to_json)
    if $redis.llen('nonlogin_timeline') > $maxRecentNum
        $redis.rpop('nonlogin_timeline')
    end
    newtweet
end
