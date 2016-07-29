class ErrorsController < ApplicationController
  layout "pages"

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  def maintenance
    render status: 503
  end
end
