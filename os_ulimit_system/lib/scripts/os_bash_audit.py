#!/usr/bin/python
#:-*- encoding=utf-8 -*-
import os
import commands
from string import Template

def check_exist(cf):
    with open(cf, "r") as fd:
        lines = fd.readlines()
        for line in lines:
            line = str(line).strip()
            if line.find("PROMPT_COMMAND") != -1 and line.find("cmdstr") != -1:
                return True
    return False

def rotate_log():
    config_content = "\n\
        /var/log/catch/egg.log {\n\
            rotate 7\n\
            daily\n\
            missingok\n\
            notifempty\n\
            delaycompress\n\
            compress\n\
        }\n"
    config_file = "/etc/logrotate.d/egg"
#     if os.path.exists(config_file):
#         return False
    ## 覆盖写入
    with open(config_file, "w") as fd:
        fd.write(config_content)

def config(cf):
    audit_log_path = "/var/log/catch/"
    log_name = "egg.log"
    cmdstr_tpl = "mkdir -p $dir && chmod 777 $dir && touch $dir/$log && chmod 777 $dir/$log" 
    s=Template(cmdstr_tpl)
    cmdstr = s.substitute({"dir": audit_log_path, "log": log_name})
     
    (status, ouput) = commands.getstatusoutput(cmdstr)
    if status != 0:
        print "Execute %s ERROR!" % (cmdstr)
        exit(1)
        
    if  False == check_exist(cf):
        with open(cf, "a+") as fd:
            #confstr = '\nexport PROMPT_COMMAND=\'{ cmdstr=$(history 1 | { read x y; echo $y; }); echo -n [$(date -d"today" "%s")]; echo -n [$(who am i) -- $(whoami)]; echo " $cmdstr"; } >> %s/egg.log\'\n'  % ('+%Y-%m-%d %H:%M:%S', audit_log_path,)
            confstr = '\nexport PROMPT_COMMAND=\'{ cmdstr=$(history 1 | { read x y; echo $y; }); echo -n "[$(date -d"today" "%s")]"; echo -n " [$(whoami)] "; echo "[$cmdstr]"; } >> %s%s\'\n'  % ('+%Y-%m-%d %H:%M:%S', audit_log_path, log_name)
            fd.write(confstr)
        ## 使生效
        commands.getstatusoutput("source %s" % (cf))
        print "OK"
    else:
        print "Exist Config, Exit Now!"

if __name__ == '__main__':
    cf = "/etc/profile"
    config(cf)
    rotate_log();
    
