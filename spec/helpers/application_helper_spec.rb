require 'spec_helper'

describe ApplicationHelper, type: :helper do
  describe '#govspeak' do
    context 'string without HTML code' do
      let(:string) { '**hello**' }

      it 'renders string in Markdown as HTML' do
        helper.govspeak(string).strip.should eq '<p><strong>hello</strong></p>'
      end
    end

    context 'string contains Javascript code' do
      let(:string) { "<script type='text/javascript'>alert('hello');</script>" }

      it '<script> tags are filtered' do
        helper.govspeak(string).strip.should eq "alert('hello');"
      end
    end
  end
end
