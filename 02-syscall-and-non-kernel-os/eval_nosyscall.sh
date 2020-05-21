#!/bin/bash
#
#

./loop &
pid=$!

sar -P ALL 1 1
kill $pid
