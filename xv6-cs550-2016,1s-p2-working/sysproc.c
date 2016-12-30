#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_date(void)
{
  struct rtcdate *r;
  if (argptr(0, (void*)&r, sizeof(struct rtcdate)) < 0)
    return -1;
  cmostime(r);
  return 0;
}

int sys_ls_call01(void)
{
  return 1;
}

int sys_ls_call02(void)
{
  return 2;
}

int sys_ls_call03(void)
{
  return 3;
}

int sys_ls_call04(void)
{
  return 4;
}

int sys_ls_call05(void)
{
  return 5;
}

int sys_ls_call06(void)
{
  return 6;
}

int sys_ls_call07(void)
{
  return 7;
}

int sys_ls_call08(void)
{
  return 8;
}

int sys_ls_call09(void)
{
  return 9;
}

int sys_ls_call10(void)
{
  return 10;
}

int sys_ls_call11(void)
{
  return 11;
}

int sys_ls_call12(void)
{
  return 12;
}

int sys_ls_call13(void)
{
  return 13;
}

int sys_ls_call14(void)
{
  return 14;
}

int sys_ls_call15(void)
{
  return 15;
}

int sys_ls_call16(void)
{
  return 16;
}

int sys_ls_call17(void)
{
  return 17;
}

int sys_ls_call18(void)
{
  return 18;
}

int sys_ls_call19(void)
{
  return 19;
}

int sys_ls_call20(void)
{
  return 20;
}

int sys_ls_call21(void)
{
  return 21;
}

int sys_ls_call22(void)
{
  return 22;
}

int sys_ls_call23(void)
{
  return 23;
}

int sys_ls_call24(void)
{
  return 24;
}

int sys_ls_call25(void)
{
  return 25;
}

int sys_ls_call26(void)
{
  return 26;
}

int sys_ls_call27(void)
{
  return 27;
}

int sys_ls_call28(void)
{
  return 28;
}

int sys_ls_call29(void)
{
  return 29;
}

int sys_ls_call30(void)
{
  return 30;
}
