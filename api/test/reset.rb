require 'csv'
require 'time'

# delete all data and create a testuser
get '/api/v1/test/reset/all' do
    deleteAll
    resetTestuser
    user_size = User.count

    "user size = #{user_size}"
end

# create data based on seeds
get '/api/v1/test/reset/standard' do
    Thread.new{
      offset=User.maximum(:id)
      deleteAll

      offset=0 if offset.nil?
      setUser offset
      setTweet offset
      #puts offset,offset_tweet
      setFollows offset

      resetTestuser
    }
end

# reset all about testuser
get '/api/v1/test/reset/testuser' do
    testuser = User.find_by username: 'testuser'
    unless testuser.nil?
        deleteTweet('testuser')
        deleteAsFollower('testuser')
        deleteAsFollowing('testuser')
    end
    resetTestuser
    "test user is reseted"
end



def deleteAll
    User.destroy_all
    Tweet.destroy_all
    Followerfollowing.destroy_all
    Hashtag.destroy_all
    Like.destroy_all
    Mention.destroy_all
    Notification.destroy_all
    Reply.destroy_all
    Tweethashtag.destroy_all
end

def resetTestuser
    user = User.new
    user.username = 'testuser'
    user.nickname = 'testie'
    newpassword = Password.create('password')
    user.password = newpassword
    user.follower_number = -1
    user.following_number = -1
    user.save
    theparam = {}
    theparam[:user_id] = user[:id]
    theparam[:following_id] = user[:id]
    a_follow_b(theparam)
end

def setUser offset
    CSV.foreach('./api/test/seeds/users.csv') do |row|
        user_id = row[0].to_i+offset
        user_name = row[1]
        User.create(username: user_name, follower_number: 0, following_number: 0).update_column(:id, user_id)
    end
end

def setTweet offset
    CSV.foreach('./api/test/seeds/tweets.csv') do |row|
        user_id = row[0].to_i+offset
        tweet = row[1]
        time = DateTime.parse(row[2])
        Tweet.create(user_id: user_id, content: tweet, create_time: time, is_forwarding: false, is_mentioning: false, has_hashtag: false, like_numbers: 0, forwarded_number: 0, reply_number: 0)
    end
end

def setFollows offset
    CSV.foreach('./api/test/seeds/follows.csv') do |row|
        #print row,"\n"
        user_id = row[0].to_i+offset
        followed_user_id = row[1].to_i+offset
        params={user_id: user_id,following_id: followed_user_id}
        #print params
        a_follow_b(params)
    end
end

def deleteTweet(username)
    testuser = User.find_by username: username
    Tweet.where(user_id: testuser[:id]).find_each(&:destroy)
end

def deleteAsFollower(username)
    testuser = User.find_by username: username
    Followerfollowing.where(user_id: testuser[:id]).find_each do |follow|
        followed_user = User.find_by id: follow[:followed_user_id]
        followed_user[:follower_number] -= 1
        follow.destroy
    end
end

def deleteAsFollowing(username)
    testuser = User.find_by username: username
    Followerfollowing.where(followed_user_id: testuser[:id]).find_each do |follow|
        following_user = User.find_by id: follow[:user_id]
        following_user[:following_number] -= 1
        follow.destroy
    end
end
