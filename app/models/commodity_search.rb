require 'api_entity'

class CommoditySearch
  include ApiEntity

  class ResultCollection
    attr_accessor :current_page, :per_page,
                  :total_entries, :total_pages,
                  :offset, :entries

    def initialize(attributes = {})
      attributes.each do |name, value|
        if self.respond_to?(:"#{name}=")
          send(:"#{name}=", value)
        end
      end if attributes.present?
    end

    def entries=(entry_data)
      @entries ||= entry_data.map { |ed| Commodity.new(ed) }
    end

    alias :limit_value  :per_page
    alias :total_count  :total_entries
    alias :num_pages    :total_pages
    alias :offset_value :offset
  end

  ATTRIBUTES = [:q, :page]

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
    ResultCollection.new(self.class.post("/search", body: { q: q, page: page }))
  end

  def persisted?
    false
  end
end
