module Models
  module Formatter
    extend ActiveSupport::Concern

    module ClassMethods
      def format(attribute, options)
        options.assert_valid_keys :with, :using, :as

        formatter, using, resulting_method = options.values_at(:with, :using, :as)
        resulting_method ||= attribute

        define_method(resulting_method) do
          values = using.inject([]) { |memo, field|
            memo << (if field.is_a?(String)
                      field
                    elsif field.is_a?(Symbol)
                      attributes[field.to_s]
                    end)
          }

          formatter.format(*values)
        end
      end
    end
  end
end
