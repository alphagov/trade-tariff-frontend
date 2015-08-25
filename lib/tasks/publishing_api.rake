namespace :publishing_api do
  desc "Publish special routes such as the homepage"
  task :publish_special_routes => :environment do
    require 'gds_api/publishing_api/special_route_publisher'

    publisher = GdsApi::PublishingApi::SpecialRoutePublisher.new(logger: Logger.new(STDOUT))

    publisher.publish(
      content_id: "81e8949b-a3fa-4712-97ff-decdd80024c8",
      base_path: "/trade-tariff",
      type: "prefix",
      rendering_app: "tariff",
      publishing_app: "tariff",
      title: "Trade tariff finder",
      description: I18n.t('meta_description'),
      public_updated_at: Time.zone.now.iso8601,
      update_type: "major",
    )
  end
end

desc "Temporary alias of publishing_api:publish_special_routes for backward compatibility"
task "router:register" => "publishing_api:publish_special_routes"
