require 'spec_helper'

describe HeadingsController, "GET to #show" do
  let!(:section) { create :section }
  let!(:chapter) { create :chapter, section: section }
  let!(:heading) { create :heading, chapter: chapter }

  before(:each) do
    get :show, id: heading.id
  end

  it { should respond_with(:success) }
  it { should assign_to(:heading) }
  it { should assign_to(:commodities) }
end
