get '/api/v1/likeStatus/:user_id/:tweet_id' do
  userLikeTweet params
end

def userLikeTweet params
  theLike=Like.where(user_id: params[:user_id],tweet_id: params[:tweet_id])
  if theLike.size.zero?
    #puts 'false'
    false
  else
    #puts 'true'
    true
  end
end
