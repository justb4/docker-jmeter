#!/bin/bash

JMETER_VERSION=${JMETER_VERSION:-"5.6.3"}
IMAGE_TIMEZONE=${IMAGE_TIMEZONE:-"Europe/Moscow"}

# Example build line
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} --build-arg TZ=${IMAGE_TIMEZONE} -t "justb4/jmeter:${JMETER_VERSION}" .
