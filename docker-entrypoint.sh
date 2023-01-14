#!/bin/bash

set -euo pipefail

: "${RT_WEB_PORT:=80}"

sed -i "s/RT_WEB_PORT/$RT_WEB_PORT/" /opt/rt5/etc/RT_SiteConfig.pm

echo "[i] Initializing rtir db"
#cd /opt/RT-IR-$RTIR_VERSION
#make initialize-database
cd /opt/rt5

echo "$PWD"
/usr/bin/perl -Ilib -I/opt/rt5/local/lib -I/opt/rt5/lib /opt/rt5/sbin/rt-setup-database --action upgrade --datadir /local/plugins/RT-IR/etc/upgrade/5.0.2/schema.SQLite --datafile /initialdata --package RT::IR --ext-version $RTIR_VERSION --skip-create --prompt-for-dba-password 
echo "[i] Finished initializing rtir db"


exec "$@"
