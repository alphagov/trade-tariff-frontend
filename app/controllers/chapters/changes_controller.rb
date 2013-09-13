module Chapters
  class ChangesController < ::ChangesController
    def changeable
      @changeable ||= Chapter.find(params[:chapter_id], query_params)
    end

    def change_url(*)
      chapter_url(changeable)
    end
  end
end
