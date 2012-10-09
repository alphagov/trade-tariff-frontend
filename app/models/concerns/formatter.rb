module Models
  module Formatter
    extend ActiveSupport::Concern

    module ClassMethods
      def format(attribute, options)
        options.assert_valid_keys :with, :using, :as

        formatter, using, resulting_method = options.values_at(:with, :using, :as)
        resulting_method ||= attribute

        define_method(resulting_method) do
          opts = {}
          using.each do |field|
            if field.is_a?(String)
              opts[field.to_sym] = field
            elsif
              field.is_a?(Symbol)
              opts[field] = attributes[field.to_s]
            end
          end
          formatter.format(opts)
        end
      end
    end
  end
end
