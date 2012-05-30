require 'api_entity'

class Heading
  include ApiEntity

  attr_accessor :description, :code, :commodities, :short_code,
                :import_measures, :export_measures

  has_one :chapter
  has_one :section
  has_many :commodities
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'

  def self.find(id)
    new(get("/headings/#{id}"))
  end

  def has_measures?
    import_measures.present? || export_measures.present?
  end

  def to_param
    short_code
  end

  def to_s
    description
  end

  def long_desc
    "HEADING #{short_code} - #{description}"
  end
end
