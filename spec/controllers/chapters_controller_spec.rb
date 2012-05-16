require 'spec_helper'

describe ChaptersController, "GET to #index" do
  let!(:section) { create :section }

  before(:each) do
    get :index, section_id: section.id
  end

  it { should respond_with(:success) }
  it { should assign_to(:section) }
  it { should assign_to(:chapters) }
end
