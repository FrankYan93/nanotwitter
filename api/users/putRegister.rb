put '/api/v1/register/:username/:password' do
    heRegister(params).to_json
end

def heRegister params
  if User.find_by(username: params[:username]).nil?
    newUser = User.new
    newpassword = Password.create(params[:password])
    newUser.username = params[:username]
    newUser.password = newpassword
    newUser.follower_number = -1
    newUser.following_number = -1
    newUser.nickname = ''
    newUser.save


    theparam = {}
    theparam[:user_id] = newUser[:id]
    theparam[:following_id] = newUser[:id]
    a_follow_b(theparam)

    User.find(theparam[:user_id])
  else
    error 400,"username is existed, please try another one"
  end
end

put '/api/v1/users/create/:username/:password' do
    heRegister(params).to_json
end
