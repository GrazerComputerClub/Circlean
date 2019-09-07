#!/bin/bash
Revision=`cat /proc/cpuinfo | grep 'Revision' | awk '{print $3}'`
RevisionDec=`echo $(( 16#$Revision ))`
echo -n "Revision: ${RevisionDec}, "
if [ $RevisionDec -ge 16 ]; then
        echo 40-pin GPIOs
        exit 0
else
        echo 26-pin GPIOs
        exit 1
fi

