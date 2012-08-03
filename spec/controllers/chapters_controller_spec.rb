require 'spec_helper'

describe ChaptersController, "GET to #show", vcr: { cassette_name: "chapters#show" } do
  let!(:section)     { attributes_for :section }
  let!(:chapter)     { build :chapter, section: section }
  let!(:actual_date) { Date.today.to_s(:dashed) }

  before(:each) do
    get :show, id: chapter.to_param
  end

  it { should respond_with(:success) }
  it { should assign_to(:chapter) }
  it { should assign_to(:headings) }
end
