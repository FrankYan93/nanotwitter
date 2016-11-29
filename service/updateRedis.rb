#require_relative '../app.rb'
require 'redis'
$redis = Redis.new(url: ENV["REDIS_URL"])
$maxRecentNum=100


def updateUserRedis userId
  #userId=session[:user_id]
  return 1 unless $redis.ttl(userId)==-2
  $redis.expire(userId,3600)
  n = 100
  join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: session[:user_id])
  all_tweets = join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('tweets.id,tweets.nickname,tweets.username,tweets.content,tweets.create_time')
  all_tweets.each{|x|
    $redis.rpush(userId,x.to_json)
  }
end

def updatePersonalTweets(userId,n)
  label=userId.to_s+'_tweet'
  return 1 unless $redis.ttl(label)==-2
  #update empty personal tweets list
  tmp=userRecentTweets(userId,n)
  for i in 0...n#the number is same as n-1 in getusertweets api
    # print tmp[i].to_json
    # puts
    break if tmp[i].nil?
    $redis.lpush(label,tmp[i].to_json)
    $redis.rpop(label) if $redis.llen(label)>n
  end
end
#updatePersonalTweets
#puts $redis.lindex('128_tweet',0)

def updateLike userId
  label=userId.to_s+'_like'
  return 1 unless $redis.ttl(label)==-2
  hislikes=userLike userId
  hislikes.each{|x|
    $redis.sadd(label,x[:tweet_id])
  }
end

def updateFollow(userId, followedID)
  label = userId.to_s + '_following'
  #return 1 unless $redis.ttl(label)==-2
  $redis.sadd(label,followedID)
  label2 = followedID.to_s + '_follower'
  #return 1 unless $redis.ttl(label2)==-2
  $redis.sadd(label2,userId)
end

def updateUnFollow(userId, followedID)
  label = userId.to_s + '_following'
  #return 1 unless $redis.ttl(label)==-2
  $redis.srem(label,followedID)
  label2 = followedID.to_s + '_follower'
  #return 1 unless $redis.ttl(label2)==-2
  $redis.srem(label2,userId)
end

#=begin
updateFollow(1,2)
updateFollow(1,3)
followings = $redis.smembers('1_following')
puts followings.class.name
users = User.where(:user_id => followings)
#=end

def calculateTimeline (userId)
  following_users = $redis.smember(userId.to_s+'following')
  #users = User.where(:user_id => )
end
