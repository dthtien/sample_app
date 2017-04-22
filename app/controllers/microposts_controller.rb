class MicropostsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "Micropost created!"
      redirect_to root_path
    else
      flash[:alert] = "Micropost cant't create"
      redirect_to root_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "Deleted"
    redirect_to request.referrer || root_path
  end

  private 
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = Micropost.find(params[:id])
      if current_user.cannot_destroy?(@micropost)
        flash[:alert] = "You have no permission"
        redirect_to root_path
      end
    end
end
