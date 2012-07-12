class HeadingsController < ApplicationController
  def show
    @heading = Heading.find(params[:id])
    @commodities = @heading.commodities
  end

  def import_measures
    @measurable = Heading.find(params[:id])
    @import_measures = @measurable.import_measures
    render "measures/import"
  end

  def export_measures
    @measurable = Heading.find(params[:id])
    @export_measures = @measurable.export_measures
    render "measures/export"
  end

end
