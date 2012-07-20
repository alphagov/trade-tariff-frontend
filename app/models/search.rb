require 'api_entity'

class Search
  include ApiEntity

  class Result
    include ApiEntity

    attr_accessor :type
    attr_reader :entries

    def exact_match?
      type == "exact_match"
    end

    def match_path
      {
        controller: match['endpoint'],
        action: :show,
        id: match['id']
      }
    end

    def match
      entries.first
    end

    def entries=(entry_data)
      @entries ||= entry_data
    end
  end

  ATTRIBUTES = [:q, :page]

  ATTRIBUTES.each do |attribute|
    attr_accessor attribute
  end

  def perform
    response = self.class.post("/search", body: { q: q, page: page })

    Result.new(response) unless response.code == 500
  end

end
