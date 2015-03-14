class GovukArtefact

  def initialize(data)
    @data = data
  end

  def primary_section
    @data["tags"].select { |tag| tag["details"] && tag["details"]["type"] == 'section' }.first if @data
  end

  def primary_root_section
    primary_root_section = primary_section
    while primary_root_section and primary_root_section["parent"]
      primary_root_section = primary_root_section["parent"]
    end
    primary_root_section
  end

  def need_ids
    @data.details.need_ids if @data && @data.details
  end

  def non_primary_sections
    if (section = primary_section)
      sections = recurse_sections(section)
      sections[0...-1]
    else
      []
    end
  end

private

  def recurse_sections(section, current = nil)
    current = [section] unless current

    if section['parent']
      current.unshift(section['parent'])
      current = recurse_sections(section['parent'], current)
    end
    current
  end
end
