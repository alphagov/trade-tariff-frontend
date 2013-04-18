class SectionPresenter
  attr_reader :section

  def initialize(section)
    @section = section
  end

  def section_note
    @section_note ||= note_renderer.render(section.section_note.to_s)
  end

  def to_param
    position
  end

  def to_s
    title
  end

  private

  def note_renderer
    @note_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::XHTML,
                                               autolink: true,
                                               space_after_headers: true,
                                               tables: true,
                                               superscript: true)
  end

  def method_missing(*args, &block)
    @section.send(*args, &block)
  end
end
