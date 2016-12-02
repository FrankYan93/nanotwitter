recent_n=Tweet.all.order(create_time: :desc).limit($maxRecentNum)
$redis.del 'nonlogin_timeline' #unless $redis.nil?
recent_n.each{|x|
  $redis.lpush('nonlogin_timeline',x.to_json)
}
