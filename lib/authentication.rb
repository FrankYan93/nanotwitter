module Authentication
  def Authentication.authenticate!
    unless session[:user]
      session[:original_request] = request.path_info
      redirect '/signin'
    end
  end
end
