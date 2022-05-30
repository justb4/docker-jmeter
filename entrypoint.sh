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

# extract JVM memory parameter
options=()  # the buffer array for the parameters
eoo=0       # end of options reached

while [[ $1 ]]
do
    if ! ((eoo)); then
	case "$1" in
	  -max_memory)
          freeMem="$2"
          shift 2
	      ;;
	  --)
	      eoo=1
	      options+=("$1")
	      shift
	      ;;
	  *)
	      options+=("$1")
	      shift
	      ;;
	esac
    else
	options+=("$1")

	# Another (worse) way of doing the same thing:
	# options=("${options[@]}" "$1")
	shift
    fi
done
# Execute JMeter command
set -e
if [ -z $freeMem ]; then 
freeMem=`awk '/MemAvailable/ { print int($2/1024) }' /proc/meminfo`
fi
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=${options[@]}"

# Keep entrypoint simple: we must pass the standard JMeter arguments
EXTRA_ARGS=-Dlog4j2.formatMsgNoLookups=true
echo "jmeter ALL ARGS=${EXTRA_ARGS} ${options[@]}"
jmeter ${EXTRA_ARGS} ${options[@]}

echo "END Running Jmeter on `date`"

#     -n \
#    -t "/tests/${TEST_DIR}/${TEST_PLAN}.jmx" \
#    -l "/tests/${TEST_DIR}/${TEST_PLAN}.jtl"
# exec tail -f jmeter.log
#    -D "java.rmi.server.hostname=${IP}" \
#    -D "client.rmi.localport=${RMI_PORT}" \
#  -R $REMOTE_HOSTS
