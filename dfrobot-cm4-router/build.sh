#!/bin/bash -x
# MIT License
#
# Copyright (c) 2024 fullburnen <fullburnen@protonmail.com>
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

PROFILE="rpi-4"
DFROBOT_PACKAGES='kmod-r8169 kmod-usb-dwc2 bcm27xx-userland'
ADDITIONAL_PACKAGES="6in4 luci luci-ssl miniupnpd-nftables luci-app-upnp luci-app-sqm luci-app-wireguard"

make -j$(nproc) image PROFILE="${PROFILE}" PACKAGES="${DFROBOT_PACKAGES} ${ADDITIONAL_PACKAGES}"
