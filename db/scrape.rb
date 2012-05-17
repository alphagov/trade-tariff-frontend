agent = Mechanize.new

base_url = "http://tariff.businesslink.gov.uk/tariff-bl/print/commoditycode.html?"
export="export=true&"
import="export=false&"
date = "simulationDate=17/05/12&"
obj_id="id=01022110"

hit_url = base_url + export + date + obj_id

page = agent.get(hit_url)

noko_body = page.at("//body")
noko_body.css('table').each do |el|
  puts el.text
end
