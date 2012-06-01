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

  def self.all(options={})
    heading_id = options[:heading_id]
    commodity_id = options[:commodity_id]
    type = options[:type]
    if heading_id
      resp = get("/headings/#{heading_id}/#{type}")
      measures = {}
      measures[:third_country_measures] = resp['third_country_measures'].map { |entry_data| new(entry_data) }
      measures[:specific_measures] = resp['specific_measures'].map { |entry_data| new(entry_data) }
    else
      resp = get("/commodities/#{commodity_id}/#{type}")
      measures = {}
      measures[:third_country_measures] = resp['third_country_measures'].map { |entry_data| new(entry_data) }
      measures[:specific_measures] = resp['specific_measures'].map { |entry_data| new(entry_data) }
    end
    measures
  end

end
