#!/bin/bash

echo "niceは変更せず"
python3 ./loop.py &
PID=$!
sar -P ALL 1 1

kill $PID

echo -e "\nnice=5で実行"
nice -n 5 python3 ./loop.py &
PID=$!
sar -P ALL 1 1

kill $PID
