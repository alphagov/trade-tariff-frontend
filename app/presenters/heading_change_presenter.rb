class HeadingChangePresenter < ChangePresenter
  def title
    "Heading #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def content
    "Heading #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def anchor_link
  end
end
