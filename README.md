[![Build Status](https://travis-ci.org/alphagov/trade-tariff-frontend.png?branch=master)](https://travis-ci.org/alphagov/trade-tariff-frontend)

# TradeTariffFrontend

A web application front end for:

* [Trade Tariff Backend](https://github.com/alphagov/trade-tariff-backend)

This application requires the trade tariff backend API to be running.

Assumes the GDS development environment is setup via puppet.

### Running TradeTariffFrontend

    (ensure trade-tariff-backend is running)
    ./startup.sh

### Running TradeTariffFrontend (bowl)

  from `development`:

      `bowl tradetariff`

  after bowling, the app will be available at:

    http://tariff.dev.gov.uk/trade-tariff

### Data

Trade Tariff's database is one of the largest we have. For this reason it is excluded from the data replication script we have in development.

In order to download the database dump, you will need to edit the [common-args.sh](github.gds/gds/development/blob/master/replication/common-args.sh):

    - Remove `tariff`, `tariff_temporal` and `tariff_demo` from the IGNORE string
    - Run the replicate-data-local.sh script

### Running the test suite

To run the spec use the following command:

    RAILS_ENV=test bundle exec rake
