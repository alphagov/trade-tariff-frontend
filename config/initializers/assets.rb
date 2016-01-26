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
}

# Assets from govuk-template
# See issue https://github.com/alphagov/govuk_template/issues/87
Rails.application.config.assets.precompile += %w(
  apple-touch-icon-152x152.png
  apple-touch-icon-120x120.png
  apple-touch-icon-76x76.png
  apple-touch-icon-60x60.png
  opengraph-image.png
  open-government-licence.png
  open-government-licence_2x.png
  govuk-crest.png
  govuk-crest-2x.png
  govuk-crest-ie.png
  gov.uk_logotype_crown.png
  gov.uk_logotype_crown-1x.png
  gov.uk_logotype_crown_invert_trans.png
  file.png
)






