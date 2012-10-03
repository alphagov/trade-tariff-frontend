class TariffDate
  include ActiveModel::Validations
  include ActiveModel::Conversion

  DEFAULT_DATE = Date.new(2012,10,03)

  attr_reader :date

  def initialize(date)
    self.date = date
  end

  def date=(date)
    @date = if date.present?
              begin
                Date.parse(date.to_s)
              rescue ArgumentError
              end
            end
  end

  def date
    @date.presence || DEFAULT_DATE
  end

  def persisted?
    false
  end

  def to_param
    date.to_formatted_s(:full)
  end

  def to_s
    date.to_formatted_s(:date)
  end
end
