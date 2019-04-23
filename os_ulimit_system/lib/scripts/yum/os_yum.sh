#!/bin/sh

#rpm -ivh http://mirrors.hustunique.com/epel/6/i386/epel-release-6-8.noarch.rpm 
#rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm 

if [ ! -e /etc/yum.repos.d/remi.repo ];then
	cp remi.repo /etc/yum.repos.d -R
fi

#阿里源
/bin/mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
curl http://mirrors.aliyun.com/repo/Centos-6.repo -o /etc/yum.repos.d/CentOS-Base.repo 
yum clean all
yum makecache
