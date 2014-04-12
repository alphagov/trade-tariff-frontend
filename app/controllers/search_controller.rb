require 'addressable/uri'

class SearchController < ApplicationController
  before_filter :bots_no_index_if_historical, only: :search

  def search
    @results = @search.perform

    respond_to do |format|
      format.html {
        if @search.contains_search_term?
          redirect_to url_for(@results.to_param.merge(url_options)) if @results.exact_match?
        else
          if request.referer
            back_url = Addressable::URI.parse(request.referer)
            back_url.query_values ||= {}
            back_url.query_values = back_url.query_values.merge(@search.query_attributes)
            return_to = back_url.to_s
          else
            return_to = sections_path
          end

          redirect_to(return_to)
        end
      }

      format.json {
        render json: SearchPresenter.new(@search, @results)
      }

      format.atom
    end
  end

  private

  def bots_no_index_if_historical
    response.headers["X-Robots-Tag"] = "none" unless @search.today?
  end
end
