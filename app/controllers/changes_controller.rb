class ChangesController < ApplicationController
  respond_to :atom

  def index
    @changes = ChangesPresenter.new(changeable.changes(query_params))

    respond_with(@changes)
  end

  helper_method :changeable
  helper_method :change_url
end
