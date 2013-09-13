class GoodsNomenclatureChangePresenter < ChangePresenter
  def title
    "Commodity #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def content
    "Commodity #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def anchor_link
  end
end
