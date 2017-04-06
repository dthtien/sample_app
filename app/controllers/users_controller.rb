class UsersController < ApplicationController

  # GET
  def show
    @user = User.find(params[:id])
    # debugger
  end
  # GET
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User create successful"
      redirect_to @user
    else
      flash.now[:alert] = "Error !"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
