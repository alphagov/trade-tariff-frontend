class ChapterChangePresenter < ChangePresenter
  def title
    "Chapter #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def content
    "Chapter #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def anchor_link
  end
end
