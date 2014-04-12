require 'spec_helper'

describe SearchController, "GET to #search" do
  context 'with HTML format' do
    context 'with search term' do
      context "with exact match query", vcr: { cassette_name: "search#search_exact" }  do
        let(:query) { "01" }

        before(:each) do
          get :search, { t: query }
        end

        it { should respond_with(:redirect) }
        it { should assign_to(:search) }
        it 'assigns search attribute' do
          assigns[:search].t.should == query
        end
      end

      context "with fuzzy match query", vcr: { cassette_name: "search#search_fuzzy" }  do
        let(:query) { "horses" }

        before(:each) do
          get :search, { t: query }
        end

        it { should respond_with(:success) }
        it { should assign_to(:search) }
        it 'assigns search attribute' do
          assigns[:search].t.should == query
        end
      end

      context "with blank match",  vcr: { cassette_name: "search#blank_match" } do
        render_views

        let(:query) { " !such string should not exist in the database! " }

        before(:each) do
          get :search, { t: query }
        end

        it { should respond_with(:success) }
        it { should assign_to(:search) }
        it 'assigns search attribute' do
          assigns[:search].t.should == query
        end
        it "should display no results" do
          response.body.should =~ /no results/
        end
      end
    end

    context 'without search term', vcr: { cassette_name: "search#blank_match" }  do
      context 'changing browse date' do
        context 'valid date params provided' do
          let(:year)    { Forgery(:date).year }
          let(:month)   { Forgery(:date).month(numerical: true) }
          let(:day)     { (1..28).to_a.sample }

          before(:each) do
            @request.env['HTTP_REFERER'] = "/#{APP_SLUG}/chapters/01"

            post :search, {
              year: year,
              month: month,
              day: day
            }
          end

          it { should respond_with(:redirect) }
          it { should assign_to(:search) }
          it { should redirect_to(chapter_path("01", year: year, month: month, day: day)) }
        end

        context 'valid date time param(as_of) provided' do
          let(:year)    { Forgery(:date).year }
          let(:month)   { Forgery(:date).month(numerical: true) }
          let(:day)     { (1..28).to_a.sample }

          before(:each) do
            @request.env['HTTP_REFERER'] = "/#{APP_SLUG}/chapters/01"

            post :search, {
              as_of: "#{year}-#{month}-#{day}"
            }
          end

          it { should respond_with(:redirect) }
          it { should assign_to(:search) }
          it { should redirect_to(chapter_path("01", year: year, month: month, day: day)) }
        end

        context 'invalid date param provided' do
          context 'date param is a string' do
            before(:each) do
              post :search, date: "2012-10-1"
            end

            it { should respond_with(:redirect) }
            it { should assign_to(:search) }
            it { should redirect_to(sections_path) }
          end

          context 'date param does not have all components present' do
            let(:year)    { Forgery(:date).year }
            let(:month)   { Forgery(:date).month(numerical: true) }

            before(:each) do
              post :search, date: {
                year: year,
                month: month,
              }
            end

            it { should respond_with(:redirect) }
            it { should assign_to(:search) }
            it { should redirect_to(sections_path) }
          end

          context 'date param components are invalid' do
            let(:year)    { 'errr' }
            let(:month)   { 'er' }
            let(:day)     { 'er' }

            before(:each) do
              post :search, date: {
                year: year,
                month: month,
                day: day
              }
            end

            it { should respond_with(:redirect) }
            it { should assign_to(:search) }
            it { should redirect_to(sections_path) }
          end
        end
      end
    end
  end

  context 'with JSON format', vcr: { cassette_name: "search#search_fuzzy" } do
    let(:query) { "horses" }

    before(:each) do
      get :search, { t: query, format: :json }
    end

    let(:body) { JSON.parse(response.body) }

    describe 'returns search suggestions as specified in OpenSearch Suggestion extension' do
      specify 'returns an Array' do
        expect(body).to be_kind_of Array
      end

      specify 'first argument in Array is search query' do
        expect(body.first).to eq query
      end

      specify 'second argument in Array is Array of suggestions' do
        expect(body.second).to be_kind_of Array
        expect(body.second.first).to eq 'Live Horses, Asses, Mules And Hinnies'
      end
    end
  end

  context 'with ATOM format', vcr: { cassette_name: "search#search_fuzzy" } do
    render_views

    let(:query) { "horses" }

    before(:each) do
      get :search, { t: query, format: :atom }
    end

    describe 'returns search suggestion in ATOM 1.0 format' do
      specify 'includes link to current page (self link)' do
        expect(response.body).to include 'trade-tariff/search.atom'
      end

      specify 'includes link to opensearch.xml file (search link)' do
        expect(response.body).to include 'trade-tariff/opensearch.xml'
      end

      specify 'includes commodity descriptions' do
        expect(response.body).to include 'Of horses, asses, mules and hinnies'
      end

      specify 'includes links to commodity pages' do
        expect(response.body).to include 'trade-tariff/commodities/0206809100'
      end
    end
  end

  describe "header for crawlers", vcr: { cassette_name: "search#blank_match" } do
    context "non historical" do
      before { get :search }

      it "should not include X-Robots-Tag" do
        expect(response.headers["X-Robots-Tag"]).to_not be_present
      end
    end
    context "historical" do
      before {
        get :search, {month: 1, year: 2008, day: 1}
      }

      it {
        expect(response.headers["X-Robots-Tag"]).to eq("none")
      }
    end
  end
end
