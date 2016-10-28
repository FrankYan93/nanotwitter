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
  currentUser=User.find_by(username: params[:username])

  @follower_number = currentUser.follower_number
  @following_number = currentUser.following_number

  @followers = hisFollowers(currentUser.id)

  erb :userfollowers

end


get "/:username/followings" do

  currentUser=User.find_by(username: params[:username])


  @follower_number = currentUser.follower_number
  @following_number = currentUser.following_number

  @followings = hisFollowings(currentUser.id)

  erb :userfollowings
end

get "/:username/showhome" do
  @username = params[:username]
  currentUser = User.find_by(username: @username)
  @follower_number = currentUser.follower_number
  @following_number = currentUser.following_number

  n = 100
  @user_tweets = Tweet.where(user_id: currentUser[:id]).order(create_time: :desc).limit(n)
  @n = params[:n].to_i || 0

  erb :showhome
end
