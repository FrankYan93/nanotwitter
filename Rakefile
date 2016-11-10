$rakedb=true
require './app'
$rakedb=false

require 'sinatra/activerecord/rake'
require 'zlib'
require 'resque/tasks'

namespace :db do
    task :load_config do
        $rakedb=true
        require './app'
        $rakedb=false
    end
end

task :default => :test
task :test do
  Dir.glob('./test/testTweet/*.rb').each { |file| require file}
  Dir.glob('./test/testUser/*.rb').each { |file| require file}
end
#
# task :initRedis do
#   require_relative 'cache_redis.rb'
# end
