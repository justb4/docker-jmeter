# inspired by https://github.com/hauptmedia/docker-jmeter  and
# https://github.com/hhcordero/docker-jmeter-server/blob/master/Dockerfile
FROM alpine:3.5

MAINTAINER Just van den Broecke<just@justobjects.nl>

ENV	JMETER_VERSION	3.1
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  http://mirror.serversupportforum.de/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV IP 127.0.0.1
ENV RMI_PORT 1099

# Install extra packages
# See https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-272703023
# Change TimeZone TODO: TZ still is not set!
ARG TZ="Europe/Amsterdam"
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update openjdk7-jre tzdata curl unzip bash
# Clean APK cache
RUN rm -rf /var/cache/apk/*

# download and extract jmeter
RUN mkdir -p /tmp/dependencies
RUN	curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz
RUN mkdir -p /opt

RUN tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm -rf /tmp/dependencies

# TODO: plugins (later)
# && unzip -oq "/tmp/dependencies/JMeterPlugins-*.zip" -d $JMETER_HOME

ENV PATH $PATH:$JMETER_BIN

# We assume tests and results are passed to entrypoint
# and are external to docker image.
# COPY tests /tests

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]
