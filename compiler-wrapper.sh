#!/usr/bin/bash

is_linker=1

args=
for var in "$@"
do
    args+=" $var"
    if [ $var == "-S" ]
    then
        is_linker=0
    fi
done

make clean --silent --no-print-directory -C $(dirname "$(realpath $0)")
if [ $is_linker == 1  ]
then
    make link --silent --no-print-directory -C $(dirname "$(realpath $0)") ARGS="$args"
else
    make compile --silent --no-print-directory -C $(dirname "$(realpath $0)") ARGS="$args"
fi