class ChaptersController < ApplicationController
  def show
    @chapter = ChapterPresenter.new(Chapter.find(params[:id], query_params))
    @headings = @chapter.headings
  end
end
