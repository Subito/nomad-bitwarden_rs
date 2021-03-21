#!/bin/sh

[ -w /etc/pkg/FreeBSD.conf ] && sed -i '' 's/quarterly/latest/' /etc/pkg/FreeBSD.conf
ASSUME_ALWAYS_YES=yes pkg bootstrap
touch /etc/rc.conf
sysrc sendmail_enable="NONE"
pkg install -y bitwarden_rs
pkg clean -y
mkdir -p /bitwarden/data
cd /bitwarden
fetch -o web-vault.tgz https://github.com/dani-garcia/bw_web_builds/releases/download/v2.19.0/bw_web_v2.19.0.tar.gz
tar xf web-vault.tgz
echo 'cd /bitwarden && /usr/local/bin/bitwarden_rs' > /usr/local/sbin/bitwarden_start.sh
