require "spec_helper"

describe "measures/_measure.html.erb", type: :view do
  let(:measure) {
    Measure.new(
      attributes_for(:measure, :third_country,
                               duty_expression: duty_expression)
    )
  }

  before {
    render "measures/measure.html.erb", measure: MeasurePresenter.new(measure)
  }

  context "with formatted_base" do
    let(:duty_expression) { attributes_for(:duty_expression) }

    it {
      rendered.should =~ /EUR/
      rendered.should =~ /Hectokilogram/
      rendered.should =~ /<abbr title='Hectokilogram'>/
    }
  end

  context "without formatted_base" do
    let(:duty_expression) {
      attributes_for(:duty_expression, formatted_base: nil)
    }

    it {
      rendered.should =~ /EUR/
      rendered.should =~ /Hectokilogram/
    }
  end
end
