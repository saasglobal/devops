#/bin/bash

mkdir -p /var/log/httpd/worker-log/

GetAllWorkers()
{
 AllWorkers=$(apachectl fullstatus | awk '/^Srv /,/^$/ {print}')
}

GetStuckWorkers()
{
 StuckWorkers=$(echo "$AllWorkers" | awk '$4 == "W" && $6 > 60 && $7 == 0 {print}')
 header=$(echo "$AllWorkers" | head -n 1)
}

GetStuckPIDs()
{
 StuckPIDs=$(echo "$AllWorkers" | awk '$4 == "W" && $6 > 60 && $7 == 0 {print$2}')
}

Show()
{
 echo "--------------------------------"
 echo " Stopped on $(date +%F\ %T)"
 echo "--------------------------------"
 echo "$header"
 echo "$StuckWorkers"
}

GetAllWorkers && GetStuckPIDs
if [ -n "$StuckPIDs" ]; then
  for PID in $StuckPIDs; do
    echo stopping $PID with SIGTERM
    kill -9 $PID
  done
  GetStuckWorkers
  #Show | mail -s "$(basename $0) executed on $(hostname -s)" root
  Show >> /var/log/httpd/worker-log/log.log
fi