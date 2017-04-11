class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Login Successfull"
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end  
  end

  def destroy 
    log_out if logged_in?
    flash[:notice] = "Loged out!"
    redirect_to root_path
  end
end
