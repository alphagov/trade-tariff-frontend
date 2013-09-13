module Models
  module Changeable
    extend ActiveSupport::Concern

    def changes
      self.class.get("#{resource_path}/changes").map { | change_data|
        Change.new(change_data)
      }
    end
  end
end
