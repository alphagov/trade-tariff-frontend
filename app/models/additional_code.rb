require 'api_entity'

class AdditionalCode
  include ApiEntity

  attr_accessor :code, :description, :formatted_description

  def id
    @id ||= "#{casted_by.destination}-#{casted_by.id}-additional-code-#{code}"
  end

  def present?
    code.present?
  end

  def to_s
    code
  end
end
