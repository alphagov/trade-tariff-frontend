require 'ostruct'

namespace :panopticon do
  desc "Register application metadata with panopticon"
  task :register => :environment do
    require 'gds_api/panopticon'

    logger = GdsApi::Base.logger = Logger.new(STDERR).tap { |l| l.level = Logger::INFO }
    logger.info "Registering with panopticon..."

    registerer = GdsApi::Panopticon::Registerer.new(owning_app: "tariff")

    record = OpenStruct.new(
        slug: APP_SLUG,
        title: "UK Trade Tariff",
        description: "Search for import and export commodity codes and for tax, duty and licenses that apply to your goods",
        need_id: "B659",
        section: "business/international-trade",
        paths: [APP_SLUG],
        prefixes: [APP_SLUG],
        state: "live",
        indexable_content: "Search for import and export commodity codes and for tax, duty and licenses that apply to your goods")
    registerer.register(record)
  end
end
