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

      self.commodity_headings = @commodities
    end

    # Extract Headings from Commodity object as we need to build
    # a tree for representation.
    # Also, add commodity to heading's commodity array so that they could
    # be listed in the tree.
    def commodity_headings=(commodities)
      @commodity_headings ||= []

      commodities.each do |commodity|
        if existing_heading = find_heading(commodity.heading)
          existing_heading.add_commodity(commodity)
        else
          @commodity_headings << build_heading_from(commodity).tap {|heading|
            heading.add_commodity(commodity)
          }
        end
      end
    end

    def resulting_headings
      (headings + commodity_headings).sort_by(&:goods_nomenclature_item_id)
    end

    def any?
      [headings, commodities, chapters, sections].any? {|entity_group| entity_group.any? }
    end

    private

    def find_heading(heading_for_search)
      (@headings + @commodity_headings).detect{|heading| heading == heading_for_search }
    end

    def build_heading_from(commodity)
      Heading.new(commodity.heading.attributes.merge(chapter: commodity.chapter.attributes,
                                                     section: commodity.section.attributes))
    end
  end

  class ReferenceMatch < BaseMatch
    array_attr_reader :sections, :chapters, :headings
    array_attr_writer :sections, :chapters, :headings

    def any?
      [headings, chapters, sections].any? {|entity_group| entity_group.any? }
    end
  end

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

  attr_accessor :t, :as_of

  def perform
    response = self.class.post("/search", body: { t: t, as_of: as_of })

    raise ApiEntity::Error if response.code == 500

    Outcome.new(response)
  end

  def to_s; t; end
end
