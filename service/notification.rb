get '/warnnonlogin' do
  erb :warnnonlogin
end

get '/notification' do
  if session[:user_id].nil?
    redirect '/warnnonlogin'
  else
    uri=URI(ENV['NANONOTI']+"/api/v1/users/#{session[:user_id]}/notifications")
    @responseArray=JSON.parse Net::HTTP.get(uri)
    @n=(params["n"]||0).to_i
    @user=User.find(session[:user_id])
    erb :notification
  end
end
