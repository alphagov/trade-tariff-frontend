require "spec_helper"

describe "JS behaviour", js: true do
  before {
    VCR.use_cassette("commodities#show_0201300020") do
      visit commodity_path("0201300020")
    end
  }

  context "tabs" do
    it "*overview* tab is shown" do
      expect(page).to have_selector("#overview-enhanced", visible: true)
    end

    it "*import* tab is hidden" do
      expect(page).to_not have_selector("#import-enhanced", visible: true)
    end

    describe "switch tabs" do
      before {
        within ".nav-tabs" do
          click_on "Import"
        end
      }

      it "*overview* tab is hidden" do
        expect(page).to_not have_selector("#overview-enhanced", visible: true)
      end

      it "*import* tab is shown" do
        expect(page).to have_selector("#import-enhanced", visible: true)
      end
    end
  end

  context "popups" do
    before {
      expect(page).to_not have_selector("#popup .info-content", visible: true) # ensure popup is hidden

      within ".nav-tabs" do
        click_on "Import"
      end
      within "#measure-3319435" do
        click_on "View Conditions"
      end
    }

    it {
      expect(page).to have_selector("#popup .info-content", visible: true)
    }

    it {
      expect(page).to have_content("Import control - CITES for ERGA OMNES")
    }
  end
end
