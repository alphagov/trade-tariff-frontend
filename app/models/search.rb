require 'api_entity'

class Search
  include ApiEntity

  class Result
    include ApiEntity

    attr_reader   :sections, :headings, :chapters, :commodities
    attr_writer   :entry, :type

    def exact_match?
      @type == "exact_match"
    end

    def match_path
      {
        controller: @entry['endpoint'],
        action: :show,
        id: @entry['id']
      }
    end

    def entries=(entry_data)
    end
  end

  attr_accessor :q

  def perform
    response = self.class.post("/search", body: { q: q })

    Result.new(response) unless response.code == 500
  end

end
