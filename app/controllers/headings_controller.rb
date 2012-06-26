class HeadingsController < ApplicationController
  def show
    @heading = Heading.find(params[:id])
    # FIXME: this should be fixed in the model/API
    @commodities = @heading.commodities.select { |x| x if x.commodities.length > 0 }
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
