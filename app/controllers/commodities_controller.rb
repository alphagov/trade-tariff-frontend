class CommoditiesController < ApplicationController
  def index
    @section = Section.find(params[:section_id])
    @chapter = @section.chapters.find(params[:chapter_id])
    @commodities = @chapter.commodities
  end
end
