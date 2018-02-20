#!/bin/bash

JMETER_VERSION="4.0"

# Example build line
# --build-arg IMAGE_TIMEZONE="Europe/Amsterdam"
sudo docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} -t "justb4/jmeter:${JMETER_VERSION}" .
