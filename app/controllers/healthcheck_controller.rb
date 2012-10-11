class HealthcheckController < ActionController::Base
  rescue_from ApiEntity::Error do |e|
    render text: '', status: :error
  end

  def check
    # Check API connectivity
    Section.all
    render json: { git_sha1: CURRENT_RELEASE_SHA }
  end
end
