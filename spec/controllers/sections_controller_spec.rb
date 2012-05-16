require 'spec_helper'

describe SectionsController, "GET to #index" do
  let!(:section) { create :section }

  before(:each) do
    get :index
  end

  it { should respond_with(:success) }
  it { should assign_to(:sections) }
end
