module Models
  module Declarable
    extend ActiveSupport::Concern

    included do
      include ApiEntity
      include Models::Formatter

      has_one :section
      has_one :chapter
      has_one :footnote
      has_many :import_measures, class_name: 'Measure'
      has_many :export_measures, class_name: 'Measure'
      has_many :basic_duty_rate_components, class_name: 'MeasureComponent'

      attr_accessor :description, :goods_nomenclature_item_id, :producline_suffix, :number_indents, :goods_nomenclature_sid, :bti_url

      format :description, with: DescriptionTrimFormatter,
                           using: [:description],
                           as: :description_plain
      format :description, with: DescriptionFormatter,
                           using: [:description],
                           as: :formatted_description
    end

    def code
      goods_nomenclature_item_id
    end
  end
end
