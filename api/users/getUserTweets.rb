get '/api/v1/users/:user_id/tweets' do
    # Just means return recent n tweets.
    n = 20
    # descend: show new tweets first.
    Tweet.where(user_id: params[:user_id]).order(create_time: :desc).limit(n).to_json
end
