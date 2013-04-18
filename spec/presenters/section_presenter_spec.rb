require 'spec_helper'

describe SectionPresenter do
  describe '#section_note' do
    let(:section) { stub(section_note: '**hello**') }

    it 'renders Markdown section note as HTML' do
      SectionPresenter.new(section).section_note.strip.should eq '<p><strong>hello</strong></p>'
    end
  end
end
