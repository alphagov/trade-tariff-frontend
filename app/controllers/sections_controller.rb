class SectionsController < ApplicationController
  def index
    Section.search do
      query { all }
      sort { by '_id' }
    end
  end

  def show
  end
end
