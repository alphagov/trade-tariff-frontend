class HeadingsController < GoodsNomenclaturesController
  def show
    @heading = HeadingPresenter.new(Heading.find(params[:id], query_params))
    @commodities = HeadingCommodityPresenter.new(@heading.commodities)
  end
end
