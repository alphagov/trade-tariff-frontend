class CommoditiesController < GoodsNomenclaturesController
  def show
    @commodity = CommodityPresenter.new(Commodity.find(params[:id], query_params))
    @heading = @commodity.heading
    @chapter = @commodity.chapter
    @section = @commodity.section
  end

  def changes
    @commodity = CommodityPresenter.new(Commodity.find(params[:id], query_params))
    @changes = ChangesPresenter.new(@commodity.changes)

    respond_to do |format|
      format.atom
    end
  end

  private

  def goods_code_id
    super.first(10)
  end
end
