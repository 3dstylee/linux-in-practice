set terminal png font "TakaoGothic,12" enhanced
set output "log/sched4A2.png"
# set xrange [ 0 : 100 ] noreverse nowriteback
set yrange [ 0 : 100 ]   noreverse nowriteback
set ytics 25
set grid
set xlabel "経過時間(ミリ秒)"
set ylabel "進捗(%)"
set title "実験4-A グラフ2"
set key left top

plot '< sed -n 3,102p log/sched4A.log' using 2:3 title 'プロセス0'
