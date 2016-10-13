get '/api/v1/users/:user_id/timeline' do
    # Just means return recent n tweets.
    n = 20
    join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: params[:user_id])
    join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('followerfollowings.user_id,followerfollowings.followed_user_id,tweets.content,tweets.create_time').to_json
end
