#!/bin/bash


 exec 50>/var/tmp/testlock.lock || exit 1
 flock 50 || exit 1
 
 
 function cleanup() {
 	echo "ouch"
 }

trap cleanup SIGINT

 echo "Doing some stuff…"
 echo "Sleeping for 30 seconds…"
 sleep 30 
