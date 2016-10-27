get '/api/v1/users/:user_id/followings/' do
    hisFollowings params[:user_id]
end

def hisFollowings theId
  followRelations = Followerfollowing.where(user_id: theId)
  results = []
  followRelations.each do |x|
      results << getUserByID(x.followed_user_id)
  end
  results.to_json
end
