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
    crumbs = [
      content_tag(:li, link_to( 'Home', '/' )),
      content_tag(:li, link_to( 'Business and self-employed', 'https://www.gov.uk/browse/business' )),
      content_tag(:li, link_to( 'Imports and exports', 'https://www.gov.uk/browse/business/imports' ))
    ]
    content_tag(:ol, crumbs.join('').html_safe, role: "breadcrumbs")
  end

  def search_active_class
    active_class_for(controller_methods: %w[sections chapters headings commodities])
  end

  def a_z_active_class
    active_class_for(controller_methods: %w[search_references])
  end

  private

  def active_class_for(controller_methods:)
    return "active" if controller_methods.include?(params[:controller])
  end
end
