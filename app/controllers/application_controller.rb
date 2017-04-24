class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # rescue_from ActiveRecord::RecordNotFound, with: :not_available
  include SessionsHelper
  protected
    def authenticate_user
      unless logged_in?
        store_location
        redirect_to login_path
        flash[:alert] = "Login to continue"
      end
    end

    def not_available
      flash[:alert] = "Page not found"
      redirect_to root_path
    end
end
