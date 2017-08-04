#!/bin/bash

docker stop `docker ps | grep services/mpd | cut -d ' ' -f 1`
