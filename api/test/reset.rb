get '/api/v1/test/reset/all' do
  deleteAll
  resetTestuser
  user_size = User.count
  "user size = #{user_size}"
end

def deleteAll
  User.destroy_all
  Tweet.destroy_all
  Followerfollowing.destroy_all
  Hashtag.destroy_all
  Like.destroy_all
  Mention.destroy_all
  Notification.destroy_all
  Reply.destroy_all
  Tweethashtag.destroy_all
end

def resetTestuser
  user = User.new
  user.username = "testuser"
  newpassword = Password.create("password")
  user.password = newpassword
  user.follower_number=0
  user.followering_number=0
  user.nickname=""
  user.save
end
