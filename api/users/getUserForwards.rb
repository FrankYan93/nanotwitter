get '/api/v1/users/:user_id/forwards' do
    userForward(params[:user_id]).to_json
end

def userForward theId
  Tweet.where('user_id=? and is_forwarding=?', theId, true)
end
