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

  def self.cached_countries
    Rails.cache.fetch(
      "cached_countries",
      expires_in: 24.hours
    ) do
      countries
    end
  end

  def self.by_long_description(long_description)
    cached_countries.select do |country|
      country.long_description =~ /#{long_description}/i
    end
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
