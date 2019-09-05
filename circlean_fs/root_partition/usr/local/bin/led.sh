#!/bin/bash

seton(){
        gpio -g mode $1 out
        gpio -g write $1 1
}

setoff(){
        gpio -g mode $1 out
        gpio -g write $1 0 
}

setglow(){
        gpio -g mode $1 up
        gpio -g mode $1 in
}


setinput(){
        gpio -g mode $1 down
        gpio -g mode $1 in
}

process_usb_state(){

  case $2 in
     connected)
          echo "USB-Drive connected"
          seton $1
          ;;
     disconnected)
          echo "USB-Drive disconnected"
          setoff $1
          ;;
     mounted)
          echo "USB-Drive mounted"
          ;; 
     unmounted)
          echo "USB-Drive unmounted"
          setglow $1
          ;; 
     *)
          echo "error: state $2 not supported"
          ;;
  esac
}

 case $1 in
     badusb)
          echo -n "bad port: "
          process_usb_state 16 $2
          ;;
     goodusb)
          echo -n "good port: "
          process_usb_state 21 $2
          ;;
     groomer)
          echo -n "groomer: "
   
          case $2 in
             started)
                  echo "started"
                  seton 20
                  ;;
             stopped)
                  echo "stopped"
                  setoff 20
                  ;;
             *)
                  echo "error: groomer state $2 not supported"                  ;;
                  ;; 
          esac
          ;;          
     *)
          echo "error: port not supported (use: $0 goodusb connected)"
          ;; 
  esac
