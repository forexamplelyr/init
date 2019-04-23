#!/bin/sh

#关闭服务
echo "Disable Service: iptables & postfix."
#/sbin/chkconfig iptables off
#/sbin/service iptables stop:
systemctl stop iptables

#/sbin/chkconfig postfix off
#/sbin/service postfix stop
systemctl stop postfix

#/sbin/chkconfig ip6tables  off
#/sbin/service ip6tables stop
systemctl stop ip6tables


#禁用SELINUX
echo "Disable Selinux."
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config


