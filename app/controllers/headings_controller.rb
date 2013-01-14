class HeadingsController < ApplicationController
  def show
    @heading = HeadingPresenter.new(Heading.find(params[:id], query_params), search_query.country)
    @commodities = HeadingCommodityPresenter.new(@heading.commodities)
  end
end
