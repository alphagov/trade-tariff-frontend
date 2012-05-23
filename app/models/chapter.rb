require 'api_entity'

class Chapter
  include ApiEntity

  attr_accessor :id, :code, :description, :headings

  has_one :section
  has_many :headings

  def self.find(id)
    new(get("/chapters/#{id}"))
  end

  def to_s
    "CHAPTER" # #{short_code} - #{description}"
  end

  def short_code
    code.first(2)
  end
end
