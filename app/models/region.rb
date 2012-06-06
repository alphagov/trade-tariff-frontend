require 'api_entity'

class Region
  include ApiEntity

  TYPES = %w(Country CountryGroup)

  attr_accessor :id, :name, :iso_code, :description, :type

  has_many :countries

  def country_names
    countries.map(&:name).join(", ") if country_group?
  end

  def country_group?
    type == 'CountryGroup'
  end

  def to_s
    name
  end

  def blank?
    name.blank?
  end
end
