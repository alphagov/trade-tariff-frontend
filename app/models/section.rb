require 'api_entity'

class Section
  include ApiEntity

  attr_accessor :numeral, :position, :title, :chapters

  has_many :chapters

  class << self
    def all
      resp = get("/sections")
      case resp.code
      when 404
        raise ApiEntity::NotFound.new resp['error']
      when 500
        raise ApiEntity::Error.new resp['error']
      end
      resp.map { |entry_data| new(entry_data) }
    end
  end

  def to_param
    position
  end

  def to_s
    title
  end
end
