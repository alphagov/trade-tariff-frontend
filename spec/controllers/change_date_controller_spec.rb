require 'spec_helper'

describe ChangeDateController, "GET to #change" do
  let(:year)    { Forgery(:date).year }
  let(:month)   { Forgery(:date).month(numerical: true) }
  let(:day)     { Forgery(:date).day }

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
