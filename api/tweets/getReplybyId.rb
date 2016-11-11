get '/api/v1/replies/:reply_id' do
    theReply=Reply.where(id: params[:reply_id])
    theReply.to_json
end
