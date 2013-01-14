require 'spec_helper'

describe Search do
  subject { Search }

  it 'raises on error if search responds with status 500' do
    response_stub = stub(code: 500)
    Search.stub(:post).and_return(response_stub)

    expect { Search.new(t: 'abc').perform }.to raise_error ApiEntity::Error
  end
end
