# NanoTwitter  [![Code Climate](https://codeclimate.com/github/FrankYan93/nanotwitter/badges/gpa.svg)](https://codeclimate.com/github/FrankYan93/nanotwitter)
NanoTwitter is a app with basic function of twitter. You can follow other users, tweet, like tweets and so on.

# Authors

- **Jiadong Yan**
- **Jiaming Xu**
- **Xinyi Jiang**

# Getting Started

Notification service repo: https://github.com/FrankYan93/nanoNotification
We must visit https://nano-notification.herokuapp.com/start to start our web service for notification.
Main website: https://nano-twitter-dratini.herokuapp.com

## Running the tests

**How to run tests**
  ```
rake (run all minitests)
ruby test/testUser/testGet.rb
ruby test/testUser/testUserCreate.rb
ruby test/testUser/testFollowUnfollow.rb
ruby test/testUser/testEditProfile.rb
ruby test/testTweet/testTweetCreate.rb

  ```
# Screenshots

# Deployment

# Built with

- Ruby
- Sinatra
- Activerecord
- PostgreSQL
- Javascript
- JQuery
- Bootstrap
- Bootbox
- Rake
- Redis
- RabbitMQ
- Resque
- Rack
- ...

# Versioning
nT1.0

# License

This project is licensed under xxx License

# Acknowledgments

# Tips

1. To run the test, conduct `rake db:test:prepare` and `rake db:test:load`
   Then type `rake` in the terminal to run all the test


2. Reset database: `heroku pg:reset DATABASE_URL`


3. We must flush all redis after test api used, and restart app.
run `heroku redis:cli`  `flushall`

4. `heroku run rake db:migrate`

5. `lsof -i :4567` to see which process is running in port 4567

6. https://nano-notification.herokuapp.com/start will start the rabbitmq notification service


# Steps in local:

1. git clone
2. install redis in local and run redis by `redis-server` links: <http://download.redis.io/releases/redis-3.2.5.tar.gz> follow readme to install redis first
3. install RabbitMQ server by `brew update`, `brew install rabbitmq`, should first install brew first. Run rabbitmq by `rabbitmq-server` if you have some problem to start, try `sudo chown $(whoami) /usr/local/share/man/man3` and `sudo chown $(whoami) /usr/local/share/man/man5`
4. install all gems by `bundle install`
5. install `postgreSQL` and open it
6. run `rake db:migrate`
7. run `ruby app.rb` to start the service
8. open `0.0.0.0:4567` in the web browser
9. reset data using test api
10. done!
