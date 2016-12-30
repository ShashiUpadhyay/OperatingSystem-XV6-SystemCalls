#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

#define SYSCALL1(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL1; \
    ret

SYS_ls_call01:
        .string "ls_call01"

SYS_ls_call02:
        .string "ls_call02"

SYS_ls_call03:
      	.string "ls_call03"

SYS_ls_call04:
        .string "ls_call04"

SYS_ls_call05:
        .string "ls_call05"

SYS_ls_call06:
        .string "ls_call06"  

SYS_ls_call07:
      	.string "ls_call07"

SYS_ls_call08:
        .string "ls_call08"

SYS_ls_call09:
        .string "ls_call09"

SYS_ls_call10:
        .string "ls_call10" 

SYS_ls_call11:
        .string "ls_call11"

SYS_ls_call12:
        .string "ls_call12"

SYS_ls_call13:
      	.string "ls_call13"

SYS_ls_call14:
        .string "ls_call14"

SYS_ls_call15:
        .string "ls_call15"

SYS_ls_call16:
        .string "ls_call16"  

SYS_ls_call17:
      	.string "ls_call17"

SYS_ls_call18:
        .string "ls_call18"

SYS_ls_call19:
        .string "ls_call19"

SYS_ls_call20:
        .string "ls_call20" 

SYS_ls_call21:
        .string "ls_call21"

SYS_ls_call22:
        .string "ls_call22"

SYS_ls_call23:
      	.string "ls_call23"

SYS_ls_call24:
        .string "ls_call24"

SYS_ls_call25:
        .string "ls_call25"

SYS_ls_call26:
        .string "ls_call26"  

SYS_ls_call27:
      	.string "ls_call27"

SYS_ls_call28:
        .string "ls_call28"

SYS_ls_call29:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(date)

SYSCALL1(ls_call01)
SYSCALL1(ls_call02)
SYSCALL1(ls_call03)
SYSCALL1(ls_call04)
SYSCALL1(ls_call05)
SYSCALL1(ls_call06)
SYSCALL1(ls_call07)
SYSCALL1(ls_call08)
SYSCALL1(ls_call09)
SYSCALL1(ls_call10)
SYSCALL1(ls_call11)
SYSCALL1(ls_call12)
SYSCALL1(ls_call13)
SYSCALL1(ls_call14)
SYSCALL1(ls_call15)
SYSCALL1(ls_call16)
SYSCALL1(ls_call17)
SYSCALL1(ls_call18)
SYSCALL1(ls_call19)
SYSCALL1(ls_call20)
SYSCALL1(ls_call21)
SYSCALL1(ls_call22)
SYSCALL1(ls_call23)
SYSCALL1(ls_call24)
SYSCALL1(ls_call25)
SYSCALL1(ls_call26)
SYSCALL1(ls_call27)
SYSCALL1(ls_call28)
SYSCALL1(ls_call29)
SYSCALL1(ls_call30)

