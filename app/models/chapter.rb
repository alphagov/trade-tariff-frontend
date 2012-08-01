require 'api_entity'
require 'formatter'

class Chapter
  include ApiEntity
  include Models::Formatter

  attr_accessor :code, :description, :headings, :short_code

  has_one :section
  has_many :headings

  format :description, with: DescriptionFormatter,
                       using: [:description]

  def to_s
    description.downcase.gsub(/^(.)/) { $1.capitalize }
  end

  def to_param
    short_code
  end
end
