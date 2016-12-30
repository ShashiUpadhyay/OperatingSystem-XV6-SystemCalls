#include "types.h"
#include "stat.h"
#include "user.h"
#include "date.h"
#include "syscall.h"
#include "traps.h"


int
main(int argc, char *argv[])
{

  struct rtcdate r;
  if (argc > 1)
  	printf(1,"Too many arguments!\n");
  else
  {
  date(&r);
  printf(1,"Year:%d, Month:%d,Day:%d Time %d-%d-%d\n", r.year,r.month,r.day, r.hour,r.minute, r.second);
  }
  exit(); 
}
