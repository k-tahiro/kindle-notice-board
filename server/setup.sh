#!/bin/bash

readonly SERVER_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly NGINX_CONF_FILE="${SERVER_DIR}/setup/nginx.conf"
readonly SERVICE_SCRIPT_FILE="${SERVER_DIR}/setup/knb"
readonly I2A_SCRIPT_FILE="${SERVER_DIR}/setup/install-i2a.sh"

function nginx() {
  cp "${NGINX_CONF_FILE}" /etc/nginx/conf.d/knb.conf
  service nginx restart
}

function knb() {
  cp "${SERVICE_SCRIPT_FILE}" /etc/init.d/knb
  sed -i "s%#SBIN_DIR#%${SERVER_FIR}/sbin%g" /etc/init.d/knb
  chkconfig knb on
}

function setup() {
  nginx
  knb
  "${I2A_SCRIPT_FILE}"
  pip install -r setup/requirements.txt
  service knb start
}

setup
