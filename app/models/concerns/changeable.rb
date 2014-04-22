module Models
  module Changeable
    extend ActiveSupport::Concern

    def changes(query_params = {})
      resp = self.class.get("#{resource_path}/changes", query_params).body
      resp.map { | change_data|
        Change.new(change_data)
      }
    end
  end
end
