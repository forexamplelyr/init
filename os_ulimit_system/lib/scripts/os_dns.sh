#!/bin/sh

fp='/etc/resolv.conf'

ns='8.8.8.8'
cat $fp | grep $ns
if [ $? -ne 0 ];then
	echo "nameserver ${ns}" >> $fp
fi

ns='114.114.114.114'
cat $fp | grep $ns
if [ $? -ne 0 ];then
	echo "nameserver ${ns}" >> $fp
fi
