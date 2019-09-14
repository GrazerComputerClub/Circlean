clean(){
    echo "GROOMER: Sync finished, sleeping 10 seconds before shutdown."
    sleep 10
    echo "GROOMER: shutting down."
    /sbin/shutdown -P -h now
}


if [ -e /dev/sda ]; then
  if [ -e /dev/sdb ]; then
    if systemctl is-system-running | grep -qE "running|degraded"; then
      echo "GROOMER: Started with system already running, no shutdown."
    else
      echo "GROOMER: Started from boot process, shutdown after operation finished."
      trap clean EXIT TERM INT
    fi 
    cd /opt/groomer
    #gpio -g mode 4 out
    #gpio -g write 4 1
    /usr/local/bin/led.sh groomer started
    /opt/groomer/init.sh
    /usr/local/bin/led.sh groomer stopped
    killall timidity || echo ""
  else
    echo "GROOMER: USB device /dev/sdb not found."
  fi
else
  echo "GROOMER: USB device /dev/sda not found."
fi

exit 0

