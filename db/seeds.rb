Section.index.delete
puts "Loading Sections"
sections = [
  {section_number: 1, section_roman: 'I',   section_title: "SECTION I - Live animals; animal products (chapter 1 - 5)"},
  {section_number: 2, section_roman: 'II', section_title: "SECTION II - Vegetable products (chapter 6 - 14)"},
  {section_number: 3, section_roman: 'III', section_title: "SECTION III- Animal or vegetable fats and oils and their cleavage products; prepared edible fats; animal or vegetable waxes (chapter 15)"},
  {section_number: 4, section_roman: 'IV', section_title: "SECTION IV - Prepared foodstuffs; beverages, spirits and vinegar; tobacco and manufactured tobacco substitutes (chapter 16 - 24)"},
  {section_number: 5, section_roman: 'V', section_title: "SECTION V - Mineral products (chapter 25 - 27)"},
  {section_number: 6, section_roman: 'VI', section_title: "SECTION VI - Products of the chemical or allied industries (chapter 28 - 38)"},
  {section_number: 7, section_roman: 'VII', section_title: "SECTION VII - Plastics and articles thereof; rubber and articles thereof (chapter 39 - 40)"},
  {section_number: 8, section_roman: 'VIII', section_title: "SECTION VIII - Raw hides and skins, leather, furskins and articles thereof; saddlery and harness; travel goods, handbags and similar containers; articles of animal gut (other than silkworm gut) (chapter 41 - 43)"},
  {section_number: 9, section_roman: 'IX', section_title: "SECTION IX - Wood and articles of wood; wood charcoal; cork and articles of cork; manufactures of straw, of esparto or of other plaiting materials; basketware and wickerwork (chapter 44 - 46)"},
  {section_number: 10, section_roman: 'X', section_title: "SECTION X - Pulp of wood or of other fibrous cellulosic material; recovered (waste and scrap) paper or paperboard; paper and paperboard and articles thereof (chapter (chapter 47 - 49)"},
  {section_number: 11, section_roman: 'XI', section_title: "SECTION XI - Textiles and textile articles (chapter 50 - 63)"},
  {section_number: 12, section_roman: 'XII', section_title: "SECTION XII - Footwear, headgear, umbrellas, sun umbrellas, walking-sticks, seat-sticks, whips, riding-crops and parts thereof; prepared feathers and articles made therewith; artificial flowers; articles of human hair (chapter 64 - 67)"},
  {section_number: 13, section_roman: 'XIII', section_title: "SECTION XIII - Articles of stone, plaster, cement, asbestos, mica or similar materials; ceramic products; glass and glassware (chapter 68 - 70)"},
  {section_number: 14, section_roman: 'XIV', section_title: "SECTION XIV - Natural or cultured pearls, precious or semi-precious stones, precious metals, metals clad with precious metal and articles thereof; imitation jewellery; coins (chapter 71)"},
  {section_number: 15, section_roman: 'XV', section_title: "SECTION XV - Base metals and articles of base metal (chapter 72 - 83)"},
  {section_number: 16, section_roman: 'XVI', section_title: "SECTION XVI - Machinery and mechanical appliances; electrical equipment; parts thereof, sound recordes and reproducers, television image and sound recorders and reproducers, and parts and accessories of such articles (chapter 84 - 85)"},
  {section_number: 17, section_roman: 'XVII', section_title: "SECTION XVII - Vehicles, aircraft, vessels and associated transport equipment (chapter 86 - 89)"},
  {section_number: 18, section_roman: 'XVIII', section_title: "SECTION XVIII - Optical, photographic, cinematographic, measuring, checking, precision, medical or surgical instruments and apparatus; clocks and watches; musical instruments; parts and accessories thereof (chapter 90 - 92)"},
  {section_number: 19, section_roman: 'XIX', section_title: "SECTION XIX - Arms and ammunition; parts and accessories thereof (chapter 93)"},
  {section_number: 20, section_roman: 'XX', section_title: "SECTION XX - Miscellaneous manufactured articles (chapter 94 - 96)"},
  {section_number: 21, section_roman: 'XXI', section_title: "SECTION XXI - Works of art, collectors' pieces and antiques (chapter 97 - 99)"}
]
sections.each do |sec|
  Section.create(sec)
end

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open Rails.root.join('db/goods-nomenclature.xls')
sheet1 = book.worksheet 0
p "#{sheet1.count} rows loaded"
