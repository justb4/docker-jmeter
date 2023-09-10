#!/bin/bash

JMETER_VERSION=${JMETER_VERSION:-"5.6.2"}

IMAGE_TIMEZONE=${IMAGE_TIMEZONE:-"US/Pacific"}

# Example build line
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} --build-arg TZ=${IMAGE_TIMEZONE} -t "doorcounts/jmeter:${JMETER_VERSION}" .
