module ApplicationHelper
  def full_title page_title = ''
    base_title = "BTGA"
    if page_title
      page_title + " | " + base_title
    else
      base_title
    end
  end
end
