put '/api/v1/users/:user_id/unfollow/:following_id' do
    heUnfollow params
end

def heUnfollow(params)
    followRelation = Followerfollowing.where(followed_user_id: params[:following_id], user_id: params[:user_id])
    unless followRelation.size.zero?
        followRelation.destroy_all
        a = User.find(params[:user_id])
        a[:following_number] -= 1
        a.save
        b = User.find(params[:following_id])
        b[:follower_number] -= 1
        b.save
        Thread.new { updateUserInfo params[:user_id] }
        Thread.new { updateUserInfo params[:following_id] }

        updateUserInfo(params[:user_id])
        updateUserInfo(params[:following_id])
        $redis.del params[:user_id]
        modifyRedis(params[:user_id])
    end
end
