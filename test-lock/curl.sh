#!/bin/bash

for ((i=1; i<=$1; i++))
do
    curl -o /dev/null -s -w "%{http_code}\n" http://localhost:8080/hotelreservation/test &
done
