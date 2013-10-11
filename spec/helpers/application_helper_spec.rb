require 'spec_helper'

describe ApplicationHelper do
  describe '#govspeak' do
    context 'string without HTML code' do
      let(:string) { '**hello**' }

      it 'renders string in Markdown as HTML' do
        helper.govspeak(string).strip.should eq '<p><strong>hello</strong></p>'
      end
    end

    context 'string contains Javascript code' do
      let(:string) { "<script type='text/javascript'>alert('hello');</script>" }

      it '<script> tags are filtered, quotes are escaped' do
        helper.govspeak(string).strip.should eq "<p>alert(&#39;hello&#39;);</p>"
      end
    end
  end
end
