get '/api/v1/users/:user_id/likes' do
    userLike(params[:user_id]).to_json
end

def userLike theId
  Like.where('user_id=?', theId)
end
