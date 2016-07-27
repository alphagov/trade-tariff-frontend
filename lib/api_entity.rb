require 'httparty'
require 'multi_json'
require 'active_model'

module ApiEntity
  class NotFound < StandardError; end
  class Error < StandardError; end

  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    include HTTParty
    include MultiJson
    base_uri Rails.application.config.api_host
    # debug_output

    attr_reader :attributes

    attr_accessor :casted_by

    class_eval do
      def resource_path
        "/#{self.class.name.underscore.pluralize}/#{to_param}"
      end

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
    true
  end

  module ClassMethods
    def all(opts = {})
      resp = get(collection_path, opts)
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
      options = opts.reverse_merge({ class_name: associations.to_s.singularize.classify,
                                     wrapper: Array })

      class_eval <<-METHODS
        def #{associations}
          #{options[:wrapper]}.new(@#{associations}.presence || [])
        end

        def #{associations}=(data)
          @#{associations} ||= if data.present?
            data.map { |record| #{options[:class_name]}.new(record.merge(casted_by: self)) }
          else
            []
          end
        end

        def add_#{associations.to_s.singularize}(record)
          @#{associations} ||= []
          @#{associations} << record
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
