module ApplicationHelper
  # Return the full title on a per-page basis
  def full_title(page_title='')
    base_title = "SampleApp"    
    if page_title.empty?
      base_title
    else
        page_title + ' | ' + base_title
    end
  end

  def posterize text
    link_hastags(strip_tags(text)).html_safe
  end

  private
    def link_hastags text
      text.gsub(/#(\w+)/) { |match| link_to match, hastag_path($1) }
    end

end
