require 'forgery'
require 'factory_girl'
require File.join(Rails.root, 'spec', 'factories.rb') unless FactoryGirl.factories.registered?(:section)

3.times do
  section = FactoryGirl.create :section

  3.times do
    chapter = FactoryGirl.create(:chapter, section: section)

    3.times do
      heading = FactoryGirl.create(:heading, chapter: chapter)

      3.times do
        commodity = FactoryGirl.create(:commodity, heading: heading)
      end
    end
  end
end
