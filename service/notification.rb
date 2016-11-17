get '/warnnonlogin' do
  erb :warnnonlogin
end

get '/notification' do
  puts ENV['NANONOTI']
  uri=URI(ENV['NANONOTI']+"/api/v1/users/#{session[:user_id]}/notifications")
  @responseArray=Net::HTTP.get(uri)  
  erb :notification
end
