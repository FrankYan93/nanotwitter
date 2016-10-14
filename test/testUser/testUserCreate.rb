require File.expand_path '../../test_helper.rb', __FILE__

class TestTweetCreate < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_create_new_user
    newUser = put '/api/v1/register/dd/dddd'
    #put '/api/v1/register/',:username => "dd", :password => "ddd"
    #get '/api/v1/users/', :user_id => '1'
    #puts User.all
    puts newUser.body 
    assert last_response.body.include?('1')
  end


end
