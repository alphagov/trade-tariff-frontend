module Models
  module Formatter
    extend ActiveSupport::Concern

    module ClassMethods
      def format(attribute, options)
        options.assert_valid_keys :with, :using, :as, :defaults

        formatter, using, resulting_method, defaults = options.values_at(:with,
                                                                         :using,
                                                                         :as,
                                                                         :defaults)
        resulting_method ||= attribute

        define_method(resulting_method) do
          opts = {}
          using.each do |field|
            field.is_a?(Symbol)
            opts[field] = attributes[field.to_s]
          end

          opts.merge!(defaults) if defaults.present?
          formatter.format(opts)
        end
      end
    end
  end
end
