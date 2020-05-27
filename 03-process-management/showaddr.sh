#!/bin/bash

echo "ELF file with header for /bin/sleep"
readelf -h /bin/sleep

echo -e "\nELF file with section for /bin/sleep"
readelf -S /bin/sleep

echo -e "\nmemory map for sleep"
/bin/sleep 10 &
pid=$!

cat /proc/$pid/maps
kill $pid


# 以下書籍外の情報
echo -e "\nlist section sizes"
size /bin/sleep
