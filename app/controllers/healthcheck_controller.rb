require "api_entity"

class HealthcheckController < ActionController::Base
  rescue_from ApiEntity::Error do |e|
    render text: '', status: :error
  end

  def check
    # Check API connectivity
    Section.all(headers: original_ua_headers)
    render json: { git_sha1: CURRENT_RELEASE_SHA }
  end

  private

  def original_ua_headers
    { "X_ORIGINAL_USER_AGENT" => request.env["HTTP_USER_AGENT"] }
  end
end
