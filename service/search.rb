get '/searchTweet' do
    @word = params[:word]
    @tweets = Tweet.where('content LIKE :query', query: "%#{@word}%").all

    @n = params[:n].to_i || 0

    erb :showSearchTweet
end

get '/searchUser' do
    @word = params[:word]
    @users = User.where('username LIKE :query', query: "%#{@word}%").all

    @n = params[:n].to_i || 0
    erb :showSearchUser
end
