class HeadingsController < GoodsNomenclaturesController
  def show
    @heading = HeadingPresenter.new(Heading.find(params[:id], query_params))
    @commodities = HeadingCommodityPresenter.new(@heading.commodities)
  end

  def changes
    @heading = HeadingPresenter.new(Heading.find(params[:id], query_params))
    @changes = ChangesPresenter.new(@heading.changes)

    respond_to do |format|
      format.atom
    end
  end

  private

  def goods_code_id
    super.first(4)
  end
end
