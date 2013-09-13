require 'api_entity'

class Change
  class Record < Hashie::Mash
  end

  include ApiEntity
  extend  ActiveModel::Naming

  attr_accessor :oid, :model_name, :operation, :operation_date, :record

  def id
    [model_name, oid].join("-")
  end

  def record=(record_attributes)
    @record = record_class.new(record_attributes)
  end

  def operation_date=(operation_date)
    @operation_date = Date.parse(operation_date)
  end

  private

  def record_class
    model_name.constantize # if change has relevant model, e.g. Measure

    rescue NameError # if change has no relevant model revert to Hashie
      Change::Record
  end
end
