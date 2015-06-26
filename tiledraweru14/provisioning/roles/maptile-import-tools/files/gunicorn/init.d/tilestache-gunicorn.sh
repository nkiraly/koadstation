#!/bin/sh

# SEE ALSO: http://gunicorn.org/

# To make sure this runs at startup, do:
# update-rc.d tilestache-gunicorn.sh defaults

ADDRESS=localhost:8080
GUNICORN=/usr/bin/gunicorn
DIRNAME=/usr/local/tiledrawer/gunicorn
CONFIG=tilestache.cfg

PIDFILE="/var/run/tiledrawer-gunicorn.pid"
LOGFILE="/var/log/tiledrawer-gunicorn.log"
COMMAND="$GUNICORN --daemon --user www-data --workers 12 --worker-class egg:gunicorn#gevent_wsgi --bind $ADDRESS --log-file $LOGFILE"

start_server () {
  if [ -f $PIDFILE ]; then
    #pid exists, check if running
    if [ "$(ps -p `cat $PIDFILE` | wc -l)" -gt 1 ]; then
       echo "Server already running on ${ADDRESS}"
       return
    fi
  fi
  echo "starting ${ADDRESS}"
  cd $DIRNAME && $COMMAND --pid $PIDFILE "TileStache:WSGITileServer('tilestache.cfg')"
}

stop_server () {
  if [ -f $PIDFILE ] && [ "$(ps -p `cat $PIDFILE` | wc -l)" -gt 1 ]; then
    echo "stopping server ${ADDRESS}"
    kill -9 `cat $PIDFILE`
    rm $PIDFILE
  else
    if [ -f $PIDFILE ]; then
      echo "server ${ADDRESS} not running"
    else
      echo "No pid file found for server ${ADDRESS}"
    fi
  fi
}

restart_server () {
  if [ -f $PIDFILE ] && [ "$(ps -p `cat $PIDFILE` | wc -l)" -gt 1 ]; then
    echo "gracefully restarting server ${ADDRESS}"
    kill -HUP `cat $PIDFILE`
  else
    if [ -f $PIDFILE ]; then
      echo "server ${ADDRESS} not running"
    else
      echo "No pid file found for server ${ADDRESS}"
    fi
  fi
}

case "$1" in
'start')
  start_server
  ;;
'stop')
  stop_server
  ;;
'restart')
  restart_server
  ;;
*)
  echo "Usage: $0 { start | stop | restart }"
  ;;
esac

exit 0
