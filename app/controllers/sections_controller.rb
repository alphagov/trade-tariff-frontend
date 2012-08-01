class SectionsController < ApplicationController
  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id], query_params)
    @chapters = @section.chapters
  end
end
