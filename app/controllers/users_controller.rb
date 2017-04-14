class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page],per_page: 10)
  end

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
      log_in @user
      flash[:notice] = "User create successful"
      redirect_to @user
    else
      flash.now[:alert] = "Can't create user !"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Update profile successful"
      redirect_to @user
    else
      flash.now[:alert] = "Can't update user: #{current_user.name}"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted"
    redirect_to users_url
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:alert] = 'You have no permission'
        redirect_to root_path
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end