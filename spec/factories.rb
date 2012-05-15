FactoryGirl.define do
  factory :section do
    title    { Forgery(:basic).text }
    position { Forgery(:basic).number }
  end

  factory :chapter do
    section
    description { Forgery(:basic).text }
    number      { Forgery(:basic).number }
  end

  factory :commodity do
    chapter
    description { Forgery(:basic).text }
  end
end
