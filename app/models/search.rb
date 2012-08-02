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
      @sections = entry_data['sections'].map{|section_data| Section.new(section_data)}
      @chapters = entry_data['chapters'].map{|chapter_data| Chapter.new(chapter_data)}
      @headings = entry_data['headings'].map{|heading_data| Heading.new(heading_data)}
    end
  end

  attr_accessor :q

  def perform
    response = self.class.post("/search", body: { q: q })

    Result.new(response) unless response.code == 500
  end

end
