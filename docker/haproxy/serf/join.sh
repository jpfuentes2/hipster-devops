#!/usr/bin/env bash

while read line; do
  ROLE=`echo $line | awk '{print $3 }'`

  if [ "${ROLE}" != "web" ]; then
    continue
  fi

  echo $line | \
    awk '{ printf "    server %s %s check\n", $1, $2 }' >>/etc/haproxy/haproxy.cfg
done

/etc/init.d/haproxy reload
