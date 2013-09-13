class CommodityPresenter < DeclarablePresenter
  def show_commodity_tree?
    true
  end

  def self.model_name
    Commodity.model_name
  end
end
