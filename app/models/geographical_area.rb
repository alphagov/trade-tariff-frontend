require 'api_entity'

class GeographicalArea
  include ApiEntity

  collection_path "/geographical_areas/countries"

  attr_accessor :id, :description, :geographical_area_id

  has_many :children_geographical_areas, class_name: 'GeographicalArea'

  def self.countries
    excluded_geographical_area_ids = ['GB']

    all.sort_by(&:id)
       .reject { |country| country.id.in?(excluded_geographical_area_ids) }
  end

  def description
    attributes['description'].presence || ''
  end

  def long_description
    "#{description} (#{id})"
  end

  def to_s
    description
  end
end
