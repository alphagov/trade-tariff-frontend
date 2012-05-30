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
    short_code  { Forgery(:basic).number }
  end

  factory :commodity do
    heading
    id       { "4fbb5fc12b200f0f5e000001" } # example id used for FactoryGirl.attributes_for
    description { Forgery(:basic).text }
    short_code  { Forgery(:basic).number }
  end
end
