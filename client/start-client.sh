#!/bin/bash

touch now

while :
do
  curl http://tahiro.org/knb >next
  difference=$(diff now next)
  if [ "${difference}" != "" ]; then
    mv next now
    cat now
  fi
  sleep 900
done
