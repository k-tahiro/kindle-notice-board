#!/bin/bash

readonly SERVER_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly NGINX_CONF_FILE="${SERVER_DIR}/setup/nginx.conf"
readonly SERVICE_SCRIPT_FILE="${SERVER_DIR}/setup/knb"
readonly I2A_SCRIPT_FILE="${SERVER_DIR}/setup/install-i2a.sh"

function nginx() {
  sudo cp "${NGINX_CONF_FILE}" /etc/nginx/conf.d/knb.conf
  sudo service nginx restart
}

function knb() {
  sudo cp "${SERVICE_SCRIPT_FILE}" /etc/init.d/knb
  sudo sed -i "s%#SBIN_DIR#%${SERVER_DIR}/sbin%g" /etc/init.d/knb
  sudo chmod +x /etc/init.d/knb
  sudo chkconfig knb on
}

function setup() {
  nginx
  knb
  "${I2A_SCRIPT_FILE}"
  pip install -r setup/requirements.txt
  sudo service knb start
}

setup
