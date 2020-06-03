set terminal png font "Meiryo,12" enhanced
set output "log/sched4D1.png"
# set xrange [ 0 : 100 ] noreverse nowriteback
set yrange [ 0 : 3 ]   noreverse nowriteback
set ytics 1
set grid
set xlabel "経過時間(ミリ秒)"
set ylabel "動作中プロセスの番号"
set title "実験4-D グラフ1"
set nokey

plot '< sed -n 3,102p log/sched4D.log' using 2:1
