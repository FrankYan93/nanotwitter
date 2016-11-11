get '/api/v1/search/tweets/?' do
    getTweetByWord params[:word]
end

def getTweetByWord(word)
    get_tweets = Tweet.where('content LIKE :query', query: "%#{word}%").all
    if get_tweets.nil?
        return 'Result not found'
    else
        return get_tweets.to_json
    end
end
