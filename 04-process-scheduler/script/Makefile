CC	= cc

.PHONY: help build test lint fmt

.SILENT: help eval2

help: ## show this help.
	@echo "Please use \`make <target>' where <target> is one of\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## build binary package
	$(CC) -o sched         sched.c
	$(CC) -o sched_nice    sched_nice.c

eval: build ## run strace
	mkdir -p log

	taskset -c 0 ./sched 1 100 1 | tee log/sched4A.log
	taskset -c 0 ./sched 2 100 1 | tee log/sched4B.log
	taskset -c 0 ./sched 4 100 1 | tee log/sched4C.log
	gnuplot script/graph4A1.plt
	gnuplot script/graph4A2.plt
	gnuplot script/graph4B1.plt
	gnuplot script/graph4B2.plt
	gnuplot script/graph4C1.plt
	gnuplot script/graph4C2.plt

	./script/process.sh | tee log/process.log
	taskset -c 0,1 ./sched 1 100 1 | tee log/sched4D.log
	taskset -c 0,1 ./sched 2 100 1 | tee log/sched4E.log
	taskset -c 0,1 ./sched 4 100 1 | tee log/sched4F.log
	gnuplot script/graph4D1.plt
	gnuplot script/graph4D2.plt
	gnuplot script/graph4E1.plt
	gnuplot script/graph4E2.plt
	gnuplot script/graph4F1.plt
	gnuplot script/graph4F2.plt

eval2: build ## eval time
	echo "論理CPU=1, プロセス数=1"
	bash -c 'time taskset -c 0 ./sched 1 10000 10000'
	echo "\n論理CPU=1, プロセス数=2"
	bash -c 'time taskset -c 0 ./sched 2 10000 10000'
	echo "\n論理CPU=2, プロセス数=1"
	bash -c 'time taskset -c 0,1 ./sched 1 10000 10000'
	echo "\n論理CPU=2, プロセス数=2"
	bash -c 'time taskset -c 0,1 ./sched 2 10000 10000'
	echo "\nスリープするプロセス"
	bash -c 'time sleep 10'
	echo "\npsコマンドによるプロセス使用時間と経過時間の出力"
	ps -eo pid,comm,time,etime
	echo "論理CPU=1, プロセス数=1 でループ処理"
	./script/loop.sh 0 1
	echo "論理CPU=1, プロセス数=2 でループ処理"
	./script/loop.sh 0 2
	echo "論理CPU=2, プロセス数=2 でループ処理"
	./script/loop.sh 0,1 2

eval3: build ## change nice
	taskset -c 0 ./sched_nice 100 1 | tee log/schedNice.log
	gnuplot script/graphNice.plt
	./script/loop_sar_nice.sh


clean: ## remove generated files
	-@rm -f *~
	-@rm -f sched_nice sched
