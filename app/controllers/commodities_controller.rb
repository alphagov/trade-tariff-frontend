class CommoditiesController < ApplicationController
  def show
    @commodity = Commodity.find(params[:id])
    @heading = @commodity.heading
    @chapter = @commodity.chapter
    @section = @commodity.section
  end

  def edit
    @commodity = Commodity.find(params[:id])
  end

  def update
    @commodity = Commodity.find(params[:id])
    @commodity.update_attrs(params)
    redirect_to edit_commodity_path(@commodity)
  end

  def import_measures
    @measurable = Commodity.find(params[:id])
    @import_measures = @measurable.import_measures
    render "measures/import"
  end

  def export_measures
    @measurable = Commodity.find(params[:id])
    @export_measures = @measurable.export_measures
    render "measures/export"
  end
end
