#!/bin/bash

rm -rf ./public/uploads/*
rm ./db/schema.rb
bundle exec rake db:reset 
bundle exec rake db:migrate
