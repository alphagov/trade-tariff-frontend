[![Build Status](https://travis-ci.org/alphagov/trade-tariff-frontend.png?branch=master)](https://travis-ci.org/alphagov/trade-tariff-frontend)

# TradeTariffFrontend

A web application front end for:

* [Trade Tariff Backend](https://github.com/alphagov/trade-tariff-backend)

This application requires the trade tariff backend API to be running.

Assumes the GDS development environment is setup via puppet.

## Run TradeTariffFrontend

    ./startup.sh

## Specs

To run the spec use the following command:

    RAILS_ENV=test bundle exec rake
