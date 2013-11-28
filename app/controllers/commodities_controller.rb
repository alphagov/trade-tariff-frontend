class CommoditiesController < GoodsNomenclaturesController
  def show
    @commodity = CommodityPresenter.new(Commodity.find(params[:id], query_params))
    @heading = @commodity.heading
    @chapter = @commodity.chapter
    @section = @commodity.section
  end
end
