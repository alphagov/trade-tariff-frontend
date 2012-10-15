require 'addressable/uri'

class ChangeDateController < ApplicationController

  def change
    if request.referer
      back_url = Addressable::URI.parse(request.referer)
      back_url.query_values ||= {}
      back_url.query_values = back_url.query_values.merge("as_of" => TariffDate.parse(params[:date]).to_s)
      return_to = back_url.to_s
    else
      return_to = sections_path
    end
    redirect_to(return_to)
  end
end
