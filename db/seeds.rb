puts "Loading Sections"
sections = [
  {number: 'I', section: "SECTION I - Live animals; animal products (chapter 1 - 5)"},
  {number: 'II', section: "SECTION II - Vegetable products (chapter 6 - 14)"},
  {number: 'III', section: "SECTION III- Animal or vegetable fats and oils and their cleavage products; prepared edible fats; animal or vegetable waxes (chapter 15)"},
  {number: 'IV', section: "SECTION IV - Prepared foodstuffs; beverages, spirits and vinegar; tobacco and manufactured tobacco substitutes (chapter 16 - 24)"},
  {number: 'V', section: "SECTION V - Mineral products (chapter 25 - 27)"},
  {number: 'VI', section: "SECTION VI - Products of the chemical or allied industries (chapter 28 - 38)"},
  {number: 'VII', section: "SECTION VII - Plastics and articles thereof; rubber and articles thereof (chapter 39 - 40)"},
  {number: 'VIII', section: "SECTION VIII - Raw hides and skins, leather, furskins and articles thereof; saddlery and harness; travel goods, handbags and similar containers; articles of animal gut (other than silkworm gut) (chapter 41 - 43)"},
  {number: 'IX', section: "SECTION IX - Wood and articles of wood; wood charcoal; cork and articles of cork; manufactures of straw, of esparto or of other plaiting materials; basketware and wickerwork (chapter 44 - 46)"},
  {number: 'X', section: "SECTION X - Pulp of wood or of other fibrous cellulosic material; recovered (waste and scrap) paper or paperboard; paper and paperboard and articles thereof (chapter (chapter 47 - 49)"},
  {number: 'XI', section: "SECTION XI - Textiles and textile articles (chapter 50 - 63)"},
  {number: 'XII', section: "SECTION XII - Footwear, headgear, umbrellas, sun umbrellas, walking-sticks, seat-sticks, whips, riding-crops and parts thereof; prepared feathers and articles made therewith; artificial flowers; articles of human hair (chapter 64 - 67)"},
  {number: 'XIII', section: "SECTION XIII - Articles of stone, plaster, cement, asbestos, mica or similar materials; ceramic products; glass and glassware (chapter 68 - 70)"},
  {number: 'XIV', section: "SECTION XIV - Natural or cultured pearls, precious or semi-precious stones, precious metals, metals clad with precious metal and articles thereof; imitation jewellery; coins (chapter 71)"},
  {number: 'XV', section: "SECTION XV - Base metals and articles of base metal (chapter 72 - 83)"},
  {number: 'XVI', section: "SECTION XVI - Machinery and mechanical appliances; electrical equipment; parts thereof, sound recordes and reproducers, television image and sound recorders and reproducers, and parts and accessories of such articles (chapter 84 - 85)"},
  {number: 'XVII', section: "SECTION XVII - Vehicles, aircraft, vessels and associated transport equipment (chapter 86 - 89) "},
  {number: 'XVIII', section: "SECTION XVIII - Optical, photographic, cinematographic, measuring, checking, precision, medical or surgical instruments and apparatus; clocks and watches; musical instruments; parts and accessories thereof (chapter 90 - 92)"},
  {number: 'XIX', section: "SECTION XIX - Arms and ammunition; parts and accessories thereof (chapter 93)"},
  {number: 'XX', section: "SECTION XX - Miscellaneous manufactured articles (chapter 94 - 96)"},
  {number: 'XXI', section: "SECTION XXI - Works of art, collectors' pieces and antiques (chapter 97 - 99)"}
]
sections.each do |sec|
  Section.create(sec)
end
