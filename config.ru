require './app'
require "rack-timeout"
use Rack::Timeout, service_timeout: 25

run Sinatra::Application
