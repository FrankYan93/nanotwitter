put '/api/v1/users/:user_id/tweets/:tweet_id/replies/:content' do
  newReply=Reply.new
  newReply.user_id=params[:user_id]
  newReply.tweet_id=params[:tweet_id]
  newReply.content=params[:content]
  newReply.save
  newReply.to_json
end
