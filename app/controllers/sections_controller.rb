class SectionsController < ApplicationController
  def index
    @sections = Section.search do
      query { all }
      sort { by :section_number }
      # size 222
    end.results
  end

  def show
  end
end
