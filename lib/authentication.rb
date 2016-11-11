module Authentication
  def Authentication.authenticate!
    if session[:user_id] == nil
      session[:original_request] = request.path_info
      redirect '/signin'
    end
  end
end
