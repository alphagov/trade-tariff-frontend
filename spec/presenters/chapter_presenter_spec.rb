require 'spec_helper'

describe ChapterPresenter do
  describe '#chapter_note' do
    let(:chapter) { stub(chapter_note: '**hello**') }

    it 'render chapter note in Markdown' do
      ChapterPresenter.new(chapter).chapter_note.strip.should eq '<p><strong>hello</strong></p>'
    end
  end
end
