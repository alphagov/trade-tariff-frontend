[![Build Status](https://travis-ci.org/alphagov/trade-tariff-frontend.png?branch=master)](https://travis-ci.org/alphagov/trade-tariff-frontend)

# TradeTariffFrontend

A web application front end for:

* [Trade Tariff Backend](https://github.com/alphagov/trade-tariff-backend)

Please ensure the API is running and properly configured in the 
environment files.

Assumes the GDS development environment is setup via puppet.

## Run TradeTariffFrontend

    ./startup.sh

## Specs

To run the spec use the following command: 

    RAILS_ENV=test bundle exec rake ci:setup:rspec spec assets:clean assets:precompile
