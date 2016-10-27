get '/api/v1/users/:user_id/tweets' do
    userRecentTweets(params[:user_id]).to_json
end

def userRecentTweets theId
  # Just means return recent n tweets.
  n = 20
  # descend: show new tweets first.
  Tweet.where(user_id: theId).order(create_time: :desc).limit(n)
end
