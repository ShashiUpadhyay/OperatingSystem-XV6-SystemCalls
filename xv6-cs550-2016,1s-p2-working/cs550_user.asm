
_cs550_user:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "traps.h"


int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 50             	sub    $0x50,%esp
int i, t1, t2, t3, t4;    
    int count =0;
   c:	c7 44 24 48 00 00 00 	movl   $0x0,0x48(%esp)
  13:	00 
    if (argc > 1)
  14:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  18:	7e 19                	jle    33 <main+0x33>
        printf(1,"Error as argument exceeds the permissible limit!\n");
  1a:	c7 44 24 04 90 0f 00 	movl   $0xf90,0x4(%esp)
  21:	00 
  22:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  29:	e8 8f 0b 00 00       	call   bbd <printf>
  2e:	e9 ce 04 00 00       	jmp    501 <main+0x501>
    else
    {
	//----Date ----------------------------//
	struct rtcdate r;
  	date(&r);
  33:	8d 44 24 20          	lea    0x20(%esp),%eax
  37:	89 04 24             	mov    %eax,(%esp)
  3a:	e8 a9 09 00 00       	call   9e8 <date>
	printf(1,"Displaying Time \n");
  3f:	c7 44 24 04 c2 0f 00 	movl   $0xfc2,0x4(%esp)
  46:	00 
  47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4e:	e8 6a 0b 00 00       	call   bbd <printf>
  	printf(1,"Year : %d | Month : %d | Day : %d | Hour : %d | Minute : %d | Second : %d \n", r.year,r.month,r.day,r.hour,r.minute,r.second);
  53:	8b 7c 24 20          	mov    0x20(%esp),%edi
  57:	8b 74 24 24          	mov    0x24(%esp),%esi
  5b:	8b 5c 24 28          	mov    0x28(%esp),%ebx
  5f:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
  63:	8b 54 24 30          	mov    0x30(%esp),%edx
  67:	8b 44 24 34          	mov    0x34(%esp),%eax
  6b:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
  6f:	89 74 24 18          	mov    %esi,0x18(%esp)
  73:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  77:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  7b:	89 54 24 0c          	mov    %edx,0xc(%esp)
  7f:	89 44 24 08          	mov    %eax,0x8(%esp)
  83:	c7 44 24 04 d4 0f 00 	movl   $0xfd4,0x4(%esp)
  8a:	00 
  8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  92:	e8 26 0b 00 00       	call   bbd <printf>
	
	//----Linear ----------------------------//
	printf(1,"Linear Hashing \n");
  97:	c7 44 24 04 20 10 00 	movl   $0x1020,0x4(%esp)
  9e:	00 
  9f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a6:	e8 12 0b 00 00       	call   bbd <printf>
        count=ls_call01();
  ab:	e8 40 09 00 00       	call   9f0 <ls_call01>
  b0:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
  b4:	8b 44 24 48          	mov    0x48(%esp),%eax
  b8:	89 44 24 08          	mov    %eax,0x8(%esp)
  bc:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
  c3:	00 
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	e8 ed 0a 00 00       	call   bbd <printf>
        count=ls_call02();
  d0:	e8 23 09 00 00       	call   9f8 <ls_call02>
  d5:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
  d9:	8b 44 24 48          	mov    0x48(%esp),%eax
  dd:	89 44 24 08          	mov    %eax,0x8(%esp)
  e1:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
  e8:	00 
  e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f0:	e8 c8 0a 00 00       	call   bbd <printf>
        count=ls_call03();
  f5:	e8 06 09 00 00       	call   a00 <ls_call03>
  fa:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
  fe:	8b 44 24 48          	mov    0x48(%esp),%eax
 102:	89 44 24 08          	mov    %eax,0x8(%esp)
 106:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 10d:	00 
 10e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 115:	e8 a3 0a 00 00       	call   bbd <printf>
        count=ls_call04();
 11a:	e8 e9 08 00 00       	call   a08 <ls_call04>
 11f:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 123:	8b 44 24 48          	mov    0x48(%esp),%eax
 127:	89 44 24 08          	mov    %eax,0x8(%esp)
 12b:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 132:	00 
 133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13a:	e8 7e 0a 00 00       	call   bbd <printf>
        count=ls_call05();
 13f:	e8 cc 08 00 00       	call   a10 <ls_call05>
 144:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 148:	8b 44 24 48          	mov    0x48(%esp),%eax
 14c:	89 44 24 08          	mov    %eax,0x8(%esp)
 150:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 157:	00 
 158:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15f:	e8 59 0a 00 00       	call   bbd <printf>
        count=ls_call06();
 164:	e8 af 08 00 00       	call   a18 <ls_call06>
 169:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\n", count);
 16d:	8b 44 24 48          	mov    0x48(%esp),%eax
 171:	89 44 24 08          	mov    %eax,0x8(%esp)
 175:	c7 44 24 04 35 10 00 	movl   $0x1035,0x4(%esp)
 17c:	00 
 17d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 184:	e8 34 0a 00 00       	call   bbd <printf>
        count=ls_call07();
 189:	e8 92 08 00 00       	call   a20 <ls_call07>
 18e:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 192:	8b 44 24 48          	mov    0x48(%esp),%eax
 196:	89 44 24 08          	mov    %eax,0x8(%esp)
 19a:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 1a1:	00 
 1a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a9:	e8 0f 0a 00 00       	call   bbd <printf>
        count=ls_call08();
 1ae:	e8 75 08 00 00       	call   a28 <ls_call08>
 1b3:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 1b7:	8b 44 24 48          	mov    0x48(%esp),%eax
 1bb:	89 44 24 08          	mov    %eax,0x8(%esp)
 1bf:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 1c6:	00 
 1c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ce:	e8 ea 09 00 00       	call   bbd <printf>
        count=ls_call09();
 1d3:	e8 58 08 00 00       	call   a30 <ls_call09>
 1d8:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 1dc:	8b 44 24 48          	mov    0x48(%esp),%eax
 1e0:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e4:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 1eb:	00 
 1ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1f3:	e8 c5 09 00 00       	call   bbd <printf>
        count=ls_call10();
 1f8:	e8 3b 08 00 00       	call   a38 <ls_call10>
 1fd:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 201:	8b 44 24 48          	mov    0x48(%esp),%eax
 205:	89 44 24 08          	mov    %eax,0x8(%esp)
 209:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 210:	00 
 211:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 218:	e8 a0 09 00 00       	call   bbd <printf>
        count=ls_call11();
 21d:	e8 1e 08 00 00       	call   a40 <ls_call11>
 222:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 226:	8b 44 24 48          	mov    0x48(%esp),%eax
 22a:	89 44 24 08          	mov    %eax,0x8(%esp)
 22e:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 235:	00 
 236:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 23d:	e8 7b 09 00 00       	call   bbd <printf>
        count=ls_call12();
 242:	e8 01 08 00 00       	call   a48 <ls_call12>
 247:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\n", count);
 24b:	8b 44 24 48          	mov    0x48(%esp),%eax
 24f:	89 44 24 08          	mov    %eax,0x8(%esp)
 253:	c7 44 24 04 35 10 00 	movl   $0x1035,0x4(%esp)
 25a:	00 
 25b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 262:	e8 56 09 00 00       	call   bbd <printf>
        count=ls_call13();
 267:	e8 e4 07 00 00       	call   a50 <ls_call13>
 26c:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 270:	8b 44 24 48          	mov    0x48(%esp),%eax
 274:	89 44 24 08          	mov    %eax,0x8(%esp)
 278:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 27f:	00 
 280:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 287:	e8 31 09 00 00       	call   bbd <printf>
        count=ls_call14();
 28c:	e8 c7 07 00 00       	call   a58 <ls_call14>
 291:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 295:	8b 44 24 48          	mov    0x48(%esp),%eax
 299:	89 44 24 08          	mov    %eax,0x8(%esp)
 29d:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 2a4:	00 
 2a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ac:	e8 0c 09 00 00       	call   bbd <printf>
        count=ls_call15();
 2b1:	e8 aa 07 00 00       	call   a60 <ls_call15>
 2b6:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 2ba:	8b 44 24 48          	mov    0x48(%esp),%eax
 2be:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c2:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 2c9:	00 
 2ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d1:	e8 e7 08 00 00       	call   bbd <printf>
        count=ls_call16();
 2d6:	e8 8d 07 00 00       	call   a68 <ls_call16>
 2db:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 2df:	8b 44 24 48          	mov    0x48(%esp),%eax
 2e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 2e7:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 2ee:	00 
 2ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f6:	e8 c2 08 00 00       	call   bbd <printf>
        count=ls_call17();
 2fb:	e8 70 07 00 00       	call   a70 <ls_call17>
 300:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 304:	8b 44 24 48          	mov    0x48(%esp),%eax
 308:	89 44 24 08          	mov    %eax,0x8(%esp)
 30c:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 313:	00 
 314:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 31b:	e8 9d 08 00 00       	call   bbd <printf>
        count=ls_call18();
 320:	e8 53 07 00 00       	call   a78 <ls_call18>
 325:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\n", count);
 329:	8b 44 24 48          	mov    0x48(%esp),%eax
 32d:	89 44 24 08          	mov    %eax,0x8(%esp)
 331:	c7 44 24 04 35 10 00 	movl   $0x1035,0x4(%esp)
 338:	00 
 339:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 340:	e8 78 08 00 00       	call   bbd <printf>
        count=ls_call19();
 345:	e8 36 07 00 00       	call   a80 <ls_call19>
 34a:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 34e:	8b 44 24 48          	mov    0x48(%esp),%eax
 352:	89 44 24 08          	mov    %eax,0x8(%esp)
 356:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 35d:	00 
 35e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 365:	e8 53 08 00 00       	call   bbd <printf>
        count=ls_call20();
 36a:	e8 19 07 00 00       	call   a88 <ls_call20>
 36f:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 373:	8b 44 24 48          	mov    0x48(%esp),%eax
 377:	89 44 24 08          	mov    %eax,0x8(%esp)
 37b:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 382:	00 
 383:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 38a:	e8 2e 08 00 00       	call   bbd <printf>
        count=ls_call21();
 38f:	e8 fc 06 00 00       	call   a90 <ls_call21>
 394:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 398:	8b 44 24 48          	mov    0x48(%esp),%eax
 39c:	89 44 24 08          	mov    %eax,0x8(%esp)
 3a0:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 3a7:	00 
 3a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3af:	e8 09 08 00 00       	call   bbd <printf>
        count=ls_call22();
 3b4:	e8 df 06 00 00       	call   a98 <ls_call22>
 3b9:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 3bd:	8b 44 24 48          	mov    0x48(%esp),%eax
 3c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 3c5:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 3cc:	00 
 3cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3d4:	e8 e4 07 00 00       	call   bbd <printf>
        count=ls_call23();
 3d9:	e8 c2 06 00 00       	call   aa0 <ls_call23>
 3de:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 3e2:	8b 44 24 48          	mov    0x48(%esp),%eax
 3e6:	89 44 24 08          	mov    %eax,0x8(%esp)
 3ea:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 3f1:	00 
 3f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3f9:	e8 bf 07 00 00       	call   bbd <printf>
        count=ls_call24();
 3fe:	e8 a5 06 00 00       	call   aa8 <ls_call24>
 403:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\n", count);
 407:	8b 44 24 48          	mov    0x48(%esp),%eax
 40b:	89 44 24 08          	mov    %eax,0x8(%esp)
 40f:	c7 44 24 04 35 10 00 	movl   $0x1035,0x4(%esp)
 416:	00 
 417:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 41e:	e8 9a 07 00 00       	call   bbd <printf>
        count=ls_call25();
 423:	e8 88 06 00 00       	call   ab0 <ls_call25>
 428:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 42c:	8b 44 24 48          	mov    0x48(%esp),%eax
 430:	89 44 24 08          	mov    %eax,0x8(%esp)
 434:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 43b:	00 
 43c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 443:	e8 75 07 00 00       	call   bbd <printf>
        count=ls_call26();
 448:	e8 6b 06 00 00       	call   ab8 <ls_call26>
 44d:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 451:	8b 44 24 48          	mov    0x48(%esp),%eax
 455:	89 44 24 08          	mov    %eax,0x8(%esp)
 459:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 460:	00 
 461:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 468:	e8 50 07 00 00       	call   bbd <printf>
        count=ls_call27();
 46d:	e8 4e 06 00 00       	call   ac0 <ls_call27>
 472:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 476:	8b 44 24 48          	mov    0x48(%esp),%eax
 47a:	89 44 24 08          	mov    %eax,0x8(%esp)
 47e:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 485:	00 
 486:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 48d:	e8 2b 07 00 00       	call   bbd <printf>
        count=ls_call28();
 492:	e8 31 06 00 00       	call   ac8 <ls_call28>
 497:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 49b:	8b 44 24 48          	mov    0x48(%esp),%eax
 49f:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a3:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 4aa:	00 
 4ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4b2:	e8 06 07 00 00       	call   bbd <printf>
        count=ls_call29();
 4b7:	e8 14 06 00 00       	call   ad0 <ls_call29>
 4bc:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 4c0:	8b 44 24 48          	mov    0x48(%esp),%eax
 4c4:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c8:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 4cf:	00 
 4d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4d7:	e8 e1 06 00 00       	call   bbd <printf>
        count=ls_call30();
 4dc:	e8 f7 05 00 00       	call   ad8 <ls_call30>
 4e1:	89 44 24 48          	mov    %eax,0x48(%esp)
        printf(1,"%d\t", count);
 4e5:	8b 44 24 48          	mov    0x48(%esp),%eax
 4e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 4ed:	c7 44 24 04 31 10 00 	movl   $0x1031,0x4(%esp)
 4f4:	00 
 4f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4fc:	e8 bc 06 00 00       	call   bbd <printf>

} 	
    t1=uptime();
 501:	e8 da 04 00 00       	call   9e0 <uptime>
 506:	89 44 24 44          	mov    %eax,0x44(%esp)
        for (i=0;i<1000000;i++)
 50a:	c7 44 24 4c 00 00 00 	movl   $0x0,0x4c(%esp)
 511:	00 
 512:	eb 0a                	jmp    51e <main+0x51e>
        {
            ls_call01();
 514:	e8 d7 04 00 00       	call   9f0 <ls_call01>
        count=ls_call30();
        printf(1,"%d\t", count);

} 	
    t1=uptime();
        for (i=0;i<1000000;i++)
 519:	83 44 24 4c 01       	addl   $0x1,0x4c(%esp)
 51e:	81 7c 24 4c 3f 42 0f 	cmpl   $0xf423f,0x4c(%esp)
 525:	00 
 526:	7e ec                	jle    514 <main+0x514>
        {
            ls_call01();
        }

        t2=uptime();
 528:	e8 b3 04 00 00       	call   9e0 <uptime>
 52d:	89 44 24 40          	mov    %eax,0x40(%esp)
        printf(1,"\n Time taken for 1000000 ls calls %d ticks \n", (t2-t1));
 531:	8b 44 24 44          	mov    0x44(%esp),%eax
 535:	8b 54 24 40          	mov    0x40(%esp),%edx
 539:	89 d1                	mov    %edx,%ecx
 53b:	29 c1                	sub    %eax,%ecx
 53d:	89 c8                	mov    %ecx,%eax
 53f:	89 44 24 08          	mov    %eax,0x8(%esp)
 543:	c7 44 24 04 3c 10 00 	movl   $0x103c,0x4(%esp)
 54a:	00 
 54b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 552:	e8 66 06 00 00       	call   bbd <printf>
        
        t3=uptime();
 557:	e8 84 04 00 00       	call   9e0 <uptime>
 55c:	89 44 24 3c          	mov    %eax,0x3c(%esp)
        for (i=0;i<1000000;i++)
 560:	c7 44 24 4c 00 00 00 	movl   $0x0,0x4c(%esp)
 567:	00 
 568:	eb 0a                	jmp    574 <main+0x574>
        {
            getpid();
 56a:	e8 59 04 00 00       	call   9c8 <getpid>

        t2=uptime();
        printf(1,"\n Time taken for 1000000 ls calls %d ticks \n", (t2-t1));
        
        t3=uptime();
        for (i=0;i<1000000;i++)
 56f:	83 44 24 4c 01       	addl   $0x1,0x4c(%esp)
 574:	81 7c 24 4c 3f 42 0f 	cmpl   $0xf423f,0x4c(%esp)
 57b:	00 
 57c:	7e ec                	jle    56a <main+0x56a>
        {
            getpid();
        }
        t4=uptime();
 57e:	e8 5d 04 00 00       	call   9e0 <uptime>
 583:	89 44 24 38          	mov    %eax,0x38(%esp)
        printf(1,"\n Time taken for 1000000 ls calls %d ticks \n", (t4-t3));
 587:	8b 44 24 3c          	mov    0x3c(%esp),%eax
 58b:	8b 54 24 38          	mov    0x38(%esp),%edx
 58f:	89 d1                	mov    %edx,%ecx
 591:	29 c1                	sub    %eax,%ecx
 593:	89 c8                	mov    %ecx,%eax
 595:	89 44 24 08          	mov    %eax,0x8(%esp)
 599:	c7 44 24 04 3c 10 00 	movl   $0x103c,0x4(%esp)
 5a0:	00 
 5a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a8:	e8 10 06 00 00       	call   bbd <printf>
    exit(); 
 5ad:	e8 96 03 00 00       	call   948 <exit>
 5b2:	90                   	nop
 5b3:	90                   	nop

000005b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	57                   	push   %edi
 5b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 5b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5bc:	8b 55 10             	mov    0x10(%ebp),%edx
 5bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c2:	89 cb                	mov    %ecx,%ebx
 5c4:	89 df                	mov    %ebx,%edi
 5c6:	89 d1                	mov    %edx,%ecx
 5c8:	fc                   	cld    
 5c9:	f3 aa                	rep stos %al,%es:(%edi)
 5cb:	89 ca                	mov    %ecx,%edx
 5cd:	89 fb                	mov    %edi,%ebx
 5cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
 5d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 5d5:	5b                   	pop    %ebx
 5d6:	5f                   	pop    %edi
 5d7:	5d                   	pop    %ebp
 5d8:	c3                   	ret    

000005d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 5d9:	55                   	push   %ebp
 5da:	89 e5                	mov    %esp,%ebp
 5dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 5e5:	90                   	nop
 5e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5e9:	0f b6 10             	movzbl (%eax),%edx
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	88 10                	mov    %dl,(%eax)
 5f1:	8b 45 08             	mov    0x8(%ebp),%eax
 5f4:	0f b6 00             	movzbl (%eax),%eax
 5f7:	84 c0                	test   %al,%al
 5f9:	0f 95 c0             	setne  %al
 5fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 600:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 604:	84 c0                	test   %al,%al
 606:	75 de                	jne    5e6 <strcpy+0xd>
    ;
  return os;
 608:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 60b:	c9                   	leave  
 60c:	c3                   	ret    

0000060d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 60d:	55                   	push   %ebp
 60e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 610:	eb 08                	jmp    61a <strcmp+0xd>
    p++, q++;
 612:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 616:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 61a:	8b 45 08             	mov    0x8(%ebp),%eax
 61d:	0f b6 00             	movzbl (%eax),%eax
 620:	84 c0                	test   %al,%al
 622:	74 10                	je     634 <strcmp+0x27>
 624:	8b 45 08             	mov    0x8(%ebp),%eax
 627:	0f b6 10             	movzbl (%eax),%edx
 62a:	8b 45 0c             	mov    0xc(%ebp),%eax
 62d:	0f b6 00             	movzbl (%eax),%eax
 630:	38 c2                	cmp    %al,%dl
 632:	74 de                	je     612 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 634:	8b 45 08             	mov    0x8(%ebp),%eax
 637:	0f b6 00             	movzbl (%eax),%eax
 63a:	0f b6 d0             	movzbl %al,%edx
 63d:	8b 45 0c             	mov    0xc(%ebp),%eax
 640:	0f b6 00             	movzbl (%eax),%eax
 643:	0f b6 c0             	movzbl %al,%eax
 646:	89 d1                	mov    %edx,%ecx
 648:	29 c1                	sub    %eax,%ecx
 64a:	89 c8                	mov    %ecx,%eax
}
 64c:	5d                   	pop    %ebp
 64d:	c3                   	ret    

0000064e <strlen>:

uint
strlen(char *s)
{
 64e:	55                   	push   %ebp
 64f:	89 e5                	mov    %esp,%ebp
 651:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 654:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 65b:	eb 04                	jmp    661 <strlen+0x13>
 65d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 661:	8b 55 fc             	mov    -0x4(%ebp),%edx
 664:	8b 45 08             	mov    0x8(%ebp),%eax
 667:	01 d0                	add    %edx,%eax
 669:	0f b6 00             	movzbl (%eax),%eax
 66c:	84 c0                	test   %al,%al
 66e:	75 ed                	jne    65d <strlen+0xf>
    ;
  return n;
 670:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 673:	c9                   	leave  
 674:	c3                   	ret    

00000675 <memset>:

void*
memset(void *dst, int c, uint n)
{
 675:	55                   	push   %ebp
 676:	89 e5                	mov    %esp,%ebp
 678:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 67b:	8b 45 10             	mov    0x10(%ebp),%eax
 67e:	89 44 24 08          	mov    %eax,0x8(%esp)
 682:	8b 45 0c             	mov    0xc(%ebp),%eax
 685:	89 44 24 04          	mov    %eax,0x4(%esp)
 689:	8b 45 08             	mov    0x8(%ebp),%eax
 68c:	89 04 24             	mov    %eax,(%esp)
 68f:	e8 20 ff ff ff       	call   5b4 <stosb>
  return dst;
 694:	8b 45 08             	mov    0x8(%ebp),%eax
}
 697:	c9                   	leave  
 698:	c3                   	ret    

00000699 <strchr>:

char*
strchr(const char *s, char c)
{
 699:	55                   	push   %ebp
 69a:	89 e5                	mov    %esp,%ebp
 69c:	83 ec 04             	sub    $0x4,%esp
 69f:	8b 45 0c             	mov    0xc(%ebp),%eax
 6a2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 6a5:	eb 14                	jmp    6bb <strchr+0x22>
    if(*s == c)
 6a7:	8b 45 08             	mov    0x8(%ebp),%eax
 6aa:	0f b6 00             	movzbl (%eax),%eax
 6ad:	3a 45 fc             	cmp    -0x4(%ebp),%al
 6b0:	75 05                	jne    6b7 <strchr+0x1e>
      return (char*)s;
 6b2:	8b 45 08             	mov    0x8(%ebp),%eax
 6b5:	eb 13                	jmp    6ca <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 6b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	0f b6 00             	movzbl (%eax),%eax
 6c1:	84 c0                	test   %al,%al
 6c3:	75 e2                	jne    6a7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 6c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 6ca:	c9                   	leave  
 6cb:	c3                   	ret    

000006cc <gets>:

char*
gets(char *buf, int max)
{
 6cc:	55                   	push   %ebp
 6cd:	89 e5                	mov    %esp,%ebp
 6cf:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 6d9:	eb 46                	jmp    721 <gets+0x55>
    cc = read(0, &c, 1);
 6db:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6e2:	00 
 6e3:	8d 45 ef             	lea    -0x11(%ebp),%eax
 6e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6f1:	e8 6a 02 00 00       	call   960 <read>
 6f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 6f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6fd:	7e 2f                	jle    72e <gets+0x62>
      break;
    buf[i++] = c;
 6ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
 702:	8b 45 08             	mov    0x8(%ebp),%eax
 705:	01 c2                	add    %eax,%edx
 707:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 70b:	88 02                	mov    %al,(%edx)
 70d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 711:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 715:	3c 0a                	cmp    $0xa,%al
 717:	74 16                	je     72f <gets+0x63>
 719:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 71d:	3c 0d                	cmp    $0xd,%al
 71f:	74 0e                	je     72f <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 721:	8b 45 f4             	mov    -0xc(%ebp),%eax
 724:	83 c0 01             	add    $0x1,%eax
 727:	3b 45 0c             	cmp    0xc(%ebp),%eax
 72a:	7c af                	jl     6db <gets+0xf>
 72c:	eb 01                	jmp    72f <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 72e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 72f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 732:	8b 45 08             	mov    0x8(%ebp),%eax
 735:	01 d0                	add    %edx,%eax
 737:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 73a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 73d:	c9                   	leave  
 73e:	c3                   	ret    

0000073f <stat>:

int
stat(char *n, struct stat *st)
{
 73f:	55                   	push   %ebp
 740:	89 e5                	mov    %esp,%ebp
 742:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 745:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 74c:	00 
 74d:	8b 45 08             	mov    0x8(%ebp),%eax
 750:	89 04 24             	mov    %eax,(%esp)
 753:	e8 30 02 00 00       	call   988 <open>
 758:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 75b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 75f:	79 07                	jns    768 <stat+0x29>
    return -1;
 761:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 766:	eb 23                	jmp    78b <stat+0x4c>
  r = fstat(fd, st);
 768:	8b 45 0c             	mov    0xc(%ebp),%eax
 76b:	89 44 24 04          	mov    %eax,0x4(%esp)
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	89 04 24             	mov    %eax,(%esp)
 775:	e8 26 02 00 00       	call   9a0 <fstat>
 77a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	89 04 24             	mov    %eax,(%esp)
 783:	e8 e8 01 00 00       	call   970 <close>
  return r;
 788:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 78b:	c9                   	leave  
 78c:	c3                   	ret    

0000078d <atoi>:

int
atoi(const char *s)
{
 78d:	55                   	push   %ebp
 78e:	89 e5                	mov    %esp,%ebp
 790:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 793:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 79a:	eb 23                	jmp    7bf <atoi+0x32>
    n = n*10 + *s++ - '0';
 79c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 79f:	89 d0                	mov    %edx,%eax
 7a1:	c1 e0 02             	shl    $0x2,%eax
 7a4:	01 d0                	add    %edx,%eax
 7a6:	01 c0                	add    %eax,%eax
 7a8:	89 c2                	mov    %eax,%edx
 7aa:	8b 45 08             	mov    0x8(%ebp),%eax
 7ad:	0f b6 00             	movzbl (%eax),%eax
 7b0:	0f be c0             	movsbl %al,%eax
 7b3:	01 d0                	add    %edx,%eax
 7b5:	83 e8 30             	sub    $0x30,%eax
 7b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7bb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 7bf:	8b 45 08             	mov    0x8(%ebp),%eax
 7c2:	0f b6 00             	movzbl (%eax),%eax
 7c5:	3c 2f                	cmp    $0x2f,%al
 7c7:	7e 0a                	jle    7d3 <atoi+0x46>
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
 7cc:	0f b6 00             	movzbl (%eax),%eax
 7cf:	3c 39                	cmp    $0x39,%al
 7d1:	7e c9                	jle    79c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 7d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 7d6:	c9                   	leave  
 7d7:	c3                   	ret    

000007d8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 7d8:	55                   	push   %ebp
 7d9:	89 e5                	mov    %esp,%ebp
 7db:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 7de:	8b 45 08             	mov    0x8(%ebp),%eax
 7e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 7e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 7e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 7ea:	eb 13                	jmp    7ff <memmove+0x27>
    *dst++ = *src++;
 7ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ef:	0f b6 10             	movzbl (%eax),%edx
 7f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f5:	88 10                	mov    %dl,(%eax)
 7f7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 7fb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 7ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 803:	0f 9f c0             	setg   %al
 806:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 80a:	84 c0                	test   %al,%al
 80c:	75 de                	jne    7ec <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 80e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 811:	c9                   	leave  
 812:	c3                   	ret    
 813:	90                   	nop

00000814 <SYS_ls_call01>:
 814:	6c                   	insb   (%dx),%es:(%edi)
 815:	73 5f                	jae    876 <SYS_ls_call10+0x8>
 817:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 81a:	6c                   	insb   (%dx),%es:(%edi)
 81b:	30 31                	xor    %dh,(%ecx)
	...

0000081e <SYS_ls_call02>:
 81e:	6c                   	insb   (%dx),%es:(%edi)
 81f:	73 5f                	jae    880 <SYS_ls_call11+0x8>
 821:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 824:	6c                   	insb   (%dx),%es:(%edi)
 825:	30 32                	xor    %dh,(%edx)
	...

00000828 <SYS_ls_call03>:
 828:	6c                   	insb   (%dx),%es:(%edi)
 829:	73 5f                	jae    88a <SYS_ls_call12+0x8>
 82b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 82e:	6c                   	insb   (%dx),%es:(%edi)
 82f:	30 33                	xor    %dh,(%ebx)
	...

00000832 <SYS_ls_call04>:
 832:	6c                   	insb   (%dx),%es:(%edi)
 833:	73 5f                	jae    894 <SYS_ls_call13+0x8>
 835:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 838:	6c                   	insb   (%dx),%es:(%edi)
 839:	30 34 00             	xor    %dh,(%eax,%eax,1)

0000083c <SYS_ls_call05>:
 83c:	6c                   	insb   (%dx),%es:(%edi)
 83d:	73 5f                	jae    89e <SYS_ls_call14+0x8>
 83f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 842:	6c                   	insb   (%dx),%es:(%edi)
 843:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

00000846 <SYS_ls_call06>:
 846:	6c                   	insb   (%dx),%es:(%edi)
 847:	73 5f                	jae    8a8 <SYS_ls_call15+0x8>
 849:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 84c:	6c                   	insb   (%dx),%es:(%edi)
 84d:	30 36                	xor    %dh,(%esi)
	...

00000850 <SYS_ls_call07>:
 850:	6c                   	insb   (%dx),%es:(%edi)
 851:	73 5f                	jae    8b2 <SYS_ls_call16+0x8>
 853:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 856:	6c                   	insb   (%dx),%es:(%edi)
 857:	30 37                	xor    %dh,(%edi)
	...

0000085a <SYS_ls_call08>:
 85a:	6c                   	insb   (%dx),%es:(%edi)
 85b:	73 5f                	jae    8bc <SYS_ls_call17+0x8>
 85d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 860:	6c                   	insb   (%dx),%es:(%edi)
 861:	30 38                	xor    %bh,(%eax)
	...

00000864 <SYS_ls_call09>:
 864:	6c                   	insb   (%dx),%es:(%edi)
 865:	73 5f                	jae    8c6 <SYS_ls_call18+0x8>
 867:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 86a:	6c                   	insb   (%dx),%es:(%edi)
 86b:	30 39                	xor    %bh,(%ecx)
	...

0000086e <SYS_ls_call10>:
 86e:	6c                   	insb   (%dx),%es:(%edi)
 86f:	73 5f                	jae    8d0 <SYS_ls_call19+0x8>
 871:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 874:	6c                   	insb   (%dx),%es:(%edi)
 875:	31 30                	xor    %esi,(%eax)
	...

00000878 <SYS_ls_call11>:
 878:	6c                   	insb   (%dx),%es:(%edi)
 879:	73 5f                	jae    8da <SYS_ls_call20+0x8>
 87b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 87e:	6c                   	insb   (%dx),%es:(%edi)
 87f:	31 31                	xor    %esi,(%ecx)
	...

00000882 <SYS_ls_call12>:
 882:	6c                   	insb   (%dx),%es:(%edi)
 883:	73 5f                	jae    8e4 <SYS_ls_call21+0x8>
 885:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 888:	6c                   	insb   (%dx),%es:(%edi)
 889:	31 32                	xor    %esi,(%edx)
	...

0000088c <SYS_ls_call13>:
 88c:	6c                   	insb   (%dx),%es:(%edi)
 88d:	73 5f                	jae    8ee <SYS_ls_call22+0x8>
 88f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 892:	6c                   	insb   (%dx),%es:(%edi)
 893:	31 33                	xor    %esi,(%ebx)
	...

00000896 <SYS_ls_call14>:
 896:	6c                   	insb   (%dx),%es:(%edi)
 897:	73 5f                	jae    8f8 <SYS_ls_call23+0x8>
 899:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 89c:	6c                   	insb   (%dx),%es:(%edi)
 89d:	31 34 00             	xor    %esi,(%eax,%eax,1)

000008a0 <SYS_ls_call15>:
 8a0:	6c                   	insb   (%dx),%es:(%edi)
 8a1:	73 5f                	jae    902 <SYS_ls_call24+0x8>
 8a3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8a6:	6c                   	insb   (%dx),%es:(%edi)
 8a7:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

000008aa <SYS_ls_call16>:
 8aa:	6c                   	insb   (%dx),%es:(%edi)
 8ab:	73 5f                	jae    90c <SYS_ls_call25+0x8>
 8ad:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8b0:	6c                   	insb   (%dx),%es:(%edi)
 8b1:	31 36                	xor    %esi,(%esi)
	...

000008b4 <SYS_ls_call17>:
 8b4:	6c                   	insb   (%dx),%es:(%edi)
 8b5:	73 5f                	jae    916 <SYS_ls_call26+0x8>
 8b7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8ba:	6c                   	insb   (%dx),%es:(%edi)
 8bb:	31 37                	xor    %esi,(%edi)
	...

000008be <SYS_ls_call18>:
 8be:	6c                   	insb   (%dx),%es:(%edi)
 8bf:	73 5f                	jae    920 <SYS_ls_call27+0x8>
 8c1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8c4:	6c                   	insb   (%dx),%es:(%edi)
 8c5:	31 38                	xor    %edi,(%eax)
	...

000008c8 <SYS_ls_call19>:
 8c8:	6c                   	insb   (%dx),%es:(%edi)
 8c9:	73 5f                	jae    92a <SYS_ls_call28+0x8>
 8cb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8ce:	6c                   	insb   (%dx),%es:(%edi)
 8cf:	31 39                	xor    %edi,(%ecx)
	...

000008d2 <SYS_ls_call20>:
 8d2:	6c                   	insb   (%dx),%es:(%edi)
 8d3:	73 5f                	jae    934 <SYS_ls_call29+0x8>
 8d5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8d8:	6c                   	insb   (%dx),%es:(%edi)
 8d9:	32 30                	xor    (%eax),%dh
	...

000008dc <SYS_ls_call21>:
 8dc:	6c                   	insb   (%dx),%es:(%edi)
 8dd:	73 5f                	jae    93e <SYS_ls_call30+0x8>
 8df:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8e2:	6c                   	insb   (%dx),%es:(%edi)
 8e3:	32 31                	xor    (%ecx),%dh
	...

000008e6 <SYS_ls_call22>:
 8e6:	6c                   	insb   (%dx),%es:(%edi)
 8e7:	73 5f                	jae    948 <exit>
 8e9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8ec:	6c                   	insb   (%dx),%es:(%edi)
 8ed:	32 32                	xor    (%edx),%dh
	...

000008f0 <SYS_ls_call23>:
 8f0:	6c                   	insb   (%dx),%es:(%edi)
 8f1:	73 5f                	jae    952 <wait+0x2>
 8f3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 8f6:	6c                   	insb   (%dx),%es:(%edi)
 8f7:	32 33                	xor    (%ebx),%dh
	...

000008fa <SYS_ls_call24>:
 8fa:	6c                   	insb   (%dx),%es:(%edi)
 8fb:	73 5f                	jae    95c <pipe+0x4>
 8fd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 900:	6c                   	insb   (%dx),%es:(%edi)
 901:	32 34 00             	xor    (%eax,%eax,1),%dh

00000904 <SYS_ls_call25>:
 904:	6c                   	insb   (%dx),%es:(%edi)
 905:	73 5f                	jae    966 <read+0x6>
 907:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 90a:	6c                   	insb   (%dx),%es:(%edi)
 90b:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

0000090e <SYS_ls_call26>:
 90e:	6c                   	insb   (%dx),%es:(%edi)
 90f:	73 5f                	jae    970 <close>
 911:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 914:	6c                   	insb   (%dx),%es:(%edi)
 915:	32 36                	xor    (%esi),%dh
	...

00000918 <SYS_ls_call27>:
 918:	6c                   	insb   (%dx),%es:(%edi)
 919:	73 5f                	jae    97a <kill+0x2>
 91b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 91e:	6c                   	insb   (%dx),%es:(%edi)
 91f:	32 37                	xor    (%edi),%dh
	...

00000922 <SYS_ls_call28>:
 922:	6c                   	insb   (%dx),%es:(%edi)
 923:	73 5f                	jae    984 <exec+0x4>
 925:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 928:	6c                   	insb   (%dx),%es:(%edi)
 929:	32 38                	xor    (%eax),%bh
	...

0000092c <SYS_ls_call29>:
 92c:	6c                   	insb   (%dx),%es:(%edi)
 92d:	73 5f                	jae    98e <open+0x6>
 92f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 932:	6c                   	insb   (%dx),%es:(%edi)
 933:	32 39                	xor    (%ecx),%bh
	...

00000936 <SYS_ls_call30>:
 936:	6c                   	insb   (%dx),%es:(%edi)
 937:	73 5f                	jae    998 <unlink>
 939:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 93c:	6c                   	insb   (%dx),%es:(%edi)
 93d:	33 30                	xor    (%eax),%esi
	...

00000940 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 940:	b8 01 00 00 00       	mov    $0x1,%eax
 945:	cd 40                	int    $0x40
 947:	c3                   	ret    

00000948 <exit>:
SYSCALL(exit)
 948:	b8 02 00 00 00       	mov    $0x2,%eax
 94d:	cd 40                	int    $0x40
 94f:	c3                   	ret    

00000950 <wait>:
SYSCALL(wait)
 950:	b8 03 00 00 00       	mov    $0x3,%eax
 955:	cd 40                	int    $0x40
 957:	c3                   	ret    

00000958 <pipe>:
SYSCALL(pipe)
 958:	b8 04 00 00 00       	mov    $0x4,%eax
 95d:	cd 40                	int    $0x40
 95f:	c3                   	ret    

00000960 <read>:
SYSCALL(read)
 960:	b8 05 00 00 00       	mov    $0x5,%eax
 965:	cd 40                	int    $0x40
 967:	c3                   	ret    

00000968 <write>:
SYSCALL(write)
 968:	b8 10 00 00 00       	mov    $0x10,%eax
 96d:	cd 40                	int    $0x40
 96f:	c3                   	ret    

00000970 <close>:
SYSCALL(close)
 970:	b8 15 00 00 00       	mov    $0x15,%eax
 975:	cd 40                	int    $0x40
 977:	c3                   	ret    

00000978 <kill>:
SYSCALL(kill)
 978:	b8 06 00 00 00       	mov    $0x6,%eax
 97d:	cd 40                	int    $0x40
 97f:	c3                   	ret    

00000980 <exec>:
SYSCALL(exec)
 980:	b8 07 00 00 00       	mov    $0x7,%eax
 985:	cd 40                	int    $0x40
 987:	c3                   	ret    

00000988 <open>:
SYSCALL(open)
 988:	b8 0f 00 00 00       	mov    $0xf,%eax
 98d:	cd 40                	int    $0x40
 98f:	c3                   	ret    

00000990 <mknod>:
SYSCALL(mknod)
 990:	b8 11 00 00 00       	mov    $0x11,%eax
 995:	cd 40                	int    $0x40
 997:	c3                   	ret    

00000998 <unlink>:
SYSCALL(unlink)
 998:	b8 12 00 00 00       	mov    $0x12,%eax
 99d:	cd 40                	int    $0x40
 99f:	c3                   	ret    

000009a0 <fstat>:
SYSCALL(fstat)
 9a0:	b8 08 00 00 00       	mov    $0x8,%eax
 9a5:	cd 40                	int    $0x40
 9a7:	c3                   	ret    

000009a8 <link>:
SYSCALL(link)
 9a8:	b8 13 00 00 00       	mov    $0x13,%eax
 9ad:	cd 40                	int    $0x40
 9af:	c3                   	ret    

000009b0 <mkdir>:
SYSCALL(mkdir)
 9b0:	b8 14 00 00 00       	mov    $0x14,%eax
 9b5:	cd 40                	int    $0x40
 9b7:	c3                   	ret    

000009b8 <chdir>:
SYSCALL(chdir)
 9b8:	b8 09 00 00 00       	mov    $0x9,%eax
 9bd:	cd 40                	int    $0x40
 9bf:	c3                   	ret    

000009c0 <dup>:
SYSCALL(dup)
 9c0:	b8 0a 00 00 00       	mov    $0xa,%eax
 9c5:	cd 40                	int    $0x40
 9c7:	c3                   	ret    

000009c8 <getpid>:
SYSCALL(getpid)
 9c8:	b8 0b 00 00 00       	mov    $0xb,%eax
 9cd:	cd 40                	int    $0x40
 9cf:	c3                   	ret    

000009d0 <sbrk>:
SYSCALL(sbrk)
 9d0:	b8 0c 00 00 00       	mov    $0xc,%eax
 9d5:	cd 40                	int    $0x40
 9d7:	c3                   	ret    

000009d8 <sleep>:
SYSCALL(sleep)
 9d8:	b8 0d 00 00 00       	mov    $0xd,%eax
 9dd:	cd 40                	int    $0x40
 9df:	c3                   	ret    

000009e0 <uptime>:
SYSCALL(uptime)
 9e0:	b8 0e 00 00 00       	mov    $0xe,%eax
 9e5:	cd 40                	int    $0x40
 9e7:	c3                   	ret    

000009e8 <date>:
SYSCALL(date)
 9e8:	b8 16 00 00 00       	mov    $0x16,%eax
 9ed:	cd 40                	int    $0x40
 9ef:	c3                   	ret    

000009f0 <ls_call01>:

SYSCALL1(ls_call01)
 9f0:	b8 14 08 00 00       	mov    $0x814,%eax
 9f5:	cd 41                	int    $0x41
 9f7:	c3                   	ret    

000009f8 <ls_call02>:
SYSCALL1(ls_call02)
 9f8:	b8 1e 08 00 00       	mov    $0x81e,%eax
 9fd:	cd 41                	int    $0x41
 9ff:	c3                   	ret    

00000a00 <ls_call03>:
SYSCALL1(ls_call03)
 a00:	b8 28 08 00 00       	mov    $0x828,%eax
 a05:	cd 41                	int    $0x41
 a07:	c3                   	ret    

00000a08 <ls_call04>:
SYSCALL1(ls_call04)
 a08:	b8 32 08 00 00       	mov    $0x832,%eax
 a0d:	cd 41                	int    $0x41
 a0f:	c3                   	ret    

00000a10 <ls_call05>:
SYSCALL1(ls_call05)
 a10:	b8 3c 08 00 00       	mov    $0x83c,%eax
 a15:	cd 41                	int    $0x41
 a17:	c3                   	ret    

00000a18 <ls_call06>:
SYSCALL1(ls_call06)
 a18:	b8 46 08 00 00       	mov    $0x846,%eax
 a1d:	cd 41                	int    $0x41
 a1f:	c3                   	ret    

00000a20 <ls_call07>:
SYSCALL1(ls_call07)
 a20:	b8 50 08 00 00       	mov    $0x850,%eax
 a25:	cd 41                	int    $0x41
 a27:	c3                   	ret    

00000a28 <ls_call08>:
SYSCALL1(ls_call08)
 a28:	b8 5a 08 00 00       	mov    $0x85a,%eax
 a2d:	cd 41                	int    $0x41
 a2f:	c3                   	ret    

00000a30 <ls_call09>:
SYSCALL1(ls_call09)
 a30:	b8 64 08 00 00       	mov    $0x864,%eax
 a35:	cd 41                	int    $0x41
 a37:	c3                   	ret    

00000a38 <ls_call10>:
SYSCALL1(ls_call10)
 a38:	b8 6e 08 00 00       	mov    $0x86e,%eax
 a3d:	cd 41                	int    $0x41
 a3f:	c3                   	ret    

00000a40 <ls_call11>:
SYSCALL1(ls_call11)
 a40:	b8 78 08 00 00       	mov    $0x878,%eax
 a45:	cd 41                	int    $0x41
 a47:	c3                   	ret    

00000a48 <ls_call12>:
SYSCALL1(ls_call12)
 a48:	b8 82 08 00 00       	mov    $0x882,%eax
 a4d:	cd 41                	int    $0x41
 a4f:	c3                   	ret    

00000a50 <ls_call13>:
SYSCALL1(ls_call13)
 a50:	b8 8c 08 00 00       	mov    $0x88c,%eax
 a55:	cd 41                	int    $0x41
 a57:	c3                   	ret    

00000a58 <ls_call14>:
SYSCALL1(ls_call14)
 a58:	b8 96 08 00 00       	mov    $0x896,%eax
 a5d:	cd 41                	int    $0x41
 a5f:	c3                   	ret    

00000a60 <ls_call15>:
SYSCALL1(ls_call15)
 a60:	b8 a0 08 00 00       	mov    $0x8a0,%eax
 a65:	cd 41                	int    $0x41
 a67:	c3                   	ret    

00000a68 <ls_call16>:
SYSCALL1(ls_call16)
 a68:	b8 aa 08 00 00       	mov    $0x8aa,%eax
 a6d:	cd 41                	int    $0x41
 a6f:	c3                   	ret    

00000a70 <ls_call17>:
SYSCALL1(ls_call17)
 a70:	b8 b4 08 00 00       	mov    $0x8b4,%eax
 a75:	cd 41                	int    $0x41
 a77:	c3                   	ret    

00000a78 <ls_call18>:
SYSCALL1(ls_call18)
 a78:	b8 be 08 00 00       	mov    $0x8be,%eax
 a7d:	cd 41                	int    $0x41
 a7f:	c3                   	ret    

00000a80 <ls_call19>:
SYSCALL1(ls_call19)
 a80:	b8 c8 08 00 00       	mov    $0x8c8,%eax
 a85:	cd 41                	int    $0x41
 a87:	c3                   	ret    

00000a88 <ls_call20>:
SYSCALL1(ls_call20)
 a88:	b8 d2 08 00 00       	mov    $0x8d2,%eax
 a8d:	cd 41                	int    $0x41
 a8f:	c3                   	ret    

00000a90 <ls_call21>:
SYSCALL1(ls_call21)
 a90:	b8 dc 08 00 00       	mov    $0x8dc,%eax
 a95:	cd 41                	int    $0x41
 a97:	c3                   	ret    

00000a98 <ls_call22>:
SYSCALL1(ls_call22)
 a98:	b8 e6 08 00 00       	mov    $0x8e6,%eax
 a9d:	cd 41                	int    $0x41
 a9f:	c3                   	ret    

00000aa0 <ls_call23>:
SYSCALL1(ls_call23)
 aa0:	b8 f0 08 00 00       	mov    $0x8f0,%eax
 aa5:	cd 41                	int    $0x41
 aa7:	c3                   	ret    

00000aa8 <ls_call24>:
SYSCALL1(ls_call24)
 aa8:	b8 fa 08 00 00       	mov    $0x8fa,%eax
 aad:	cd 41                	int    $0x41
 aaf:	c3                   	ret    

00000ab0 <ls_call25>:
SYSCALL1(ls_call25)
 ab0:	b8 04 09 00 00       	mov    $0x904,%eax
 ab5:	cd 41                	int    $0x41
 ab7:	c3                   	ret    

00000ab8 <ls_call26>:
SYSCALL1(ls_call26)
 ab8:	b8 0e 09 00 00       	mov    $0x90e,%eax
 abd:	cd 41                	int    $0x41
 abf:	c3                   	ret    

00000ac0 <ls_call27>:
SYSCALL1(ls_call27)
 ac0:	b8 18 09 00 00       	mov    $0x918,%eax
 ac5:	cd 41                	int    $0x41
 ac7:	c3                   	ret    

00000ac8 <ls_call28>:
SYSCALL1(ls_call28)
 ac8:	b8 22 09 00 00       	mov    $0x922,%eax
 acd:	cd 41                	int    $0x41
 acf:	c3                   	ret    

00000ad0 <ls_call29>:
SYSCALL1(ls_call29)
 ad0:	b8 2c 09 00 00       	mov    $0x92c,%eax
 ad5:	cd 41                	int    $0x41
 ad7:	c3                   	ret    

00000ad8 <ls_call30>:
SYSCALL1(ls_call30)
 ad8:	b8 36 09 00 00       	mov    $0x936,%eax
 add:	cd 41                	int    $0x41
 adf:	c3                   	ret    

00000ae0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	83 ec 28             	sub    $0x28,%esp
 ae6:	8b 45 0c             	mov    0xc(%ebp),%eax
 ae9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 aec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 af3:	00 
 af4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 af7:	89 44 24 04          	mov    %eax,0x4(%esp)
 afb:	8b 45 08             	mov    0x8(%ebp),%eax
 afe:	89 04 24             	mov    %eax,(%esp)
 b01:	e8 62 fe ff ff       	call   968 <write>
}
 b06:	c9                   	leave  
 b07:	c3                   	ret    

00000b08 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 b08:	55                   	push   %ebp
 b09:	89 e5                	mov    %esp,%ebp
 b0b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 b0e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 b15:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 b19:	74 17                	je     b32 <printint+0x2a>
 b1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 b1f:	79 11                	jns    b32 <printint+0x2a>
    neg = 1;
 b21:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 b28:	8b 45 0c             	mov    0xc(%ebp),%eax
 b2b:	f7 d8                	neg    %eax
 b2d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 b30:	eb 06                	jmp    b38 <printint+0x30>
  } else {
    x = xx;
 b32:	8b 45 0c             	mov    0xc(%ebp),%eax
 b35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 b38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 b3f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 b42:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b45:	ba 00 00 00 00       	mov    $0x0,%edx
 b4a:	f7 f1                	div    %ecx
 b4c:	89 d0                	mov    %edx,%eax
 b4e:	0f b6 80 b0 12 00 00 	movzbl 0x12b0(%eax),%eax
 b55:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 b58:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b5b:	01 ca                	add    %ecx,%edx
 b5d:	88 02                	mov    %al,(%edx)
 b5f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 b63:	8b 55 10             	mov    0x10(%ebp),%edx
 b66:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 b69:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b6c:	ba 00 00 00 00       	mov    $0x0,%edx
 b71:	f7 75 d4             	divl   -0x2c(%ebp)
 b74:	89 45 ec             	mov    %eax,-0x14(%ebp)
 b77:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 b7b:	75 c2                	jne    b3f <printint+0x37>
  if(neg)
 b7d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 b81:	74 2e                	je     bb1 <printint+0xa9>
    buf[i++] = '-';
 b83:	8d 55 dc             	lea    -0x24(%ebp),%edx
 b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b89:	01 d0                	add    %edx,%eax
 b8b:	c6 00 2d             	movb   $0x2d,(%eax)
 b8e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 b92:	eb 1d                	jmp    bb1 <printint+0xa9>
    putc(fd, buf[i]);
 b94:	8d 55 dc             	lea    -0x24(%ebp),%edx
 b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b9a:	01 d0                	add    %edx,%eax
 b9c:	0f b6 00             	movzbl (%eax),%eax
 b9f:	0f be c0             	movsbl %al,%eax
 ba2:	89 44 24 04          	mov    %eax,0x4(%esp)
 ba6:	8b 45 08             	mov    0x8(%ebp),%eax
 ba9:	89 04 24             	mov    %eax,(%esp)
 bac:	e8 2f ff ff ff       	call   ae0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 bb1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 bb5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 bb9:	79 d9                	jns    b94 <printint+0x8c>
    putc(fd, buf[i]);
}
 bbb:	c9                   	leave  
 bbc:	c3                   	ret    

00000bbd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 bbd:	55                   	push   %ebp
 bbe:	89 e5                	mov    %esp,%ebp
 bc0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 bc3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 bca:	8d 45 0c             	lea    0xc(%ebp),%eax
 bcd:	83 c0 04             	add    $0x4,%eax
 bd0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 bd3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 bda:	e9 7d 01 00 00       	jmp    d5c <printf+0x19f>
    c = fmt[i] & 0xff;
 bdf:	8b 55 0c             	mov    0xc(%ebp),%edx
 be2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 be5:	01 d0                	add    %edx,%eax
 be7:	0f b6 00             	movzbl (%eax),%eax
 bea:	0f be c0             	movsbl %al,%eax
 bed:	25 ff 00 00 00       	and    $0xff,%eax
 bf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 bf5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 bf9:	75 2c                	jne    c27 <printf+0x6a>
      if(c == '%'){
 bfb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 bff:	75 0c                	jne    c0d <printf+0x50>
        state = '%';
 c01:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 c08:	e9 4b 01 00 00       	jmp    d58 <printf+0x19b>
      } else {
        putc(fd, c);
 c0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 c10:	0f be c0             	movsbl %al,%eax
 c13:	89 44 24 04          	mov    %eax,0x4(%esp)
 c17:	8b 45 08             	mov    0x8(%ebp),%eax
 c1a:	89 04 24             	mov    %eax,(%esp)
 c1d:	e8 be fe ff ff       	call   ae0 <putc>
 c22:	e9 31 01 00 00       	jmp    d58 <printf+0x19b>
      }
    } else if(state == '%'){
 c27:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 c2b:	0f 85 27 01 00 00    	jne    d58 <printf+0x19b>
      if(c == 'd'){
 c31:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 c35:	75 2d                	jne    c64 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 c37:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c3a:	8b 00                	mov    (%eax),%eax
 c3c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 c43:	00 
 c44:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 c4b:	00 
 c4c:	89 44 24 04          	mov    %eax,0x4(%esp)
 c50:	8b 45 08             	mov    0x8(%ebp),%eax
 c53:	89 04 24             	mov    %eax,(%esp)
 c56:	e8 ad fe ff ff       	call   b08 <printint>
        ap++;
 c5b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 c5f:	e9 ed 00 00 00       	jmp    d51 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 c64:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 c68:	74 06                	je     c70 <printf+0xb3>
 c6a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 c6e:	75 2d                	jne    c9d <printf+0xe0>
        printint(fd, *ap, 16, 0);
 c70:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c73:	8b 00                	mov    (%eax),%eax
 c75:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 c7c:	00 
 c7d:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 c84:	00 
 c85:	89 44 24 04          	mov    %eax,0x4(%esp)
 c89:	8b 45 08             	mov    0x8(%ebp),%eax
 c8c:	89 04 24             	mov    %eax,(%esp)
 c8f:	e8 74 fe ff ff       	call   b08 <printint>
        ap++;
 c94:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 c98:	e9 b4 00 00 00       	jmp    d51 <printf+0x194>
      } else if(c == 's'){
 c9d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 ca1:	75 46                	jne    ce9 <printf+0x12c>
        s = (char*)*ap;
 ca3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ca6:	8b 00                	mov    (%eax),%eax
 ca8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 cab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 caf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cb3:	75 27                	jne    cdc <printf+0x11f>
          s = "(null)";
 cb5:	c7 45 f4 69 10 00 00 	movl   $0x1069,-0xc(%ebp)
        while(*s != 0){
 cbc:	eb 1e                	jmp    cdc <printf+0x11f>
          putc(fd, *s);
 cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cc1:	0f b6 00             	movzbl (%eax),%eax
 cc4:	0f be c0             	movsbl %al,%eax
 cc7:	89 44 24 04          	mov    %eax,0x4(%esp)
 ccb:	8b 45 08             	mov    0x8(%ebp),%eax
 cce:	89 04 24             	mov    %eax,(%esp)
 cd1:	e8 0a fe ff ff       	call   ae0 <putc>
          s++;
 cd6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 cda:	eb 01                	jmp    cdd <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 cdc:	90                   	nop
 cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ce0:	0f b6 00             	movzbl (%eax),%eax
 ce3:	84 c0                	test   %al,%al
 ce5:	75 d7                	jne    cbe <printf+0x101>
 ce7:	eb 68                	jmp    d51 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ce9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 ced:	75 1d                	jne    d0c <printf+0x14f>
        putc(fd, *ap);
 cef:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cf2:	8b 00                	mov    (%eax),%eax
 cf4:	0f be c0             	movsbl %al,%eax
 cf7:	89 44 24 04          	mov    %eax,0x4(%esp)
 cfb:	8b 45 08             	mov    0x8(%ebp),%eax
 cfe:	89 04 24             	mov    %eax,(%esp)
 d01:	e8 da fd ff ff       	call   ae0 <putc>
        ap++;
 d06:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 d0a:	eb 45                	jmp    d51 <printf+0x194>
      } else if(c == '%'){
 d0c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 d10:	75 17                	jne    d29 <printf+0x16c>
        putc(fd, c);
 d12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 d15:	0f be c0             	movsbl %al,%eax
 d18:	89 44 24 04          	mov    %eax,0x4(%esp)
 d1c:	8b 45 08             	mov    0x8(%ebp),%eax
 d1f:	89 04 24             	mov    %eax,(%esp)
 d22:	e8 b9 fd ff ff       	call   ae0 <putc>
 d27:	eb 28                	jmp    d51 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 d29:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 d30:	00 
 d31:	8b 45 08             	mov    0x8(%ebp),%eax
 d34:	89 04 24             	mov    %eax,(%esp)
 d37:	e8 a4 fd ff ff       	call   ae0 <putc>
        putc(fd, c);
 d3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 d3f:	0f be c0             	movsbl %al,%eax
 d42:	89 44 24 04          	mov    %eax,0x4(%esp)
 d46:	8b 45 08             	mov    0x8(%ebp),%eax
 d49:	89 04 24             	mov    %eax,(%esp)
 d4c:	e8 8f fd ff ff       	call   ae0 <putc>
      }
      state = 0;
 d51:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d58:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 d5c:	8b 55 0c             	mov    0xc(%ebp),%edx
 d5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d62:	01 d0                	add    %edx,%eax
 d64:	0f b6 00             	movzbl (%eax),%eax
 d67:	84 c0                	test   %al,%al
 d69:	0f 85 70 fe ff ff    	jne    bdf <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 d6f:	c9                   	leave  
 d70:	c3                   	ret    
 d71:	90                   	nop
 d72:	90                   	nop
 d73:	90                   	nop

00000d74 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d74:	55                   	push   %ebp
 d75:	89 e5                	mov    %esp,%ebp
 d77:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d7a:	8b 45 08             	mov    0x8(%ebp),%eax
 d7d:	83 e8 08             	sub    $0x8,%eax
 d80:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d83:	a1 cc 12 00 00       	mov    0x12cc,%eax
 d88:	89 45 fc             	mov    %eax,-0x4(%ebp)
 d8b:	eb 24                	jmp    db1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d90:	8b 00                	mov    (%eax),%eax
 d92:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 d95:	77 12                	ja     da9 <free+0x35>
 d97:	8b 45 f8             	mov    -0x8(%ebp),%eax
 d9a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 d9d:	77 24                	ja     dc3 <free+0x4f>
 d9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 da2:	8b 00                	mov    (%eax),%eax
 da4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 da7:	77 1a                	ja     dc3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 da9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 dac:	8b 00                	mov    (%eax),%eax
 dae:	89 45 fc             	mov    %eax,-0x4(%ebp)
 db1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 db4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 db7:	76 d4                	jbe    d8d <free+0x19>
 db9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 dbc:	8b 00                	mov    (%eax),%eax
 dbe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 dc1:	76 ca                	jbe    d8d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 dc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 dc6:	8b 40 04             	mov    0x4(%eax),%eax
 dc9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 dd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 dd3:	01 c2                	add    %eax,%edx
 dd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 dd8:	8b 00                	mov    (%eax),%eax
 dda:	39 c2                	cmp    %eax,%edx
 ddc:	75 24                	jne    e02 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 dde:	8b 45 f8             	mov    -0x8(%ebp),%eax
 de1:	8b 50 04             	mov    0x4(%eax),%edx
 de4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 de7:	8b 00                	mov    (%eax),%eax
 de9:	8b 40 04             	mov    0x4(%eax),%eax
 dec:	01 c2                	add    %eax,%edx
 dee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 df1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 df4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 df7:	8b 00                	mov    (%eax),%eax
 df9:	8b 10                	mov    (%eax),%edx
 dfb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 dfe:	89 10                	mov    %edx,(%eax)
 e00:	eb 0a                	jmp    e0c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 e02:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e05:	8b 10                	mov    (%eax),%edx
 e07:	8b 45 f8             	mov    -0x8(%ebp),%eax
 e0a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 e0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e0f:	8b 40 04             	mov    0x4(%eax),%eax
 e12:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 e19:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e1c:	01 d0                	add    %edx,%eax
 e1e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 e21:	75 20                	jne    e43 <free+0xcf>
    p->s.size += bp->s.size;
 e23:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e26:	8b 50 04             	mov    0x4(%eax),%edx
 e29:	8b 45 f8             	mov    -0x8(%ebp),%eax
 e2c:	8b 40 04             	mov    0x4(%eax),%eax
 e2f:	01 c2                	add    %eax,%edx
 e31:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e34:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e37:	8b 45 f8             	mov    -0x8(%ebp),%eax
 e3a:	8b 10                	mov    (%eax),%edx
 e3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e3f:	89 10                	mov    %edx,(%eax)
 e41:	eb 08                	jmp    e4b <free+0xd7>
  } else
    p->s.ptr = bp;
 e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e46:	8b 55 f8             	mov    -0x8(%ebp),%edx
 e49:	89 10                	mov    %edx,(%eax)
  freep = p;
 e4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 e4e:	a3 cc 12 00 00       	mov    %eax,0x12cc
}
 e53:	c9                   	leave  
 e54:	c3                   	ret    

00000e55 <morecore>:

static Header*
morecore(uint nu)
{
 e55:	55                   	push   %ebp
 e56:	89 e5                	mov    %esp,%ebp
 e58:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 e5b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 e62:	77 07                	ja     e6b <morecore+0x16>
    nu = 4096;
 e64:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 e6b:	8b 45 08             	mov    0x8(%ebp),%eax
 e6e:	c1 e0 03             	shl    $0x3,%eax
 e71:	89 04 24             	mov    %eax,(%esp)
 e74:	e8 57 fb ff ff       	call   9d0 <sbrk>
 e79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 e7c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 e80:	75 07                	jne    e89 <morecore+0x34>
    return 0;
 e82:	b8 00 00 00 00       	mov    $0x0,%eax
 e87:	eb 22                	jmp    eab <morecore+0x56>
  hp = (Header*)p;
 e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 e8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 e92:	8b 55 08             	mov    0x8(%ebp),%edx
 e95:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 e98:	8b 45 f0             	mov    -0x10(%ebp),%eax
 e9b:	83 c0 08             	add    $0x8,%eax
 e9e:	89 04 24             	mov    %eax,(%esp)
 ea1:	e8 ce fe ff ff       	call   d74 <free>
  return freep;
 ea6:	a1 cc 12 00 00       	mov    0x12cc,%eax
}
 eab:	c9                   	leave  
 eac:	c3                   	ret    

00000ead <malloc>:

void*
malloc(uint nbytes)
{
 ead:	55                   	push   %ebp
 eae:	89 e5                	mov    %esp,%ebp
 eb0:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eb3:	8b 45 08             	mov    0x8(%ebp),%eax
 eb6:	83 c0 07             	add    $0x7,%eax
 eb9:	c1 e8 03             	shr    $0x3,%eax
 ebc:	83 c0 01             	add    $0x1,%eax
 ebf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 ec2:	a1 cc 12 00 00       	mov    0x12cc,%eax
 ec7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 eca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 ece:	75 23                	jne    ef3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 ed0:	c7 45 f0 c4 12 00 00 	movl   $0x12c4,-0x10(%ebp)
 ed7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 eda:	a3 cc 12 00 00       	mov    %eax,0x12cc
 edf:	a1 cc 12 00 00       	mov    0x12cc,%eax
 ee4:	a3 c4 12 00 00       	mov    %eax,0x12c4
    base.s.size = 0;
 ee9:	c7 05 c8 12 00 00 00 	movl   $0x0,0x12c8
 ef0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ef6:	8b 00                	mov    (%eax),%eax
 ef8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 efb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 efe:	8b 40 04             	mov    0x4(%eax),%eax
 f01:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 f04:	72 4d                	jb     f53 <malloc+0xa6>
      if(p->s.size == nunits)
 f06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f09:	8b 40 04             	mov    0x4(%eax),%eax
 f0c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 f0f:	75 0c                	jne    f1d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f14:	8b 10                	mov    (%eax),%edx
 f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
 f19:	89 10                	mov    %edx,(%eax)
 f1b:	eb 26                	jmp    f43 <malloc+0x96>
      else {
        p->s.size -= nunits;
 f1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f20:	8b 40 04             	mov    0x4(%eax),%eax
 f23:	89 c2                	mov    %eax,%edx
 f25:	2b 55 ec             	sub    -0x14(%ebp),%edx
 f28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f2b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 f2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f31:	8b 40 04             	mov    0x4(%eax),%eax
 f34:	c1 e0 03             	shl    $0x3,%eax
 f37:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 f3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f3d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 f40:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 f43:	8b 45 f0             	mov    -0x10(%ebp),%eax
 f46:	a3 cc 12 00 00       	mov    %eax,0x12cc
      return (void*)(p + 1);
 f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f4e:	83 c0 08             	add    $0x8,%eax
 f51:	eb 38                	jmp    f8b <malloc+0xde>
    }
    if(p == freep)
 f53:	a1 cc 12 00 00       	mov    0x12cc,%eax
 f58:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 f5b:	75 1b                	jne    f78 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 f5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f60:	89 04 24             	mov    %eax,(%esp)
 f63:	e8 ed fe ff ff       	call   e55 <morecore>
 f68:	89 45 f4             	mov    %eax,-0xc(%ebp)
 f6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 f6f:	75 07                	jne    f78 <malloc+0xcb>
        return 0;
 f71:	b8 00 00 00 00       	mov    $0x0,%eax
 f76:	eb 13                	jmp    f8b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 f7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 f81:	8b 00                	mov    (%eax),%eax
 f83:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 f86:	e9 70 ff ff ff       	jmp    efb <malloc+0x4e>
}
 f8b:	c9                   	leave  
 f8c:	c3                   	ret    
