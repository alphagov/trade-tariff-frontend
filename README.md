# TariffWebApp

A web application front end for use with the UK Trade Tariff API

## Dependencies

1. ElasticSearch (Mac OS X using Homebrew):

    ```
    brew install elasticsearch
    ```

## Local install/run instructions

1. Clone repo:

    ```
    git clone git@github.com:alphagov/TariffWebApp.git
    ```

2. Clone Slimmer:

    ```
    git clone git@github.com:alphagov/slimmer.git
    ```

3. Clone gds-api-adapters:

    ```
    git clone git@github.com:alphagov/gds-api-adapters.git
    ```

4. Setup the database:

    ```
    cd TariffWebApp
    bundle exec rake db:setup
    bundle exec rake db:import
    ``` 

4. Run TariffWebApp:

    ```
    bundle exec rails s
    ```

## Notes

* Missing indexes on chapters (section_id) and commodities (chapter_id)
* No exception notification utility in here yet.
