#!/bin/bash
# Create a new Elastic Beanstalk application
aws elasticbeanstalk create-application --application-name my-app

# Create a new environment
aws elasticbeanstalk create-environment --application-name my-app --environment-name my-env --solution-stack-name "64bit Amazon Linux 2 v5.4.4 running Node.js 14"

# List environments
aws elasticbeanstalk describe-environments

# Terminate an environment
aws elasticbeanstalk terminate-environment --environment-name my-env
