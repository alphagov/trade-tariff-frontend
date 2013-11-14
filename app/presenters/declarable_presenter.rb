class DeclarablePresenter < TradeTariffFrontend::Presenter
  attr_reader :declarable

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

  def meursing_tool_link_for(date)
    MEURSING_TOOL_LINK % { date: date, commodity_code: declarable.code }
  end

  def self.model_name
    name.chomp("Presenter").constantize.model_name
  end

  def to_param
    @declarable.to_param
  end

  private

  def method_missing(*args, &block)
    @declarable.send(*args, &block)
  end
end
