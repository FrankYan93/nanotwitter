require File.expand_path '../../test_helper.rb', __FILE__

class TestTweetCreate < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

 def setup
#create 3 test users
  put '/api/v1/register/testuser1/testpassword1'
  @user1 =  JSON.parse(last_response.body)
  @user1_id = @user1["id"]

  put '/api/v1/register/testuser2/testpassword2'
  @user2 =  JSON.parse(last_response.body)
  @user2_id = @user2["id"]

  put '/api/v1/register/testuser3/testpassword3'
  @user3 =  JSON.parse(last_response.body)
  @user3_id = @user3["id"]

#create 3 tweets of each user
  put "/api/v1/users/#{@user1_id}/tweets/test11"
  put "/api/v1/users/#{@user1_id}/tweets/test12"
  put "/api/v1/users/#{@user1_id}/tweets/test13"

  put "/api/v1/users/#{@user2_id}/tweets/test21"
  put "/api/v1/users/#{@user2_id}/tweets/test22"
  put "/api/v1/users/#{@user2_id}/tweets/test23"

  put "/api/v1/users/#{@user3_id}/tweets/test31"
  put "/api/v1/users/#{@user3_id}/tweets/test31"
  put "/api/v1/users/#{@user3_id}/tweets/test31"

#create follow relations of 1->2, 1->3, 2->3, 3->1
  put "/api/v1/users/#{@user1_id}/follow/#{@user2_id}"
  put "/api/v1/users/#{@user1_id}/follow/#{@user3_id}"
  put "/api/v1/users/#{@user2_id}/follow/#{@user3_id}"
  put "/api/v1/users/#{@user3_id}/follow/#{@user1_id}"

end

  def test_it_get_user
    get "/api/v1/users/#{@user1_id}"
    user = JSON.parse(last_response.body)
    assert_equal user["id"], @user1_id
  end

 def test_it_get_user_followers
    get "/api/v1/users/#{@user1_id}/followers/"
    result = JSON.parse(last_response.body)
    assert_equal result["id"], @user3_id
 end

 def test_it_get_user_followings
    get "/api/v1/users/#{@user1_id}/followings/"
    result = JSON.parse(last_response.body).first
    puts result
    assert_equal result[1]["id"], @user2_id
    assert_equal result[2]["id"], @user3_id

    @user1.destroy
    @user2.destroy
    @user3.destroy
 end





end
