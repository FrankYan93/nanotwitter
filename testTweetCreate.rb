ENV['RACK_ENV'] = 'test'

require './app.rb'
require 'test/unit'
require 'rack/test'

class TestTweetCreate < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    put '/api/v1/register/', :username => 'ddd', :password => 'dddd'
    get '/api/v1/users/', :user_id => '1'
    #assert last_response.ok?
    puts last_response.body
    puts last_response
    assert last_response.body.include?('1')
  end

#  def test_it_says_hello_to_a_person
#    get '/', :name => 'Simon'
#    assert last_response.body.include?('Simon')
#  end
end
