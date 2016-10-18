put '/api/v1/users/:user_id/unlike/:tweet_id' do
    unLike = Like.where(tweet_id: params[:tweet_id]).find_by(user_id: params[:user_id])
    unLike.destroy
end
