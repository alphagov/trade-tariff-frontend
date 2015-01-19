require "spec_helper"

describe "a-z index", vcr: {
  cassette_name: "search_references#az_index",
  record: :new_episodes
} do
  let(:search_reference) {
    SearchReference.all.first
  }

  before {
    visit a_z_index_path("a")
  }

  it {
    expect(page).to have_content(search_reference.title.titleize)
  }
end
