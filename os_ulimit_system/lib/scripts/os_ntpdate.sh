#!/bin/sh

yum install -y ntpdate

fp='/var/spool/cron/root'

if [ ! -e $fp ];then
	echo "0 */1 * * * /usr/sbin/ntpdate pool.ntp.org" >> /var/spool/cron/root
else
	item='/usr/sbin/ntpdate'
	cat $fp | grep "$item"
	if [ $? -ne 0 ];then
		echo "0 */1 * * * /usr/sbin/ntpdate pool.ntp.org" >> /var/spool/cron/root
	fi
fi

/usr/sbin/ntpdate pool.ntp.org