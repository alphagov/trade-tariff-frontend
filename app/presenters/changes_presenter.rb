class ChangesPresenter
  include Enumerable

  delegate :each, to: :@change_collection
  delegate :operation_date, to: :first_change, prefix: true
  delegate :operation_date, to: :last_change, prefix: true

  def initialize(change_collection)
    @change_collection = change_collection.map { |change|
      change_presenter_class_for(change.model_name).new(change)
    }
  end

  private

  def first_change
    @change_collection.first || NullObject.new
  end

  def last_change
    @change_collection.last || NullObject.new
  end

  def change_presenter_class_for(model)
    "#{model}ChangePresenter".constantize

    rescue NameError
      ChangePresenter
  end
end
