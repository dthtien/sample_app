class RelationshipsController < ApplicationController
  before_action :authenticate_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respon_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respon_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
