#!/bin/bash

# MIT License
# 
# Copyright (c) 2024 fullburnen <fullburnen@protonmail.com>
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

usage() {
    echo "Usage: ${0} <-h|-v> <-f 1.55|1.33> <squeezed_file>"
    exit 255
}

if [[ ${#} != 4 ]]; then
    usage
fi

if [ "x`which ffmpeg`" == "x" ]; then
    echo "ffmpeg was not found"
    exit 255
fi

while getopts ":hvf:" OPT; do
    case "${OPT}" in
        h)
            DIMENSION=${DIMENSION:="h"}
            ;;
        v)
            DIMENSION=${DIMENSION:="v"}
            ;;
        f)
            if [[ ${OPTARG} == 1.55 ]]; then
                FACTOR=${FACTOR:=1.55}
            elif [[ ${OPTARG} == 1.33 ]]; then
                FACTOR=${FACTOR:=1.33}
            fi
            ;;
        *)
            ;;
    esac
done
shift $((OPTIND-1))

FILENAME=${1}

if [ -z ${DIMENSION} ] || [ -z ${FACTOR} ] || [ -z ${FILENAME} ]; then
    usage
fi

if [ ! -f ${FILENAME} ]; then
    echo "ERROR: Squeezed file not found"
    exit 255
fi

if [ ${DIMENSION} == "h" ]; then
    DIM_W="iw*${FACTOR}"
    DIM_H="ih"
elif [ ${DIMENSION} == "v" ]; then
    DIM_W="iw"
    DIM_H="ih*${FACTOR}"
fi

DIRNAME=`dirname "${FILENAME}"`
BASENAME=`basename "${FILENAME}"`

ffmpeg -i "${FILENAME}" -vf scale=${DIM_W}:${DIM_H} -q:v 1 "${DIRNAME}/${BASENAME%.*}_desq.png"
