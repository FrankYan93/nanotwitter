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
