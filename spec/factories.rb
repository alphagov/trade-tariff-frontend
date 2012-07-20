FactoryGirl.define do
  factory :section do
    id       { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    title    { Forgery(:basic).text }
    position { Forgery(:basic).number }
  end

  factory :chapter do
    section
    id       { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    description { Forgery(:basic).text }
    code        { Forgery(:basic).number }
    short_code  { Forgery(:basic).number }
  end

  factory :heading do
    chapter
    id       { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    description { Forgery(:basic).text }
    code        { Forgery(:basic).number.to_s }
    short_code  { Forgery(:basic).number }
  end

  factory :commodity do
    heading
    id       { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    description { Forgery(:basic).text }
    code        { Forgery(:basic).number }
    short_code  { Forgery(:basic).number }
    producline_suffix { ["10", "20", "80"].sample }

    trait :with_children do
      children { [attributes_for(:commodity)] }
    end

    trait :without_children do
      children { [] }
    end
  end

  factory :region do
    id          { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    name        { Forgery(:basic).text }
    iso_code    { Forgery(:address).country.first(2).upcase }
    description { Forgery(:basic).text }
    type        { Region::TYPES.sample }
    countries   { [] }
  end

  factory :country do
    id          { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    name        { Forgery(:basic).text }
  end
end
