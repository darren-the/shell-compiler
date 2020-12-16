#!/bin/sh

# Reads n lines from STDIN and prints "Duplicate line!"
# if there are two lines in a row that are the same

n=0
prev_line=""
while test $n -lt $1
do
read line
if test "$line" = "$prev_line"
then
    echo Duplicate line!
fi
prev_line=$line
n=`expr $n + 1`
done
