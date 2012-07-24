class HeadingsController < ApplicationController
  def show
    @heading = Heading.find(params[:id])
    @commodities = @heading.commodities
  end
end
