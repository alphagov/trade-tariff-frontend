class ChangeDateController < ApplicationController
  def change
    params[:as_of] = "#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}"
    @tariff_date = TariffDate.new(params[:as_of])
    redirect_to sections_path, as_of: "#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}"
  end
end