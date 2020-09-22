class SessionsController < ApplicationController
 
  def new
  end

  def create
    # If users' login work, send them to home page 
    if user = User.authenticate_with_credentials(params[:email], params[:password]).
      session[:username] = user.name
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If users' login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
