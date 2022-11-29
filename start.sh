#! /bin/bash
/usr/sbin/sshd
exec /usr/bin/vpp -c /etc/vpp/startup.conf
