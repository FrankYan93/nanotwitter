get '/api/v1/users/:user_id' do
    getUserByID(params[:user_id]).to_json
end

def getUserByID(userId)
    get_user = User.find(userId)
end
