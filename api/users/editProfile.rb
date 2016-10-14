put '/api/v1/users/:user_id/profile' do
    currentUser=User.find(params[:user_id])
    
    currentUser.password = Password.create(params[:password])
    currentUser.birthday = params[:birthday] unless params[:birthday].nil?
    currentUser.nickname = params[:nickname] unless params[:nickname].nil?
    currentUser.description=params[:description] unless params[:description].nil?
    currentUser.save
    currentUser.to_json
end
