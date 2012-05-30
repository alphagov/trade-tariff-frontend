require 'api_entity'

class Section
  include ApiEntity

  attr_accessor :id, :numeral, :position, :title, :chapters

  has_many :chapters

  class << self
    def all
      get("/sections").map { |entry_data| new(entry_data) }
    end

    def find(id)
      new(get("/sections/#{id}"))
    end
  end

  def to_param
    position
  end

  def to_s
    title
  end
end
