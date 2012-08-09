FactoryGirl.define do
  factory :section do
    title    { Forgery(:basic).text }
    position { 1 }
  end

  factory :chapter do
    section
    description { Forgery(:basic).text }
    goods_nomenclature_item_id { "0100000000" }
  end

  factory :heading do
    chapter
    description { Forgery(:basic).text }
    goods_nomenclature_item_id { "0101000000" }
  end

  factory :commodity do
    heading
    description { Forgery(:basic).text }
    producline_suffix { "80" }
    goods_nomenclature_item_id { "0101300000" }
    goods_nomenclature_sid { Forgery(:basic).number }
    parent_sid { Forgery(:basic).number }
  end
end
