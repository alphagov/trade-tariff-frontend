class SectionsController < ApplicationController
  def index
    Section.search do
      query { all }
    end.results
  end

  def show
  end
end
