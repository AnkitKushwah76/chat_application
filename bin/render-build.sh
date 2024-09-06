#!/usr/bin/env bash
# exit on error
set -o errexit

# Install gems
bundle install

# Precompile assets
bundle exec rails assets:precompile

# Clean up old assets
bundle exec rails assets:clean

# Create the database
bundle exec rails db:create

# Run database migrations
bundle exec rails db:migrate
