get '/api/v1/test/status' do
    @user_size = User.count
    @tweet_size = Tweet.count
    @follows_size = Followerfollowing.count
#    "follows size = #{follows_size}\n"
    testuser = User.find_by(username: 'testuser')
    @testuser_id = testuser[:id] || 0
    @testuser_follows = Followerfollowing.where(user_id: @testuser_id).count
    @flag_user = User.find_by(username: 'flag')
    erb :test_status
end
