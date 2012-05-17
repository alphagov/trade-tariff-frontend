agent = Mechanize.new

base_url = "http://tariff.businesslink.gov.uk/tariff-bl/print/commoditycode.html?"
export="export=true&"
import="export=false&"
date = "simulationDate=17/05/12&"
obj_id="id=01022110"

hit_url = base_url + export + date + obj_id

page = agent.get(hit_url)

noko_body = page.at("//body")
tables = noko_body.css('table')

#fields: Measure Type, Duty rates / prohibitions, Additional codes, Conditions, Exclusions, Legal Act Footnote
"Third country measures"

#fields: Country, Measure Type,  Duty rates / prohibitions, Additional codes,  Conditions,  Exclusions,  Legal Act, Footnotes
"Measures for specific countries and country groups"

#DUplicated data
#fields: code, description, duty
"Additional code"

#fields: Code, Description
"Footnotes"
