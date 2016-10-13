get '/api/v1/tweets/recent/' do
    getTweetByTime
end

def getTweetByTime
    get_tweets = Tweet.where('create_time <= ?', Date.today).order('create_time DESC').limit(100)
    get_tweets.to_json
end
