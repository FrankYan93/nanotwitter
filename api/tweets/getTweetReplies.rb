get '/api/v1/tweets/:tweet_id/replies' do
    currentReplies=Reply.where(tweet_id: params[:tweet_id])
    currentReplies.to_json
end
