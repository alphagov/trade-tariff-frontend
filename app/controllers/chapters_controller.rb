class ChaptersController < ApplicationController
  def show
    @chapter = Chapter.find(params[:id], query_params)
    @headings = @chapter.headings
  end

  def changes
    @chapter = Chapter.find(params[:id], query_params)
    @changes = ChangesPresenter.new(@chapter.changes)

    respond_to do |format|
      format.atom
    end
  end
end
