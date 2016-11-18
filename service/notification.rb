get '/warnnonlogin' do
  erb :warnnonlogin
end

get '/notification' do
  if session[:user_id].nil?
    redirect '/warnnonlogin'
  else
    z = ENV['NANONOTI']+"/api/v1/users/#{session[:user_id]}/notifications"
    puts z
    uri=URI(z)
    #@responseArray=JSON.parse
    puts Net::HTTP.get(uri)
    @n=(params["n"]||0).to_i
    @user=User.find(session[:user_id])
    erb :notification
  end
end

get '/notitest' do
  z=ENV['NANONOTI']
  uri=URI(z)
  Net::HTTP.get(uri)  
end
