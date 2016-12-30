#include "types.h"
#include "stat.h"
#include "user.h"
#include "date.h"
#include "syscall.h"
#include "traps.h"


int
main(int argc, char *argv[])
{

	int d =0;
  if (argc > 1)
  	printf(1,"Too many arguments!\n");
  else
  {
  d=ls_call01();
  printf(1,"Call %d\n", d);
 d=ls_call02();
  printf(1,"Call %d\n", d);
  d=ls_call03();
  printf(1,"Call %d\n", d);
  d=ls_call04();
  printf(1,"Call %d\n", d);
  d=ls_call05();
  printf(1,"Call %d\n", d);
  d=ls_call06();
  printf(1,"Call %d\n", d);
 d=ls_call07();
  printf(1,"Call %d\n", d);
 d=ls_call07();
 printf(1,"Call %d\n", d);  
 d=ls_call08();
  printf(1,"Call %d\n", d);
 d=ls_call09();
  printf(1,"Call %d\n", d);
 d=ls_call10();
  printf(1,"Call %d\n", d);
 d=ls_call11();
  printf(1,"Call %d\n", d);
 d=ls_call12();
  printf(1,"Call %d\n", d);
 d=ls_call13();
  printf(1,"Call %d\n", d);
 d=ls_call14();
  printf(1,"Call %d\n", d);
 d=ls_call15();
  printf(1,"Call %d\n", d);
 d=ls_call16();
  printf(1,"Call %d\n", d);
 d=ls_call17();
  printf(1,"Call %d\n", d);
 d=ls_call18();
  printf(1,"Call %d\n", d);
 d=ls_call19();
  printf(1,"Call %d\n", d);
 d=ls_call20();
  printf(1,"Call %d\n", d);
 d=ls_call21();
  printf(1,"Call %d\n", d);
 d=ls_call22();
  printf(1,"Call %d\n", d);
 d=ls_call23();
  printf(1,"Call %d\n", d);
 d=ls_call24();
  printf(1,"Call %d\n", d);
 d=ls_call25();
  printf(1,"Call %d\n", d);
 d=ls_call26();
  printf(1,"Call %d\n", d);
 d=ls_call27();
  printf(1,"Call %d\n", d);
 d=ls_call28();
  printf(1,"Call %d\n", d);
 d=ls_call29();
  printf(1,"Call %d\n", d);
 d=ls_call30();
  printf(1,"Call %d\n", d);
 }
  exit(); 
}
