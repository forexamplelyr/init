#!/bin/sh

fp='/etc/sysctl.conf'

item='kernel.panic = 1'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 内核panic时，1秒后自动重启

item='kernel.shmmax = 4294967296'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 内核所允许的最大共享内存段的大小（bytes）

item='kernel.shmall = 1073741824'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 在任何给定时刻，系统上可以使用的共享内存的总量（pages）

item='kernel.core_pattern = core_%e'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 设定程序core时生成的文件名格式

item='vm.panic_on_oom = 1'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 当发生oom时，自动转换为panic

item='vm.min_free_kbytes = 1048576'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 表示强制Linux VM最低保留多少空闲内存（Kbytes）

item='vm.vfs_cache_pressure = 250'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 该值高于100，则将导致内核倾向于回收directory和inode cache

item='vm.swappiness = 20'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 表示系统进行交换行为的程度，数值（0-100）越高，越可能发生磁盘交换

item='net.core.somaxconn = 1024'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 网络层优化
# listen()的默认参数,挂起请求的最大数量，默认128

item='net.core.netdev_max_backlog = 2000'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 进入包的最大设备队列.默认是300

item='net.core.wmem_default = 8388608'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.core.rmem_default = 8388608'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.core.rmem_max = 16777216'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.core.wmem_max = 16777216'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 增加Linux自动调整TCP缓冲区限制

item='net.ipv4.tcp_syncookies = 1'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 开启SYN洪水攻击保护

item='net.ipv4.conf.all.log_martians = 1'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.conf.default.log_martians = 1'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 开启并记录欺骗，源路由和重定向包

item='net.ipv4.ip_default_ttl = 64'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# TTL

item='net.ipv4.tcp_rmem = 4096 87380 8388608'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.tcp_wmem = 4096 32768 8388608'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 增加TCP最大缓冲区大小

item='net.ipv4.tcp_window_scaling = 1'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# Tcp自动窗口

item='net.ipv4.tcp_max_syn_backlog = 8192'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 进入SYN包的最大请求队列.默认1024

item='net.ipv4.tcp_tw_recycle = 1 '
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.tcp_tw_reuse = 0  '
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 打开TIME-WAIT套接字重用功能，对于存在大量连接的Web服务器非常有效。 

item='net.ipv4.tcp_timestamps = 0'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.tcp_syn_retries = 2'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.tcp_synack_retries = 2'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi

# 表示是否启用以一种比超时重发更精确的方法（请参阅 RFC 1323）来启用对 RTT 的计算；为了实现更好的性能应该启用这个选项
# 表示本机向外发起TCP SYN连接超时重传的次数

item='net.ipv4.tcp_fin_timeout = 20 '
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 减少处于FIN-WAIT-2连接状态的时间，使系统可以处理更多的连接。 

item='net.ipv4.tcp_keepalive_time = 300 '
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.tcp_keepalive_probes = 2'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='et.ipv4.tcp_keepalive_intvl = 2'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 减少TCP KeepAlive连接侦测的时间，使系统可以处理更多的连接。 
# 如果某个TCP连接在idle 300秒后,内核才发起probe.如果probe 2次(每次2秒)不成功,内核才彻底放弃,认为该连接已失效.

item='net.ipv4.tcp_max_orphans = 262144'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 系统所能处理不属于任何进程的TCP sockets最大数量

item='net.ipv4.tcp_max_tw_buckets = 20000 '
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# 系统同时保持TIME_WAIT套接字的最大数量，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息。

item='net.ipv4.neigh.default.gc_thresh2 = 512'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.neigh.default.gc_thresh1 = 128'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
item='net.ipv4.neigh.default.gc_thresh3 = 4096'
cat $fp | grep "$item"
if [ $? -ne 0 ];then
        echo "$item" >> $fp
fi
# arp_table的缓存限制优化

