#!/bin/bash
#create a variable td holding todays date.
#td=`date '+%F'`
#create a variable yd holding yesterday's date
#yd=`date -d yesterday '+%F'`

# email recipients
RECIPIENT_EMAIL=bwiderski@hbs.edu,bstraz@hbs.edu,smathew@hbs.edu,kpendergrass@hbs.edu,msamouelian@hbs.edu,jeattimo@hbs.edu

cd /home/svc_nasmonitor
#rename yesterday's reports
mv ~/log/vhealth.txt ~/log/vhealth-yesterday.txt
mv ~/log/diffvol.txt  ~/log/diffvol-yesterday.txt
#Redirect snapmirror query to a text file to overwrite each run
ssh monitor_prd@svm-aws-nas-cl1.hbs.edu snapmirror show -source-path nas-kls-adapt-prd:* -fields source-path,destination-path,state,healthy > ~/log/vhealth.txt
#email the content of logfile.
mailx -a ./log/vhealth.txt -r donotreply@hbs.edu -s "ADAPT Prod volumes snapmirror status" $RECIPIENT_EMAIL < ~/healthmsg-prd.txt 
#diff today's vs yesterday's
diff ~/log/vhealth-yesterday.txt ~/log/vhealth.txt >  ~/log/diffvol.txt
#email diff report
mailx -a ./log/diffvol.txt -r donotreply@hbs.edu -s "ADAPT Prod volumes daily diff" $RECIPIENT_EMAIL < ~/healthmsg-prd-diff.txt
