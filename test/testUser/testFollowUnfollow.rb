require File.expand_path '../../test_helper.rb', __FILE__

class TestFollowUnfollow < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_put_follow_and_unfollow
    get '/api/v1/test/reset/all'

    put '/api/v1/register/testuser1/testpassword1'
    user1 = JSON.parse(last_response.body)
    user1_id = user1["id"]

    put '/api/v1/register/testuser2/testpassword2'
    user2 = JSON.parse(last_response.body)
    user2_id = user2["id"]

    put "/api/v1/users/#{user1_id}/follow/#{user2_id}?test=yes"
    relation =  JSON.parse(last_response.body)
    assert_equal relation["user_id"], user1_id
    assert_equal relation["followed_user_id"], user2_id

    user = User.find_by(id: user1_id)
    assert_equal user["following_number"], 1

    user = User.find_by(id: user2_id)
    assert_equal user["follower_number"], 1

    put "/api/v1/users/#{user1_id}/unfollow/#{user2_id}"
    assert_equal last_response.body, ""

    user = User.find_by(id: user1_id)
    assert_equal user["following_number"], 0

    user = User.find_by(id: user2_id)
    assert_equal user["follower_number"], 0


    user1 = User.find_by(username: "testuser1")
    user2 = User.find_by(username: "testuser2")
    user1.destroy
    user2.destroy
  end
end
