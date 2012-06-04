module CommoditiesHelper
  def commodity_tree(commodities)
    tree = ""

    commodities.each_with_index do |commodity, index|
      tree << content_tag(:li, "#{'-' * (index + 1)} #{commodity.description} (#{commodity.short_code})")
    end

    tree
  end
end
