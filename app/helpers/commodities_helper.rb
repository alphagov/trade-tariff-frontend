module CommoditiesHelper
  def commodity_tree(commodities)
    tree = ""

    commodities.each_with_index do |commodity, index|
      tree << content_tag(:li, "#{'-' * (index + 1)} #{commodity.description} (#{commodity.short_code})")
    end

    tree
  end

  def format_commodity_code(commodity)
    code = commodity.display_short_code.to_s
    "#{code[0..1]}&nbsp;#{code[2..3]}&nbsp;#{code[4..-1]}".html_safe
  end
end
