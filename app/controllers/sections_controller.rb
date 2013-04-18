class SectionsController < ApplicationController
  def index
    @tariff_updates = TariffUpdate.all
    @sections = Section.all
    @section_css = 'sections-context'
  end

  def show
    @section = SectionPresenter.new(Section.find(params[:id], query_params))
    @chapters = @section.chapters
  end
end
