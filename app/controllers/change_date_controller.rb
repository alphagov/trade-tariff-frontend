class ChangeDateController < ApplicationController
  def change
    redirect_to sections_path(as_of: TariffDate.parse(params[:date]))
  end
end
