get '/api/v1/users/:user_id/forwards' do
  Tweet.where("user_id=? and is_forwarding=?",params[:user_id],true).to_json
end
