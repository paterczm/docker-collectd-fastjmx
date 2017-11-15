#!/bin/bash

export COLLECTD_INTERVAL="${COLLECTD_INTERVAL:-1}"
export COLLECTD_TIMEOUT="${COLLECTD_TIMEOUT:-2}"
export COLLECTD_READ_THREADS="${COLLECTD_READ_THREADS:-5}"

export CARBON_HOST=${CARBON_HOST?"You need to provide CARBON_HOST"}
export CARBON_PORT=${CARBON_PORT:-2003}
export CARBON_PREFIX=${CARBON_PREFIX?"You need to provide CARBON_PREFIX"}

export FASTJMX_LOGLEVEL=${FASTJMX_LOGLEVEL:-INFO}
export FASTJMX_FORCELOGLEVELTO=${FASTJMX_FORCELOGLEVELTO:-WARNING}
export FASTJMX_URL=${FASTJMX_URL:-service:jmx:remote+http://$HOSTNAME:9990}
export FASTJMX_USER=${FASTJMX_USER?"You need to provide jboss management FASTJMX_USER"}
export FASTJMX_PASSWORD=${FASTJMX_PASSWORD?"You need to provide jboss management FASTJMX_PASSWORD"}
export FASTJMX_TTL=${FASTJMX_TTL:-30}

envsubst < /etc/collectd.conf.TEMPLATE > /etc/collectd.conf

envsubst < /etc/collectd.d/10-write_graphite.conf.TEMPLATE > /etc/collectd.d/10-write_graphite.conf
envsubst < /etc/collectd.d/12-fastjmx.conf.TEMPLATE > /etc/collectd.d/12-fastjmx.conf

/usr/sbin/collectd -C /etc/collectd.conf -f
