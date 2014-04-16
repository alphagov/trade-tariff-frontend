require 'api_entity'
require 'ostruct'
require 'search/base_match'

class Search
  include ApiEntity

  class ReferenceMatch < BaseMatch
    BLANK_RESULT = OpenStruct.new(
      sections: [], chapters: [], headings: [], commodities: []
    )

    array_attr_reader :sections, :chapters, :headings, :commodities
    array_attr_writer :sections, :chapters, :headings, :commodities

    def any?
      [headings, chapters, sections, commodities].any? { |entity_group| entity_group.any? }
    end

    def all
      (sections + chapters + headings + commodities).flatten
    end

    def size
      all.size
    end
  end
end
