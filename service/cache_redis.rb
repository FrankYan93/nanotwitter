recent_n=Tweet.all.order(create_time: :desc).limit($maxRecentNum)
$redis.del 'nonlogin_timeline'
recent_n.each{|x|
  $redis.rpush('nonlogin_timeline',x.to_json)
}
