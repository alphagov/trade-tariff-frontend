require 'spec_helper'

describe Search do
  it 'strips [ and ] characters from search term' do
    search = Search.new(t: '[hello] [world]')
    search.t.should eq 'hello world'
  end

  it 'raises on error if search responds with status 500' do
    response_stub = OpenStruct.new(code: 500)
    Search.stub(:post).and_return(response_stub)

    expect { Search.new(t: 'abc').perform }.to raise_error ApiEntity::Error
  end
end
