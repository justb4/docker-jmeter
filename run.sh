#!/bin/bash
#
# Run JMeter Docker image with options

NAME="jmeter"
JMETER_VERSION=${JMETER_VERSION:-"5.4"}
IMAGE="justb4/jmeter:${JMETER_VERSION}"

# Finally run
docker run --rm --name ${NAME} -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} $@
