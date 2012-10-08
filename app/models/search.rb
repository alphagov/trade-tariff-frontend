require 'api_entity'

class Search
  include ApiEntity

  class BaseMatch
    include ApiEntity

    private

    def self.array_attr_reader(*args)
      args.each do |arg|
        define_method(arg.to_sym) do
          instance_variable_get("@#{arg}").presence ||[]
        end
      end
    end

    def self.array_attr_writer(*names)
      names.each do |name|
        define_method("#{name}=") do |entry_data|
          instance_variable_set("@#{name}", entry_data.map{|ed| name.to_s.singularize.capitalize.constantize.new(ed.has_key?('reference') ? ed['reference'] : ed)})
        end
      end
    end
  end

  class GoodsNomenclatureMatch < BaseMatch
    array_attr_reader :sections, :chapters, :headings, :commodities
    array_attr_writer :sections, :chapters, :headings, :commodities
    attr_reader :commodity_headings

    def commodities=(commodity_data)
      @commodities = commodity_data.map { |cd| Commodity.new(cd) }
      @commodity_headings ||= []

      @commodities.each do |commodity|
        existing_heading = (@headings + @commodity_headings).detect{|heading| heading == commodity.heading }

        if existing_heading.present?
          existing_heading.add_commodity commodity
        else
          new_heading = Heading.new(commodity.heading.attributes.merge(chapter: commodity.chapter.attributes,
                                                                       section: commodity.section.attributes))
          new_heading.add_commodity commodity
          @commodity_headings << new_heading
        end
      end
    end

    def resulting_headings
      (headings + commodity_headings).sort_by(&:goods_nomenclature_item_id)
    end
  end

  class ReferenceMatch < BaseMatch
    array_attr_reader :sections, :chapters, :headings
    array_attr_writer :sections, :chapters, :headings
  end

  class Outcome
    include ApiEntity

    attr_writer :entry, :type
    attr_reader :goods_nomenclature_match, :reference_match

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
      goods_nomenclature_match.present? || reference_match.present?
    end

    def goods_nomenclature_match=(entries)
      @goods_nomenclature_match ||= GoodsNomenclatureMatch.new(entries)
    end

    def reference_match=(entries)
      @reference_match ||= ReferenceMatch.new(entries)
    end
  end

  attr_accessor :q, :as_of

  def perform
    response = self.class.post("/search", body: { q: q, as_of: as_of })

    raise ApiEntity::Error if response.code == 500

    Outcome.new(response)
  end

  def to_s; q; end
end
