put '/api/v1/users/:user_id/tweets/:content' do
    hisNewTweet(params).to_json
end

def hisNewTweet(params)
    tmp=$redis.get("User"+params['user_id'].to_s)
    user=JSON.parse tmp unless tmp.nil?
    if user.nil?
      user = User.find(params['user_id'])
      $redis.set("User"+params['user_id'].to_s,user.to_json)
    end
    #user = User.find(params['user_id'])
    newtweet = Tweet.new
    newtweet.username = user['username']
    newtweet.nickname = user['nickname']
    newtweet.content = params['content']
    newtweet.user_id = params['user_id']
    newtweet.create_time = Time.now
    newtweet.save!
    #update nonloging_timeline
    $redis.lpush('nonlogin_timeline', newtweet.to_json)
    if $redis.llen('nonlogin_timeline') > $maxRecentNum
        $redis.rpop('nonlogin_timeline')
    end
    #update follower's redis
    insertIntoAllFollower params['user_id'],newtweet
    #return this tweet record
    newtweet
end

def newhisNewTweet(params)
  tmp=$redis.get("User"+params['user_id'].to_s)
  user=JSON.parse tmp unless tmp.nil?
  if user.nil?
    user = User.find(params['user_id'])
    $redis.set("User"+params['user_id'].to_s,user.to_json)
  end
  #user = User.find(params['user_id'])
  newtweet = Tweet.new
  newtweet.username = user['username']
  newtweet.nickname = user['nickname']
  newtweet.content = params['content']
  newtweet.user_id = params['user_id']
  newtweet.create_time = Time.now
  newtweet.save!
end
