#!/bin/bash

killed(){
    echo 'Music stopped.'
}

run_timidity() {
    # Force output on analog
    amixer cset numid=3 1
    files=(${MUSIC_DIR}*.mid)
    while true; do
        # -id flags set interface to "dumb" and -qq silences most/all terminal output
        # 44100 khz uses ~97% cpu load on Pi 1 !
        CPU=`cat /proc/cpuinfo | grep Hardware | cut -d : -f 2 | cut -d " " -f 2`
        if [ $CPU = "BCM2835" ] ; then
          echo "Music: using low quality audio to reduce cpu load for ARM11 core"
          # uses ~15-30% cpu load @ Pi 1
          FREQ=11025
        else
          FREQ=22050
        fi
        TIMIDITYFILE=`basename ${TIMIDITY}`
        killall ${TIMIDITYFILE} || echo ""
        "${TIMIDITY}" -idqq -s $FREQ "${files[RANDOM % ${#files[@]}]}"
    done
}

main() {
    set -eu  # exit when a line returns non-0 status, treat unset variables as errors
    trap killed EXIT TERM INT  # run clean when the script ends or is interrupted
    source ./config.sh  # get config values
    run_timidity
}

main
