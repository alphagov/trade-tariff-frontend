class MeasureCollection
  include Enumerable

  attr_accessor :measures, :presenter_klass

  delegate :length, :collect, :map, :each, :all?, :include?, :to_ary, to: :to_a

  def initialize(measures, presenter_klass = MeasurePresenter)
    @measures = measures.clone
    @presenter_klass = presenter_klass
  end

  def for_country(country)
    self.measures = measures.select{ |m| m.relevant_for_country?(country) }
    self
  end

  def for_all_countries
    self.measures = measures.select(&:third_country)
    self
  end

  def for_specific_countries
    self.measures = measures.select(&:for_specific_countries)
    self
  end

  def vat
    self.measures = measures.select{ |measure| measure.vat? }
    self
  end

  def national
    self.measures = measures.select{ |measure| measure.national? }
    self
  end

  def except(condition)
    self.measures = measures.reject(&condition)
    self
  end

  def to_a
    if presenter_klass.present?
      present_with(presenter_klass)
    else
      measures
    end
  end

  def present?
    measures.any?
  end

  private

  def present_with(presenter_klass)
    measures.map { |entry| presenter_klass.new(entry) }
  end
end
