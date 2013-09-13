module Commodities
  class ChangesController < ::ChangesController
    def changeable
      @changeable ||= CommodityPresenter.new(Commodity.find(params[:commodity_id], query_params))
    end
  end
end
