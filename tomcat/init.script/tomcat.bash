#!/bin/bash

### BEGIN INIT INFO
# Provides:        Saiful Islam Rokon
# Required-Start:  $network
# Required-Stop:   $network
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Start/Stop Tomcat 7/8/9 server
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin

#Replese "apache" by tomcat running user.

start() {
 /usr/bin/sudo /bin/su -l apache -s /usr/share/tomcat7/bin/startup.sh
}

stop() {
 /usr/bin/sudo /bin/su -l apache -s /usr/share/tomcat7/bin/shutdown.sh

}
case $1 in
  start|stop) $1;;
  restart) stop; start;;
  *) echo "Run as $0 <start|stop|restart>"; exit 1;;
esac
exit 0
