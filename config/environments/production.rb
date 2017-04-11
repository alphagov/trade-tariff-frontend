TradeTariffFrontend::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_files = true

  # Compress JavaScripts and CSS
  config.assets.js_compressor = :uglifier

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # See everything in the log (default is :info)
  config.log_level = :info
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.custom_options = lambda do |event|
    {
      params: event.payload[:params].except('controller', 'action', 'format', 'utf8'),
    }.merge(
      JSON.parse(ENV['VCAP_APPLICATION']).except('application_uris', 'host', 'application_name', 'space_id', 'port', 'uris', 'application_version')
    )
  end
  config.lograge.ignore_actions = ['HealthcheckController#index']

  # Use a different cache store in production
  config.cache_store = :dalli_store, nil, {
    compress: true,
    expires_in: 1.day,
    username: ENV["MEMCACHE_USER"],
    password: ENV["MEMCACHE_PASSWORD"],
    namespace: ENV["GOVUK_APP_DOMAIN"],
    pool_size: Integer(ENV["MAX_THREADS"] || 5)
  }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  config.action_controller.asset_host = ENV["GOVUK_ASSET_ROOT"]

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( tariff-print.css.scss )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :ses

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Host for Trade Tariff API endpoint
  config.api_host = ENV["PLEK_SERVICE_TARIFF_API_URI"]
end
