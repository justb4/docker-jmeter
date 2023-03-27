#!/bin/bash
#
# Run JMeter Docker image with options

NAME="jmeter"
#JMETER_VERSION=${JMETER_VERSION:-"latest"}
JMETER_VERSION="5.5"
IMAGE="casep/jmeter:${JMETER_VERSION}"
DISPLAY=:0.0

# Finally run
xhost +
docker run --network host -e DISPLAY=$DISPLAY -e AWS_REGION=eu-west-2 -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN --rm --name ${NAME} -i -v ${PWD}:${PWD} -v /tmp/.X11-unix:/tmp/.X11-unix:ro  -w ${PWD} ${IMAGE} $@
xhost -
