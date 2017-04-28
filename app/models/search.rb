class Search
  attr_reader :term
  def initialize(options = {})
    @term = options.fetch(:term, "")
  end

  def posts
    Micropost.search do
      fulltext term
    end.results
  end
   
end