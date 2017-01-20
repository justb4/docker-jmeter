#!/bin/bash
#
# Run JMeter Docker image with options

NAME="jmeter"
IMAGE="justb4/jmeter:3.1"
MFP_NAME="mfprint"

# Use the current working dir
WORK_DIR="`pwd`"

LINK_MAP="--link ${MFP_NAME}:${MFP_NAME}"

# Finally run
sudo docker stop ${NAME} > /dev/null 2>&1
sudo docker rm ${NAME} > /dev/null 2>&1
sudo docker run --name ${NAME} -i -v ${WORK_DIR}:${WORK_DIR} -w ${WORK_DIR} ${IMAGE} $@


# When running: get into container with bash
# sudo docker exec -it print  bash

