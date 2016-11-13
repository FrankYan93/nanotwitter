# build everything from scratch
# /api/v1/test/setup/all?count=100&tweets=100&testtweet=20&testfollow=20&follows=20
get '/api/v1/test/setup/all' do
    'begin setup'
    begin_time = Time.now
    count_number = (params[:count] || 100).to_i
    tweet_number = (params[:tweets] || 10).to_i
    testuser_tweets = (params[:testtweet] || 20).to_i
    testuser_follow = (params[:testfollow] || 20).to_i
    follow_number = (params[:follows] || 20).to_i

    puts count_number
    puts tweet_number
    puts testuser_follow
    puts testuser_tweets
    puts follow_number

    # reset testuser
    testuser = User.find_by username: 'testuser'
    if testuser.nil?
        resetTestuser
    else
        deleteTweet('testuser')
        deleteAsFollower('testuser')
        deleteAsFollowing('testuser')
    end
    testuser.follower_number = -1
    testuser.following_number = -1
    testuser.save
    theparam = {}
    theparam[:user_id] = testuser[:id]
    theparam[:following_id] = testuser[:id]
    a_follow_b(theparam)

    # create user and tweets
    createUsersTweets(count_number, tweet_number)

    # make testuser tweet
    for j in 1..testuser_tweets
        text = Faker::Hacker.say_something_smart
        newTweet(testuser[:id], text)
      end

    # make testuser follow users
    # follow(testuser[:id], testuser[:id]+1)
    random_follow(testuser[:id], testuser_follow)

    # random follow

    users = shuffle User.all.to_a, follow_number
    for i in 0..follow_number - 1
        break if users[i].nil?
        random_follow(users[i][:id], follow_number)
    end

    end_time = Time.now
    require_relative '../../cache_redis.rb'
    updateUserRedis testuser[:id]
    updatePersonalTweets(testuser[:id], 100)
    "setup all.\ntime used = #{end_time - begin_time}"
end

def random_follow(id, count)
    not_followed_users = User.not_follow_by(id)
    users_to_follow = shuffle not_followed_users.to_a, count
    times = 0
    for i in 0..count - 1
        break if users_to_follow[i].nil?
        followed_id = users_to_follow[i][:id]
        follow(id, followed_id)
        times += 1
    end
    puts times
end
