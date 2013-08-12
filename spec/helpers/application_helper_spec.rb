require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    let(:markdown_string) { '**hello**' }

    it 'renders string in Markdown as HTML' do
      helper.markdown(markdown_string).strip.should eq '<p><strong>hello</strong></p>'
    end
  end
end
