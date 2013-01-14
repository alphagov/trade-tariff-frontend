class CommoditiesController < ApplicationController
  def show
    @commodity = CommodityPresenter.new(Commodity.find(params[:id], query_params), params[:country])
    @heading = @commodity.heading
    @chapter = @commodity.chapter
    @section = @commodity.section
  end
end
