class SectionPresenter < TradeTariffFrontend::Presenter
  attr_reader :section

  def initialize(section)
    @section = section
  end

  def link
    view_context.section_path(@section)
  end

  private

  def method_missing(*args, &block)
    @section.send(*args, &block)
  end
end
