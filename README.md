# TariffWebApp

A web application front end for use with the UK Trade Tariff API

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

4. Run TariffWebApp:

    ```
    cd TariffWebApp
    API_DEV=1 SLIMMER_DEV=1 be rails s
    ```

## Notes

* Missing indexes on chapters (section_id) and commodities (chapter_id)
* No exception notification utility in here yet.
