#!/bin/bash
# MIT License
#
# Copyright (c) 2019 fullburnen <fullburnen@protonmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
