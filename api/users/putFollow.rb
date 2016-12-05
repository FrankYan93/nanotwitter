put '/api/v1/users/:user_id/follow/:following_id' do
    params["username"]=User.find(params[:user_id]).username
    params["owner_id"]=params[:following_id]
    x=a_follow_b(params)
    if x
      Thread.new{rpcClient params} if params["test"].nil?
      x.to_json
    else
      "repeated follow"
    end
end

def a_follow_b(params)
  if Followerfollowing.where(user_id: params[:user_id],followed_user_id: params[:following_id]).size.zero?
    followRelation = Followerfollowing.new
    followRelation.user_id = params[:user_id]
    followRelation.followed_user_id = params[:following_id]
    followRelation.follow_date = Time.now
    followRelation.save

    user = User.find_by(id: params[:user_id])
    followed_user = User.find_by(id: params[:following_id])

    user["following_number"] += 1
  #  puts user["following_number"]
    followed_user["follower_number"] +=1
  #  puts followed_user["follower_number"]
    user.save
    followed_user.save
    Thread.new{updateUserInfo params[:user_id]}
    Thread.new{updateUserInfo params[:following_id]}
    followRelation
  else
    nil
  end
end
