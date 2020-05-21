#!/bin/bash
#
#

./ppidloop &
pid=$!

sar -P ALL 1 1
kill $pid
