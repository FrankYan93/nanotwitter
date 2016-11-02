# build everything from scratch
# /api/v1/test/setup/all?count=100&tweets=100&testtweet=20&testfollow=20&follows = 20
get '/api/v1/test/setup/all' do
    "begin setup"
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
    unless testuser.nil?
        deleteTweet('testuser')
        deleteAsFollower('testuser')
        deleteAsFollowing('testuser')
    end
    resetTestuser
    testuser = User.find_by username: 'testuser'

    # create user and tweets
    createUsersTweets(count_number, tweet_number)

    # make testuser tweet
    for j in 1..testuser_tweets
        text = Faker::Hacker.say_something_smart
        newTweet(testuser[:id], text)
      end

    # make testuser follow users
    follow(testuser[:id], testuser[:id]+1)
    random_follow(testuser[:id],testuser_follow)

    # random follow
    for i in 1..follow_number
        users = shuffle User.all.to_a, follow_number
        for j in 1..follow_number
            if users[i] == nil
              break
            end
            random_follow(users[i][:id], follow_number)
        end
    end

    end_time = Time.now
    "setup all.\ntime used = #{end_time - begin_time}"
end


def random_follow(id, count)
    not_followed_users = User.not_follow_by(id)
    users_to_follow = shuffle not_followed_users.to_a, count
    for i in 1..count
        break if users_to_follow[i].nil?
        followed_id = users_to_follow[i][:id]
        follow(id, followed_id)
    end
end
