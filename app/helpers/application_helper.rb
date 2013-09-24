module ApplicationHelper
  def markdown(markdown_text, renderer = markdown_renderer)
    renderer.render(markdown_text).html_safe
  end

  private

  def markdown_renderer
    renderer = Redcarpet::Render::XHTML.new(filter_html: true)

    @note_renderer ||= Redcarpet::Markdown.new(renderer,
                                               autolink: true,
                                               space_after_headers: true,
                                               tables: true,
                                               superscript: true)
  end
end
