get '/api/v1/test/users/create' do
  begin_time = Time.now
  count_number = params[:count].to_i||1
  tweet_number = params[:tweets].to_i||0
  createUsersTweets(count_number, tweet_number)
  end_time = Time.now
  "time used = #{end_time-begin_time}"
end

get '/api/v1/test/user/:user_name/tweets' do
  begin_time = Time.now
  user_name = params[:user_name]
  tweet_number = params[:tweets].to_i || 0
  user = User.find_by username: user_name
  user_id = user.id
  for j in 1..tweet_number
    text = Faker::Hacker.say_something_smart
    newTweet(user_id, text)
  end
  end_time = Time.now
  "time used = #{end_time-begin_time}"
end

get '/api/v1/test/user/:id/follow' do
  begin_time = Time.now
  count_number = params[:count].to_i||0
  followed_id = params[:id]
  for i in 1..count_number
    user_id = rand(User.count)
    follow(user_id, followed_id)
  end
  end_time = Time.now
  "time used = #{end_time-begin_time}"
end

get '/api/v1/test/user/follow' do
  begin_time = Time.now
  count_number = params[:count].to_i||0
  for i in 1..count_number
    user_id = rand(User.count)
    for j in 1..count_number
      followed_id = rand(User.count)
      follow(user_id,followed_id)
    end
  end
  end_time = Time.now
  "time used = #{end_time-begin_time}"
end

def createUsersTweets (count_number, tweet_number)
  for i in 1..count_number
    username = Faker::Name.first_name
    user_id = newUser(username)
    for j in 1..tweet_number
      text = Faker::Hacker.say_something_smart
      newTweet(user_id, text)
    end
  end
end

def newUser(username)
  newUser = User.new
  newUser.username = username
  newUser.follower_number = 0
  newUser.following_number = 0
  newUser.nickname = ''
  newUser.save
  return newUser.id
end

def newTweet(user_id, content)
  newtweet = Tweet.new
  newtweet.content = content
  newtweet.user_id = user_id
  newtweet.create_time = Time.now
  newtweet.save!
end

def follow (user_id, followed_id)
  user = User.find_by(id: user_id)
  followed_user = User.find_by(id: followed_id)
  if user == nil || followed_user == nil
    return
  end
  user["following_number"] += 1
  followed_user["follower_number"] +=1
  user.save
  followed_user.save

  followRelation = Followerfollowing.new
  followRelation.user_id = user_id
  followRelation.followed_user_id = followed_id
  followRelation.follow_date = Time.now
  followRelation.save
end
