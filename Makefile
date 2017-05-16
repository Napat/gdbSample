

all: factorial factorial_gdb multiplicationtable multiplicationtable_gdb install

factorial: factorial.c
	cc factorial.c -o $@

factorial_gdb: factorial.c
	cc -g factorial.c -o $@

multiplicationtable: multiplicationtable.c
	cc multiplicationtable.c -o $@

multiplicationtable_gdb: multiplicationtable.c
	cc -g multiplicationtable.c -o $@

install: FORCE
	mkdir -p host target
	cp factorial factorial_gdb multiplicationtable multiplicationtable_gdb host
	mv factorial factorial_gdb multiplicationtable multiplicationtable_gdb target

clean: FORCE
		rm -rf host target

FORCE: 
	