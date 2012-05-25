require 'api_entity'

class Measure
  include ApiEntity

  attr_accessor :id, :measure_type, :origin, :duty_rates

  has_many :conditions
  has_many :footnotes
  has_many :additional_codes
  has_many :excluded_countries, class_name: 'Region'
  has_one  :legal_act
  has_one  :region
end
