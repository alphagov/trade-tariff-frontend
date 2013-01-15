require 'api_entity'

class Search
  class Outcome
    include ApiEntity

    attr_writer :entry, :type
    attr_reader :goods_nomenclature_match, :reference_match

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

    def goods_nomenclature_match=(entries)
      @goods_nomenclature_match ||= GoodsNomenclatureMatch.new(entries)
    end

    def reference_match=(entries)
      @reference_match ||= ReferenceMatch.new(entries)
    end
  end
end
