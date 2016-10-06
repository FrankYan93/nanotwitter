ENV['RACK_ENV'] = 'test'
require 'test/unit'
require 'rack/test'

require './app.rb'

class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_without_authentication
    get '/protected'
    assert_equal 401, last_response.status
  end

  def test_with_bad_credentials
    authorize 'bad', 'boy'
    get '/protected'
    assert_equal 401, last_response.status
  end

  def test_with_proper_credentials
    authorize 'admin', 'admin'
    get '/protected'
    assert_equal 200, last_response.status
    assert_equal "You're welcome", last_response.body
  end
end
