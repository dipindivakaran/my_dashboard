class UsersController < ApplicationController


  def signup
    @user = User.new(@params[:user])
    if request.post?
      if user.save?
        session[:user] = User.authenticate(@user.email_id,@user.password)
        redirect_to :action=>'home'
       end
    end
  end

  def login
   @user = User.new
  end

  def validate_login
    if request.post?
      if (session[:user]=User.authenticate(params[:user][:email_id],params[:user][:password]))
        puts "################ SESSION CREATED ",session[:user].to_yaml
        redirect_to :controller=>'todo_lists' , :action=>'home'
       return
      else
        flash[:message] = "Invalid username/password"
      end
    end
    redirect_to :action=>'login'
  end


  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

 def auth2callback
   auth_param = request.env["omniauth.auth"]
   if (session[:user]= auth_param.extra.raw_info.email)
     puts " ################ RAW INFO ################",auth_param.extra.raw_info
    flash[:user] = auth_param.extra.raw_info.email
    redirect_to :controller=>'todo_lists' , :action=>'home'
    else
        flash[:message] = "Invalid username/password"
    redirect_to :action=>'login'
   end

 end


end
