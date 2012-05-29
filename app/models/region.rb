require 'api_entity'

class Region
  include ApiEntity

  attr_accessor :id, :name, :iso_code, :description, :type, :countries

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
    id.present?
  end
end
