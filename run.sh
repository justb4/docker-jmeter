#!/bin/bash
#
# Run JMeter Docker image with options

NAME="jmeter"
IMAGE="whindes/jmeter:3.3"

# Use the current working dir
WORK_DIR="`pwd`"

# Finally run
docker stop ${NAME} > /dev/null 2>&1
docker rm ${NAME} > /dev/null 2>&1
docker run --name ${NAME} -i -v ${WORK_DIR}:${WORK_DIR} -w ${WORK_DIR} ${IMAGE} $@