# Basic C debugger(gdb) tutorial

## To launch gdb for local application   
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

## Sample to run gdb over mutiplicationtable_gdp that normal mutiplicationtable require 
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

## gdb attach a process
Sometime we want to attach the process like child process from fork() or pthread_create() to gdb by using   
เราสามารถผูก gdb เข้ากับ process ใดๆได้ด้วยเลข pid ได้ด้วย
Syntax: 
```
gdb -p <pid>
```

For example,
```
## SHELL 01
$ ./host/factorial_gdb
Enter factorial number: 
```

```
## SHELL 02
$ ps | grep factorial_gdb
 641 ?        00:00:00 factorial_gdb
$
$ gdp -p 641
(gdb)
```

--------------------------------------------

## Sample runtime error: Segmentation fault with debug info   

```
$ gdb host/err_arrayoverflow_gdb 
(gdb) run
array[0]=2
array[1]=3
array[2]=4
array[3]=5
array[4]=6
array[5]=1
array[6]=4195473
array[7]=1
array[8]=-359555935
array[9]=32768
array[10]=4195838

Program received signal SIGSEGV, Segmentation fault.
0x00000000004005fe in main () at err_arrayoverflow.c:14
14              printf("end main()\r\n");
(gdb)
```


--------------------------------------------

## GDBServer, debug C programs on remote server   
## การดีบั๊คโปรแกรมภาษา C บนเครื่องรีโมทด้วย GDBServer   

target: remote machine that a program running on   
host: local machine a debugger running on to debug target machine via network   

### Senorio   
Ubuntu machine(x64) debugging a program in target machine(mipsel)   
ตัวอย่างการดีบั๊กโปรแกรมจากเครื่อง host: Ubuntu ด้วยการรีโมทไปที่โปรแกรมในเครื่อง target(mipsel)     
1. Compile binary with `-g` option and copy executable files to both host and target machines.
2. Install gdbserver on Target machine.
3. Target machine: Launch gdbserver with executable file in step 1.
4. Launch gdb on host(ubuntuX64) with executable file in step 1.
5. Remote debugging like local debug
6. Attach gdb to a Running Process on Target

--------------------------------------------

3. Target machine: Launch gdbserver with executable file in step 1.
```
$ gdbserver 127.0.0.1:2345 factorial_gdb
gdbserver: Error disabling address space randomization: Success
Process factorial_gdb created; pid = 90
Listening on port 2345

```


--------------------------------------------

4. Launch gdb on host(ubuntuX64) with executable file in step 1.
```
host$ gdb factorial_gdb
```

Connect to target gdbserver using ip:port
```
(gdb) target remote 127.0.0.1:2345
(gdb)
```

--------------------------------------------

5. Remote debugging like local debug
We can run any normal commands in local gdb to debug program in target.   
```
(gdb) l
4       int32_t factorial(int32_t fact){
5               if(fact == 0){
6                       return 1;
7               }
8               return fact*factorial(fact-1);
9       }
10
11      int main()
12      {       int32_t fact;
13              printf ("Enter factorial number: ");
(gdb) b factorial
Breakpoint 1 at 0x4005a8: file factorial.c, line 5.
(gdb) b main
Breakpoint 2 at 0x4005d0: file factorial.c, line 13.
(gdb) c
Continuing.

Breakpoint 2, main () at factorial.c:13
13              printf ("Enter factorial number: ");
(gdb)
```

** Output of program will be print in the target machine **

--------------------------------------------

6. Attach gdb to a Running Process on Target
```
(gdb) attach 123
```

--------------------------------------------

Reference:
1. http://www.delorie.com/gnu/docs/gdb/gdb_29.html
2. http://www.thegeekstuff.com/2010/03/debug-c-program-using-gdb
