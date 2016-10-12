get '/api/v1/users/:user_id' do
  getUserByID params[:user_id]
end

def getUserByID userId
  get_user=User.find(userId)
  get_user.to_json
end
