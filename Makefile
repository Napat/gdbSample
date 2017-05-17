
TOP_DIR = $(shell pwd)
export TOP_DIR

include $(TOP_DIR)/*.mk

all: factorial_gdb multiplicationtable_gdb err_arrayoverflow_gdb install

factorial_gdb: factorial.c
	${CC} -g factorial.c -o $@

multiplicationtable_gdb: multiplicationtable.c
	${CC} -g multiplicationtable.c -o $@

err_arrayoverflow_gdb: err_arrayoverflow.c
	${CC} -g err_arrayoverflow.c -o $@

install: FORCE
	mkdir -p host target
	cp factorial_gdb multiplicationtable_gdb err_arrayoverflow_gdb host
	mv factorial_gdb multiplicationtable_gdb err_arrayoverflow_gdb target

clean: FORCE
		rm -rf host target

FORCE: 
	