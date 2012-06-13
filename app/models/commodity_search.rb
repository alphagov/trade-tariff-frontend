require 'api_entity'

class CommoditySearch
  include ApiEntity

  class ResultCollection
    include ApiEntity
    attr_accessor :current_page, :per_page,
                  :total_entries, :total_pages,
                  :offset, :entries

    def entries=(entry_data)
      @entries ||= entry_data.map { |entry_data|
                     (entry_data['_type'] == 'commodity') ? Commodity.new(entry_data) : Heading.new(entry_data)
                   }
    end

    alias :limit_value  :per_page
    alias :total_count  :total_entries
    alias :num_pages    :total_pages
    alias :offset_value :offset
  end

  ATTRIBUTES = [:q, :page]

  ATTRIBUTES.each do |attribute|
    attr_accessor attribute
  end

  def perform
    response = self.class.post("/search", body: { q: q, page: page })

    ResultCollection.new(response) unless response.code == 500
  end

end
