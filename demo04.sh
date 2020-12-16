#!/bin/sh

# Given a limit (1st argument) determines whether the other
# given numbers are greater than, less than or equal to the limit.

limit=$1
is_limit=1
for n in $@
do
if test $is_limit -ne 1
then
if test $n -gt $limit
then
echo greater
elif test $n -eq $limit
then
echo equal
elif test $n -lt $limit
then
echo less
else
exit 0
fi
fi
is_limit=0
done
