#!/bin/bash -x
bundle install --path "/home/jenkins/bundles/${JOB_NAME}" --deployment
bundle exec rake RAILS_ENV=test ci:setup:rspec spec assets:clean assets:precompile
RESULT=$?
exit $RESULT
