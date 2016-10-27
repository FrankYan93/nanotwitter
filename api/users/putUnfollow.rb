put '/api/v1/users/:user_id/unfollow/:following_id' do
    heUnfollow params
end

def heUnfollow params
  followRelation = Followerfollowing.where(followed_user_id: params[:following_id]).find_by(user_id: params[:user_id])
  followRelation.destroy
end
