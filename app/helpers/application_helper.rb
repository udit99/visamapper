module ApplicationHelper

  def current_user
    return @current_user if defined?(@current_user)      
    @current_user = User.find(session[:user_id])
  end
end
