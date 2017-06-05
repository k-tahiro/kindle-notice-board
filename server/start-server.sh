#!/bin/bash

uwsgi --ini uwsgi.ini --daemonize uwsgi.log --pidfile uwsgi.pid
