## NanoTwitter
NanoTwitter is a app with basic function of twitter. You can follow other users, tweet, like tweets and so on.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
### Installing
1. download for our website
2. double click the icon
```
Give some code exmaple
```

### Running the tests
**How to run tests**
* rake (run all minitests)
* ruby test/testUser/testGet.rb
* ruby test/testUser/testUserCreate.rb
* ruby test/testUser/testFollowUnfollow.rb
* ruby test/testUser/testEditProfile.rb
* ruby test/testTweet/testTweetCreate.rb
```
Give some code exmaple
```
### Deployment

## Built with
* Ruby
* Sinatra
* Activerecord
* PostgreSQL
* Javascript
* JQuery
* Bootstrap
* Bootbox
* Rake
* Redis
* RabbitMQ
* Resque
* Rack
* ...

## Versioning

## Authors
* **Jiadong Yan**
* **Jiaming Xu**
* **Xinyi Jiang**

## License
This project is licensed under xxx License
## Acknowledgments

## Tips

1. To run the test, conduct "rake db:test:prepare" and "rake db:test:load"
   Then type "rake" in the terminal to run all the test

2. Reset database: "heroku pg:reset DATABASE_URL"

3. We must flushall redis after test api used, and restart app.

4. heroku run rake db:migrate
