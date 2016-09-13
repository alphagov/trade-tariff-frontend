require 'spec_helper'

describe Chapters::ChangesController, "GET to #index", type: :controller do
  let!(:chapter)   { Chapter.new(attributes_for :chapter, goods_nomenclature_item_id: "0100000000") }

  describe 'chapter is valid at given date', vcr: { cassette_name: "chapters_changes#index" } do
    before(:each) do
      get :index, chapter_id: chapter.short_code, format: :atom
    end

    it { should respond_with(:success) }
    it { expect(assigns(:changeable)).to be_present }
    it { expect(assigns(:changes)).to be_a(ChangesPresenter) }
  end

  describe 'chapter has no changes at given date', vcr: { cassette_name: "chapters_changes#index_0100000000_1972-01-01" } do
    before(:each) do
      get :index, chapter_id: chapter.short_code, as_of: Date.new(1972,1,1), format: :atom
    end

    it { should respond_with(:success) }
    it { expect(assigns(:changeable)).to be_present }
    it { expect(assigns(:changes)).to be_a(ChangesPresenter) }

    it 'fetches no changes' do
      expect(assigns[:changes]).to be_empty
    end
  end

  describe 'chapter is not valid at given date', vcr: { cassette_name: "chapters_changes#index_0100000000_1970-01-01" } do
    before(:each) do
      get :index, chapter_id: chapter.short_code, as_of: Date.new(1970,1,1), format: :atom
    end

    it { should respond_with(:not_found) }
  end
end
