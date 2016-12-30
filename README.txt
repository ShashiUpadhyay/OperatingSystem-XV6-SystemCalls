CS 550: System Calls

Due March 6th, 11:59 PM.

(This document was last modified on Tuesday, March 8, 2016 at 09:42:29 PM.)

For this assignment, you are to implement and test two alternative system call mechanisms for the xv6 operating system. The interrupts you should use are int 65, and int 66, which are currently unused, and instead of passing an index to indicate the desired system call, a string is passed to the kernel giving the name of the system call to execute. (If you wish to use some other instruction, such as SYSENTER, contact me.) This string must be used to dispatch to the actual handler, which entails a lookup. The first mechanism you will implement, using interrupt 65, will perform a linear-time search of a simple table. The second mechanism you will implement, using interrupt 66, will perform a hash-table lookup.

xv6 is a reimplementation of Unix V6. It is a real operating system, but we will run it on a virtual machine called QEMU. The main current web page for xv6 is here. This book on xv6 will help greatly. There is an accompanying numbered source code PDF that you may also find helpful.

First, download and untar the xv6 baseline from here. This version has been patched so that it will halt the CPU when there are no processes to run.

Then, modify the Makefile to run QEMU from my home directory. Add the following line:

QEMU=/home/kchiu/packages/linux-x86_64/bin/qemu-system-i386
Now compile with make, and run with make qemu-nox, or make qemu-nox-gdb if you wish to debug with gdb. (Start gdb after the above to connect.) To exit, type Control-a, then c, then quit.

You may also develop on your own machine, but you will be mostly on your own for how to do this. Generally, it is not hard to install the needed packages. You must of course use the same xv6 baseline.

To understand how to implement the alternative syscall mechanisms, the best strategy is to understand the current one. The trap starts from the interrupt descriptor table (IDT). The IDT is mostly already setup for you in the kernel, but you need to modify the permission bits for the relevant interrupts so that the interrupt is allowed from user-mode. See the existing code in tvinit(). Start the trace from there.

Tasks

Some of the code you must implement is in the kernel, while other code is in user-mode.
Some of the code is highly repetitive. To reduce the amount of typing that's needed, I suggest that you use macros as much as possible.

Kernel Mode

You must implement a number of different system calls, along with the associated mechanisms. All code must be cs550_syscall.c, though you will need to also add declarations to defs.h. You are also allowed to add a few lines to trap.c in order to dispatch to the new system call handlers.
With Existing Mechanism

This system call must be implemented using the current mechanism, which passes a system call number to the kernel. The system call is named date(), and accepts a single argument of type struct rtcdate *. Upon return, the current date is stored in the struct given by the pointer. To access the real time, use the cmostime() function. If a bad adress is passed, the OS must not crash, but instead the system call must return -1. No error message should be printed by the kernel.
Examine existing system calls to see how to read arguments from the user stack.

With Linear Search

This mechanism must pass a string to the kernel, and then using a simple table, perform a sequential, linear search of the table for the system call. Implement 50 systems calls of this type, named ls_call01(), etc. Each system call must return the respective number. So ls_call01() must return 1, ls_call02() must return 2, etc. These system calls do not take any arguments.
With Hash Table

This mechanism must pass a string to the kernel, and then use a hash table to perform a search for the system call name. You may use any collision resolution scheme that you wish, such as linear probing, chaining, etc. Implement 50 systems calls of this type, named ht_call01(), etc. Each system call must return the respective number. So ht_call01() must return 1, ht_call02() must return 2, etc. These system calls do not take any arguments.
The system call mechanisms that you implement (linear search and hash table) should print an error message and return -1 if the system call is not found, or if a bad address is passed to the kernel. Under no situation should the kernel crash. Such a bug would allow a malicious user to crash the OS, which is obviously undesirable.

System calls return -1 on error, 0 on success.

User Mode

You must also add assembly language stubs for all the new system calls to usys.S.

In addition, you must implement a user mode program to test your new system calls. This user mode program must:

Test the functionality for all the new system calls. The more comprehensive, the higher your score for this part. Tests for production systems must also test the behavior when given bad arguments.
Demonstate that the OS behaves as described above when an unknown system call name or a bad string address is passed to the system call mechanisms from user mode.

To test, this code can be used to pass a bad string to the system call mechanism. Of course, the 65 should be changed to 66 to test the hash table mechanism.

char *p = ...;
int rv;
asm volatile("movl %0, %%eax" : : "rm" (p));
asm volatile("int $65" : :);
asm volatile("movl %%eax, %0" : "=rm" (rv) : );
To figure out what addresses are bad, check the xv6 book and look at the process address space layout. You'll need to be a little bit creative in figuring out how to create a bad address.

The existing mechanism (indexed), hash table mechanism, and linear search mechanism are expected to have different performance. To demonstrate the performance differences, you must also submit code that will time different calls. Use the uptime() system call to obtain the current time in ticks. Each tick is 1/100 of a second. Print the elapsed time for each system call to be tested in nanoseconds with three significant digits. Note that the granularity of a tick means that you will need to measure many calls, then divide by the number of calls.

Existing Mechanism

To test the existing mechanism, time getpid().
Linear Search

To test the linear search mechanism, test two different system calls. The first call must be the first one in the lookup sequence (ls_call01()). The second call must be the last one in the lookup sequence (ls_call50()).
Hash Table

To test the hash table mechanism, test two different system calls. One of the calls must exhibit performance at least as good as the fastest call implemented with linear search. The other call must exhibit performance that is somewhere in between the fastest and slowest linear search system call. (In other words, it is slower than the fastest linear search call, but faster than the slowest linear search call.) You may need to adjust your hash table size to exhibit this behavior.
Implement all your user mode code test code in a user-mode program named cs550_user.c.

Submission and Evaluation

A deliverables checklist is given below. It is just a concise checklist, full requirements are given above.
date() system call implement with existing mechanism.
System calls named ls_call01() through ls_call50() implemented with linear search.
System calls named ht_call01() through ht_call50() implemented with hash table.
User-mode program implemented in source file named cs550_user.c. This program must:
Verify that all system calls work correctly, and do not crash the OS if given bad arguments.
Test and print the timing of getpid().
Test and print the timing of ls_call01() and ls_call50(). These should be slower than getpid().
Test and print the timing of a fast and slow system call using the hash table mechanism. At least one of these should be between the fastest and slowest call when using linear search.
Verify that invoking interrupt 65 or 66 with non-existent system call names or bad addresses will not crash the system.
All kernel code must be in cs550_syscall.c, and all user code must be in cs550_user.c, except for some minor edits to
Makefile
defs.h
main.c
syscall.c
syscall.h
trap.c
traps.h
user.h
usys.S
No functions may be in the files in the above list. Funcions in any file in the list will not be graded.
To submit, first do a make clean, and then create a diff with:

diff -Nur xv6-cs550-2016,1s-p1-baseline xv6-cs550-2016,1s-p2-working >proj2.your-BU-ID.patch
The working directory of your code should be as above. Note that the baseline has the wrong project number in the directory name. In the baseline directory you should have the original, unmodified code.

If you any additional information that you need to give to the TA for grading, create a file named README.your_B_number.txt, and put it in the working directory. It will be included automatically by the diff command into the patch file.

Your code must compile with no warnings. Your code must not have any fixed limits. Your program must not have any memory leaks. Your code must run on the Linux classroom machines. Your code must not output any debugging messages.

Your grade will be based on correctness and performance. Correctness will include whether or not your output is correct, or have any memory (or other resource) leaks. Correctness will also depend on whether or not you have followed instructions. In this assignment, relative performance is important, so your hash table must be implemented correctly, etc.