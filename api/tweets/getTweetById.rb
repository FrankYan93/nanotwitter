get '/api/v1/tweets/:tweet_id' do
    getTweetByID params[:tweet_id]
end

def getTweetByID(tweetId)
    get_tweet = Tweet.find(tweetId)
    get_tweet.to_json
end
