module ApplicationHelper
  def govspeak(text)
    Govspeak::Document.new(text).to_html.html_safe
  end
end
