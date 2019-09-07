#!/bin/bash
#https://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/
Revision=`cat /proc/cpuinfo | grep 'Revision' | awk '{print $3}'`
RevisionDec=`echo $(( 16#$Revision ))`
echo -n "CPU Revision: ${RevisionDec}, "
if [ $RevisionDec -ge 16 ]; then
        echo 40-pin GPIOs
        exit 0
else
        echo 26-pin GPIOs
        exit 1
fi

