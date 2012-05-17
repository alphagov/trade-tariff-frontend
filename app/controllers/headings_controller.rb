class HeadingsController < ApplicationController
  def index
    @section = Section.find(params[:section_id])
    @chapter = @section.chapters.find(params[:chapter_id])
    @headings = @chapter.headings
  end
end
