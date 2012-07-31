require 'api_entity'
require 'null_object'

class OrderNumber
  include ApiEntity

  class Definition
    include ApiEntity

    DATE_FIELDS = %w(blocking_period_start_date blocking_period_end_date
                     suspension_period_start_date suspension_period_end_date
                     validity_start_date validity_end_date last_allocation_date)

    attr_accessor :initial_volume, :status, :measurement_unit,
                  :measurement_unit_qualifier,
                  :monetary_unit, :balance

    DATE_FIELDS.each do |field|
      define_method(field.to_sym) {
        instance_variable_get("@#{field}".to_sym).presence || NullObject.new
      }

      define_method("#{field}=".to_sym) { |arg|
        instance_variable_set("@#{field}".to_sym, Time.parse(arg)) if arg.present?
      }
    end
  end

  attr_accessor :number

  delegate :present?, to: :number

  has_one :definition

  def id
    @id ||= SecureRandom.hex(16)
  end
end
