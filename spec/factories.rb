FactoryGirl.define do
  factory :section do
    title    { Forgery(:basic).text }
    position { Forgery(:basic).number }
  end

  factory :chapter do
    section
    description { Forgery(:basic).text }
    goods_nomenclature_item_id { "#{2.times.map{ Random.rand(9) }.join}00000000" }
  end

  factory :heading do
    chapter
    description { Forgery(:basic).text }
    goods_nomenclature_item_id { "#{4.times.map{ Random.rand(9) }.join}00000000" }
  end

  factory :commodity do
    heading
    description { Forgery(:basic).text }
    producline_suffix { ["10", "20", "80"].sample }
    goods_nomenclature_item_id { 10.times.map{ Random.rand(9) }.join }

    trait :with_children do
      children { [attributes_for(:commodity)] }
    end

    trait :without_children do
      children { [] }
    end
  end
end
