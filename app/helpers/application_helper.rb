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
    if @artefact && @artefact.primary_section
      @artefact.non_primary_sections.each do |section|
        crumbs << content_tag(:li, link_to( section.title, section.content_with_tag.web_url))
      end
      primary_link = link_to( @artefact.primary_section.title, @artefact.primary_section.content_with_tag.web_url)
      crumbs << content_tag(:li, content_tag(:strong, primary_link))
    end
    content_tag(:ol, crumbs.join('').html_safe, role: "breadcrumbs")
  end
end
