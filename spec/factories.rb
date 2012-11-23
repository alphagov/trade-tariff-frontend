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

  factory :measure do
    origin { ['eu', 'uk'].sample }
    measure_type_description { Forgery(:basic).text }
    ordernumber { Forgery(:basic).number(exactly: 5) }
    effective_start_date { Date.today.ago(3.years).to_s }
    effective_end_date { nil }
    measure_type_id { Forgery(:basic).text }

    trait :vat do
      measure_type_description { 'VAT' }
    end

    trait :third_country do
      measure_type_id { '103' }
      geographical_area { attributes_for(:geographical_area, :third_country) }
    end

    trait :specific_country do
      geographical_area { attributes_for(:geographical_area, :specific_country) }
    end

    trait :with_conditions do
      measure_conditions { [attributes_for(:measure_condition)] }
    end

    trait :with_additional_code do
      additional_code { attributes_for(:additional_code) }
    end

    trait :with_footnotes do
      footnotes { [attributes_for(:footnote)] }
    end
  end

  factory :geographical_area do
    iso_code { Forgery(:basic).text(exactly: 2).upcase }
    description { Forgery(:basic).text }

    trait :third_country do
      description { "ERGA OMNES" }
    end

    trait :specific_country do
      description { Forgery(:basic).text }
    end

    trait :with_children do
      iso_code { nil }
      children_geographical_areas { [attributes_for(:geograpical_area)] }
    end
  end

  factory :measure_condition do
    document_code { Forgery(:basic).text }
    action { Forgery(:basic).text }
    condition { Forgery(:basic).text }
    requirement_type { Forgery(:basic).text }
  end

  factory :additional_code do
    code { Forgery(:basic).text }
    description { Forgery(:basic).text }
  end

  factory :footnote do
    code { Forgery(:basic).text }
    description { Forgery(:basic).text }
  end

  factory :measure_component do
    duty_expression_id { Forgery(:basic).text }

    trait :meursing do
      duty_expression_id { %w[12 14 21 25 27 29].sample }
    end
  end
end
