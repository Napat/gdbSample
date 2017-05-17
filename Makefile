
TOP_DIR = $(shell pwd)
export TOP_DIR

include $(TOP_DIR)/*.mk

all: factorial factorial_gdb multiplicationtable multiplicationtable_gdb install

factorial: factorial.c
	CC factorial.c -o $@

factorial_gdb: factorial.c
	CC -g factorial.c -o $@

multiplicationtable: multiplicationtable.c
	CC multiplicationtable.c -o $@

multiplicationtable_gdb: multiplicationtable.c
	CC -g multiplicationtable.c -o $@

install: FORCE
	mkdir -p host target
	cp factorial factorial_gdb multiplicationtable multiplicationtable_gdb host
	mv factorial factorial_gdb multiplicationtable multiplicationtable_gdb target

clean: FORCE
		rm -rf host target

FORCE: 
	