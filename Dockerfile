# inspired by https://github.com/hauptmedia/docker-jmeter  and
# https://github.com/hhcordero/docker-jmeter-server/blob/master/Dockerfile
FROM alpine:latest

MAINTAINER casep <casep@fedoraproject.org>

ARG JMETER_VERSION="5.5"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_CUSTOM_PLUGINS_FOLDER /plugins
ENV JMETER_BIN	${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGIN_AWSMETER awsmeter-2.1.1.zip
ENV JMETER_PLUGIN_AWSMETER_DOWNLOAD_URL https://jmeter-plugins.org/files/packages/${JMETER_PLUGIN_AWSMETER}

ARG UID=1000
ARG JMETER_USER=jmeter
RUN adduser -D -u $UID ${JMETER_USER}

# Install extra packages
# Set TimeZone, See: https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-612751142
ARG TZ="Europe/Amsterdam"
ENV TZ ${TZ}
RUN apk upgrade --update \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk17-jre tzdata curl unzip bash \
	&& apk add --no-cache nss msttcorefonts-installer fontconfig \
	&& update-ms-fonts \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& curl -L --silent ${JMETER_PLUGIN_AWSMETER_DOWNLOAD_URL} > /tmp/${JMETER_PLUGIN_AWSMETER} \
	&& unzip /tmp/${JMETER_PLUGIN_AWSMETER} -d ${JMETER_HOME}/ \
	&& rm -rf /tmp/dependencies \
	&& mkdir ${JMETER_HOME}/backups \
	&& chown ${JMETER_USER}.${JMETER_USER} ${JMETER_HOME}/backups

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /

WORKDIR	${JMETER_HOME}

USER ${JMETER_USER}
RUN mkdir /home/${JMETER_USER}/.aws
COPY config /home/${JMETER_USER}/.aws/
COPY credentials /home/${JMETER_USER}/.aws/

ENTRYPOINT ["/entrypoint.sh"]
