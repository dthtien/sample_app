class SearchesController < ApplicationController
  def show
    @search = Search.new(params[:search])
  end

  private
    def search_params

    end
      
end
