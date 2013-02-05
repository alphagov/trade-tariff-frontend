require 'api_entity'

class NationalMeasurementUnit
  include ApiEntity

  attr_accessor :measurement_unit_code, :description, :level

  def description_map
    {
     '048' => 'Hectokilogram Net Dry Matter (100kg/net mas)',
     '070' => 'Standard Litre of Hydrocarbon Oil',
     '100' => '% Lactic Matter / 100 Kg Product',
     '101' => '% Lactic Dry Matter / 100 Kg Product',
     '102' => '% Sucrose Content / 100 Kg Net',
     '104' => '% Added Sugar / 100 Kg',
     '106' => '% Actual Alcoholic Strength / Hectolitre',
    }
  end

  def description
    description_map.fetch(measurement_unit_code, format(attributes[:description]))
  end

  def present?
    measurement_unit_code.present?
  end

  def to_s
    description
  end

  private

  def format(description = '')
    description.downcase.titlecase
  end
end
