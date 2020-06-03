set terminal png font "TakaoGothic,12" enhanced
set output "log/sched4C2.png"
# set xrange [ 0 : 100 ] noreverse nowriteback
set yrange [ 0 : 100 ]   noreverse nowriteback
set ytics 25
set grid
set xlabel "経過時間(ミリ秒)"
set ylabel "進捗(%)"
set title "実験4-C グラフ2"
set key left top

plot '< sed -n 3,102p   log/sched4C.log' using 2:3 title 'プロセス3', \
     '< sed -n 105,204p log/sched4C.log' using 2:3 title 'プロセス2', \
     '< sed -n 207,306p log/sched4C.log' using 2:3 title 'プロセス1', \
     '< sed -n 309,424p log/sched4C.log' using 2:3 title 'プロセス0'


