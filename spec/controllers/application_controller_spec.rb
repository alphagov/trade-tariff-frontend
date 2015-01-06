require 'spec_helper'

describe ApplicationController, type: :controller do
  describe "behaviour for all subclasses" do
    controller do
      def index
        render :text => "Jabberwocky"
      end
    end

    it "should fetch the artefact from content api" do
      artefact_data = artefact_for_slug(APP_SLUG)
      content_api_has_an_artefact(APP_SLUG, artefact_data)

      get :index

      expect(assigns(:aretefact))
    end

    describe "caching" do
      before do
        get :index
      end

      it "should have a max-age of 2 hours" do
        expect(response.headers["Cache-Control"]).to include "max-age=7200"
      end

      it "should have a public directive" do
        expect(response.headers["Cache-Control"]).to include "public"
      end

      it "should have a stale-if-error of 1 day" do
        expect(response.headers["Cache-Control"]).to include "stale-if-error=86400"
      end

      it "should have a stale-while-revalidate of 1 day" do
        expect(response.headers["Cache-Control"]).to include "stale-while-revalidate=86400"
      end
    end
  end
end
