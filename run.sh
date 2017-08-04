#!/bin/bash

. settings.conf

MODE=d #default is daemon

while getopts ":i" opt; do
    case $opt in
	i)
	    MODE=i
	    CMD=/bin/bash
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    ;;
    esac
done

docker run \
       -${MODE}t \
       --privileged \
       -e PULSE_SERVER=tcp:${PULSE_SERVER_IP}:4713 \
       -e PULSE_COOKIE=/run/pulse/cookie \
       -v /dev/shm:/dev/shm \
       -v /etc/machine-id:/etc/machine-id \
       -v /var/lib/dbus:/var/lib/dbus \
       -v /etc/localtime/:/etc/localtime/:ro \
       -v ${MUSIC_MOUNT_POINT}:/opt/music:ro \
       -v ${DATABASE_DIR}:/var/lib/mpd/ \
       -p 6600:6600 \
       -p 8000:8000 \
       -h ${MPD_HOSTNAME} \
       services/mpd ${CMD}
