put '/api/v1/users/:user_id/profile' do
    userProfile(params).to_json
end

def userProfile theParam
  currentUser=User.find(theParam[:user_id])

  currentUser.password = Password.create(theParam[:password])
  currentUser.birthday = theParam[:birthday] unless theParam[:birthday].nil?
  currentUser.nickname = theParam[:nickname] unless theParam[:nickname].nil?
  currentUser.description=theParam[:description] unless theParam[:description].nil?
  currentUser.save
  currentUser
end

put '/api/v1/users/:user_id/UpdateProfile' do
  begin
    currentUser=User.find(params[:user_id])

    if currentUser.nil?
      error 400, "user dose not exist".to_json # :bad_request
    else
      profiles = JSON.parse(request.body.read)

      currentUser.password = Password.create(profiles["password"]) unless profiles["password"].nil?
      currentUser.birthday = profiles["birthday"] unless profiles["birthday"].nil?
      currentUser.nickname = profiles["nickname"] unless profiles["nickname"].nil?
      currentUser.description = profiles["description"] unless profiles["description"].nil?
      currentUser.save!
      puts currentUser[:birthday]
      puts "updated"
      currentUser.to_json
    end
  rescue => e
    error 400, "unknown error".to_json
  end
end
