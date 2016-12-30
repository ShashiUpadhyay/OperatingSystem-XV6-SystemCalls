#include "types.h"
#include "stat.h"
#include "user.h"
#include "date.h"
#include "syscall.h"
#include "traps.h"


int
main(int argc, char *argv[])
{
int i, t1, t2, t3, t4;    
    int count =0;
    if (argc > 1)
        printf(1,"Error as argument exceeds the permissible limit!\n");
    else
    {
	//----Date ----------------------------//
	struct rtcdate r;
  	date(&r);
	printf(1,"Displaying Time \n");
  	printf(1,"Year : %d | Month : %d | Day : %d | Hour : %d | Minute : %d | Second : %d \n", r.year,r.month,r.day,r.hour,r.minute,r.second);
	
	//----Linear ----------------------------//
	printf(1,"Linear Hashing \n");
        count=ls_call01();
        printf(1,"%d\t", count);
        count=ls_call02();
        printf(1,"%d\t", count);
        count=ls_call03();
        printf(1,"%d\t", count);
        count=ls_call04();
        printf(1,"%d\t", count);
        count=ls_call05();
        printf(1,"%d\t", count);
        count=ls_call06();
        printf(1,"%d\n", count);
        count=ls_call07();
        printf(1,"%d\t", count);
        count=ls_call08();
        printf(1,"%d\t", count);
        count=ls_call09();
        printf(1,"%d\t", count);
        count=ls_call10();
        printf(1,"%d\t", count);
        count=ls_call11();
        printf(1,"%d\t", count);
        count=ls_call12();
        printf(1,"%d\n", count);
        count=ls_call13();
        printf(1,"%d\t", count);
        count=ls_call14();
        printf(1,"%d\t", count);
        count=ls_call15();
        printf(1,"%d\t", count);
        count=ls_call16();
        printf(1,"%d\t", count);
        count=ls_call17();
        printf(1,"%d\t", count);
        count=ls_call18();
        printf(1,"%d\n", count);
        count=ls_call19();
        printf(1,"%d\t", count);
        count=ls_call20();
        printf(1,"%d\t", count);
        count=ls_call21();
        printf(1,"%d\t", count);
        count=ls_call22();
        printf(1,"%d\t", count);
        count=ls_call23();
        printf(1,"%d\t", count);
        count=ls_call24();
        printf(1,"%d\n", count);
        count=ls_call25();
        printf(1,"%d\t", count);
        count=ls_call26();
        printf(1,"%d\t", count);
        count=ls_call27();
        printf(1,"%d\t", count);
        count=ls_call28();
        printf(1,"%d\t", count);
        count=ls_call29();
        printf(1,"%d\t", count);
        count=ls_call30();
        printf(1,"%d\t", count);

} 	
    t1=uptime();
        for (i=0;i<1000000;i++)
        {
            ls_call01();
        }

        t2=uptime();
        printf(1,"\n Time taken for 1000000 ls calls %d ticks \n", (t2-t1));
        
        t3=uptime();
        for (i=0;i<1000000;i++)
        {
            getpid();
        }
        t4=uptime();
        printf(1,"\n Time taken for 1000000 ls calls %d ticks \n", (t4-t3));
    exit(); 
}
