require 'api_entity'

class Search
  class Outcome
    include ApiEntity

    attr_writer :entry, :type

    def exact_match?
      @type == "exact_match"
    end

    def to_param
      {
        controller: @entry['endpoint'],
        action: :show,
        id: @entry['id']
      }
    end

    def any?
      (goods_nomenclature_match.present? && goods_nomenclature_match.any?) ||
      (reference_match.present? && reference_match.any?)
    end

    def goods_nomenclature_match
      @goods_nomenclature_match || GoodsNomenclatureMatch::BLANK_RESULT
    end

    def reference_match
      @reference_match || ReferenceMatch::BLANK_RESULT
    end

    def goods_nomenclature_match=(entries)
      @goods_nomenclature_match ||= GoodsNomenclatureMatch.new(entries)
    end

    def reference_match=(entries)
      @reference_match ||= ReferenceMatch.new(entries)
    end

    def all_reference_matches
      [reference_match.chapters, reference_match.headings].flatten
    end

    def reference_matches_by_chapter
      results_hash = {}

      reference_match.chapters.each do |chapter|
        results_hash[chapter.short_code] = [chapter, []]
      end

      reference_match.headings.each do |heading|
        old_result = results_hash[heading.chapter.short_code]
        old_heading = old_result.nil? ? [] : old_result[1]
        results_hash[heading.chapter.short_code] = [heading.chapter, old_heading << heading]
      end

      results_hash
    end

    def all
      [reference_match.all, goods_nomenclature_match.all].flatten
    end

    def size
      all.size
    end
  end
end
