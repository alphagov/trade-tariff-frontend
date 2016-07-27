module Headings
  class ChangesController < ::ChangesController

    private

    def heading
      @heading ||= Heading.find(params[:heading_id], query_params)
    end

    def changeable
      @changeable ||= HeadingPresenter.new(heading)
    end

    def change_url(*)
      heading_url(heading)
    end
  end
end
