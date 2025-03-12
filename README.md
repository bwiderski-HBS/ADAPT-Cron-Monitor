# ADAPT-Cron-Monitor
The temporary script used to monitor ADAPT Collections and changes on-prem vs FSx

After ADAPT offsite volumes were migrated from CVO to FSx Baker Library customers wanted a method to be alerted to changes in the number of Prod volumes and their snapmirror status.

Prior to changes to the ADAPT GUI dashboard this script was created to run daily to
1 - List all of the Prod volumes visible in FSx and their snapmirror status
2 - Compare today's list to yesterday's via diff to see any changes in the last 24 hours.

The script runs on rhnaklsrsync01.hbs.edu as user svc_nasmonitor.
It connects via SSH to Fsx location svm-aws-nas-cl1.hbs.edu and runs a Netapp Ontap snapmirror command to list the volumes in the ADAPT Prod. 
The output fields source-path,destination-path,state,health are redirected to the file /home/svc_nasmonitor/logs/vhealth.txt.
vhealth.txt is diff'd with vhealth-yesterday.txt to create diffvol.txt
vhealth.txt and diffvol.txt are emailed to CSE and ADAPT-connected customers and coders.
