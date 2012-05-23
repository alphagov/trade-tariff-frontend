module ApiEntity
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion

    include HTTParty
    base_uri Rails.application.config.api_host

    class_eval do
      def to_param
        id
      end
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      if self.respond_to?(:"#{name}=")
        send(:"#{name}=", value)
      end
    end if attributes.present?
  end

  def persisted?
    false
  end

  module ClassMethods
    def has_one(association)
      attr_accessor association.to_sym

      class_eval <<-METHODS
        def #{association}=(data)
          @#{association} ||= #{association.to_s.classify}.new(data)
        end
      METHODS
    end

    def has_many(associations)
      attr_accessor associations.to_s.singularize.to_sym

      class_eval <<-METHODS
        def #{associations}=(data)
          @#{associations} ||= data.map { |record| #{associations.to_s.singularize.classify}.new(record) }
        end
      METHODS
    end
  end
end
