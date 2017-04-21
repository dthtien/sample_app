class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]


  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:alert] = "Email address not found"
      render :new
    end
  end


  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.error.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attribute(user_params)
      login @user
      flash[:notice] = "Password has been reset"
      redirect_to @user
    else
      flash.now[:alert] = "Error"
      render :edit
    end
  end


  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def set_user 
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        flash[:alert] = "Error password reset"
        redirect_to root_path
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:alert] = "Password reset has exired"
        redirect_to new_password_reset_url
      end
    end
end
