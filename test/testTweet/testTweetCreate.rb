require File.expand_path '../../test_helper.rb', __FILE__

class TestTweetCreate < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    put '/api/v1/register/bbb/bbb'#, :username => 'ddd', :password => 'dddd'
    #get '/api/v1/users/', :user_id => '1'
    #puts User.all
    puts last_response.body
    puts last_response
    assert last_response.body.include?('1')
  end


end
