#!/bin/bash

if [ -f './etc/production.rb' ]; then
  cp ./etc/production.rb ./config/environments/
fi

sudo docker build -t miniblog:prod .
