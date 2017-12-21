#! /usr/bin/env sh
set -e

PACKAGE_NAME=ccjhd
PACKAGE_DESC="ccjhd server"
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:${PATH}

start() {
    echo -n "Starting ${PACKAGE_DESC}: "
    nohup ./ccjhd ccjhd.ini >/dev/null 2>&1 &
	echo "${PACKAGE_NAME}."
}

stop() {
    echo -n "Stopping ${PACKAGE_DESC}: "
    kill -3 `ps aux | grep 'ccjhd' | grep -v grep | awk '{print $2}'` >/dev/null 2>&1 || true
    echo "${PACKAGE_NAME}."
}

restart() {
    stop || true
    sleep 1
    start
}

usage() {
    N=$(basename "$0")
    echo "Usage: [sudo] $N {start|stop|restart}" >&2
    exit 1
}

if [ "$(id -u)" != "0" ]; then
    echo "please use sudo to run ${PACKAGE_NAME}"
    exit 0
fi

cd `dirname $(readlink -fn $0)`

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    #reload)
    restart | force-reload)
        restart
        ;;
    *)
        usage
        ;;
esac

exit 
