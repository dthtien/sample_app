class HastagsController < ApplicationController
  def show
    @hastags_post = Search.new(term: "##{params[:id]}") 
  end
end   