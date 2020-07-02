CC	= cc

.PHONY: help build eval1 eval2 eval3 eval4

.SILENT: help eval2

help: ## show this help.
	@echo "Please use \`make <target>' where <target> is one of\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## build binary package
	$(CC) -o segv       segv.c
	$(CC) -o mmap		mmap.c
	$(CC) -o malloc 	malloc.c

eval1: build ## eval page fault
	mkdir -p log

	free        >  log/memory.log
	sar -r 1 10 >> log/memory.log

	./segv      >  log/eval1.log


eval2: build ## eval memory allocation
# ALOC_SIZEの変更は手動で対応する必要あり

	mkdir -p log

	echo "mmapの動作検証" >  log/eval2.log
	./mmap              >> log/eval2.log

	echo -n "\nmallocの動作検証\n" >> log/eval2.log
	./malloc              >> log/eval2.log

	echo -n "\nmmapのstrace\n"  >> log/eval2.log
	strace ./mmap       2>> log/eval2.log

	echo -n "\nmallocのstrace\n" >> log/eval2.log
	strace ./malloc      2>> log/eval2.log

eval3: build ## eval filemap/demand paging

eval4: build ## eval cow/swap/...

clean: ## remove generated files
	-@rm -f *~
	-@rm -f segv mmap mmap_heap mmap_pagemap mmap_sleep malloc
