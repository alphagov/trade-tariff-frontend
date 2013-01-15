require 'httparty'
require 'multi_json'

module ApiEntity
  class NotFound < StandardError; end
  class Error < StandardError; end

  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion

    include HTTParty
    include MultiJson
    base_uri Rails.application.config.api_host
    debug_output if Rails.env.development?

    attr_reader :attributes

    attr_accessor :casted_by

    class_eval do
      def to_param
        id
      end
    end
  end

  def initialize(attributes = {})
    class_name = self.class.name.downcase

    attributes = HashWithIndifferentAccess.new(attributes)

    if attributes.present? && attributes.has_key?(class_name)
      @attributes = attributes[class_name]

      self.attributes = attributes[class_name]
    else
      @attributes = attributes

      self.attributes = attributes
    end
  end

  def attributes=(attributes={})
    attributes.each do |name, value|
      if self.respond_to?(:"#{name}=")
        send(:"#{name}=", (value.is_a?(String) && value == "null") ? nil : value)
      end
    end if attributes.present?
  end

  def persisted?
    false
  end

  module ClassMethods
    def all
      resp = get(collection_path)
      case resp.code
      when 404
        raise ApiEntity::NotFound.new resp['error']
      when 500
        raise ApiEntity::Error.new resp['error']
      when 502
        raise ApiEntity::Error.new "502 Bad Gateway"
      end
      resp.map { |entry_data| new(entry_data) }
    end

    def find(id, opts = {})
      resp = get("/#{self.name.pluralize.parameterize}/#{id}", opts)
      case resp.code
      when 404
        raise ApiEntity::NotFound
      when 500
        raise ApiEntity::Error.new resp['error']
      when 502
        raise ApiEntity::Error.new resp['error']
      end
      new(resp)
    end

    def has_one(association, opts = {})
      options = opts.reverse_merge({ class_name: association.to_s.singularize.classify })

      attr_accessor association.to_sym

      class_eval <<-METHODS
        def #{association}=(data)
          data ||= {}

          @#{association} ||= #{options[:class_name]}.new(data.merge(casted_by: self))
        end
      METHODS
    end

    def has_many(associations, opts = {})
      options = opts.reverse_merge({ class_name: associations.to_s.singularize.classify })

      attr_accessor associations.to_sym

      class_eval <<-METHODS
        def #{associations}=(data)
          @#{associations} ||= data.map { |record| #{options[:class_name]}.new(record.merge(casted_by: self)) }
        end

        def add_#{associations.to_s.singularize}(record)
          @#{associations} ||= []
          @#{associations} << record
        end

        def #{associations}
          @#{associations}.presence || []
        end
      METHODS
    end

    def collection_path(path = nil)
      if path
        @collection_path = path
      else
        @collection_path
      end
    end
  end
end
