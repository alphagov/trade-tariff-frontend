require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    context 'string without HTML code' do
      let(:markdown_string) { '**hello**' }

      it 'renders string in Markdown as HTML' do
        helper.markdown(markdown_string).strip.should eq '<p><strong>hello</strong></p>'
      end
    end

    context 'string contains HTML code' do
      let(:markdown_string) { '<b class="class">abc</b>' }

      it 'HTML entities are escaped' do
        helper.markdown(markdown_string).strip.should eq '<p>abc</p>'
      end
    end
  end
end
