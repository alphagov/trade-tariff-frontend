require 'spec_helper'

describe Chapters::ChangesController, "GET to #index", vcr: { cassette_name: "chapters_changes#index" }  do
  let!(:chapter)   { Chapter.new(attributes_for :chapter, goods_nomenclature_item_id: "0100000000") }

  before(:each) do
    get :index, chapter_id: chapter.short_code, format: :atom
  end

  it { should respond_with(:success) }
  it { should assign_to(:changeable) }
  it { should assign_to(:changes) }
end
