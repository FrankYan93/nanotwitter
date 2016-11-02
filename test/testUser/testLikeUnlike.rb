require File.expand_path '../../test_helper.rb', __FILE__

class TestLikeUnlike < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_put_like_and_unlike
    get '/api/v1/test/reset/all'

    put '/api/v1/register/testuser1/testpassword1'
    user1 = JSON.parse(last_response.body)
    user1_id = user1["id"]

    put '/api/v1/register/testuser2/testpassword2'
    user2 = JSON.parse(last_response.body)
    user2_id = user2["id"]

    put "/api/v1/users/#{user2_id}/tweets/tall"
    tweet =  JSON.parse(last_response.body)
    tweet_id = tweet["id"]

    put "/api/v1/users/#{user1_id}/likes/#{tweet_id}"


    tweet = Tweet.find_by(id: tweet_id)
    assert_equal tweet["like_numbers"], 1

    put "/api/v1/users/#{user1_id}/unlike/#{tweet_id}"

    tweet = Tweet.find_by(id: tweet_id)
    assert_equal tweet["like_numbers"], 0

    get '/api/v1/test/reset/all'
  end
end
