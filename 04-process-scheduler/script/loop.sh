#!/bin/bash

cpu=$1
nproc=$2

pid=()

if [ $# -ne 2 ]; then
    cpu="0"
    nproc=1
fi

for ((proc=0; proc<$nproc; proc++)); do
    taskset -c $cpu python3 ./loop.py &
    pid+=($!)
done

sleep 10

ps -eo pid,comm,time,etime | head -1
ps -eo pid,comm,time,etime | grep python3

kill ${pid[@]}
