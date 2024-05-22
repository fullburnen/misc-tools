#!/bin/bash -e

# MIT License
# 
# Copyright (c) 2020-2024 fullburnen <fullburnen@protonmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Written for use with cygwin bash

UNSORTED_DIR=""
XAVCS=0

EXIFTOOL_BIN=""
EXIFTOOL_ARGS="-r -api largefilesupport=1"

KERNEL=`uname -s`
case "${KERNEL}" in
    CYGWIN*)
        echo "Info: Detected Cygwin"
        EXIFTOOL_BIN="exiftool.exe"
        ;;
    Linux*)
        echo "Info: Detected Linux"
        EXIFTOOL_BIN="exiftool"
        ;;
esac

if [ "x${EXIFTOOL_BIN}" == "x" ]; then
    echo "Error: Unknown system"
    exit 1
fi

while (( "${#}" )); do
    if [ ${#} == 1 ] && [ "x${UNSORTED_DIR}" == "x" ]; then
        UNSORTED_DIR=${1}
        if [[ $(ls "${UNSORTED_DIR}") == "" ]]; then
            echo "Error: unsorted directory does not exist"
            exit 1
        fi
        echo "Info: Unsorted dir is \"${UNSORTED_DIR}\""
    elif [ "$1" == "xavcs" ]; then
        XAVCS=1
        echo "Info: XAVCS set"
    else
        echo "Error: Unknown argument"
    fi
    shift
done

if [ "x${UNSORTED_DIR}" == "x" ]; then
    echo "Error: No unsorted directory specified"
    exit 1
fi

if [ ${XAVCS} == 1 ]; then
    #XAVCS files don't have DateTimeOriginal
    #Sony CreationDateValue causes issues in Windows
    echo "Info: Updating XAVCS timestamp and filename"
    ${EXIFTOOL_BIN} ${EXIFTOOL_ARGS} -ee -ext mp4 -P -overwrite_original "-DateTimeOriginal<CreationDateValue" ${UNSORTED_DIR}
    ${EXIFTOOL_BIN} ${EXIFTOOL_ARGS} -ee -ext mp4 -d %Y%m%d%H%M%S.%%e "-FileName<DateTimeOriginal" ${UNSORTED_DIR}
else
    echo "Info: Sorting files"
    ${EXIFTOOL_BIN} ${EXIFTOOL_ARGS} -ee -o . "-Directory<DateTimeOriginal" -d %Y/%Y-%m-%d ${UNSORTED_DIR}
fi
