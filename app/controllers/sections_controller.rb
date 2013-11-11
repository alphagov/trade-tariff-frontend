class SectionsController < GoodsNomenclaturesController
  def index
    @tariff_updates = TariffUpdate.all
    @sections = Section.all
    @section_css = 'sections-context'
  end

  def show
    @section = Section.find(params[:id], query_params)
    @chapters = @section.chapters
  end

  private

  def find_relevant_goods_code_or_fallback
    redirect_to sections_url
  end
end
