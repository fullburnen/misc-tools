## Pi Slideshow

Designed for a Raspberry Pi 3B with the official 7" touchscreen display running Raspberry Pi OS with desktop.

### Install

* Install `feh`
* Drop bin and .config (if you want the slideshow to autorun on boot) into /home/pi
* Configure fstab for loading images from a network share
  * `<ip>:<share> /home/pi/slideshow nfs4 user,nofail 0 0`
