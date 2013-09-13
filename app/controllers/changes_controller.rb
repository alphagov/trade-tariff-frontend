class ChangesController < ApplicationController
  def index
    @changes = ChangesPresenter.new(changeable.changes)

    respond_to do |format|
      format.atom
    end
  end

  helper_method :changeable
  helper_method :change_url
end
