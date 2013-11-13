class PagesController < ApplicationController
  layout "pages"

  def index
    @section_css = 'visuallyhidden'
  end

  def opensearch
    respond_to do |format|
      format.xml
    end
  end
end
