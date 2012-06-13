module SearchHelper
  def render_synonyms(synonyms)
    list_body = ""

    synonyms.split(/ /).uniq.each { |synonym|
      list_body << content_tag(:span, synonym, class: "label label-info")
      list_body << " "
    }

    list_body
  end
end
