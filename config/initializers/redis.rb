$redis = Redis.new(url: ENV["REDIS_URL"], timeout: 3600)
$maxRecentNum=100
