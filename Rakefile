require './app'
require 'sinatra/activerecord/rake'
require 'zlib'

namespace :db do
    task :load_config do
        require './app'
    end
end

task :default => :test
task :test do
  Dir.glob('./test/testTweet/*.rb').each { |file| require file}
  Dir.glob('./test/testUser/*.rb').each { |file| require file}
end
