class SectionsController < ApplicationController
  def index
    @tariff_updates = TariffUpdate.all
    @sections = Section.all
    @section_css = 'sections-context'
  end

  def show
    @section = Section.find(params[:id], query_params)
    @chapters = @section.chapters
  end
end
