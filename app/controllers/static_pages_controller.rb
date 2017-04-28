class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @home = Home.new(current_user, params[:page])
      # @micropost = current_user.microposts.build
      # @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
