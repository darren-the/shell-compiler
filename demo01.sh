#!/bin/sh

# Prints all integers between two given numbers
n1=$1
n2=$2
while test $n1 -le $n2
do
    echo $n1
    n1=`expr $n1 + 1`
done
