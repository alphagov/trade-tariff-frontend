require 'forgery'
require 'factory_girl'
require File.join(Rails.root, 'spec', 'factories.rb') unless FactoryGirl.factories.registered?(:system_admin)

3.times do
  section = FactoryGirl.create :section

  3.times do
    chapter = FactoryGirl.create(:chapter, section: section)

    3.times do
      commodity = FactoryGirl.create(:commodity, chapter: chapter)
    end
  end
end
