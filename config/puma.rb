workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

timeout 20

before_fork do
  if defined?(::ActiveRecord) && defined?(::ActiveRecord::Base)
         ActiveRecord::Base.connection_pool.disconnect!
       end

end

on_worker_boot do
  # Valid on Rails up to 4.1 the initializer method of setting `pool` size
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
