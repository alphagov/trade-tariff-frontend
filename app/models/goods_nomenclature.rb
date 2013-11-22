require 'api_entity'

class GoodsNomenclature
  include ApiEntity

  attr_accessor :validity_start_date,
                :validity_end_date,
                :goods_nomenclature_item_id,
                :formatted_description,
                :description

  def validity_start_date=(validity_start_date)
    @attributes['validity_start_date'] = Date.parse(validity_start_date.to_s) if validity_start_date.present?
  end

  def validity_start_date
    @attributes['validity_start_date'].presence || NullObject.new
  end

  def validity_end_date=(validity_end_date)
    @attributes['validity_end_date'] = Date.parse(validity_end_date.to_s) if validity_end_date.present?
  end

  def validity_end_date
    @attributes['validity_end_date'].presence || NullObject.new
  end
end
