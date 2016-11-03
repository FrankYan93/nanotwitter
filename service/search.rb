get '/searchTweet' do
    @word = params[:word]
    @tweets = Tweet.where('content LIKE :query', query: "%#{@word}%").all

    erb :showSearchTweet


end

get '/searchUser' do
    @word = params[:word]
    @users = User.where('username LIKE :query', query: "%#{@word}%").all

    erb :showSearchUser
end
