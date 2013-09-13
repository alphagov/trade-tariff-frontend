module Headings
  class ChangesController < ::ChangesController
    def changeable
      @changeable ||= HeadingPresenter.new(Heading.find(params[:heading_id], query_params))
    end
  end
end
