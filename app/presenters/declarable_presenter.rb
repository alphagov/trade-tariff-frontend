class DeclarablePresenter
  attr_reader :declarable

  def initialize(declarable)
    @declarable = declarable
  end

  def to_s
    declarable.formatted_description
  end

  def display_meursing_table?
    !(([import_measures.map(&:measure_components).flatten.map(&:duty_expression_id) + export_measures.map(&:measure_components).flatten.map(&:duty_expression_id)]).flatten & ["12", "14", "21", "25", "27", "29"]).empty?
  end

  def national_vat_import_measures
    declarable.import_measures
              .select{|measure| measure.national? && measure.vat? }
              .present_with(MeasurePresenter)
  end

  def import_measures_for_third_country
    declarable.import_measures
              .select(&:third_country)
              .sort_by(&:sort_key)
              .present_with(MeasurePresenter)
  end

  def import_measures_for_specific_countries
    declarable.import_measures
              .select(&:for_specific_countries)
              .group_by(&:geographical_area_type)
              .map(&:last)
              .map{|measure_group| measure_group.sort_by(&:sort_key) }
              .flatten
              .present_with(MeasurePresenter)
  end

  def has_import_measures_for_specific_countries?
    declarable.import_measures
              .select(&:for_specific_countries)
              .any?
  end

  def has_export_measures_for_third_countries?
    declarable.export_measures
              .select(&:third_country)
              .any?
  end

  def export_measures_for_third_country
    declarable.export_measures
              .select(&:third_country)
              .sort_by(&:sort_key)
              .present_with(MeasurePresenter)
  end

  def has_vat_or_excise_third_country_export_measures?
    declarable.export_measures
              .select(&:third_country)
              .select(&:vat?)
              .any?
  end

  def has_export_measures_for_specific_countries?
    declarable.export_measures
              .select(&:for_specific_countries)
              .any?
  end

  def export_measures_for_specific_countries
    declarable.export_measures
              .select(&:for_specific_countries)
              .group_by(&:geographical_area_type)
              .map(&:last)
              .map{|measure_group| measure_group.sort_by(&:sort_key) }
              .flatten
              .present_with(MeasurePresenter)
  end

  private

  def method_missing(*args, &block)
    @declarable.send(*args, &block)
  end
end
