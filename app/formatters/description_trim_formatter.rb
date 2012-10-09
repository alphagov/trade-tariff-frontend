class DescriptionTrimFormatter
  def self.format(opts = {})
    str = opts[:description]
    str.gsub!("|", " ")
    str.gsub!("!1!", "")
    str.gsub!("!X!", "")
    str.gsub!("!x!", "")
    str.gsub!("!o!", "")
    str.gsub!("!O!", "")
    str.gsub!("!>=!", "")
    str.gsub!("!<=!", "")
    str.gsub! /@(.)/ do
      "#{$1}"
    end
    str.gsub! /\$(.)/ do
      "#{$1}"
    end
    str.strip
    str.html_safe
  end
end
