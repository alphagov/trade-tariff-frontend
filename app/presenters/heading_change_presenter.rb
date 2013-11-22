class HeadingChangePresenter < GoodsNomenclatureChangePresenter
  def title
    "Heading #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def content
    %Q{
      Heading #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}

      #{effective_start_date}
      #{effective_end_date}
    }.strip
  end

  def anchor_link
  end
end
