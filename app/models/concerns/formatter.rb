module Models
  module Formatter
    extend ActiveSupport::Concern

    module ClassMethods
      def format(attribute, options)
        options.assert_valid_keys :with, :using

        formatter = options[:with]
        using = options[:using]

        define_method(attribute) do
          values = using.inject([]) { |memo, field|
            memo << (if field.is_a?(String)
                      field
                    elsif field.is_a?(Symbol)
                      send(field)
                    end)
          }

          formatter.format(*values)
        end
      end
    end
  end
end
