get '/api/v1/users/:user_id' do
    getUserByID(params[:user_id]).to_json
end

def getUserByID(userId)
    get_user = User.find(userId)
    get_user
end

get '/api/v1/users/name/:user_name' do
    user = User.find_by username: params[:user_name]
    user.to_json
end
