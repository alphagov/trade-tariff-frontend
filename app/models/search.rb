class Search
  ATTRIBUTES = [:q]

  include ActiveModel::Validations
  include ActiveModel::Conversion

  ATTRIBUTES.each do |attribute|
    attr_accessor attribute
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      if self.respond_to?(:"#{name}=")
        send(:"#{name}=", value)
      end
    end if attributes.present?
  end

  def perform
    Commodity.search(q.presence || "").results
  end

  def persisted?
    false
  end
end
