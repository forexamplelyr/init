#!/bin/sh

sed -i "s@#UseDNS yes@UseDNS no@g" /etc/ssh/sshd_config

sed -i 's%#   StrictHostKeyChecking ask%StrictHostKeyChecking no%g'  /etc/ssh/ssh_config

sed -i "s/#MaxAuthTries 6/MaxAuthTries 3/" /etc/ssh/sshd_config

systemctl reload sshd
