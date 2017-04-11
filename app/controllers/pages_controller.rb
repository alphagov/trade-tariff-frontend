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

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end
end
