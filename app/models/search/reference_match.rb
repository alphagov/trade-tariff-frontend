require 'api_entity'
require 'ostruct'
require 'search/base_match'

class Search
  include ApiEntity

  class ReferenceMatch < BaseMatch
    BLANK_RESULT = OpenStruct.new(
      sections: [], chapters: [], headings: []
    )

    array_attr_reader :sections, :chapters, :headings
    array_attr_writer :sections, :chapters, :headings

    def any?
      [headings, chapters, sections].any? { |entity_group| entity_group.any? }
    end

    def all
      (sections + chapters + headings).flatten
    end

    def size
      all.size
    end
  end
end
