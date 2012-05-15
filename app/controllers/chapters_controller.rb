class ChaptersController < ApplicationController
  def index
    @section = Section.find(params[:section_id])
    @chapters = @section.chapters
  end
end
