require 'api_entity'

class Search
  class BaseMatch
    include ApiEntity

    private

    def self.array_attr_reader(*args)
      args.each do |arg|
        define_method(arg.to_sym) do
          instance_variable_get("@#{arg}").presence ||[]
        end
      end
    end

    def self.array_attr_writer(*names)
      names.each do |name|
        define_method("#{name}=") do |entry_data|
          instance_variable_set("@#{name}", entry_data.map{|ed| name.to_s.singularize.capitalize.constantize.new(ed['_source'].has_key?('reference') ? ed['_source']['reference'] : ed['_source'])})
        end
      end
    end
  end
end
