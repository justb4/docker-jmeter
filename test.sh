#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line
export TARGET_SERVER="www.map5.nl"
export TARGET_PATH="/kaarten.html"
export TARGET_KEYWORD="Kaartdiensten"

T_DIR=tests/trivial
/bin/rm -f ${T_DIR}/test-plan.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
	-JTARGET_SERVER=${TARGET_SERVER} -JTARGET_PATH=${TARGET_PATH} -JTARGET_KEYWORD=${TARGET_KEYWORD} \
	-n -t ${T_DIR}/test-plan.jmx -l ${T_DIR}/test-plan.jtl -j ${T_DIR}/jmeter.log

echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Test Report ===="
cat ${T_DIR}/test-plan.jtl
