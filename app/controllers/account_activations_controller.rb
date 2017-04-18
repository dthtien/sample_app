class AccountActivationsController < ApplicationController

  def edit 
    user = User.find_by(eamil: params[:email])
    if user &&!user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:notice] = "Account activated!"
      redirect_to user
    else
      flash[:alert] = "Invalid activation link"
      redirect_to root_path
    end
  end
end
