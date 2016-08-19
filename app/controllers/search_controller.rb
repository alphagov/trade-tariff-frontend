require 'addressable/uri'

class SearchController < ApplicationController
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
          anchor = if params[:search][:anchor].present?
            if params[:search][:anchor] == 'import'
              '#import'
            else
              '#export'
            end
          end
          redirect_to(return_to + anchor)
        end
      }

      format.json {
        render json: SearchPresenter.new(@search, @results)
      }

      format.atom
    end
  end
end
