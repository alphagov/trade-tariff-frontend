class ChaptersController < GoodsNomenclaturesController
  def show
    @chapter = Chapter.find(params[:id], query_params)
    @headings = @chapter.headings
  end
end
