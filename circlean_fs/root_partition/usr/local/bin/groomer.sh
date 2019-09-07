clean(){
    echo "GROOMER: Copy over, sleeping 15s before shutdown."
    sleep 15
    echo "GROOMER: rc.local done, shutting down."
    /sbin/shutdown -P -h now
}


if [ -e /dev/sda ]; then
  if [ -e /dev/sdb ]; then
    # trap clean EXIT TERM INT
    cd /opt/groomer
    #gpio -g mode 4 out
    #gpio -g write 4 1
    /usr/local/bin/led.sh groomer started
    echo "GROOMER: start"
    /opt/groomer/init.sh
    /usr/local/bin/led.sh groomer stopped
  else
    echo "GROOMER: USB device /dev/sdb not found"
  fi
else
  echo "GROOMER: USB device /dev/sda not found"
fi

exit 0

