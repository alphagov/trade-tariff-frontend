require 'spec_helper'

describe ChaptersController, "GET to #show", type: :controller do
  let!(:section)     { attributes_for :section }

  context 'with existing chapter id provided', vcr: { cassette_name: "chapters#show" } do
    let!(:chapter)     { build :chapter, section: section }
    let!(:actual_date) { Date.today.to_s(:dashed) }

    before(:each) do
      get :show, id: chapter.to_param
    end

    it { should respond_with(:success) }
    it { expect(assigns(:chapter)).to be_a(Chapter) }
    it { expect(assigns(:headings)).to be_a(Array) }
  end

  context 'with too long chapter id provided', vcr: { cassette_name: "chapters#show_011" } do
    let(:chapter_id) { '011' } # chapter 0101 actually exists

    before(:each) do
      get :show, id: chapter_id
    end

    it 'redirects to chapter page (strips exceeding chapter id characters)' do
      expect(response.status).to eq 302
      expect(response.location).to eq chapter_url(id: chapter_id.first(2))
    end
  end

  context 'with non existing chapter id provided', vcr: { cassette_name: "chapters#show_bb" } do
    let(:chapter_id) { 'bb' }

    before(:each) do
      get :show, id: chapter_id
    end

    it 'redirects to sections index page as fallback' do
      expect(response.status).to eq 302
      expect(response.location).to eq sections_url
    end
  end
end
