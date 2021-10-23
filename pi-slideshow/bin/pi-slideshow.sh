#!/bin/bash

#Image source directory
SLIDESHOW_PATH="/home/pi/slideshow"
#Local images or from the network
NETWORK=1
#Image transition delay
DELAY=5

if [ ${NETWORK} -ne 0 ]; then
    #Check for network connection, not needed if local images
    HAS_IP=$(ifconfig wlan0 | grep "inet ")
    while [ -z "${HAS_IP}" ]; do
        sleep 10
        HAS_IP=$(ifconfig wlan0 | grep "inet ")
    done

    #Mount directory specified in fstab, not needed if local images
    mount | grep -q ${SLIDESHOW_PATH}
    MOUNT_CHECK=$?
    if [ ${MOUNT_CHECK} -ne 0 ]; then
        mount ${SLIDESHOW_PATH}
    fi
fi

#Start slideshow
DISPLAY=:0.0 XAUTHORITY=/home/pi/.Xauthority feh -Z -F -Y -D ${DELAY} --auto-rotate ${SLIDESHOW_PATH}
