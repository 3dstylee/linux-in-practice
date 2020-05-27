
.PHONY: help build eval clean

CC	= cc

help: ## show this help.
	@echo "Please use \`make <target>' where <target> is one of\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## build binary package
	$(CC) -o fork          fork.c
	$(CC) -o fork2         fork2.c
	$(CC) -o fork-and-exec fork-and-exec.c

eval: build ## run strace
	mkdir -p log
	./fork          | tee log/fork.log
	./fork2         | tee log/fork2.log
	./fork-and-exec | tee log/fork-and-exec.log
	./showaddr.sh   | tee log/addr.log

clean: ## remove generated files
	-@rm -f *~
	-@rm -f fork fork2 fork-and-exec
