class HeadingCommodityPresenter
  def initialize(commodities)
    @commodities = commodities
  end

  def root_commodities
    @commodities.select(&:root)
  end
end
