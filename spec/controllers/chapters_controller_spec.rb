require 'spec_helper'

describe ChaptersController, "GET to #show" do
  let!(:section) { create :section }
  let!(:chapter) { create :chapter, section: section }

  before(:each) do
    get :show, id: chapter.id
  end

  it { should respond_with(:success) }
  it { should assign_to(:chapter) }
  it { should assign_to(:headings) }
end
