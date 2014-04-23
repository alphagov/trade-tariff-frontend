require "spec_helper"
require "tariff_diff"

require "pry"

describe TariffDiff do
  let(:host1) { "http://tariff.dev.gov.uk/" }
  let(:host2) { "https://www.gov.uk/" }
  let(:diff)  { TariffDiff.new(host1: host1, host2: host2) }

  describe "#initialize" do
    it "should setup faraday correctly" do
      expect(diff.host1.url_prefix.to_s).to eq(host1)
      expect(diff.host2.url_prefix.to_s).to eq(host2)
    end
  end

  describe "diff" do
    around { |example|
      VCR.use_cassette('tariff_diff_spec#diff') do
        example.yield
      end
    }

    before {
      # set chapter
      ENV["chapter"] = "01"
      Rails.logger.level = Logger::WARN
      diff.run!
    }

    it {
      expect(diff.resources_count).to eq(154)
      expect(diff.not_found.count).to eq(38)
      expect(diff.not_found).to include("https://www.gov.uk/trade-tariff/commodities/0102909100.json")

      expect(diff.not_matching.values.flatten.count).to eq(148)
      expect(diff.not_matching[:commodities]).to include("0101300000")
    }
  end
end
