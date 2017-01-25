#!/bin/bash

JMETER_VERSION="3.1"

# Example build line
# --build-arg IMAGE_TIMEZONE="Europe/Amsterdam"
sudo docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} -t "justobjects/jmeter:${JMETER_VERSION}" .
