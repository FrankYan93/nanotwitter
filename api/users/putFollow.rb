put '/api/v1/users/:user_id/follow/:following_id' do
    a_follow_b(params).to_json
end

def a_follow_b(params)
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
  followRelation
end
