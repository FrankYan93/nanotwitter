get '/api/v1/users/:user_id' do
  puts "get_user!!!"
  get_user=User.find(params[:user_id])
  get_user.to_json
end
