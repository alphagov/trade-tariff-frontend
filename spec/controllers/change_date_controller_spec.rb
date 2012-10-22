require 'spec_helper'

describe ChangeDateController, "GET to #change" do
  context 'valid date param provided' do
    let(:year)    { Forgery(:date).year }
    let(:month)   { Forgery(:date).month(numerical: true) }
    let(:day)     { Forgery(:date).day }

    before(:each) do
      @request.env['HTTP_REFERER'] = "/#{APP_SLUG}/chapters/01"

      get :change, { date: {
        year: year,
        month: month,
        day: day
      } }
    end

    it { should respond_with(:redirect) }
    it { should assign_to(:tariff_date) }
    it { should redirect_to(chapter_path("01", as_of: Date.new(year, month, day).to_s(:db))) }
  end

  context 'invalid date param provided' do
    context 'date param is a string' do
      before(:each) do
        get :change, date: "2012-10-1"
      end

      it { should respond_with(:redirect) }
      it { should assign_to(:tariff_date) }
      it { should redirect_to(sections_path) }
    end

    context 'date param does not have all components present' do
      let(:year)    { Forgery(:date).year }
      let(:month)   { Forgery(:date).month(numerical: true) }

      before(:each) do
        get :change, date: {
          year: year,
          month: month,
        }
      end

      it { should respond_with(:redirect) }
      it { should assign_to(:tariff_date) }
      it { should redirect_to(sections_path) }
    end

    context 'date param components are invalid' do
      let(:year)    { 'errr' }
      let(:month)   { 'er' }
      let(:day)     { 'er' }

      before(:each) do
        get :change, date: {
          year: year,
          month: month,
          day: day
        }
      end

      it { should respond_with(:redirect) }
      it { should assign_to(:tariff_date) }
      it { should redirect_to(sections_path) }
    end
  end
end
