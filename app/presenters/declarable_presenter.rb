class DeclarablePresenter
  attr_reader :declarable

  MEURSING_DUTY_EXPRESSION_IDS = %w[12 14 21 25 27 29]
  MEURSING_TOOL_LINK = "http://ec.europa.eu/taxation_customs/dds2/taric/measures.jsp?Lang=en&SimDate=%{date}&Taric=%{commodity_code}&LangDescr=en"

  def initialize(declarable)
    @declarable = declarable
  end

  def to_s
    declarable.formatted_description
  end

  def display_meursing_table?
    ((declarable.import_measures.map(&:measure_components).flatten.map(&:duty_expression_id) +
      declarable.export_measures.map(&:measure_components).flatten.map(&:duty_expression_id)) &
       MEURSING_DUTY_EXPRESSION_IDS).any?
  end

  def meursing_tool_link_for(date)
    MEURSING_TOOL_LINK % { date: date, commodity_code: declarable.code }
  end

  def national_vat_import_measures
    declarable.import_measures
              .select{|measure| measure.national? && measure.vat? }
              .present_with(MeasurePresenter)
  end

  def import_measures_for_third_country
    declarable.third_country_duty_measures
              .sort_by(&:sort_key)
              .present_with(MeasurePresenter)
  end

  def import_measures_for_specific_countries
    declarable.import_measures
              .select(&:for_specific_countries)
              .sort_by(&:specific_country_sort_key)
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
              .sort_by(&:specific_country_sort_key)
              .flatten
              .present_with(MeasurePresenter)
  end

  private

  def method_missing(*args, &block)
    @declarable.send(*args, &block)
  end
end
