module Chapters
  class ChangesController < ::ChangesController
    def changeable
      @changeable ||= Chapter.find(params[:chapter_id], query_params)
    end
  end
end
