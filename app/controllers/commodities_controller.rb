class CommoditiesController < ApplicationController
  before_filter :fetch_parents

  def index
    @commodities = @heading.commodities
  end

  def show
    @commodity = @heading.commodities.find(params[:id])
  end

  private

  def fetch_parents
    @section = Section.find(params[:section_id])
    @chapter = @section.chapters.find(params[:chapter_id])
    @heading = @chapter.headings.find(params[:heading_id])
  end
end
