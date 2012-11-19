module CommoditiesHelper
  def commodity_level(commodity)
    "level-#{commodity.number_indents}"
  end

  def commodity_tree(main_commodity, commodities)
    if commodities.any?
      content_tag(:dl, class: 'commodities') do
        content_tag(:dt, commodities.first.to_s) +
        content_tag(:dd, tree_node(main_commodity, commodities, commodities.first.number_indents))
      end
    else
      content_tag(:dl, class: 'commodities') do
        content_tag(:dt, commodity_heading(main_commodity))
      end
    end
  end

  def format_commodity_code(commodity)
    code = commodity.display_short_code.to_s
    "#{code[0..1]}&nbsp;#{code[2..3]}&nbsp;#{code[4..-1]}".html_safe
  end

  private

  def tree_node(main_commodity, commodities, depth)
    deeper_node = commodities.select{ |c| c.number_indents == depth + 1 }.first

    if deeper_node.present?
      content_tag(:dd) do
        content_tag(:dl) do
          content_tag(:dt, deeper_node) +
          tree_node(main_commodity, commodities, deeper_node.number_indents)
        end
      end
    else
      content_tag(:dd, commodity_heading(main_commodity))
    end
  end

  def commodity_heading(commodity)
    content_tag(:h1) do
      content_tag(:span, format_commodity_code(commodity),
                         title: "Full tariff code: #{commodity.code}",
                         class: 'identifier',
                         'aria-describedby' => "commodity-#{commodity.code}") +
      content_tag(:span, commodity,
                          class: 'description',
                          id: "commodity-#{commodity.code}")
    end
  end

  def declarable_heading(commodity)
    content_tag(:h1) do
      content_tag(:span, commodity,
                          class: 'description',
                          id: "commodity-#{commodity.code}")
    end
  end
end
