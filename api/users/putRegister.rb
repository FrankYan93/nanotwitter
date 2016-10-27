put '/api/v1/register/:username/:password' do
    heRegister(params).to_json
end

def heRegister params
  newUser = User.new
  newpassword = Password.create(params[:password])
  newUser.username = params[:username]
  newUser.password = newpassword
  newUser.follower_number = 0
  newUser.following_number = 0
  newUser.nickname = ''
  newUser.save
  newUser
end
