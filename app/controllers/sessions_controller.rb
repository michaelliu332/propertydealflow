class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth)
    user.update_attributes(
      :token      => auth['credentials']['token'],
      :secret     => auth['credentials']['secret'],
      :name       => auth["user_info"]["name"],
      :nickname   => auth["user_info"]["nickname"],
      :avatar     => auth["user_info"]["image"]
    )
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
  
  def failure
    redirect_to root_url, :alert => 'Sorry, there was something wrong with your login attempt. Please try again.'
  end
end
