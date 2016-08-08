# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Enable the asset pipeline
Rails.application.config.assets.enabled = true

Rails.application.config.assets.prefix = "/tariff"

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

Rails.application.config.assets.precompile += %w{
  favicon.ico
  ui-icons_222222_256x240.png
  application.css
  application.js
  application-ie8.css
  application-ie7.css
  application-ie6.css
  tariff.css
  tariff-print.css
  gov.uk_logotype_crown.svg
}
