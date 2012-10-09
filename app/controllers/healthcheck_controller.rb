class HealthcheckController < ActionController::Base
  def check
    # Check API connectivity
    Section.all
    render json: { git_sha1: CURRENT_RELEASE_SHA }
  end
end