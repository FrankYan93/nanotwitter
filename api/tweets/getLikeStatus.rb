get '/api/v1/likeStatus/:user_id/:tweet_id' do
  userLikeTweet params
end

def userLikeTweet params
  return false if params[:user_id]==-1
  updateLike params[:user_id]

  if $redis.sismember("#{params[:user_id]}_like",params[:tweet_id])
    true
  else
    false
  end
end
