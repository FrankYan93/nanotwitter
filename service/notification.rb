get '/warnnonlogin' do
  erb :warnnonlogin
end

get '/notification' do
  puts ENV['NANONOTI']
  uri=URI(ENV['NANONOTI']+"/api/v1/users/#{session[:user_id]}/notifications")
  @responseArray=JSON.parse Net::HTTP.get(uri)
  @n=(params["n"]||0).to_i
  erb :notification
end
