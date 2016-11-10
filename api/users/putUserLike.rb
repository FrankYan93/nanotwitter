put '/api/v1/users/:user_id/likes/:tweet_id' do
    heLike(params).to_json
end

def heLike params
  newlike = Like.new
  newlike.user_id = params['user_id']
  newlike.tweet_id = params['tweet_id']
  newlike.save!
  if newlike.tweet.like_numbers.nil?
      newlike.tweet.like_numbers = 1
  else
      newlike.tweet.like_numbers += 1
  end
  newlike.tweet.save
  # invoke notification to corresponding tweet_id 
  newlike
end
