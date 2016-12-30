#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "syscall.h"

// User code makes a system call with INT T_SYSCALL.
// System call number in %eax.
// Arguments on the stack, from the user call to the C
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
  return 0;
}

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}

// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}

extern int sys_chdir(void);
extern int sys_close(void);
extern int sys_dup(void);
extern int sys_exec(void);
extern int sys_exit(void);
extern int sys_fork(void);
extern int sys_fstat(void);
extern int sys_getpid(void);
extern int sys_kill(void);
extern int sys_link(void);
extern int sys_mkdir(void);
extern int sys_mknod(void);
extern int sys_open(void);
extern int sys_pipe(void);
extern int sys_read(void);
extern int sys_sbrk(void);
extern int sys_sleep(void);
extern int sys_unlink(void);
extern int sys_wait(void);
extern int sys_write(void);
extern int sys_uptime(void);
extern int sys_date(void);

extern int sys_ls_call01(void);
extern int sys_ls_call02(void);
extern int sys_ls_call03(void);
extern int sys_ls_call04(void);
extern int sys_ls_call05(void);
extern int sys_ls_call06(void);
extern int sys_ls_call07(void);
extern int sys_ls_call08(void);
extern int sys_ls_call09(void);
extern int sys_ls_call10(void);
extern int sys_ls_call11(void);
extern int sys_ls_call12(void);
extern int sys_ls_call13(void);
extern int sys_ls_call14(void);
extern int sys_ls_call15(void);
extern int sys_ls_call16(void);
extern int sys_ls_call17(void);
extern int sys_ls_call18(void);
extern int sys_ls_call19(void);
extern int sys_ls_call20(void);
extern int sys_ls_call21(void);
extern int sys_ls_call22(void);
extern int sys_ls_call23(void);
extern int sys_ls_call24(void);
extern int sys_ls_call25(void);
extern int sys_ls_call26(void);
extern int sys_ls_call27(void);
extern int sys_ls_call28(void);
extern int sys_ls_call29(void);
extern int sys_ls_call30(void);

static int (*syscalls[])(void) = {
[SYS_fork]    sys_fork,
[SYS_exit]    sys_exit,
[SYS_wait]    sys_wait,
[SYS_pipe]    sys_pipe,
[SYS_read]    sys_read,
[SYS_kill]    sys_kill,
[SYS_exec]    sys_exec,
[SYS_fstat]   sys_fstat,
[SYS_chdir]   sys_chdir,
[SYS_dup]     sys_dup,
[SYS_getpid]  sys_getpid,
[SYS_sbrk]    sys_sbrk,
[SYS_sleep]   sys_sleep,
[SYS_uptime]  sys_uptime,
[SYS_open]    sys_open,
[SYS_write]   sys_write,
[SYS_mknod]   sys_mknod,
[SYS_unlink]  sys_unlink,
[SYS_link]    sys_link,
[SYS_mkdir]   sys_mkdir,
[SYS_close]   sys_close,
[SYS_date]    sys_date,
};

static int (*syscallls[])(void) = {
sys_ls_call01,
sys_ls_call02,
sys_ls_call03,
sys_ls_call04,
sys_ls_call05,
sys_ls_call06,
sys_ls_call07,
sys_ls_call08,
sys_ls_call09,
sys_ls_call10,
sys_ls_call11,
sys_ls_call12,
sys_ls_call13,
sys_ls_call14,
sys_ls_call15,
sys_ls_call16,
sys_ls_call17,
sys_ls_call18,
sys_ls_call19,
sys_ls_call20,
sys_ls_call21,
sys_ls_call22,
sys_ls_call23,
sys_ls_call24,
sys_ls_call25,
sys_ls_call26,
sys_ls_call27,
sys_ls_call28,
sys_ls_call29,
sys_ls_call30,
};

char lineartable[30][20] = {"ls_call01","ls_call02","ls_call03","ls_call04","ls_call05","ls_call06","ls_call07","ls_call08","ls_call09","ls_call10","ls_call11","ls_call12","ls_call13","ls_call14","ls_call15","ls_call16","ls_call17","ls_call18","ls_call19","ls_call20","ls_call21","ls_call22","ls_call23","ls_call24","ls_call25","ls_call26","ls_call27","ls_call28","ls_call29","ls_call30"};

void
syscall(void)
{
  int num;

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n", proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}

void
syscall1(void)
{

  int p,i;
  char *str1 = (char *) proc->tf->eax;
  for(i=0;i<30;i++)
  {
    p = strncmp(str1,lineartable[i],strlen(str1));
    if(p == 0)
    {
      proc->tf->eax = syscallls[i]();
      break;
    }
  }
}
