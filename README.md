# TariffWebApp

A web application front end for use with the UK Trade Tariff API

## Local install/run instructions

1. Clone repo:

    ```
    git clone git@github.com:alphagov/TariffWebApp.git
    ```

2. Setup the database:

    ```
    cd TariffWebApp
    ```

3. Run TariffWebApp:

    ```
    ./startup.sh
    ```

4. Modify development.rb (if running without puppet)

    ```
    config.api_host = "localhost:3016"
    ```
