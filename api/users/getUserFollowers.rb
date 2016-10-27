get '/api/v1/users/:user_id/followers/' do
    hisFollowers params[:user_id]
end

def hisFollowers theId
  followRelations = Followerfollowing.where(followed_user_id: theId)
  results = []
  followRelations.each do |x|
      results << getUserByID(x.user_id)
  end
  results.to_json
end
