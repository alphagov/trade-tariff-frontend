require 'api_entity'
require 'formatter'

class Chapter
  include ApiEntity
  include Models::Formatter

  attr_accessor :code, :description, :headings, :short_code

  has_one :section
  has_many :headings

  format :description, with: DecriptionFormatter,
                       using: [:description]

  def to_s
    description
  end

  def to_param
    short_code
  end
end
