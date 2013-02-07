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

  def third_country_duty_measures
    import_measures.for_all_countries
                   .sort_by(&:sort_key)
  end

  def third_country_duty_rate
    third_country_duty_measures.select(&:third_country_duty)
                               .sort_by(&:additional_code_code)
                               .last
                               .try(:duty_expression)
  end

  def display_meursing_table?
    ((import_measures.map(&:measure_components).flatten.map(&:duty_expression_id) +
      export_measures.map(&:measure_components).flatten.map(&:duty_expression_id)) &
       MEURSING_DUTY_EXPRESSION_IDS).any?
  end

  def meursing_tool_link_for(date)
    MEURSING_TOOL_LINK % { date: date, commodity_code: declarable.code }
  end

  private

  def method_missing(*args, &block)
    @declarable.send(*args, &block)
  end
end
