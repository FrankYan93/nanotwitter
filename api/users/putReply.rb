put '/api/v1/users/:user_id/tweets/:tweet_id/replies/:content' do
  heReply(params).to_json
end

def heReply params
  newReply=Reply.new
  newReply.user_id=params[:user_id]
  newReply.tweet_id=params[:tweet_id]
  newReply.content=params[:content]
  newReply.save
  newReply
end
