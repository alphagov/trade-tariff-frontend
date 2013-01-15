require 'api_entity'
require 'search/base_match'

class Search
  include ApiEntity

  class ReferenceMatch < BaseMatch
    array_attr_reader :sections, :chapters, :headings
    array_attr_writer :sections, :chapters, :headings

    def any?
      [headings, chapters, sections].any? {|entity_group| entity_group.any? }
    end
  end
end
