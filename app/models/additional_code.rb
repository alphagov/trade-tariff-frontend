require 'api_entity'

class AdditionalCode
  include ApiEntity

  attr_accessor :code, :description

  def id
    @id ||= SecureRandom.hex(16)
  end

  def present?
    code.present?
  end

  def to_s
    code
  end
end
