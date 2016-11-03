$redis = Redis.new(url: ENV["REDIS_URL"], timeout: 3600)
$maxRecentNum=100
recent_n=Tweet.all.order(create_time: :desc).limit($maxRecentNum)
recent_n.each{|x|
  $redis.rpush('nonlogin_timeline',x.to_json)
}
