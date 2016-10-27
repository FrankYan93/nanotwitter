get "/:username/editProfile" do
  @username = params[:usename]
  currentUser=User.find_by(username: session[:username])

  @password_hash = Password.new (currentUser.password)

  @birthday = currentUser.birthday
  @nickname = currentUser.nickname
  @description = currentUser.description
  erb :editProfile
end

post "/editProfile" do

  currentUser=User.find_by(id: session[:user_id])
  currentUser.password = Password.create(params[:password])
  currentUser.birthday = params[:birthday] unless params[:birthday].nil?
  currentUser.nickname = params[:nickname] unless params[:nickname].nil?
  currentUser.description=params[:description] unless params[:description].nil?
  currentUser.save
  erb :home
end

get "/:username/followers" do
  @username = params[:usename]
  currentUser=User.find_by(username: session[:username])

  @password_hash = Password.new (currentUser.password)

  @birthday = currentUser.birthday
  @nickname = currentUser.nickname
  @description = currentUser.description
  erb :userfollowers
end

get "/:username/followings" do
  @username = params[:usename]
  currentUser=User.find_by(username: session[:username])

  @password_hash = Password.new (currentUser.password)

  @birthday = currentUser.birthday
  @nickname = currentUser.nickname
  @description = currentUser.description
  erb :userfollowings
end
