put '/api/v1/users/:user_id/unlike/:tweet_id' do
  heUnlike params
end

def heUnlike params
  unLike = Like.where(tweet_id: params[:tweet_id]).find_by(user_id: params[:user_id])
  tweet = Tweet.find_by(id: params[:tweet_id])
   unless tweet.nil?
     tweet.like_numbers -=1
     tweet.save
   end
  unLike.destroy
end
