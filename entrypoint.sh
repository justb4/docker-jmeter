#!/bin/bash
# Inspired from https://github.com/hhcordero/docker-jmeter-client
# Basically runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
#
# This script expects the standdard JMeter command parameters.
#

# Install jmeter plugins available on /plugins volume
if [ -d /plugins ]
then
    for plugin in /plugins/*.jar; do
        cp $plugin ${JMETER_HOME}/lib/ext
    done;
fi

# Execute JMeter command
set -e
freeMem=`awk '/MemAvailable/ { print int($2/1024) }' /proc/meminfo`

if [-z $JVM_XMN]; then
    n=$JVM_XMN
else 
    n=$(($freeMem/10*2))
fi

if [-z $JVM_XMS]; then
    s=$JVM_XMS
else
    s=$(($freeMem/10*8))
fi

if [-z $JVM_XMX]; then
    x=$JVM_XMX
else
    x=$(($freeMem/10*8))
fi

export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Keep entrypoint simple: we must pass the standard JMeter arguments
EXTRA_ARGS=-Dlog4j2.formatMsgNoLookups=true
echo "jmeter ALL ARGS=${EXTRA_ARGS} $@"
jmeter ${EXTRA_ARGS} $@

echo "END Running Jmeter on `date`"

#     -n \
#    -t "/tests/${TEST_DIR}/${TEST_PLAN}.jmx" \
#    -l "/tests/${TEST_DIR}/${TEST_PLAN}.jtl"
# exec tail -f jmeter.log
#    -D "java.rmi.server.hostname=${IP}" \
#    -D "client.rmi.localport=${RMI_PORT}" \
#  -R $REMOTE_HOSTS
