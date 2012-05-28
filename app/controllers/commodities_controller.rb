class CommoditiesController < ApplicationController
  def show
    @commodity = Commodity.find(params[:id])
    @heading = @commodity.heading
    @chapter = @commodity.chapter
    @section = @commodity.section
  end
end
