require 'api_entity'

class AdditionalCode
  include ApiEntity
  include Models::Formatter

  attr_accessor :code, :description

  format :formatted_description, with: DescriptionFormatter,
                                 using: :description

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
