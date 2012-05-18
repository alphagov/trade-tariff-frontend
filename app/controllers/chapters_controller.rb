class ChaptersController < ApplicationController
  def show
    @chapter = Chapter.find(params[:id])
    @headings = @chapter.headings
  end
end
