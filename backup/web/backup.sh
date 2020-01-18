#!/bin/bash
# This file should be on /hd2/backup/


mkdir linespay_com
mkdir divineit_net
mkdir prismerp_net

P="no200Dhaka"

mysqldump -u root -p$P linespay_com > linespay_com/linespay_com_$(date "+%b-%d-%Y-%H-%M-%S").sql

mysqldump -u root -p$P divineit_net > divineit_net/divineit_net_$(date "+%b-%d-%Y-%H-%M-%S").sql

mysqldump -u root -p$P www_prismerp_net > prismerp_net/prismerp_net_$(date "+%b-%d-%Y-%H-%M-%S").sql

cp -rf /var/www/html/linespay_com linespay_com/

cp -rf /var/www/html/divineit_net divineit_net/

cp -rf /var/www/html/www_prismerp_net prismerp_net/

/var/www/html/linespay_com/.venv/bin/pip list > linespay_com/piplist.txt
/var/www/html/linespay_com/.venv/bin/pip freeze > linespay_com//pipfreeze.txt 



/var/www/html/divineit_net/.venv/bin/pip list > divineit_net/piplist.txt
/var/www/html/divineit_net/.venv/bin/pip freeze > divineit_net/pipfreeze.txt 

/var/www/html/www_prismerp_net/.venv/bin/pip list > prismerp_net/piplist.txt 
/var/www/html/www_prismerp_net/.venv/bin/pip freeze > prismerp_net/pipfreeze.txt 


git --git-dir /var/www/html/linespay_com/.git/ log -5 > linespay_com/gitlog.txt
git --git-dir /var/www/html/divineit_net/.git/ log -5 > divineit_net/gitlog.txt
git --git-dir /var/www/html/www_prismerp_net/.git/ log -5 > prismerp_net/gitlog.txt

zip -r linespay_com_$(date "+%b-%d-%Y-%H-%M-%S").zip linespay_com/ -x linespay_com/linespay_com/.venv/**\*
zip -r divineit_net_$(date "+%b-%d-%Y-%H-%M-%S").zip divineit_net/ -x divineit_net/divineit_net/.venv/**\*
zip -r prismerp_net_$(date "+%b-%d-%Y-%H-%M-%S").zip prismerp_net/ -x prismerp_net/www_prismerp_net/.venv/**\*


rm -rf divineit_net
rm -rf linespay_com
rm -rf prismerp_net