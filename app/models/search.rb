require 'api_entity'

class Search
  include ApiEntity

  class Result
    include ApiEntity

    attr_writer   :entry, :type

    [:sections, :chapters, :headings, :commodities].each do |scope|
      define_method(scope) do
        instance_variable_get("@#{scope}").presence ||[]
      end
    end

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

    def any?
      sections.any? || chapters.any? || headings.any?
    end

    def entries=(entry_data)
      @sections = entry_data['sections'].map{|section_data| Section.new(section_data)}
      @chapters = entry_data['chapters'].map{|chapter_data| Chapter.new(chapter_data)}
      @headings = entry_data['headings'].map{|heading_data| Heading.new(heading_data)}
    end
  end

  attr_accessor :q, :as_of

  def perform
    response = self.class.post("/search", body: { q: q, as_of: as_of })

    raise ApiEntity::Error if response.code == 500

    Result.new(response)
  end

end
