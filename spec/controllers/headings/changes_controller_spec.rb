require 'spec_helper'

describe Headings::ChangesController, "GET to #index", vcr: { cassette_name: "headings_changes#index" }  do
  let!(:heading)   { Heading.new(attributes_for :heading, goods_nomenclature_item_id: "0101000000") }

  before(:each) do
    get :index, heading_id: heading.short_code, format: :atom
  end

  it { should respond_with(:success) }
  it { should assign_to(:changeable) }
  it { should assign_to(:changes) }
end
