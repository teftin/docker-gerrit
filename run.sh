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

gc() {
  git config -f /gerrit/etc/$1.config $2 $3
}

#gc gerrit gitweb.cgi /usr/share/gitweb/gitweb.cgi
#gc gerrit auth.type DEVELOPMENT_BECOME_ANY_ACCOUNT

echo "==> starting gerrit"
exec /gerrit-app/bin/gerrit.sh supervise -d /gerrit-app
