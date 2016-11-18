require File.expand_path '../../test_helper.rb', __FILE__


class TestRegister < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_register

    user = User.find_by(username: "testuser")
    unless user.nil?
      user.destroy
    end

    put '/api/v1/register/testuser/testpassword'
    user = JSON.parse(last_response.body)
    user_id = user["id"]

    assert_equal user["username"], "testuser"

    #password = Password.new(user[:password])
    #assert_equal password == "testpassword", true
    assert_equal user["follower_number"], 0
    assert_equal user["following_number"], 0
    assert_equal user["nickname"], ''

    put '/api/v1/register/testuser/testpassword'
    user = last_response.body

    assert_equal user, "username is existed, please try another one"

    user = User.find_by(username: "testuser")
    user.destroy
  end
end
