#!/bin/sh

# Prints the word form of a digit given in numerical form

if test $1 -eq 0
then
    echo zero
elif test $1 -eq 1
then
    echo one
elif test $1 -eq 2
then
    echo two
elif test $1 -eq 3
then
    echo three
elif test $1 -eq 4
then
    echo four
elif test $1 -eq 5
then
    echo five
elif test $1 -eq 6
then
    echo six
elif test $1 -eq 7
then
    echo seven
elif test $1 -eq 8
then
    echo eight
elif test $1 -eq 9
then
    echo nine
else
    exit 0
fi