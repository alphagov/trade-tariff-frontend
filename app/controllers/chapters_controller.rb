class ChaptersController < GoodsNomenclaturesController
  def show
    @chapter = Chapter.find(params[:id], query_params)
    @headings = @chapter.headings
  end

  private

  def goods_code_id
    super.first(4)
  end
end
