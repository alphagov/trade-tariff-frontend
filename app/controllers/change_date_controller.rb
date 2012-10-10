class ChangeDateController < ApplicationController
  skip_before_filter :store_location

  def change
    redirect_back_or_default(sections_path, as_of: TariffDate.parse(params[:date]))
  end
end
