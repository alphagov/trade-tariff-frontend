#!/bin/bash -x
bundle install --path "/home/jenkins/bundles/${JOB_NAME}" --deployment
bundle exec rake db:setup
bundle exec rake db:migrate
bundle exec rake ci:setup:rspec
RESULT=$?
exit $RESULT
