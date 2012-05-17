FactoryGirl.define do
  factory :section do
    title    { Forgery(:basic).text }
    position { Forgery(:basic).number }
  end

  factory :chapter do
    section
    description { Forgery(:basic).text }
    code        { Forgery(:basic).number }
  end

  factory :heading, class: Commodity do
    chapter
    description { Forgery(:basic).text }
    is_heading  { true }
  end

  factory :commodity do
    chapter
    description { Forgery(:basic).text }
  end
end
