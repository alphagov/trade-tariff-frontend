require 'api_entity'

class TariffUpdate
  include ApiEntity

  collection_path "/updates/latest"

  attr_accessor :update_type, :state, :created_at, :updated_at, :filename

  def update_type
    case attributes[:update_type]
    when /Taric/ then 'TARIC'
    when /Chief/ then 'CHIEF'
    end
  end

  def updated_at
    Date.parse(attributes[:updated_at].to_s)
  end

  def to_s
    "Applied #{update_type} at #{updated_at} (#{filename})"
  end
end
