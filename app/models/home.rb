class Home 
  def initialize(user, page)
    @user = user
    @page = page
  end

  def new_micropost
    @user.microposts.build   
  end 

  def timeline
    @user.feed.paginate(page: @page)
  end
end