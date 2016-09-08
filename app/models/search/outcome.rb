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

    def all_gn_matches
      [goods_nomenclature_match.chapters, goods_nomenclature_match.headings].flatten
    end

    def gn_chapters_without_duplicates
      # TODO - Do we need this if we're removing duplicates below anyway?
      goods_nomenclature_match.chapters.delete_if { |gc| reference_match.chapters.select { |rc| rc.code == gc.code }.any? }
    end

    def gn_headings_without_duplicates
      goods_nomenclature_match.headings.delete_if { |gh| reference_match.headings.select { |rh| rh.code == gh.code }.any? }
    end

    def matches_by_chapter(chapters, headings)
      results = {}

      chapters.each do |chapter|
        results[chapter.short_code] = [chapter, []]
      end

      headings.sort_by! { |h| h.short_code }
      headings.each do |heading|
        result = results[heading.chapter.short_code]
        result_existing_headings = result.nil? ? [] : result[1]
        results[heading.chapter.short_code] = [heading.chapter, result_existing_headings.push(heading)]
      end
      sorted_results = results.sort_by { |k, v| k }
      sorted_results.to_a
    end

    def reference_matches_by_chapter
      matches_by_chapter(reference_match.chapters, reference_match.headings)
    end

    def gn_matches_without_duplicates_by_chapter
      gn_matches_by_chapter = matches_by_chapter(gn_chapters_without_duplicates, gn_headings_without_duplicates)

      gn_matches_by_chapter.delete_if do |gn|
        reference_matches_by_chapter.select { |ref| ref[0] == gn[0] } && gn[1][1].blank?
      end
    end

    def all
      [reference_match.all, goods_nomenclature_match.all].flatten
    end

    def size
      all.size
    end
  end
end
