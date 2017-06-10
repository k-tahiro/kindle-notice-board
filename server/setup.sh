#!/bin/bash

readonly SERVER_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly SOURCE_UWSGI_FILE="${SERVER_DIR}/setup/uwsgi.ini"
readonly SOURCE_NGINX_FILE="${SERVER_DIR}/setup/nginx.conf"
readonly SOURCE_SERVICE_FILE="${SERVER_DIR}/setup/knb"
readonly DESTINATION_UWSGI_FILE="${SERVER_DIR}/conf/uwsgi.ini"
readonly DESTINATION_NGINX_FILE="/etc/nginx/conf.d/knb.conf"
readonly DESTINATION_SERVICE_FILE="/etc/init.d/knb"
readonly I2A_SCRIPT_FILE="${SERVER_DIR}/setup/install-i2a.sh"

function nginx() {
  sudo cp -f "${SOURCE_NGINX_FILE}" "${DESTINATION_NGINX_FILE}"
  sudo service nginx restart
}

function knb() {
  mkdir "${SERVER_DIR}/conf"
  cp -f "${SOURCE_UWSGI_FILE}" "${DESTINATION_UWSGI_FILE}"
  sudo sed -i "s%#SERVER_DIR#%${SERVER_DIR}%g" "${DESTINATION_UWSGI_FILE}"

  sudo cp -f "${SERVICE_SCRIPT_FILE}" "${DESTINATION_SERVICE_FILE}"
  sudo sed -i "s%#SBIN_DIR#%${SERVER_DIR}/sbin%g" "${DESTINATION_SERVICE_FILE}"
  sudo chmod +x "${DESTINATION_SERVICE_FILE}"

  chkconfig --add knb
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
