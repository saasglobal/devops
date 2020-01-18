#! /bin/bash
### BEGIN INIT INFO
# Provides:          Divine IT Limited
# Required-Start:    nginx
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: The main django process
# Description:       The gunicorn process that receives HTTP requests
#                    from nginx
#
### END INIT INFO
#
# Author:       mle <saiful@divine-it.net>
#
PATH=/bin:/usr/bin:/sbin:/usr/sbin

APPNAME=sellocityweb
USER=nginx
APPDIR=/var/www/html/sellocity_web
APPMODULE=website.wsgi
PORT=9093
WORKERS=2

ACTIVATE=$APPDIR/.venv/bin/activate
DAEMON=gunicorn
RUN=$APPDIR/.venv/bin/gunicorn
HOST=127.0.0.1
BIND=$HOST:$PORT
PIDFILE=/var/run/$APPNAME.pid
LOGFILE=/var/log/$APPNAME.log
source /etc/init.d/functions
#. /etc/init.d/functions
#. /lib/lsb/init-functions
# Source function library.
#. /etc/rc.d/init.d/functions
if [ -e "/etc/default/$APPNAME" ]
then
    . /etc/default/$APPNAME
fi


case "$1" in
  start)
        log_daemon_msg "Starting deferred execution scheduler" "$APPNAME"
        cd $APPDIR
        $RUN --bind=$BIND --pid=$PIDFILE --workers=$WORKERS --log-file=$LOGFILE $APPMODULE &
        log_end_msg $?
    ;;
  stop)
        log_daemon_msg "Stopping deferred execution scheduler" "APPNAME"
        killproc -p $PIDFILE $DAEMON
        log_end_msg $?
    ;;
  force-reload|restart)
    $0 stop
    $0 start
    ;;
  status)
    status_of_proc -p $PIDFILE $DAEMON && exit 0 || exit $?
    ;;
  *)
    echo "Usage: /etc/init.d/$APPNAME {start|stop|restart|force-reload|status}"
    exit 1
    ;;
esac

exit 0
