##
set terminal png font "TakaoGothic,12" enhanced
set output "log/schedNice1.png"
# set xrange [ 0 : 100 ] noreverse nowriteback
set yrange [ 0 : 3 ]   noreverse nowriteback
set ytics 1
set grid
set xlabel "経過時間(ミリ秒)"
set ylabel "動作中プロセスの番号"
set title "論理CPU0での実行中のプロセス"
set nokey

plot '< sed -n 1,100p log/schedNice.log' using 2:1, \
     '< sed -n 101,200p log/schedNice.log' using 2:1


set terminal png font "TakaoGothic,12" enhanced
set output "log/schedNice2.png"
# set xrange [ 0 : 100 ] noreverse nowriteback
set yrange [ 0 : 100 ]   noreverse nowriteback
set ytics 25
set grid
set xlabel "経過時間(ミリ秒)"
set ylabel "進捗(%)"
set title "プロセス0, プロセス1の進捗"
set key left top

plot '< sed -n 1,100p   log/schedNice.log' using 2:3 title 'プロセス0', \
     '< sed -n 101,200p log/schedNice.log' using 2:3 title 'プロセス1'


