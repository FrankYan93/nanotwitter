put '/api/v1/users/:user_id/replies/:reply_id/replies/:content' do
  newReply=Reply.new
  newReply.user_id=params[:user_id]
  newReply.reply_id=params[:reply_id]
  newReply.content=params[:content]
  newReply.save
  newReply.to_json
end
