module SearchHelper
  def result_title(klass, results, query)
    if results.referenced_match?
      "Suggested #{klass.to_s.pluralize.downcase} for #{content_tag(:mark, query)}:"
    else
      "#{klass.to_s.pluralize.capitalize} that contain #{content_tag(:mark, query)}:"
    end.html_safe
  end
end
