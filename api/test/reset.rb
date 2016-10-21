require 'csv'
require 'time'

get '/api/v1/test/reset/all' do
    deleteAll
    resetTestuser
    user_size = User.count
    "user size = #{user_size}"
end

get '/api/v1/test/reset/standard' do
    deleteAll
    setUser
    setTweet
    setFollows
    resetTestuser
end

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
    newpassword = Password.create('password')
    user.password = newpassword
    user.follower_number = 0
    user.following_number = 0
    user.nickname = ''
    user.save
end

def setUser
    CSV.foreach('./api/test/seeds/users.csv') do |row|
        user_id = row[0].to_i
        user_name = row[1]
        User.create(username: user_name, follower_number: 0, following_number: 0).update_column(:id, user_id)
    end
end

def setTweet
    CSV.foreach('./api/test/seeds/tweets.csv') do |row|
        user_id = row[0].to_i
        tweet = row[1]
        time = DateTime.parse(row[2])
        Tweet.create(user_id: user_id, content: tweet, create_time: time, is_forwarding: false, is_mentioning: false, has_hashtag: false, like_numbers: 0, forwarded_number: 0, reply_number: 0)
    end
end

def setFollows
    CSV.foreach('./api/test/seeds/follows.csv') do |row|
        user_id = row[0].to_i
        followed_user_id = row[1].to_i
        Followerfollowing.create(user_id: user_id, followed_user_id: followed_user_id, follow_date: Time.now)
        following_user = User.find_by id: user_id
        unless following_user.nil?
            following_user[:following_number] += 1
            following_user.save
        end
        followed_user = User.find_by id: followed_user_id
        unless followed_user.nil?
            followed_user[:follower_number] += 1
            followed_user.save
        end
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
        follows.destroy
    end
end

def deleteAsFollowing(username)
    testuser = User.find_by username: username
    Followerfollowing.where(followed_user_id: testuser[:id]).find_each do |follow|
        following_user = User.find_by id: follow[:user_id]
        following_user[:following_number] -= 1
        follows.destroy
    end
end
