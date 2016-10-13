get '/api/v1/test/status' do
    @user_size = User.count
    @tweet_size = Tweet.count
    @follows_size = Followerfollowing.count
#    "follows size = #{follows_size}\n"
    testuser = User.find_by(username: 'testuser')
    @testuser_id = 0
    @testuser_id = testuser[:id] unless testuser.nil?
    erb :test_status
end
