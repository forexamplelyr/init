# os init 操作系统初始化
## 适用
###CentOS 6.5等


## 功能说明
###通常在操作系统安装完成时执行，例如配置DNS、配置YUM源、Bash审计、时间同步、系统内核参数调优、ulimit调优、SSH优化、安全配置等。可以通过/etc/os_init.conf选择配置项;具体见lib/scripts目录下的脚步。


## 使用方法
###Usage: python os_init.py   


## 例子
##python os_init.py 
###读取etc/os_init.conf配置文件，注意配置文件中设定的脚本路径为相对路径


