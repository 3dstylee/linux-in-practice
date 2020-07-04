#!/bin/bash

echo -e "\nシステム全体のメモリ利用状況の推移検証"
sar -r 1 > log/demand_sar_used.log &
pid=$!

./demand-paging

kill $pid

echo -e "\nシステム全体のページフォルト状況の推移検証"
sar -B 1 > log/demand_sar_fault.log &
pid=$!

./demand-paging
echo -e "\nシステム全体のページフォルト状況の推移検証(割り当て済ページへの再アクセス検証)"
./demand-paging-all

kill $pid


echo -e "\ndemand-pagingプロセスのメモリ利用状況の推移検証"
(sleep 1; sh ./vsz-rss.sh >log/vsz-rss.log)&
echo $(pwd)
 ./demand-paging

echo -e "\ndemand-pagingプロセスのメモリ利用状況の推移検証(割り当て済ページへの再アクセス)"
(sleep 1; sh ./vsz-rss.sh >log/vsz-rss-all.log)&
./demand-paging-all

