require 'spec_helper'

describe ApplicationHelper, type: :helper do
  describe '#govspeak' do
    context 'string without HTML code' do
      let(:string) { '**hello**' }

      it 'renders string in Markdown as HTML' do
        expect(
          helper.govspeak(string).strip
        ).to eq '<p><strong>hello</strong></p>'
      end
    end

    context 'string contains Javascript code' do
      let(:string) { "<script type='text/javascript'>alert('hello');</script>" }

      it '<script> tags are filtered' do
        expect(
          helper.govspeak(string).strip
        ).to eq "alert('hello');"
      end
    end
  end
end
