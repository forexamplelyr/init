#!/bin/sh

fp="/etc/pam.d/sshd"
cat ${fp} | grep 'pam_tally2.so deny=5'
if [ $? -ne 0 ];then
	lnum=$(cat  ${fp} | grep -nE '^#%PAM'| tail -n 1|awk -F: '{print $1}')
	sed -i "${lnum}a auth       required     pam_tally2.so deny=5 unlock_time=60"  ${fp}
fi

fp="/etc/pam.d/system-auth"
item="password    requisite     pam_cracklib.so difok=3 minlen=8 ucredit=-1 lcredit=-1 dcredit=1"
cat ${fp} | grep "${item}"
if [ $? -ne 0 ];then
	lnum=$(cat  ${fp} | grep -nE '^password'| tail -n 1|awk -F: '{print $1}')
	sed -i "${lnum}a ${item}"  ${fp}
fi


systemctl restart sshd
