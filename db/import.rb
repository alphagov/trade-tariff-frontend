sections = [
  {number: 1, numeral: 'I',   title: "SECTION I - Live animals; animal products (chapter 1 - 5)"},
  {number: 2, numeral: 'II', title: "SECTION II - Vegetable products (chapter 6 - 14)"},
  {number: 3, numeral: 'III', title: "SECTION III- Animal or vegetable fats and oils and their cleavage products; prepared edible fats; animal or vegetable waxes (chapter 15)"},
  {number: 4, numeral: 'IV', title: "SECTION IV - Prepared foodstuffs; beverages, spirits and vinegar; tobacco and manufactured tobacco substitutes (chapter 16 - 24)"},
  {number: 5, numeral: 'V', title: "SECTION V - Mineral products (chapter 25 - 27)"},
  {number: 6, numeral: 'VI', title: "SECTION VI - Products of the chemical or allied industries (chapter 28 - 38)"},
  {number: 7, numeral: 'VII', title: "SECTION VII - Plastics and articles thereof; rubber and articles thereof (chapter 39 - 40)"},
  {number: 8, numeral: 'VIII', title: "SECTION VIII - Raw hides and skins, leather, furskins and articles thereof; saddlery and harness; travel goods, handbags and similar containers; articles of animal gut (other than silkworm gut) (chapter 41 - 43)"},
  {number: 9, numeral: 'IX', title: "SECTION IX - Wood and articles of wood; wood charcoal; cork and articles of cork; manufactures of straw, of esparto or of other plaiting materials; basketware and wickerwork (chapter 44 - 46)"},
  {number: 10, numeral: 'X', title: "SECTION X - Pulp of wood or of other fibrous cellulosic material; recovered (waste and scrap) paper or paperboard; paper and paperboard and articles thereof (chapter (chapter 47 - 49)"},
  {number: 11, numeral: 'XI', title: "SECTION XI - Textiles and textile articles (chapter 50 - 63)"},
  {number: 12, numeral: 'XII', title: "SECTION XII - Footwear, headgear, umbrellas, sun umbrellas, walking-sticks, seat-sticks, whips, riding-crops and parts thereof; prepared feathers and articles made therewith; artificial flowers; articles of human hair (chapter 64 - 67)"},
  {number: 13, numeral: 'XIII', title: "SECTION XIII - Articles of stone, plaster, cement, asbestos, mica or similar materials; ceramic products; glass and glassware (chapter 68 - 70)"},
  {number: 14, numeral: 'XIV', title: "SECTION XIV - Natural or cultured pearls, precious or semi-precious stones, precious metals, metals clad with precious metal and articles thereof; imitation jewellery; coins (chapter 71)"},
  {number: 15, numeral: 'XV', title: "SECTION XV - Base metals and articles of base metal (chapter 72 - 83)"},
  {number: 16, numeral: 'XVI', title: "SECTION XVI - Machinery and mechanical appliances; electrical equipment; parts thereof, sound recordes and reproducers, television image and sound recorders and reproducers, and parts and accessories of such articles (chapter 84 - 85)"},
  {number: 17, numeral: 'XVII', title: "SECTION XVII - Vehicles, aircraft, vessels and associated transport equipment (chapter 86 - 89)"},
  {number: 18, numeral: 'XVIII', title: "SECTION XVIII - Optical, photographic, cinematographic, measuring, checking, precision, medical or surgical instruments and apparatus; clocks and watches; musical instruments; parts and accessories thereof (chapter 90 - 92)"},
  {number: 19, numeral: 'XIX', title: "SECTION XIX - Arms and ammunition; parts and accessories thereof (chapter 93)"},
  {number: 20, numeral: 'XX', title: "SECTION XX - Miscellaneous manufactured articles (chapter 94 - 96)"},
  {number: 21, numeral: 'XXI', title: "SECTION XXI - Works of art, collectors' pieces and antiques (chapter 97 - 99)"}
]
# puts "Loading Sections"
# sections.each do |sec|
#   Section.create(sec)
# end

module XlsImporter
  def process_substr(x)
    x.nil? ? 0 : x.strip.split(' ').count
  end

  def process_id(x)
    x.gsub(" ", '')
  end

  def get_chapter(str)
    str[0..1]
  end

  def get_heading(str)
    str[0..3]
  end

  def build_attrs(row)
    { code: process_id(row[0]), description: row[6], hier_pos: row[4], substring: (process_substr(row[5])) }
  end

  def is_chapter?(attrs)
    attrs[:hier_pos] == 2 && attrs[:substring] == 0
  end

  def is_heading?(attrs)
    attrs[:hier_pos] == 4 && attrs[:substring] == 0
  end

  def create_objects(obj)
    if is_chapter?(obj)
      obj.delete(:hier_pos)
      obj.delete(:substring)
      Chapter.create(obj)
    elsif is_heading?(obj)
      chapter = Chapter.where("code LIKE ?", get_chapter(obj[:code])+'%').first
      Commodity.create(obj.merge({heading: true, chapter: chapter}))
    else
      # heading = Commodity.where("heading = TRUE AND code LIKE ?", get_heading(obj[:code])+'%')
      Commodity.create(obj)
    end
  end
end
include XlsImporter

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open Rails.root.join('db/goods-nomenclature.xls')
sheet1 = book.worksheet 0
p "#{sheet1.count} rows loaded"
sheet1.each 1 do |row|
  x = build_attrs(row)
  # p x
  create_objects(x)
end
