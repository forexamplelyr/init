#!/bin/bash

fp1='/etc/security/limits.conf'
fp2='/etc/profile'

item='* soft nproc 102400'
cat $fp1 | grep "$item"
if [ $? -ne 0 ];then
	echo "$item" >> $fp1
fi

item='* hard nproc 102400'
cat $fp1 | grep "$item"
if [ $? -ne 0 ];then
	echo "$item" >> $fp1
fi

item='* soft nofile 128607'
cat $fp1 | grep "$item"
if [ $? -ne 0 ];then
	echo "$item" >> $fp1
fi

item='* hard nofile 128607'
cat $fp1 | grep "$item"
if [ $? -ne 0 ];then
	echo "$item" >> $fp1
fi

## DB
item='* hard sigpending 128607'
cat $fp1 | grep "$item"
if [ $? -ne 0 ];then
	echo "$item" >> $fp1
fi

item='* soft sigpending 128607'
cat $fp1 | grep "$item"
if [ $? -ne 0 ];then
	echo "$item" >> $fp1
fi


item='ulimit -d unlimited'
cat $fp2 | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp2
fi

item='ulimit -m unlimited'
cat $fp2 | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp2
fi

item='ulimit -s unlimited'
cat $fp2 | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp2
fi

item='ulimit -t unlimited'
cat $fp2 | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp2
fi

item='ulimit -v unlimited'
cat $fp2 | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp2
fi

## user process limit
sed -i 's/65535/128607/g' /etc/security/limits.d/20-nproc.conf

