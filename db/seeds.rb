puts "Loading Sections"
sections = [
  {code: 'I', title: "SECTION I - Live animals; animal products (chapter 1 - 5)"},
  {code: 'II', title: "SECTION II - Vegetable products (chapter 6 - 14)"},
  {code: 'III', title: "SECTION III- Animal or vegetable fats and oils and their cleavage products; prepared edible fats; animal or vegetable waxes (chapter 15)"},
  {code: 'IV', title: "SECTION IV - Prepared foodstuffs; beverages, spirits and vinegar; tobacco and manufactured tobacco substitutes (chapter 16 - 24)"},
  {code: 'V', title: "SECTION V - Mineral products (chapter 25 - 27)"},
  {code: 'VI', title: "SECTION VI - Products of the chemical or allied industries (chapter 28 - 38)"},
  {code: 'VII', title: "SECTION VII - Plastics and articles thereof; rubber and articles thereof (chapter 39 - 40)"},
  {code: 'VIII', title: "SECTION VIII - Raw hides and skins, leather, furskins and articles thereof; saddlery and harness; travel goods, handbags and similar containers; articles of animal gut (other than silkworm gut) (chapter 41 - 43)"},
  {code: 'IX', title: "SECTION IX - Wood and articles of wood; wood charcoal; cork and articles of cork; manufactures of straw, of esparto or of other plaiting materials; basketware and wickerwork (chapter 44 - 46)"},
  {code: 'X', title: "SECTION X - Pulp of wood or of other fibrous cellulosic material; recovered (waste and scrap) paper or paperboard; paper and paperboard and articles thereof (chapter (chapter 47 - 49)"},
  {code: 'XI', title: "SECTION XI - Textiles and textile articles (chapter 50 - 63)"},
  {code: 'XII', title: "SECTION XII - Footwear, headgear, umbrellas, sun umbrellas, walking-sticks, seat-sticks, whips, riding-crops and parts thereof; prepared feathers and articles made therewith; artificial flowers; articles of human hair (chapter 64 - 67)"},
  {code: 'XIII', title: "SECTION XIII - Articles of stone, plaster, cement, asbestos, mica or similar materials; ceramic products; glass and glassware (chapter 68 - 70)"},
  {code: 'XIV', title: "SECTION XIV - Natural or cultured pearls, precious or semi-precious stones, precious metals, metals clad with precious metal and articles thereof; imitation jewellery; coins (chapter 71)"},
  {code: 'XV', title: "SECTION XV - Base metals and articles of base metal (chapter 72 - 83)"},
  {code: 'XVI', title: "SECTION XVI - Machinery and mechanical appliances; electrical equipment; parts thereof, sound recordes and reproducers, television image and sound recorders and reproducers, and parts and accessories of such articles (chapter 84 - 85)"},
  {code: 'XVII', title: "SECTION XVII - Vehicles, aircraft, vessels and associated transport equipment (chapter 86 - 89)"},
  {code: 'XVIII', title: "SECTION XVIII - Optical, photographic, cinematographic, measuring, checking, precision, medical or surgical instruments and apparatus; clocks and watches; musical instruments; parts and accessories thereof (chapter 90 - 92)"},
  {code: 'XIX', title: "SECTION XIX - Arms and ammunition; parts and accessories thereof (chapter 93)"},
  {code: 'XX', title: "SECTION XX - Miscellaneous manufactured articles (chapter 94 - 96)"},
  {code: 'XXI', title: "SECTION XXI - Works of art, collectors' pieces and antiques (chapter 97 - 99)"}
]
sections.each do |sec|
  Section.create(sec)
end
