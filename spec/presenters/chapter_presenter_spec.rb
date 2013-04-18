require 'spec_helper'

describe ChapterPresenter do
  describe '#chapter_note' do
    let(:chapter) { stub(chapter_note: '**hello**') }

    it 'renders Markdown chapter note as HTML' do
      ChapterPresenter.new(chapter).chapter_note.strip.should eq '<p><strong>hello</strong></p>'
    end
  end
end
