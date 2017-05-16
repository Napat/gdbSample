# Basic C debugger(gdb) tutorial

To launch gdb for local application
การดีบั๊คโปรแกรมที่รันอยู่บนเครื่องปัจจุบันด้วย gdb มีขั้นตอนดังต่อไปนี้
1. Compile C program with `-g` option: <app_g_option>   
เพิ่มออปชั่น `-g` เข้าไปในขั้นตอนคอมไพล์โปรแกรม
2. Execute gdb with <app_g_option> parameter
เปิดโปรแกรม gdb โดยใส่โปรแกรมที่ต้องการดีบั๊คเข้ามาด้วย
3. Setup break point
ตั้งค่าจุดเบรคพ้อยที่ต้องการตรวจโปรแกรม
4. Run <app_g_option> in gdb shell
สั่งเริ่มทำงานโปรแกรมในโหมดดีบั๊ค
5. Debuging any variables
ตรวจสอบค่าต่างๆที่ตำแหน่งเบรคพ้อย
6. Continue/StepOver/StepIn to next program lines 
ใช้คำสั่งเพื่อนเลื่อนไปยังตำแหน่งอื่นๆของโปรแกรมเพื่อตรวจสอบการทำงาน

Frequent gdb command shortcuts
```
q - quit gdb
l – list
p – print
c – continue
s – step
ENTER: pressing enter key would execute the previously executed command again.

```
   
--------------------------------------------
   
1. Compile C program with `-g` option
```
$ cc -g factorial.c -o factorial_gdb
$ cc -g multiplicationtable.c -o multiplicationtable_gdb
```
   
--------------------------------------------
   
2. Execute gdb with <app_g_option> parameter
```
## SHELL 01
$ cd host 
$ gdb factorial_gdb
GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
...
Type "apropos word" to search for commands related to "word"...
Reading symbols from factorial_gdb...done.
(gdb) 
```
   
--------------------------------------------
   
3. Setup break point
Break point syntaxs to setup inside C program
```
break linenum
break function
break filename:linenum
break filename:function
break *address
More see [1] http://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_28.html
```
   
```
## SHELL 01
## set break point at line 6 and 8 of factorial.c
(gdb) break factorial.c:6
Breakpoint 1 at 0x4005ae: file factorial.c, line 6.
(gdb) break factorial.c:8
Breakpoint 3 at 0x4005b5: file factorial.c, line 8.
(gdb)
```
   
--------------------------------------------
   
4. Run <app_g_option> in gdb shell
Note that to start running <app_g_option> can also give command line
argument via args using syntex,
```
run [args]
```
   
```
## SHELL 01
(gdb) run
Starting program: /mnt/c/Users/Napat/Desktop/gdbtest/host/factorial_gdb
warning: Error disabling address space randomization: Success
warning: linux_ptrace_test_ret_to_nx: PTRACE_KILL waitpid returned -1: Interrupted system call
Enter factorial number: 5

Breakpoint 2, factorial (fact=5) at factorial.c:8
8               return fact*factorial(fact-1);
(gdb) l
3
4       int32_t factorial(int32_t fact){
5               if(fact == 0){
6                       return 1;
7               }
8               return fact*factorial(fact-1);
9       }
10
11      int main()
12      {       int32_t fact;
(gdb)
```
   
--------------------------------------------
   
5. Debuging any variables
Syntax: 
```
print {variable}
```
   
```
## SHELL 01
(gdb) print fact
$1 = 5
(gdb)
```
   
--------------------------------------------
   
6. Continue/StepOver/StepIn to next program lines 
Three kind of gdb operations when program stops at a break point.
- c or continue: Debugger will continue executing until the next break point.
- n or next: Debugger will execute the next line as single instruction.
- s or step: Same as next, but does not treats function as a single instruction, 
instead goes into the function and executes it line by line.
   
```
## SHELL 01
(gdb) p fact
$2 = 4
(gdb) s
factorial (fact=3) at factorial.c:5
5               if(fact == 0){
(gdb) p fact
$3 = 3
(gdb) s

Breakpoint 2, factorial (fact=3) at factorial.c:8
8               return fact*factorial(fact-1);
(gdb) p fact
$4 = 3
(gdb) s
factorial (fact=2) at factorial.c:5
5               if(fact == 0){
(gdb) p fact
$5 = 2
(gdb) c
Continuing.

Breakpoint 2, factorial (fact=2) at factorial.c:8
8               return fact*factorial(fact-1);
(gdb) c
Continuing.

Breakpoint 2, factorial (fact=1) at factorial.c:8
8               return fact*factorial(fact-1);
(gdb) c
Continuing.

Breakpoint 1, factorial (fact=0) at factorial.c:6
6                       return 1;
(gdb) c
Continuing.
factorial(5) is 120
[Inferior 1 (process 298) exited with code 024]
(gdb) q
napat@.../host$

```

--------------------------------------------

Sample to run gdb over mutiplicationtable_gdp that normal mutiplicationtable require 
executing with argument: `./mutiplicationtable 3`
ตัวอย่างการสั่งรันโปรแกรมที่รับค่าเข้าไปในขั้นตอนการรัน

```
...
## 2. Execute gdb with <app_g_option> parameter
$ gdb multiplicationtable_gdb
...
## 4. Run <app_g_option> in gdb shell
(gdb) run 3
```

--------------------------------------------

Reference:
1. http://www.delorie.com/gnu/docs/gdb/gdb_29.html
2. http://www.thegeekstuff.com/2010/03/debug-c-program-using-gdb
