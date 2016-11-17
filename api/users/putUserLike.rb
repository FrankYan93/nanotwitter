put '/api/v1/users/:user_id/likes/:tweet_id' do
    params["username"]=User.find(params[:user_id]).username
    rpcClient params
    heLike(params).to_json
end

def heLike params
  newlike = Like.new
  newlike.user_id = params['user_id']
  newlike.tweet_id = params['tweet_id']
  newlike.save!
  $redis.sadd("#{params['user_id']}_like",params['tweet_id'])
  if newlike.tweet.nil?
      puts "This tweet does not exist!\nIt should not happen!"
  else
    if newlike.tweet[:like_numbers].nil?
      newlike.tweet[:like_numbers] = 1
    else
      newlike.tweet[:like_numbers] += 1
    end
    newlike.tweet.save
  end
  newlike
end
