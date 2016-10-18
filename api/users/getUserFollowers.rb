get '/api/v1/users/:user_id/followers/' do
    followRelations = Followerfollowing.where(followed_user_id: params[:user_id])
    results = []
    followRelations.each do |x|
        results << getUserByID(x.user_id)
    end
    results.to_json
end
