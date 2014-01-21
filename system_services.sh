#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install init process.
##cp /build/my_init /sbin/

## Install supervisor
$minimal_apt_get_install supervisor
mkdir -p /var/log/supervisor
cp /build/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

## Install a syslog daemon.
$minimal_apt_get_install syslog-ng-core
cp /build/supervisor/conf.d/syslog-ng.conf /etc/supervisor/conf.d/

## Install the SSH server.
$minimal_apt_get_install openssh-server
mkdir /var/run/sshd
cp /build/supervisor/conf.d/sshd.conf /etc/supervisor/conf.d/
cp /build/config/sshd_config /etc/ssh/sshd_config

## Install default SSH key for root and app.
mkdir -p /root/.ssh
chmod 700 /root/.ssh
chown root:root /root/.ssh
cat /build/id_rsa.pub > /root/.ssh/authorized_keys

## Install cron daemon.
$minimal_apt_get_install cron
cp /build/supervisor/conf.d/cron.conf /etc/supervisor/conf.d/cron.conf
