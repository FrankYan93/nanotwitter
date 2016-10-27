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
