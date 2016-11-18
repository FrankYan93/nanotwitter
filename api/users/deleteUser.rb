delete '/api/v1/users/:username' do
  user = User.find_by username: params[:username]
  if user.nil?
    error 400, "user dose not exist".to_json # :bad_request
  else
    username = user[:username]
    deleteTweet(username)
    deleteAsFollower(username)
    deleteAsFollowing(username)
    user.destroy
    user.to_json
  end
end
