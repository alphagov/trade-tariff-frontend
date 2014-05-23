module Models
  module Changeable
    extend ActiveSupport::Concern

    def changes(query_params = {})
      self.class.get("#{resource_path}/changes", query_params).map { | change_data|
        Change.new(change_data)
      }
    end
  end
end
