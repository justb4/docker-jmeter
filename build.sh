#!/bin/bash

JMETER_VERSION=${JMETER_VERSION:-"5.4"}

# Example build line
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} --build-arg TZ="Europe/Berlin" -t "justb4/jmeter:${JMETER_VERSION}" .
