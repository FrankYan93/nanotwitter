put '/api/v1/users/:user_id/likes/:tweet_id' do
    newlike = Like.new
    newlike.user_id = params['user_id']
    newlike.tweet_id = params['tweet_id']
    newlike.save!
    if newlike.tweet.like_numbers.nil?
        newlike.tweet.like_numbers = 1
    else
        newlike.tweet.like_numbers += 1
    end
    # 调用 notification to tweet_id 对应的user
    newlike.to_json
end
