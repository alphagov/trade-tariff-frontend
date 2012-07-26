class DecriptionFormatter
  def self.format(str)
    str.gsub!("|", "&nbsp;")
    str.gsub!("!1!", "<br />")
    str.gsub!("!X!", "&times;")
    str.gsub!("!x!", "&times;")
    str.gsub!("!o!", "&deg;")
    str.gsub!("!O!", "&deg;")
    str.gsub!("!>=!", "&ge;")
    str.gsub!("!<=!", "&le;")
    #TODO this should be the following char is subscript
    str.gsub!("@", "_")
    #TODO this should be the following char is superscript
    str.gsub!("$", "^")
    str.strip
    str.html_safe
  end
end