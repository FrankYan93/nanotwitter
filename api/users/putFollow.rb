put '/api/v1/users/:user_id/follow/:following_id' do
    followRelation = Followerfollowing.new
    followRelation.user_id = params[:user_id]
    followRelation.followed_user_id = params[:following_id]
    followRelation.follow_date = Time.now
    followRelation.save
    tmp = followRelation.user.followering_number
    if tmp.nil?
        puts 'is nil'
        followRelation.user.followering_number = 1
    else
        puts 'not nil'
        followRelation.user.followering_number += 1
    end
    tmp = followRelation.followed_user.follower_number
    if tmp.nil?
        followRelation.followed_user.follower_number = 1
    else
        followRelation.followed_user.follower_number += 1
    end
    followRelation.to_json
end
