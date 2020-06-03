#!/bin/bash

echo "process count"
ps ax | wc -l

echo -e "\nprocess list"
ps ax

echo -e "\ncheck idle process with sar"
sar -P ALL 1 1

echo -e "\ncheck heavy process with sar"
taskset -c 0 python3 loop.py &
pid=$!

sar -P ALL 1 1
kill $pid

echo -e "\ncheck run queue length with sar (no other tasks)"
sar -q 1 1

echo -e "\ncheck run queue length with sar (exist loop task)"
taskset -c 0 python3 loop.py &
pid1=$!
sar -q 1 1

taskset -c 0 python3 loop.py &
pid2=$!
sar -q 1 1

kill $pid1
kill $pid2
