module ApplicationHelper
  def flash_messages
    html = ''
    flash.each do |key, value|
      html << "<div class=\"alert-message #{key}\">\n"
      html << "  <a class=\"close\" href=\"#\">x<\/a>\n"
      html << "  <p>#{value}</p>\n"
      html << "<\/div>\n"
    end
    html.html_safe
  end
end
