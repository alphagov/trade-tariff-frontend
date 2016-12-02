class GeographicalAreasController < ApplicationController
  respond_to :json

  def index
    results = geographical_areas.map do |geographical_area|
      {
        id: geographical_area.id,
        text: geographical_area.long_description
      }
    end
    respond_with results: results
  end

  private

  def geographical_areas
    search_term = Regexp.escape(params[:term])
    GeographicalArea.by_long_description(search_term)
                    .sort_by(&:description)
  end
end
