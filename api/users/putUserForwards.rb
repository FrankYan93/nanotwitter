put '/api/v1/users/:user_id/forwards/:tweet_id' do
    heForward(params).to_json
end

def heForward params
  newForward = Tweet.new
  oldTweet = Tweet.find(params[:tweet_id])
  newForward.content = oldTweet.content
  newForward.is_forwarding = true
  newForward.forward_id = params[:tweet_id]
  newForward.create_time = Time.now
  newForward.user_id = params[:user_id]
  newForward.is_mentioning = oldTweet.is_mentioning
  newForward.has_hashtag = oldTweet.has_hashtag
  if oldTweet.forwarded_number.nil?
      oldTweet.forwarded_number = 1
  else
      oldTweet.forwarded_number += 1
  end
  oldTweet.save
  newForward.save
  newForward
end
