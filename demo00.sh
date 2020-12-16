#!/bin/sh

# ls in shell
path=$1
if test $path != ""
then
    cd $path
fi
for file in *
do
    echo $file
done
