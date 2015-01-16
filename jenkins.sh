#!/bin/bash -x
export GOVUK_APP_DOMAIN=test.gov.uk
export GOVUK_ASSET_ROOT=http://static.test.gov.uk
env

bundle install --path "/home/jenkins/bundles/${JOB_NAME}" --deployment
bundle exec rake RAILS_ENV=test default assets:clean assets:precompile
RESULT=$?
exit $RESULT
