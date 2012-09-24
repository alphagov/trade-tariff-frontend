require 'api_entity'

class LegalAct
  include ApiEntity

  attr_accessor :generating_regulation_code, :url, :validity_end_date,
                :validity_start_date

  def validity_start_date=(date)
    @validity_start_date = Date.parse(date)
  end

  def validity_end_date=(date)
    @validity_end_date = Date.parse(date)
  end
end
