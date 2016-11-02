put '/api/v1/users/:user_id/unfollow/:following_id' do
    heUnfollow params
end

def heUnfollow params
  followRelation = Followerfollowing.where({followed_user_id: params[:following_id],user_id: params[:user_id]})
  followRelation.destroy_all
  a=User.find(params[:user_id])
  a[:following_number]-=1
  a.save
end
