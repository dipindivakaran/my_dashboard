class ApplicationController < ActionController::Base
  
  def login_required
    if session[:user]
        return true
      else
    end 
    flash[:warning]='Please login to continue'
    redirect_to :controller => "users", :action => "login"
    return false
  end
  
  def current_user
    session[:user]
  end
  
end
