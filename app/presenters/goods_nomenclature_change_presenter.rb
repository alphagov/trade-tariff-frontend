class GoodsNomenclatureChangePresenter < ChangePresenter
  def title
    "Commodity #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"
  end

  def content
    %Q{
      Commodity #{change_record.goods_nomenclature_item_id} ('#{change_record.description}') #{operation_name}"

      #{effective_start_date}
      #{effective_end_date}
    }.strip
  end

  def anchor_link
  end

  def effective_start_date
    "Effective start date: #{validity_start_date}"
  end

  def effective_end_date
    "Effective end date: #{validity_end_date}" if validity_end_date.present?
  end

  private

  def validity_start_date
    change_record.validity_start_date.to_formatted_s(:default)
  end

  def validity_end_date
    change_record.validity_end_date.to_formatted_s(:default)
  end
end
