#!/bin/bash

mkdir -p /gerrit

echo "==> populating data volume"
for d in db etc git static; do
  if [[ ! -h /gerrit-app/$d ]]; then
    mv /gerrit-app/$d /gerrit-app/$d.orig
    ln -s ../gerrit/$d /gerrit-app/
  fi
  if [[ ! -e /gerrit/$d ]]; then
    echo "==> .. $d"
    cp -r /gerrit-app/$d.orig /gerrit/$d
  fi
done

echo "==> starting gerrit"
exec /gerrit-app/bin/gerrit.sh supervise -d /gerrit-app
