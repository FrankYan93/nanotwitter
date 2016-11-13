get '/api/v1/users/:user_id/tweets' do
  # Just means return recent n tweets.
  n = 20
    userRecentTweets(params[:user_id],n).to_json
end

def userRecentTweets(theId,n)

  # descend: show new tweets first.
  Tweet.where(user_id: theId).order(create_time: :desc).limit(n)
end
