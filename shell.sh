#!/bin/bash

ID=`docker ps | grep Up | grep 'services/mpd' | cut -d ' ' -f 1`

[ "${ID}" == "" ] && echo "services/mpd is not running" && exit 1

docker exec -it ${ID} bash
