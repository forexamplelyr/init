# -*- encoding=utf-8 -*-
###
# 1) support mutil group
# 2) install support extra option string
###
__version__="20151110"

import sys,os,re
from lib.base import cmd
from lib.base import mydate
from lib.base.log import Log
from lib.helpers.confex import conf
from optparse import OptionParser
import traceback

reload(sys) 
sys.setdefaultencoding('utf8')

def get_realpath():
    return os.path.split(os.path.realpath(__file__))[0]

def get_binname():
    return os.path.split(os.path.realpath(__file__))[1]

def get_logstr(list_dict, max_key_len=16, joinstr="\n"):
    log_str = ""
    for conf in list_dict:
        for (key,val) in dict(conf).iteritems():
            log_str = log_str + str(key).ljust(max_key_len) + ": " + str(val) + joinstr
    log_str = log_str.strip() # 去掉尾部 \n
    return log_str


def main():
    binpath = get_realpath()
    binname = get_binname()
    logger = Log("/tmp/os_init.log")
    try:
        parser = OptionParser()  

        parser.add_option("-f", "--file",  
                          action="store", dest="conffile", default=None,  
                          help="path of config file,must", metavar="FILE")
        parser.add_option("-g", "--groups",  
                          action="store", dest="groups", default=None,  
                          help="which groups to use,when no set,use the field 'groups' in config file as default", metavar="GROUPS")
        
        (options, args) = parser.parse_args()
        
        #default
        confpath = get_realpath()+"/etc/os_init.conf"
        groups = None
        
        if options.conffile and os.path.exists(os.path.abspath(options.conffile)) == False:
            confpath = os.path.abspath(options.conffile)
            
        if options.groups:
            groups = options.groups

        insc = conf(confpath)
        configs = insc.get_config()

        for (path, confs) in dict(configs).iteritems():
            system_conf = confs["system"]
            groups_default = system_conf["groups"]

            if not groups: ## use default group
                groups = groups_default
                
            group_list = re.split("[,|;| |\t]+", groups)
            for group in group_list:
                if dict(confs).has_key(group) == False: ## check if group exist
                    msg = "Group: %s Not Exist" %(group)
                    logconf = [{"msg": msg}]
                    logstr = get_logstr(logconf, max_key_len=8)
                    logger.error(logstr)
                    continue

                conf_list = confs[group]
                total = len(conf_list)
                
                for (idx, confitem) in enumerate(conf_list):
                    exector = confitem["exector"]  if dict(confitem).has_key("exector") else None
                    script = confitem["script"] if dict(confitem).has_key("script") else None
                    params = confitem["params"] if dict(confitem).has_key("params") else None
                    comment = confitem["comment"] if dict(confitem).has_key("comment") else None
                    timeout = confitem["timeout"] if dict(confitem).has_key("timeout") else None
                    timeout = int(timeout) if timeout else 120
                    
                    if not exector or not script:
                        msg = "No exector or script"
                        logconf = [{"msg": msg}]
                        logstr = get_logstr(logconf, max_key_len=8)
                        logger.warn(logstr)
                        continue
                    
                    fullpath = get_realpath() + "/lib/scripts/" + script
                    if os.path.exists(fullpath) == False:
                        msg = "Script Not Exist! %s" % (fullpath)
                        logconf = [{"msg": msg}]
                        logstr = get_logstr(logconf, max_key_len=8)
                        logger.warn(logstr)
                        continue
                    
                    #fullpath = os.path.abspath(script)
                    (dirname, scriptname) = os.path.split(fullpath)
                    cmdstr = "cd %s && %s %s %s" %(dirname, exector, scriptname, params)
                    (stdo, stde, retcode) = cmd.docmd_ex(cmdstr, timeout=timeout)
                    logconf = [
                        {"comment": comment},
                        {"cmdstr": cmdstr},
                        {"timeout": timeout},
                        {"stdo": stdo},
                        {"stde": stde},
                        {"retcode": retcode},
                    ]
                    
                    if retcode == 0:
                        logconf.append({"result": "success"})
                        logstr = get_logstr(logconf, max_key_len=8)
                        logger.info(logstr)
                    else:
                        logconf.append({"result": "error"})
                        logstr = get_logstr(logconf, max_key_len=8)
                        logger.error(logstr)

        
    except Exception as ept:
        tb = traceback.format_exc()
        logconf = [{"traceback": tb}]
        logstr = get_logstr(logconf, max_key_len=15)
        logger.error(logstr)
    
if __name__ == "__main__":
    
    with open("/tmp/os_init_version.log", "a+")  as fd:
        version_line = "%s\t%s\n" %(mydate.ADatetime().get_datetime_str(), __version__)
        fd.write(version_line)
    main()

