set terminal png font "Meiryo,12" enhanced
set output "result/sched4E2.png"
# set xrange [ 0 : 100 ] noreverse nowriteback
set yrange [ 0 : 100 ]   noreverse nowriteback
set ytics 25
set grid
set xlabel "経過時間(ミリ秒)"
set ylabel "進捗(%)"
set title "実験4-E グラフ2"
set key left top

plot '< sed -n 3,102p   log/sched4C.log' using 2:3 title 'プロセス1', \
     '< sed -n 105,204p log/sched4C.log' using 2:3 title 'プロセス0'
