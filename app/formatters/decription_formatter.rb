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
    str.gsub! /@(.)/ do 
      "<sub>#{$1}</sub>"
    end
    str.gsub! /$(.)/ do
      "<sup>#{$1}</sup>"
    end
    str.strip
    str.html_safe
  end
end