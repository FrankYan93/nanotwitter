get '/api/v1/users/:user_id/followings' do
    followRelations = Followerfollowing.where(user_id: params[:user_id])
    results = []
    followRelations.each do |x|
        results << getUserByID(x.followed_user_id)
    end
    results
end
