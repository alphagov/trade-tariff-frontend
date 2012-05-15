class SectionsController < ApplicationController
  def index
    @sections = Section.all
  end

  def show
  end
end
