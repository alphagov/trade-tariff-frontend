require 'spec_helper'

describe ApplicationController do

  describe "behaviour for all subclasses" do
    controller do
      def index
        render :text => "Jabberwocky"
      end
    end

    it "should fetch the artefact and pass it to slimmer" do
      mock_artefact = {"slug" => APP_SLUG, "title" => "Trade Tariff"}
      GdsApi::Panopticon.any_instance.should_receive(:artefact_for_slug).with(APP_SLUG).and_return(mock_artefact)
      @controller.should_receive(:set_slimmer_artefact).with(mock_artefact)

      get :index
    end
  end
end
