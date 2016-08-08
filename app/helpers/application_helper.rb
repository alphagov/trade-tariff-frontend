module ApplicationHelper
  def govspeak(text)
    Govspeak::Document.new(text).to_sanitized_html.html_safe
  end

  def a_z_index(letter = 'a')
    ('a'..'z').map do |index_letter|
      content_tag(:li, class: "#{'active' if index_letter == letter}") do
        link_to index_letter.upcase, a_z_index_path(letter: index_letter)
      end
    end.join.html_safe
  end

  def breadcrumbs
    crumbs = [ content_tag(:li, link_to( 'Home', '/' )) ]
    content_tag(:ol, crumbs.join('').html_safe, role: "breadcrumbs")
  end
end
