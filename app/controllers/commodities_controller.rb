class CommoditiesController < ApplicationController
  def index
    @commodities = @heading.commodities
  end

  def show
    @commodity = Commodity.find(params[:id])
    @heading = @commodity.heading
    @chapter = @heading.chapter
    @section = @chapter.section
  end
end
