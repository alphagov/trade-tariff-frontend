class ChapterPresenter
  attr_reader :chapter

  def initialize(chapter)
    @chapter = chapter
  end

  def chapter_note
    @chapter_note ||= note_renderer.render(chapter.chapter_note.to_s)
  end

  def to_param
    chapter.short_code
  end

  def to_s
    chapter.formatted_description.mb_chars.downcase.to_s.gsub(/^(.)/) { $1.capitalize }
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
    @chapter.send(*args, &block)
  end
end
