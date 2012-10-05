class HealthcheckController < ActionController::Base
  def check
    # Check API connectivity
    Section.all
    render json: {}
  end
end