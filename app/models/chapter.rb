require 'api_entity'

class Chapter
  include ApiEntity

  attr_accessor :code, :description, :headings, :short_code

  has_one :section
  has_many :headings

  def to_s
    DecriptionFormatter.format(description.downcase.titlecase)
  end

  def to_param
    short_code
  end
end
