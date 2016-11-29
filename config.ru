require './app'
require "rack-timeout"
use Rack::Timeout, service_timeout: 250

run Sinatra::Application
