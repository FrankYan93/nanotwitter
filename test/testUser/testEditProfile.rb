require File.expand_path '../../test_helper.rb', __FILE__

class TestEditProfile < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_edit_profile
    user = User.find_by(username: "testuser")
    unless user.nil?
      user.destroy
    end
    put '/api/v1/register/testuser/testpassword'
    user = JSON.parse(last_response.body)
    user_id = user["id"]
    put "/api/v1/users/#{user_id}/profile", birthday: "01-01-1990" , nickname: "test", description: "I am tall"
    user =  JSON.parse(last_response.body)
    assert_equal user["birthday"], "1990-01-01"
    assert_equal user["nickname"], "test"
    assert_equal user["description"], "I am tall"

    user = User.find_by(username: "testuser")
    user.destroy
  end
end
