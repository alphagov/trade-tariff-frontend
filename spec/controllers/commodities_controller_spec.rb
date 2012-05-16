require 'spec_helper'

describe CommoditiesController, "GET to #index" do
  let!(:section) { create :section }
  let!(:chapter) { create :chapter, section: section }

  before(:each) do
    get :index, section_id: section.id,
                chapter_id: chapter.id
  end

  it { should respond_with(:success) }
  it { should assign_to(:section) }
  it { should assign_to(:chapter) }
  it { should assign_to(:commodities) }
end
