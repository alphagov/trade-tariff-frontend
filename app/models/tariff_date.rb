class TariffDate
  include ActiveModel::Validations
  include ActiveModel::Conversion

  DATE_KEYS = %w[year month day]

  attr_reader :date

  def self.parse(date_param)
    new(if valid_date_param?(date_param)
      date_param.values_at(*DATE_KEYS).join("-")
    else
      Date.today
    end)
  end

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
    @date.presence || Date.today
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

  def to_taric_date
    date.to_formatted_s(:eutaric)
  end

  def self.valid_date_param?(date_param)
    date_param.present? && date_param.is_a?(Hash) &&
    DATE_KEYS.all? { |k| k.in?(date_param.keys) }
  end
end
