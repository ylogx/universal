#!/usr/bin/env bash
#
#   follow.sh - watch for change and run when written to
#   This file is a part of Universal Competitive Programming Suite.
#
#   Copyright (c) 2014-2015 Shubham Chaudhary <me@shubhamchaudhary.in>
#
#   Universal is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Universal is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Universal.  If not, see <http://www.gnu.org/licenses/>.
#


filename=$1
if [ "$filename" = "" ]; then
    echo "FATAL ERROR: No filename specified"
    echo "Please enter a filename to follow."
    exit -1
fi
# filename_length=${#1}
if test "${1:${#filename}-2}" == '.c' ;  then
    basename=${1:0:${#filename}-2}
    extname=${1:${#filename}-2}
elif test "${1:nameLen-4}" == '.cpp' ; then #first arg: crop till nameLen-4
    basename=${1:0:${#filename}-4}
    extname=${1:${#filename}-4}
elif test "${1:nameLen-3}" == '.py' ; then
    basename=${1:0:${#filename}-3}
    extname=${1:${#filename}-3}
else
    echo "Unknow file format"
fi
outname=${basename}.out
testname=${basename}.test

notify_array_list=()

function get_names {
    notify_array_list=($filename)

    # Only add to notify list if exists
    if [ -f $outname ]; then
        notify_array_list+=" $outname"
    fi
    if [ -f $testname ]; then
        notify_array_list+=" $testname"
    fi
}

get_names
echo $extname
echo Yo I\'m watching $notify_array_list

while inotifywait $notify_array_list;
do
    sleep 0.5;  # Make sure MOVE_SELF done
    universal $filename;
    if [ -f $outname ]; then
        if [ -f $testname ]; then
            ./$outname < $testname
        else
            ./$outname
        fi
    fi
    sleep 1;  #So that it doesn't read file.out OPEN
    get_names
    echo "Watching $notify_array_list"
done

