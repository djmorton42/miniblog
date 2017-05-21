#!/bin/bash

MAILDEV_CONTAINER_NAME='maildev_container'

if [ "" != "$(sudo docker ps | grep ${MAILDEV_CONTAINER_NAME})" ] ; then
    echo "Maildev container is already running."
    exit 0
fi

if [ "" == "$(sudo docker ps -a | grep ${MAILDEV_CONTAINER_NAME})" ] ; then
    echo "Maildev container does not exist.  Creating..."
    sudo docker run -d -p 1080:80 -p 1025:25 --name=${MAILDEV_CONTAINER_NAME} djfarrelly/maildev
else
    CURRENT_CONTAINER=$(sudo docker ps -a | grep ${MAILDEV_CONTAINER_NAME} | awk '{print $1}')
    echo "Maildev container exists.  Starting..."
    sudo docker start ${CURRENT_CONTAINER}
fi


