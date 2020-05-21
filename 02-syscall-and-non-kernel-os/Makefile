.PHONY: help build eval clean 

CC	= cc

help: ## show this help.
	@echo "Please use \`make <target>' where <target> is one of\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## build binary package
	$(CC) -o hello     hello.c
	$(CC) -o loop      loop.c
	$(CC) -o ppidloop  ppidloop.c

eval: build ## run strace
	mkdir -p log
	strace -o log/hello.log ./hello
	strace -o log/hello.py.log python3 ./hello.py
	strace -T -o log/hello_time.log ./hello
	./eval_nosyscall.sh   | tee log/eval_nosyscall.log
	./eval_withsyscall.sh | tee log/eval_withsyscall.log
	./eval_ldd.sh         | tee log/eval_ldd.log

clean: ## remove generated files
	-@rm -f *~
	-@rm -f hello loop ppidloop
