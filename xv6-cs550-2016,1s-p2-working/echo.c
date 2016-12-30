#include "types.h"
#include "stat.h"
#include "user.h"
#include "date.h"

int
main(int argc, char *argv[])
{
  int i;
  struct rtcdate r;
  date(&r);
  printf(1,"%d, %d", r.year,r.month);


  for(i = 1; i < argc; i++)
  printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
}
