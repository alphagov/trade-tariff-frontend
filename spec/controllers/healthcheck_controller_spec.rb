require 'spec_helper'

describe HealthcheckController do
  it "returns success on request" do
    Section.stub(:all).and_return([])

    get :check
    response.status.should == 200
  end

  it "throws a 500 on no API connection" do
    Section.stub(:all).and_raise(ApiEntity::Error.new("502 Bad Gateway"))
    get :check
    response.status.should == 500
  end
end
