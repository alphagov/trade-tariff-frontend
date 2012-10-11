class PagesController < ApplicationController
  layout "pages"

  def index
    @section_css = 'visuallyhidden'
  end
end
