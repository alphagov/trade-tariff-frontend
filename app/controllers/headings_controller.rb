class HeadingsController < ApplicationController
  def show
    @heading = Heading.find(params[:id], query_params)
    @commodities = @heading.commodities
  end
end
