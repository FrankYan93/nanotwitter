put '/api/v1/users/:user_id/tweets/:content' do
    user = User.find(params['user_id'])
    newtweet = Tweet.new
    newtweet.username = user.username
    newtweet.nickname = user.nickname
    newtweet.content = params['content']
    newtweet.user_id = params['user_id']
    newtweet.create_time = Time.now
    newtweet.save!
    newtweet.to_json
end
