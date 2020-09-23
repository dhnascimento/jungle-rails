class SessionsController < ApplicationController
 
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      puts user
      session[:username] = user.first_name
      session[:user_id] = user.id
      redirect_to '/'
    else
      if params[:email].empty? || params[:password].empty?
        flash[:blank] = "Please fill in all the fields"
      else
        flash[:error] = "Wrong Email or Password!"
      end  
        redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
  
  add_flash_types :error, :blank

end
