get '/api/v1/users/:user_id/timeline' do
  userHomeTimeline(params[:user_id]).to_json
end

def userHomeTimeline theId
  # Just means return recent n tweets.
  n = 20
  join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: theId)
  join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('followerfollowings.user_id,followerfollowings.followed_user_id,tweets.content,tweets.create_time')
end
