class ChapterPresenter < TradeTariffFrontend::Presenter
  attr_reader :chapter

  def initialize(chapter)
    @chapter = chapter
  end

  def link
    view_context.chapter_path(@chapter)
  end

  private

  def method_missing(*args, &block)
    @chapter.send(*args, &block)
  end
end
