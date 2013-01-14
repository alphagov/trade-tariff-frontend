require 'api_entity'

class GeographicalArea
  include ApiEntity

  collection_path "/geographical_areas/countries"

  attr_accessor :iso_code, :description, :geographical_area_id

  has_many :children_geographical_areas, class_name: 'GeographicalArea'

  def self.countries
    all.sort_by(&:iso_code)
  end

  def group_key
    children_geographical_areas.any? ? "0" : "1"
  end

  def description
    attributes['description'].presence || ''
  end

  def id
    geographical_area_id.presence || iso_code
  end

  def to_s
    description
  end
end
