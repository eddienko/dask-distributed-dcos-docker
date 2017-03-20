#!/usr/bin/env bash

set -o errexit -o pipefail

source "$HOME/.bash_profile"
source activate dask-distributed

if [ \( -n "${MARATHON_APP_ID-}" \) -a \( -n "${HOST-}" \) \
    -a \( -n "${PORT1-}" \) -a \( -n "${PORT2-}" \) \
    -a \( -n "${PORT3-}" \) -a \( -n "${PORT4-}" \) ]
then
    SCHEDULER_BOKEH_APP_PREFIX=""

    if [ -n "${MARATHON_APP_LABEL_HAPROXY_3_PATH-}" ]
    then
        SCHEDULER_BOKEH_APP_PREFIX="${MARATHON_APP_LABEL_HAPROXY_3_PATH}"
    fi
    
    echo "Dask Scheduler Bokeh App Prefix: ${SCHEDULER_BOKEH_APP_PREFIX}"

    dask-scheduler \
        --host "*" \
        --port "${PORT1}" \
        --http-port "${PORT2}" \
        --bokeh-port "${PORT3}" \
        --bokeh-internal-port "${PORT4}" \
        --prefix "${SCHEDULER_BOKEH_APP_PREFIX}"
else
    dask-scheduler "$@"
fi
