class PagesController < ApplicationController
  layout "pages"

  def index
    @section_css = 'visuallyhidden'
    @meta_description = I18n.t('meta_description')
  end

  def opensearch
    respond_to do |format|
      format.xml
    end
  end
end
