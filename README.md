# NanoTwitter

NanoTwitter is a app with basic function of twitter. You can follow other users, tweet, like tweets and so on.

# Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Installing

1. download for our website
2. double click the icon

  ```
  Give some code exmaple
  ```

## Running the tests

**How to run tests**

- rake (run all minitests)
- ruby test/testUser/testGet.rb
- ruby test/testUser/testUserCreate.rb
- ruby test/testUser/testFollowUnfollow.rb
- ruby test/testUser/testEditProfile.rb
- ruby test/testTweet/testTweetCreate.rb

  ```
  Give some code exmaple
  ```

  ### Deployment

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

# Authors

- **Jiadong Yan**
- **Jiaming Xu**
- **Xinyi Jiang**

# License

This project is licensed under xxx License

# Acknowledgments

# Tips

1. To run the test, conduct "rake db:test:prepare" and "rake db:test:load" Then type "rake" in the terminal to run all the test

2. Reset database: "heroku pg:reset DATABASE_URL"

3. We must flushall redis after test api used, and restart app.
   run "heroku redis:cli"  "flushall" "Ok"

4. heroku run rake db:migrate
   heroku run rake db:seed

5. https://nano-notification.herokuapp.com/start will start the rabbitmq notification service


# Steps in local:

1. git clone

  <links from="" github="">
  </links>

2. install redis in local and run redis by "redis-server" links: <http://download.redis.io/releases/redis-3.2.5.tar.gz> follow readme to install redis first

3. install RabbitMQ server by "brew update", "brew install rabbitmq", should first install brew first. Run rabbitmq by "rabbitmq-server" if you have some problem to start, try "sudo chown $(whoami) /usr/local/share/man/man3" and "sudo chown $(whoami) /usr/local/share/man/man5"
4. install all gems by "bundle install"
5. install postgreSQL and open it
6. run "rake db:migrate"
7. run "ruby app.rb" to start the service
8. open "0.0.0.0:4567" in the web browser
9. reset data using test api
10. done!
