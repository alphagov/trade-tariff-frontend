require 'forwardable'

class ChangesPresenter
  include Enumerable
  extend Forwardable
  def_delegators :@change_collection, :each, :length

  def initialize(change_collection)
    @change_collection = change_collection.map { |change|
      change_presenter_class_for(change.model_name).new(change)
    }
  end

  private

  def change_presenter_class_for(model)
    "#{model}ChangePresenter".constantize

    rescue NameError
      ChangePresenter
  end
end
