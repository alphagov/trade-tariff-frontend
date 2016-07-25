[![Circle CI](https://circleci.com/gh/bitzesty/trade-tariff-frontend.svg?style=svg)](https://circleci.com/gh/bitzesty/trade-tariff-frontend)

# Trade Tariff Frontend

https://www.gov.uk/trade-tariff

This is the front-end application for:

* [Trade Tariff Backend](https://github.com/alphagov/trade-tariff-backend)

This application requires the Trade Tariff Backend API to be running and the following env variable set `TARIFF_API_HOST`.

## Running the frontend

Requires:
* Ruby
* Rails

Uses:
* Memcache

Commands:

    ./bin/setup
    foreman start

## Running the test suite

To run the spec use the following command:

    RAILS_ENV=test bundle exec rake

## Deploying the application

We deploy to cloud foundry, so you need to have the CLI installed, and the following [cf plugin](https://docs.cloudfoundry.org/cf-cli/use-cli-plugins.html) installed:

Download the plugin for your os:  https://github.com/contraband/autopilot/releases

    chmod +x autopilot-(YOUR_OS)
    cf install-plugin autopilot-(YOUR_OS)

Set the following ENV variables:
* CF_USER
* CF_PASSWORD
* CF_ORG
* CF_SPACE
* CF_APP

Then run

    ./bin/deploy
