
_call100:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "traps.h"


int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp

	int d =0;
   9:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  10:	00 
  if (argc > 1)
  11:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  15:	7e 19                	jle    30 <main+0x30>
  	printf(1,"Too many arguments!\n");
  17:	c7 44 24 04 89 0e 00 	movl   $0xe89,0x4(%esp)
  1e:	00 
  1f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  26:	e8 8e 0a 00 00       	call   ab9 <printf>
  2b:	e9 7b 04 00 00       	jmp    4ab <main+0x4ab>
  else
  {
  d=ls_call01();
  30:	e8 b7 08 00 00       	call   8ec <ls_call01>
  35:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
  39:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  3d:	89 44 24 08          	mov    %eax,0x8(%esp)
  41:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
  48:	00 
  49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  50:	e8 64 0a 00 00       	call   ab9 <printf>
 d=ls_call02();
  55:	e8 9a 08 00 00       	call   8f4 <ls_call02>
  5a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
  5e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  62:	89 44 24 08          	mov    %eax,0x8(%esp)
  66:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
  6d:	00 
  6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  75:	e8 3f 0a 00 00       	call   ab9 <printf>
  d=ls_call03();
  7a:	e8 7d 08 00 00       	call   8fc <ls_call03>
  7f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
  83:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  87:	89 44 24 08          	mov    %eax,0x8(%esp)
  8b:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
  92:	00 
  93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9a:	e8 1a 0a 00 00       	call   ab9 <printf>
  d=ls_call04();
  9f:	e8 60 08 00 00       	call   904 <ls_call04>
  a4:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
  a8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  ac:	89 44 24 08          	mov    %eax,0x8(%esp)
  b0:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
  b7:	00 
  b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  bf:	e8 f5 09 00 00       	call   ab9 <printf>
  d=ls_call05();
  c4:	e8 43 08 00 00       	call   90c <ls_call05>
  c9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
  cd:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  d1:	89 44 24 08          	mov    %eax,0x8(%esp)
  d5:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e4:	e8 d0 09 00 00       	call   ab9 <printf>
  d=ls_call06();
  e9:	e8 26 08 00 00       	call   914 <ls_call06>
  ee:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
  f2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  f6:	89 44 24 08          	mov    %eax,0x8(%esp)
  fa:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 101:	00 
 102:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 109:	e8 ab 09 00 00       	call   ab9 <printf>
 d=ls_call07();
 10e:	e8 09 08 00 00       	call   91c <ls_call07>
 113:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 117:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 11b:	89 44 24 08          	mov    %eax,0x8(%esp)
 11f:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 126:	00 
 127:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12e:	e8 86 09 00 00       	call   ab9 <printf>
 d=ls_call07();
 133:	e8 e4 07 00 00       	call   91c <ls_call07>
 138:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 printf(1,"Call %d\n", d);  
 13c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 140:	89 44 24 08          	mov    %eax,0x8(%esp)
 144:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 14b:	00 
 14c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 153:	e8 61 09 00 00       	call   ab9 <printf>
 d=ls_call08();
 158:	e8 c7 07 00 00       	call   924 <ls_call08>
 15d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 161:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 165:	89 44 24 08          	mov    %eax,0x8(%esp)
 169:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 170:	00 
 171:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 178:	e8 3c 09 00 00       	call   ab9 <printf>
 d=ls_call09();
 17d:	e8 aa 07 00 00       	call   92c <ls_call09>
 182:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 186:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 18a:	89 44 24 08          	mov    %eax,0x8(%esp)
 18e:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 195:	00 
 196:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 19d:	e8 17 09 00 00       	call   ab9 <printf>
 d=ls_call10();
 1a2:	e8 8d 07 00 00       	call   934 <ls_call10>
 1a7:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 1ab:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1af:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b3:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 1ba:	00 
 1bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c2:	e8 f2 08 00 00       	call   ab9 <printf>
 d=ls_call11();
 1c7:	e8 70 07 00 00       	call   93c <ls_call11>
 1cc:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 1d0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1d4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d8:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 1df:	00 
 1e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1e7:	e8 cd 08 00 00       	call   ab9 <printf>
 d=ls_call12();
 1ec:	e8 53 07 00 00       	call   944 <ls_call12>
 1f1:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 1f5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1f9:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fd:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 204:	00 
 205:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 20c:	e8 a8 08 00 00       	call   ab9 <printf>
 d=ls_call13();
 211:	e8 36 07 00 00       	call   94c <ls_call13>
 216:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 21a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 21e:	89 44 24 08          	mov    %eax,0x8(%esp)
 222:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 229:	00 
 22a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 231:	e8 83 08 00 00       	call   ab9 <printf>
 d=ls_call14();
 236:	e8 19 07 00 00       	call   954 <ls_call14>
 23b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 23f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 243:	89 44 24 08          	mov    %eax,0x8(%esp)
 247:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 24e:	00 
 24f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 256:	e8 5e 08 00 00       	call   ab9 <printf>
 d=ls_call15();
 25b:	e8 fc 06 00 00       	call   95c <ls_call15>
 260:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 264:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 268:	89 44 24 08          	mov    %eax,0x8(%esp)
 26c:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 273:	00 
 274:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 27b:	e8 39 08 00 00       	call   ab9 <printf>
 d=ls_call16();
 280:	e8 df 06 00 00       	call   964 <ls_call16>
 285:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 289:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 28d:	89 44 24 08          	mov    %eax,0x8(%esp)
 291:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 298:	00 
 299:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a0:	e8 14 08 00 00       	call   ab9 <printf>
 d=ls_call17();
 2a5:	e8 c2 06 00 00       	call   96c <ls_call17>
 2aa:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 2ae:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 2b2:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b6:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 2bd:	00 
 2be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2c5:	e8 ef 07 00 00       	call   ab9 <printf>
 d=ls_call18();
 2ca:	e8 a5 06 00 00       	call   974 <ls_call18>
 2cf:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 2d3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 2d7:	89 44 24 08          	mov    %eax,0x8(%esp)
 2db:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 2e2:	00 
 2e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ea:	e8 ca 07 00 00       	call   ab9 <printf>
 d=ls_call19();
 2ef:	e8 88 06 00 00       	call   97c <ls_call19>
 2f4:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 2f8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 2fc:	89 44 24 08          	mov    %eax,0x8(%esp)
 300:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 307:	00 
 308:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 30f:	e8 a5 07 00 00       	call   ab9 <printf>
 d=ls_call20();
 314:	e8 6b 06 00 00       	call   984 <ls_call20>
 319:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 31d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 321:	89 44 24 08          	mov    %eax,0x8(%esp)
 325:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 32c:	00 
 32d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 334:	e8 80 07 00 00       	call   ab9 <printf>
 d=ls_call21();
 339:	e8 4e 06 00 00       	call   98c <ls_call21>
 33e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 342:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 346:	89 44 24 08          	mov    %eax,0x8(%esp)
 34a:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 351:	00 
 352:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 359:	e8 5b 07 00 00       	call   ab9 <printf>
 d=ls_call22();
 35e:	e8 31 06 00 00       	call   994 <ls_call22>
 363:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 367:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 36b:	89 44 24 08          	mov    %eax,0x8(%esp)
 36f:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 376:	00 
 377:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 37e:	e8 36 07 00 00       	call   ab9 <printf>
 d=ls_call23();
 383:	e8 14 06 00 00       	call   99c <ls_call23>
 388:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 38c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 390:	89 44 24 08          	mov    %eax,0x8(%esp)
 394:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 39b:	00 
 39c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3a3:	e8 11 07 00 00       	call   ab9 <printf>
 d=ls_call24();
 3a8:	e8 f7 05 00 00       	call   9a4 <ls_call24>
 3ad:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 3b1:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 3b5:	89 44 24 08          	mov    %eax,0x8(%esp)
 3b9:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 3c0:	00 
 3c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3c8:	e8 ec 06 00 00       	call   ab9 <printf>
 d=ls_call25();
 3cd:	e8 da 05 00 00       	call   9ac <ls_call25>
 3d2:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 3d6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 3da:	89 44 24 08          	mov    %eax,0x8(%esp)
 3de:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 3e5:	00 
 3e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3ed:	e8 c7 06 00 00       	call   ab9 <printf>
 d=ls_call26();
 3f2:	e8 bd 05 00 00       	call   9b4 <ls_call26>
 3f7:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 3fb:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 3ff:	89 44 24 08          	mov    %eax,0x8(%esp)
 403:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 40a:	00 
 40b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 412:	e8 a2 06 00 00       	call   ab9 <printf>
 d=ls_call27();
 417:	e8 a0 05 00 00       	call   9bc <ls_call27>
 41c:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 420:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 424:	89 44 24 08          	mov    %eax,0x8(%esp)
 428:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 42f:	00 
 430:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 437:	e8 7d 06 00 00       	call   ab9 <printf>
 d=ls_call28();
 43c:	e8 83 05 00 00       	call   9c4 <ls_call28>
 441:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 445:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 449:	89 44 24 08          	mov    %eax,0x8(%esp)
 44d:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 454:	00 
 455:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 45c:	e8 58 06 00 00       	call   ab9 <printf>
 d=ls_call29();
 461:	e8 66 05 00 00       	call   9cc <ls_call29>
 466:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 46a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 46e:	89 44 24 08          	mov    %eax,0x8(%esp)
 472:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 479:	00 
 47a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 481:	e8 33 06 00 00       	call   ab9 <printf>
 d=ls_call30();
 486:	e8 49 05 00 00       	call   9d4 <ls_call30>
 48b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(1,"Call %d\n", d);
 48f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 493:	89 44 24 08          	mov    %eax,0x8(%esp)
 497:	c7 44 24 04 9e 0e 00 	movl   $0xe9e,0x4(%esp)
 49e:	00 
 49f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4a6:	e8 0e 06 00 00       	call   ab9 <printf>
 }
  exit(); 
 4ab:	e8 94 03 00 00       	call   844 <exit>

000004b0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 4b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4b8:	8b 55 10             	mov    0x10(%ebp),%edx
 4bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 4be:	89 cb                	mov    %ecx,%ebx
 4c0:	89 df                	mov    %ebx,%edi
 4c2:	89 d1                	mov    %edx,%ecx
 4c4:	fc                   	cld    
 4c5:	f3 aa                	rep stos %al,%es:(%edi)
 4c7:	89 ca                	mov    %ecx,%edx
 4c9:	89 fb                	mov    %edi,%ebx
 4cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
 4ce:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 4d1:	5b                   	pop    %ebx
 4d2:	5f                   	pop    %edi
 4d3:	5d                   	pop    %ebp
 4d4:	c3                   	ret    

000004d5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 4d5:	55                   	push   %ebp
 4d6:	89 e5                	mov    %esp,%ebp
 4d8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 4db:	8b 45 08             	mov    0x8(%ebp),%eax
 4de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 4e1:	90                   	nop
 4e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e5:	0f b6 10             	movzbl (%eax),%edx
 4e8:	8b 45 08             	mov    0x8(%ebp),%eax
 4eb:	88 10                	mov    %dl,(%eax)
 4ed:	8b 45 08             	mov    0x8(%ebp),%eax
 4f0:	0f b6 00             	movzbl (%eax),%eax
 4f3:	84 c0                	test   %al,%al
 4f5:	0f 95 c0             	setne  %al
 4f8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4fc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 500:	84 c0                	test   %al,%al
 502:	75 de                	jne    4e2 <strcpy+0xd>
    ;
  return os;
 504:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 507:	c9                   	leave  
 508:	c3                   	ret    

00000509 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 509:	55                   	push   %ebp
 50a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 50c:	eb 08                	jmp    516 <strcmp+0xd>
    p++, q++;
 50e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 512:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 516:	8b 45 08             	mov    0x8(%ebp),%eax
 519:	0f b6 00             	movzbl (%eax),%eax
 51c:	84 c0                	test   %al,%al
 51e:	74 10                	je     530 <strcmp+0x27>
 520:	8b 45 08             	mov    0x8(%ebp),%eax
 523:	0f b6 10             	movzbl (%eax),%edx
 526:	8b 45 0c             	mov    0xc(%ebp),%eax
 529:	0f b6 00             	movzbl (%eax),%eax
 52c:	38 c2                	cmp    %al,%dl
 52e:	74 de                	je     50e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 530:	8b 45 08             	mov    0x8(%ebp),%eax
 533:	0f b6 00             	movzbl (%eax),%eax
 536:	0f b6 d0             	movzbl %al,%edx
 539:	8b 45 0c             	mov    0xc(%ebp),%eax
 53c:	0f b6 00             	movzbl (%eax),%eax
 53f:	0f b6 c0             	movzbl %al,%eax
 542:	89 d1                	mov    %edx,%ecx
 544:	29 c1                	sub    %eax,%ecx
 546:	89 c8                	mov    %ecx,%eax
}
 548:	5d                   	pop    %ebp
 549:	c3                   	ret    

0000054a <strlen>:

uint
strlen(char *s)
{
 54a:	55                   	push   %ebp
 54b:	89 e5                	mov    %esp,%ebp
 54d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 550:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 557:	eb 04                	jmp    55d <strlen+0x13>
 559:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 55d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 560:	8b 45 08             	mov    0x8(%ebp),%eax
 563:	01 d0                	add    %edx,%eax
 565:	0f b6 00             	movzbl (%eax),%eax
 568:	84 c0                	test   %al,%al
 56a:	75 ed                	jne    559 <strlen+0xf>
    ;
  return n;
 56c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 56f:	c9                   	leave  
 570:	c3                   	ret    

00000571 <memset>:

void*
memset(void *dst, int c, uint n)
{
 571:	55                   	push   %ebp
 572:	89 e5                	mov    %esp,%ebp
 574:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 577:	8b 45 10             	mov    0x10(%ebp),%eax
 57a:	89 44 24 08          	mov    %eax,0x8(%esp)
 57e:	8b 45 0c             	mov    0xc(%ebp),%eax
 581:	89 44 24 04          	mov    %eax,0x4(%esp)
 585:	8b 45 08             	mov    0x8(%ebp),%eax
 588:	89 04 24             	mov    %eax,(%esp)
 58b:	e8 20 ff ff ff       	call   4b0 <stosb>
  return dst;
 590:	8b 45 08             	mov    0x8(%ebp),%eax
}
 593:	c9                   	leave  
 594:	c3                   	ret    

00000595 <strchr>:

char*
strchr(const char *s, char c)
{
 595:	55                   	push   %ebp
 596:	89 e5                	mov    %esp,%ebp
 598:	83 ec 04             	sub    $0x4,%esp
 59b:	8b 45 0c             	mov    0xc(%ebp),%eax
 59e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 5a1:	eb 14                	jmp    5b7 <strchr+0x22>
    if(*s == c)
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	0f b6 00             	movzbl (%eax),%eax
 5a9:	3a 45 fc             	cmp    -0x4(%ebp),%al
 5ac:	75 05                	jne    5b3 <strchr+0x1e>
      return (char*)s;
 5ae:	8b 45 08             	mov    0x8(%ebp),%eax
 5b1:	eb 13                	jmp    5c6 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 5b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	0f b6 00             	movzbl (%eax),%eax
 5bd:	84 c0                	test   %al,%al
 5bf:	75 e2                	jne    5a3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 5c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 5c6:	c9                   	leave  
 5c7:	c3                   	ret    

000005c8 <gets>:

char*
gets(char *buf, int max)
{
 5c8:	55                   	push   %ebp
 5c9:	89 e5                	mov    %esp,%ebp
 5cb:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 5d5:	eb 46                	jmp    61d <gets+0x55>
    cc = read(0, &c, 1);
 5d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5de:	00 
 5df:	8d 45 ef             	lea    -0x11(%ebp),%eax
 5e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5ed:	e8 6a 02 00 00       	call   85c <read>
 5f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 5f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5f9:	7e 2f                	jle    62a <gets+0x62>
      break;
    buf[i++] = c;
 5fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	01 c2                	add    %eax,%edx
 603:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 607:	88 02                	mov    %al,(%edx)
 609:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 60d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 611:	3c 0a                	cmp    $0xa,%al
 613:	74 16                	je     62b <gets+0x63>
 615:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 619:	3c 0d                	cmp    $0xd,%al
 61b:	74 0e                	je     62b <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 61d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 620:	83 c0 01             	add    $0x1,%eax
 623:	3b 45 0c             	cmp    0xc(%ebp),%eax
 626:	7c af                	jl     5d7 <gets+0xf>
 628:	eb 01                	jmp    62b <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 62a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 62b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 62e:	8b 45 08             	mov    0x8(%ebp),%eax
 631:	01 d0                	add    %edx,%eax
 633:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 636:	8b 45 08             	mov    0x8(%ebp),%eax
}
 639:	c9                   	leave  
 63a:	c3                   	ret    

0000063b <stat>:

int
stat(char *n, struct stat *st)
{
 63b:	55                   	push   %ebp
 63c:	89 e5                	mov    %esp,%ebp
 63e:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 641:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 648:	00 
 649:	8b 45 08             	mov    0x8(%ebp),%eax
 64c:	89 04 24             	mov    %eax,(%esp)
 64f:	e8 30 02 00 00       	call   884 <open>
 654:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 657:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 65b:	79 07                	jns    664 <stat+0x29>
    return -1;
 65d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 662:	eb 23                	jmp    687 <stat+0x4c>
  r = fstat(fd, st);
 664:	8b 45 0c             	mov    0xc(%ebp),%eax
 667:	89 44 24 04          	mov    %eax,0x4(%esp)
 66b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66e:	89 04 24             	mov    %eax,(%esp)
 671:	e8 26 02 00 00       	call   89c <fstat>
 676:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 679:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67c:	89 04 24             	mov    %eax,(%esp)
 67f:	e8 e8 01 00 00       	call   86c <close>
  return r;
 684:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 687:	c9                   	leave  
 688:	c3                   	ret    

00000689 <atoi>:

int
atoi(const char *s)
{
 689:	55                   	push   %ebp
 68a:	89 e5                	mov    %esp,%ebp
 68c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 68f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 696:	eb 23                	jmp    6bb <atoi+0x32>
    n = n*10 + *s++ - '0';
 698:	8b 55 fc             	mov    -0x4(%ebp),%edx
 69b:	89 d0                	mov    %edx,%eax
 69d:	c1 e0 02             	shl    $0x2,%eax
 6a0:	01 d0                	add    %edx,%eax
 6a2:	01 c0                	add    %eax,%eax
 6a4:	89 c2                	mov    %eax,%edx
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
 6a9:	0f b6 00             	movzbl (%eax),%eax
 6ac:	0f be c0             	movsbl %al,%eax
 6af:	01 d0                	add    %edx,%eax
 6b1:	83 e8 30             	sub    $0x30,%eax
 6b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	0f b6 00             	movzbl (%eax),%eax
 6c1:	3c 2f                	cmp    $0x2f,%al
 6c3:	7e 0a                	jle    6cf <atoi+0x46>
 6c5:	8b 45 08             	mov    0x8(%ebp),%eax
 6c8:	0f b6 00             	movzbl (%eax),%eax
 6cb:	3c 39                	cmp    $0x39,%al
 6cd:	7e c9                	jle    698 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 6d2:	c9                   	leave  
 6d3:	c3                   	ret    

000006d4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 6d4:	55                   	push   %ebp
 6d5:	89 e5                	mov    %esp,%ebp
 6d7:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 6da:	8b 45 08             	mov    0x8(%ebp),%eax
 6dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 6e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 6e6:	eb 13                	jmp    6fb <memmove+0x27>
    *dst++ = *src++;
 6e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6eb:	0f b6 10             	movzbl (%eax),%edx
 6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f1:	88 10                	mov    %dl,(%eax)
 6f3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 6f7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 6ff:	0f 9f c0             	setg   %al
 702:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 706:	84 c0                	test   %al,%al
 708:	75 de                	jne    6e8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 70a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 70d:	c9                   	leave  
 70e:	c3                   	ret    
 70f:	90                   	nop

00000710 <SYS_ls_call01>:
 710:	6c                   	insb   (%dx),%es:(%edi)
 711:	73 5f                	jae    772 <SYS_ls_call10+0x8>
 713:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 716:	6c                   	insb   (%dx),%es:(%edi)
 717:	30 31                	xor    %dh,(%ecx)
	...

0000071a <SYS_ls_call02>:
 71a:	6c                   	insb   (%dx),%es:(%edi)
 71b:	73 5f                	jae    77c <SYS_ls_call11+0x8>
 71d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 720:	6c                   	insb   (%dx),%es:(%edi)
 721:	30 32                	xor    %dh,(%edx)
	...

00000724 <SYS_ls_call03>:
 724:	6c                   	insb   (%dx),%es:(%edi)
 725:	73 5f                	jae    786 <SYS_ls_call12+0x8>
 727:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 72a:	6c                   	insb   (%dx),%es:(%edi)
 72b:	30 33                	xor    %dh,(%ebx)
	...

0000072e <SYS_ls_call04>:
 72e:	6c                   	insb   (%dx),%es:(%edi)
 72f:	73 5f                	jae    790 <SYS_ls_call13+0x8>
 731:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 734:	6c                   	insb   (%dx),%es:(%edi)
 735:	30 34 00             	xor    %dh,(%eax,%eax,1)

00000738 <SYS_ls_call05>:
 738:	6c                   	insb   (%dx),%es:(%edi)
 739:	73 5f                	jae    79a <SYS_ls_call14+0x8>
 73b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 73e:	6c                   	insb   (%dx),%es:(%edi)
 73f:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

00000742 <SYS_ls_call06>:
 742:	6c                   	insb   (%dx),%es:(%edi)
 743:	73 5f                	jae    7a4 <SYS_ls_call15+0x8>
 745:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 748:	6c                   	insb   (%dx),%es:(%edi)
 749:	30 36                	xor    %dh,(%esi)
	...

0000074c <SYS_ls_call07>:
 74c:	6c                   	insb   (%dx),%es:(%edi)
 74d:	73 5f                	jae    7ae <SYS_ls_call16+0x8>
 74f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 752:	6c                   	insb   (%dx),%es:(%edi)
 753:	30 37                	xor    %dh,(%edi)
	...

00000756 <SYS_ls_call08>:
 756:	6c                   	insb   (%dx),%es:(%edi)
 757:	73 5f                	jae    7b8 <SYS_ls_call17+0x8>
 759:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 75c:	6c                   	insb   (%dx),%es:(%edi)
 75d:	30 38                	xor    %bh,(%eax)
	...

00000760 <SYS_ls_call09>:
 760:	6c                   	insb   (%dx),%es:(%edi)
 761:	73 5f                	jae    7c2 <SYS_ls_call18+0x8>
 763:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 766:	6c                   	insb   (%dx),%es:(%edi)
 767:	30 39                	xor    %bh,(%ecx)
	...

0000076a <SYS_ls_call10>:
 76a:	6c                   	insb   (%dx),%es:(%edi)
 76b:	73 5f                	jae    7cc <SYS_ls_call19+0x8>
 76d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 770:	6c                   	insb   (%dx),%es:(%edi)
 771:	31 30                	xor    %esi,(%eax)
	...

00000774 <SYS_ls_call11>:
 774:	6c                   	insb   (%dx),%es:(%edi)
 775:	73 5f                	jae    7d6 <SYS_ls_call20+0x8>
 777:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 77a:	6c                   	insb   (%dx),%es:(%edi)
 77b:	31 31                	xor    %esi,(%ecx)
	...

0000077e <SYS_ls_call12>:
 77e:	6c                   	insb   (%dx),%es:(%edi)
 77f:	73 5f                	jae    7e0 <SYS_ls_call21+0x8>
 781:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 784:	6c                   	insb   (%dx),%es:(%edi)
 785:	31 32                	xor    %esi,(%edx)
	...

00000788 <SYS_ls_call13>:
 788:	6c                   	insb   (%dx),%es:(%edi)
 789:	73 5f                	jae    7ea <SYS_ls_call22+0x8>
 78b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 78e:	6c                   	insb   (%dx),%es:(%edi)
 78f:	31 33                	xor    %esi,(%ebx)
	...

00000792 <SYS_ls_call14>:
 792:	6c                   	insb   (%dx),%es:(%edi)
 793:	73 5f                	jae    7f4 <SYS_ls_call23+0x8>
 795:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 798:	6c                   	insb   (%dx),%es:(%edi)
 799:	31 34 00             	xor    %esi,(%eax,%eax,1)

0000079c <SYS_ls_call15>:
 79c:	6c                   	insb   (%dx),%es:(%edi)
 79d:	73 5f                	jae    7fe <SYS_ls_call24+0x8>
 79f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7a2:	6c                   	insb   (%dx),%es:(%edi)
 7a3:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

000007a6 <SYS_ls_call16>:
 7a6:	6c                   	insb   (%dx),%es:(%edi)
 7a7:	73 5f                	jae    808 <SYS_ls_call25+0x8>
 7a9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7ac:	6c                   	insb   (%dx),%es:(%edi)
 7ad:	31 36                	xor    %esi,(%esi)
	...

000007b0 <SYS_ls_call17>:
 7b0:	6c                   	insb   (%dx),%es:(%edi)
 7b1:	73 5f                	jae    812 <SYS_ls_call26+0x8>
 7b3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7b6:	6c                   	insb   (%dx),%es:(%edi)
 7b7:	31 37                	xor    %esi,(%edi)
	...

000007ba <SYS_ls_call18>:
 7ba:	6c                   	insb   (%dx),%es:(%edi)
 7bb:	73 5f                	jae    81c <SYS_ls_call27+0x8>
 7bd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7c0:	6c                   	insb   (%dx),%es:(%edi)
 7c1:	31 38                	xor    %edi,(%eax)
	...

000007c4 <SYS_ls_call19>:
 7c4:	6c                   	insb   (%dx),%es:(%edi)
 7c5:	73 5f                	jae    826 <SYS_ls_call28+0x8>
 7c7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7ca:	6c                   	insb   (%dx),%es:(%edi)
 7cb:	31 39                	xor    %edi,(%ecx)
	...

000007ce <SYS_ls_call20>:
 7ce:	6c                   	insb   (%dx),%es:(%edi)
 7cf:	73 5f                	jae    830 <SYS_ls_call29+0x8>
 7d1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7d4:	6c                   	insb   (%dx),%es:(%edi)
 7d5:	32 30                	xor    (%eax),%dh
	...

000007d8 <SYS_ls_call21>:
 7d8:	6c                   	insb   (%dx),%es:(%edi)
 7d9:	73 5f                	jae    83a <SYS_ls_call30+0x8>
 7db:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7de:	6c                   	insb   (%dx),%es:(%edi)
 7df:	32 31                	xor    (%ecx),%dh
	...

000007e2 <SYS_ls_call22>:
 7e2:	6c                   	insb   (%dx),%es:(%edi)
 7e3:	73 5f                	jae    844 <exit>
 7e5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7e8:	6c                   	insb   (%dx),%es:(%edi)
 7e9:	32 32                	xor    (%edx),%dh
	...

000007ec <SYS_ls_call23>:
 7ec:	6c                   	insb   (%dx),%es:(%edi)
 7ed:	73 5f                	jae    84e <wait+0x2>
 7ef:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7f2:	6c                   	insb   (%dx),%es:(%edi)
 7f3:	32 33                	xor    (%ebx),%dh
	...

000007f6 <SYS_ls_call24>:
 7f6:	6c                   	insb   (%dx),%es:(%edi)
 7f7:	73 5f                	jae    858 <pipe+0x4>
 7f9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 7fc:	6c                   	insb   (%dx),%es:(%edi)
 7fd:	32 34 00             	xor    (%eax,%eax,1),%dh

00000800 <SYS_ls_call25>:
 800:	6c                   	insb   (%dx),%es:(%edi)
 801:	73 5f                	jae    862 <read+0x6>
 803:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 806:	6c                   	insb   (%dx),%es:(%edi)
 807:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

0000080a <SYS_ls_call26>:
 80a:	6c                   	insb   (%dx),%es:(%edi)
 80b:	73 5f                	jae    86c <close>
 80d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 810:	6c                   	insb   (%dx),%es:(%edi)
 811:	32 36                	xor    (%esi),%dh
	...

00000814 <SYS_ls_call27>:
 814:	6c                   	insb   (%dx),%es:(%edi)
 815:	73 5f                	jae    876 <kill+0x2>
 817:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 81a:	6c                   	insb   (%dx),%es:(%edi)
 81b:	32 37                	xor    (%edi),%dh
	...

0000081e <SYS_ls_call28>:
 81e:	6c                   	insb   (%dx),%es:(%edi)
 81f:	73 5f                	jae    880 <exec+0x4>
 821:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 824:	6c                   	insb   (%dx),%es:(%edi)
 825:	32 38                	xor    (%eax),%bh
	...

00000828 <SYS_ls_call29>:
 828:	6c                   	insb   (%dx),%es:(%edi)
 829:	73 5f                	jae    88a <open+0x6>
 82b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 82e:	6c                   	insb   (%dx),%es:(%edi)
 82f:	32 39                	xor    (%ecx),%bh
	...

00000832 <SYS_ls_call30>:
 832:	6c                   	insb   (%dx),%es:(%edi)
 833:	73 5f                	jae    894 <unlink>
 835:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 838:	6c                   	insb   (%dx),%es:(%edi)
 839:	33 30                	xor    (%eax),%esi
	...

0000083c <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 83c:	b8 01 00 00 00       	mov    $0x1,%eax
 841:	cd 40                	int    $0x40
 843:	c3                   	ret    

00000844 <exit>:
SYSCALL(exit)
 844:	b8 02 00 00 00       	mov    $0x2,%eax
 849:	cd 40                	int    $0x40
 84b:	c3                   	ret    

0000084c <wait>:
SYSCALL(wait)
 84c:	b8 03 00 00 00       	mov    $0x3,%eax
 851:	cd 40                	int    $0x40
 853:	c3                   	ret    

00000854 <pipe>:
SYSCALL(pipe)
 854:	b8 04 00 00 00       	mov    $0x4,%eax
 859:	cd 40                	int    $0x40
 85b:	c3                   	ret    

0000085c <read>:
SYSCALL(read)
 85c:	b8 05 00 00 00       	mov    $0x5,%eax
 861:	cd 40                	int    $0x40
 863:	c3                   	ret    

00000864 <write>:
SYSCALL(write)
 864:	b8 10 00 00 00       	mov    $0x10,%eax
 869:	cd 40                	int    $0x40
 86b:	c3                   	ret    

0000086c <close>:
SYSCALL(close)
 86c:	b8 15 00 00 00       	mov    $0x15,%eax
 871:	cd 40                	int    $0x40
 873:	c3                   	ret    

00000874 <kill>:
SYSCALL(kill)
 874:	b8 06 00 00 00       	mov    $0x6,%eax
 879:	cd 40                	int    $0x40
 87b:	c3                   	ret    

0000087c <exec>:
SYSCALL(exec)
 87c:	b8 07 00 00 00       	mov    $0x7,%eax
 881:	cd 40                	int    $0x40
 883:	c3                   	ret    

00000884 <open>:
SYSCALL(open)
 884:	b8 0f 00 00 00       	mov    $0xf,%eax
 889:	cd 40                	int    $0x40
 88b:	c3                   	ret    

0000088c <mknod>:
SYSCALL(mknod)
 88c:	b8 11 00 00 00       	mov    $0x11,%eax
 891:	cd 40                	int    $0x40
 893:	c3                   	ret    

00000894 <unlink>:
SYSCALL(unlink)
 894:	b8 12 00 00 00       	mov    $0x12,%eax
 899:	cd 40                	int    $0x40
 89b:	c3                   	ret    

0000089c <fstat>:
SYSCALL(fstat)
 89c:	b8 08 00 00 00       	mov    $0x8,%eax
 8a1:	cd 40                	int    $0x40
 8a3:	c3                   	ret    

000008a4 <link>:
SYSCALL(link)
 8a4:	b8 13 00 00 00       	mov    $0x13,%eax
 8a9:	cd 40                	int    $0x40
 8ab:	c3                   	ret    

000008ac <mkdir>:
SYSCALL(mkdir)
 8ac:	b8 14 00 00 00       	mov    $0x14,%eax
 8b1:	cd 40                	int    $0x40
 8b3:	c3                   	ret    

000008b4 <chdir>:
SYSCALL(chdir)
 8b4:	b8 09 00 00 00       	mov    $0x9,%eax
 8b9:	cd 40                	int    $0x40
 8bb:	c3                   	ret    

000008bc <dup>:
SYSCALL(dup)
 8bc:	b8 0a 00 00 00       	mov    $0xa,%eax
 8c1:	cd 40                	int    $0x40
 8c3:	c3                   	ret    

000008c4 <getpid>:
SYSCALL(getpid)
 8c4:	b8 0b 00 00 00       	mov    $0xb,%eax
 8c9:	cd 40                	int    $0x40
 8cb:	c3                   	ret    

000008cc <sbrk>:
SYSCALL(sbrk)
 8cc:	b8 0c 00 00 00       	mov    $0xc,%eax
 8d1:	cd 40                	int    $0x40
 8d3:	c3                   	ret    

000008d4 <sleep>:
SYSCALL(sleep)
 8d4:	b8 0d 00 00 00       	mov    $0xd,%eax
 8d9:	cd 40                	int    $0x40
 8db:	c3                   	ret    

000008dc <uptime>:
SYSCALL(uptime)
 8dc:	b8 0e 00 00 00       	mov    $0xe,%eax
 8e1:	cd 40                	int    $0x40
 8e3:	c3                   	ret    

000008e4 <date>:
SYSCALL(date)
 8e4:	b8 16 00 00 00       	mov    $0x16,%eax
 8e9:	cd 40                	int    $0x40
 8eb:	c3                   	ret    

000008ec <ls_call01>:

SYSCALL1(ls_call01)
 8ec:	b8 10 07 00 00       	mov    $0x710,%eax
 8f1:	cd 41                	int    $0x41
 8f3:	c3                   	ret    

000008f4 <ls_call02>:
SYSCALL1(ls_call02)
 8f4:	b8 1a 07 00 00       	mov    $0x71a,%eax
 8f9:	cd 41                	int    $0x41
 8fb:	c3                   	ret    

000008fc <ls_call03>:
SYSCALL1(ls_call03)
 8fc:	b8 24 07 00 00       	mov    $0x724,%eax
 901:	cd 41                	int    $0x41
 903:	c3                   	ret    

00000904 <ls_call04>:
SYSCALL1(ls_call04)
 904:	b8 2e 07 00 00       	mov    $0x72e,%eax
 909:	cd 41                	int    $0x41
 90b:	c3                   	ret    

0000090c <ls_call05>:
SYSCALL1(ls_call05)
 90c:	b8 38 07 00 00       	mov    $0x738,%eax
 911:	cd 41                	int    $0x41
 913:	c3                   	ret    

00000914 <ls_call06>:
SYSCALL1(ls_call06)
 914:	b8 42 07 00 00       	mov    $0x742,%eax
 919:	cd 41                	int    $0x41
 91b:	c3                   	ret    

0000091c <ls_call07>:
SYSCALL1(ls_call07)
 91c:	b8 4c 07 00 00       	mov    $0x74c,%eax
 921:	cd 41                	int    $0x41
 923:	c3                   	ret    

00000924 <ls_call08>:
SYSCALL1(ls_call08)
 924:	b8 56 07 00 00       	mov    $0x756,%eax
 929:	cd 41                	int    $0x41
 92b:	c3                   	ret    

0000092c <ls_call09>:
SYSCALL1(ls_call09)
 92c:	b8 60 07 00 00       	mov    $0x760,%eax
 931:	cd 41                	int    $0x41
 933:	c3                   	ret    

00000934 <ls_call10>:
SYSCALL1(ls_call10)
 934:	b8 6a 07 00 00       	mov    $0x76a,%eax
 939:	cd 41                	int    $0x41
 93b:	c3                   	ret    

0000093c <ls_call11>:
SYSCALL1(ls_call11)
 93c:	b8 74 07 00 00       	mov    $0x774,%eax
 941:	cd 41                	int    $0x41
 943:	c3                   	ret    

00000944 <ls_call12>:
SYSCALL1(ls_call12)
 944:	b8 7e 07 00 00       	mov    $0x77e,%eax
 949:	cd 41                	int    $0x41
 94b:	c3                   	ret    

0000094c <ls_call13>:
SYSCALL1(ls_call13)
 94c:	b8 88 07 00 00       	mov    $0x788,%eax
 951:	cd 41                	int    $0x41
 953:	c3                   	ret    

00000954 <ls_call14>:
SYSCALL1(ls_call14)
 954:	b8 92 07 00 00       	mov    $0x792,%eax
 959:	cd 41                	int    $0x41
 95b:	c3                   	ret    

0000095c <ls_call15>:
SYSCALL1(ls_call15)
 95c:	b8 9c 07 00 00       	mov    $0x79c,%eax
 961:	cd 41                	int    $0x41
 963:	c3                   	ret    

00000964 <ls_call16>:
SYSCALL1(ls_call16)
 964:	b8 a6 07 00 00       	mov    $0x7a6,%eax
 969:	cd 41                	int    $0x41
 96b:	c3                   	ret    

0000096c <ls_call17>:
SYSCALL1(ls_call17)
 96c:	b8 b0 07 00 00       	mov    $0x7b0,%eax
 971:	cd 41                	int    $0x41
 973:	c3                   	ret    

00000974 <ls_call18>:
SYSCALL1(ls_call18)
 974:	b8 ba 07 00 00       	mov    $0x7ba,%eax
 979:	cd 41                	int    $0x41
 97b:	c3                   	ret    

0000097c <ls_call19>:
SYSCALL1(ls_call19)
 97c:	b8 c4 07 00 00       	mov    $0x7c4,%eax
 981:	cd 41                	int    $0x41
 983:	c3                   	ret    

00000984 <ls_call20>:
SYSCALL1(ls_call20)
 984:	b8 ce 07 00 00       	mov    $0x7ce,%eax
 989:	cd 41                	int    $0x41
 98b:	c3                   	ret    

0000098c <ls_call21>:
SYSCALL1(ls_call21)
 98c:	b8 d8 07 00 00       	mov    $0x7d8,%eax
 991:	cd 41                	int    $0x41
 993:	c3                   	ret    

00000994 <ls_call22>:
SYSCALL1(ls_call22)
 994:	b8 e2 07 00 00       	mov    $0x7e2,%eax
 999:	cd 41                	int    $0x41
 99b:	c3                   	ret    

0000099c <ls_call23>:
SYSCALL1(ls_call23)
 99c:	b8 ec 07 00 00       	mov    $0x7ec,%eax
 9a1:	cd 41                	int    $0x41
 9a3:	c3                   	ret    

000009a4 <ls_call24>:
SYSCALL1(ls_call24)
 9a4:	b8 f6 07 00 00       	mov    $0x7f6,%eax
 9a9:	cd 41                	int    $0x41
 9ab:	c3                   	ret    

000009ac <ls_call25>:
SYSCALL1(ls_call25)
 9ac:	b8 00 08 00 00       	mov    $0x800,%eax
 9b1:	cd 41                	int    $0x41
 9b3:	c3                   	ret    

000009b4 <ls_call26>:
SYSCALL1(ls_call26)
 9b4:	b8 0a 08 00 00       	mov    $0x80a,%eax
 9b9:	cd 41                	int    $0x41
 9bb:	c3                   	ret    

000009bc <ls_call27>:
SYSCALL1(ls_call27)
 9bc:	b8 14 08 00 00       	mov    $0x814,%eax
 9c1:	cd 41                	int    $0x41
 9c3:	c3                   	ret    

000009c4 <ls_call28>:
SYSCALL1(ls_call28)
 9c4:	b8 1e 08 00 00       	mov    $0x81e,%eax
 9c9:	cd 41                	int    $0x41
 9cb:	c3                   	ret    

000009cc <ls_call29>:
SYSCALL1(ls_call29)
 9cc:	b8 28 08 00 00       	mov    $0x828,%eax
 9d1:	cd 41                	int    $0x41
 9d3:	c3                   	ret    

000009d4 <ls_call30>:
SYSCALL1(ls_call30)
 9d4:	b8 32 08 00 00       	mov    $0x832,%eax
 9d9:	cd 41                	int    $0x41
 9db:	c3                   	ret    

000009dc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 9dc:	55                   	push   %ebp
 9dd:	89 e5                	mov    %esp,%ebp
 9df:	83 ec 28             	sub    $0x28,%esp
 9e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 9e5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 9e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9ef:	00 
 9f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 9f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 9f7:	8b 45 08             	mov    0x8(%ebp),%eax
 9fa:	89 04 24             	mov    %eax,(%esp)
 9fd:	e8 62 fe ff ff       	call   864 <write>
}
 a02:	c9                   	leave  
 a03:	c3                   	ret    

00000a04 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a04:	55                   	push   %ebp
 a05:	89 e5                	mov    %esp,%ebp
 a07:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 a0a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 a11:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 a15:	74 17                	je     a2e <printint+0x2a>
 a17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 a1b:	79 11                	jns    a2e <printint+0x2a>
    neg = 1;
 a1d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 a24:	8b 45 0c             	mov    0xc(%ebp),%eax
 a27:	f7 d8                	neg    %eax
 a29:	89 45 ec             	mov    %eax,-0x14(%ebp)
 a2c:	eb 06                	jmp    a34 <printint+0x30>
  } else {
    x = xx;
 a2e:	8b 45 0c             	mov    0xc(%ebp),%eax
 a31:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 a34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 a3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 a3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a41:	ba 00 00 00 00       	mov    $0x0,%edx
 a46:	f7 f1                	div    %ecx
 a48:	89 d0                	mov    %edx,%eax
 a4a:	0f b6 80 ec 10 00 00 	movzbl 0x10ec(%eax),%eax
 a51:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 a54:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a57:	01 ca                	add    %ecx,%edx
 a59:	88 02                	mov    %al,(%edx)
 a5b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 a5f:	8b 55 10             	mov    0x10(%ebp),%edx
 a62:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 a65:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a68:	ba 00 00 00 00       	mov    $0x0,%edx
 a6d:	f7 75 d4             	divl   -0x2c(%ebp)
 a70:	89 45 ec             	mov    %eax,-0x14(%ebp)
 a73:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 a77:	75 c2                	jne    a3b <printint+0x37>
  if(neg)
 a79:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a7d:	74 2e                	je     aad <printint+0xa9>
    buf[i++] = '-';
 a7f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 a82:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a85:	01 d0                	add    %edx,%eax
 a87:	c6 00 2d             	movb   $0x2d,(%eax)
 a8a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 a8e:	eb 1d                	jmp    aad <printint+0xa9>
    putc(fd, buf[i]);
 a90:	8d 55 dc             	lea    -0x24(%ebp),%edx
 a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a96:	01 d0                	add    %edx,%eax
 a98:	0f b6 00             	movzbl (%eax),%eax
 a9b:	0f be c0             	movsbl %al,%eax
 a9e:	89 44 24 04          	mov    %eax,0x4(%esp)
 aa2:	8b 45 08             	mov    0x8(%ebp),%eax
 aa5:	89 04 24             	mov    %eax,(%esp)
 aa8:	e8 2f ff ff ff       	call   9dc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 aad:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 ab1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ab5:	79 d9                	jns    a90 <printint+0x8c>
    putc(fd, buf[i]);
}
 ab7:	c9                   	leave  
 ab8:	c3                   	ret    

00000ab9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 ab9:	55                   	push   %ebp
 aba:	89 e5                	mov    %esp,%ebp
 abc:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 abf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 ac6:	8d 45 0c             	lea    0xc(%ebp),%eax
 ac9:	83 c0 04             	add    $0x4,%eax
 acc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 acf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 ad6:	e9 7d 01 00 00       	jmp    c58 <printf+0x19f>
    c = fmt[i] & 0xff;
 adb:	8b 55 0c             	mov    0xc(%ebp),%edx
 ade:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ae1:	01 d0                	add    %edx,%eax
 ae3:	0f b6 00             	movzbl (%eax),%eax
 ae6:	0f be c0             	movsbl %al,%eax
 ae9:	25 ff 00 00 00       	and    $0xff,%eax
 aee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 af1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 af5:	75 2c                	jne    b23 <printf+0x6a>
      if(c == '%'){
 af7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 afb:	75 0c                	jne    b09 <printf+0x50>
        state = '%';
 afd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 b04:	e9 4b 01 00 00       	jmp    c54 <printf+0x19b>
      } else {
        putc(fd, c);
 b09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 b0c:	0f be c0             	movsbl %al,%eax
 b0f:	89 44 24 04          	mov    %eax,0x4(%esp)
 b13:	8b 45 08             	mov    0x8(%ebp),%eax
 b16:	89 04 24             	mov    %eax,(%esp)
 b19:	e8 be fe ff ff       	call   9dc <putc>
 b1e:	e9 31 01 00 00       	jmp    c54 <printf+0x19b>
      }
    } else if(state == '%'){
 b23:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 b27:	0f 85 27 01 00 00    	jne    c54 <printf+0x19b>
      if(c == 'd'){
 b2d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 b31:	75 2d                	jne    b60 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 b33:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b36:	8b 00                	mov    (%eax),%eax
 b38:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 b3f:	00 
 b40:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 b47:	00 
 b48:	89 44 24 04          	mov    %eax,0x4(%esp)
 b4c:	8b 45 08             	mov    0x8(%ebp),%eax
 b4f:	89 04 24             	mov    %eax,(%esp)
 b52:	e8 ad fe ff ff       	call   a04 <printint>
        ap++;
 b57:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 b5b:	e9 ed 00 00 00       	jmp    c4d <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 b60:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 b64:	74 06                	je     b6c <printf+0xb3>
 b66:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 b6a:	75 2d                	jne    b99 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 b6c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b6f:	8b 00                	mov    (%eax),%eax
 b71:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 b78:	00 
 b79:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 b80:	00 
 b81:	89 44 24 04          	mov    %eax,0x4(%esp)
 b85:	8b 45 08             	mov    0x8(%ebp),%eax
 b88:	89 04 24             	mov    %eax,(%esp)
 b8b:	e8 74 fe ff ff       	call   a04 <printint>
        ap++;
 b90:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 b94:	e9 b4 00 00 00       	jmp    c4d <printf+0x194>
      } else if(c == 's'){
 b99:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 b9d:	75 46                	jne    be5 <printf+0x12c>
        s = (char*)*ap;
 b9f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ba2:	8b 00                	mov    (%eax),%eax
 ba4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 ba7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 bab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 baf:	75 27                	jne    bd8 <printf+0x11f>
          s = "(null)";
 bb1:	c7 45 f4 a7 0e 00 00 	movl   $0xea7,-0xc(%ebp)
        while(*s != 0){
 bb8:	eb 1e                	jmp    bd8 <printf+0x11f>
          putc(fd, *s);
 bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bbd:	0f b6 00             	movzbl (%eax),%eax
 bc0:	0f be c0             	movsbl %al,%eax
 bc3:	89 44 24 04          	mov    %eax,0x4(%esp)
 bc7:	8b 45 08             	mov    0x8(%ebp),%eax
 bca:	89 04 24             	mov    %eax,(%esp)
 bcd:	e8 0a fe ff ff       	call   9dc <putc>
          s++;
 bd2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 bd6:	eb 01                	jmp    bd9 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 bd8:	90                   	nop
 bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bdc:	0f b6 00             	movzbl (%eax),%eax
 bdf:	84 c0                	test   %al,%al
 be1:	75 d7                	jne    bba <printf+0x101>
 be3:	eb 68                	jmp    c4d <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 be5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 be9:	75 1d                	jne    c08 <printf+0x14f>
        putc(fd, *ap);
 beb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bee:	8b 00                	mov    (%eax),%eax
 bf0:	0f be c0             	movsbl %al,%eax
 bf3:	89 44 24 04          	mov    %eax,0x4(%esp)
 bf7:	8b 45 08             	mov    0x8(%ebp),%eax
 bfa:	89 04 24             	mov    %eax,(%esp)
 bfd:	e8 da fd ff ff       	call   9dc <putc>
        ap++;
 c02:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 c06:	eb 45                	jmp    c4d <printf+0x194>
      } else if(c == '%'){
 c08:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 c0c:	75 17                	jne    c25 <printf+0x16c>
        putc(fd, c);
 c0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 c11:	0f be c0             	movsbl %al,%eax
 c14:	89 44 24 04          	mov    %eax,0x4(%esp)
 c18:	8b 45 08             	mov    0x8(%ebp),%eax
 c1b:	89 04 24             	mov    %eax,(%esp)
 c1e:	e8 b9 fd ff ff       	call   9dc <putc>
 c23:	eb 28                	jmp    c4d <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c25:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 c2c:	00 
 c2d:	8b 45 08             	mov    0x8(%ebp),%eax
 c30:	89 04 24             	mov    %eax,(%esp)
 c33:	e8 a4 fd ff ff       	call   9dc <putc>
        putc(fd, c);
 c38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 c3b:	0f be c0             	movsbl %al,%eax
 c3e:	89 44 24 04          	mov    %eax,0x4(%esp)
 c42:	8b 45 08             	mov    0x8(%ebp),%eax
 c45:	89 04 24             	mov    %eax,(%esp)
 c48:	e8 8f fd ff ff       	call   9dc <putc>
      }
      state = 0;
 c4d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c54:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 c58:	8b 55 0c             	mov    0xc(%ebp),%edx
 c5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c5e:	01 d0                	add    %edx,%eax
 c60:	0f b6 00             	movzbl (%eax),%eax
 c63:	84 c0                	test   %al,%al
 c65:	0f 85 70 fe ff ff    	jne    adb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 c6b:	c9                   	leave  
 c6c:	c3                   	ret    
 c6d:	90                   	nop
 c6e:	90                   	nop
 c6f:	90                   	nop

00000c70 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c70:	55                   	push   %ebp
 c71:	89 e5                	mov    %esp,%ebp
 c73:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c76:	8b 45 08             	mov    0x8(%ebp),%eax
 c79:	83 e8 08             	sub    $0x8,%eax
 c7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c7f:	a1 08 11 00 00       	mov    0x1108,%eax
 c84:	89 45 fc             	mov    %eax,-0x4(%ebp)
 c87:	eb 24                	jmp    cad <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c89:	8b 45 fc             	mov    -0x4(%ebp),%eax
 c8c:	8b 00                	mov    (%eax),%eax
 c8e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 c91:	77 12                	ja     ca5 <free+0x35>
 c93:	8b 45 f8             	mov    -0x8(%ebp),%eax
 c96:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 c99:	77 24                	ja     cbf <free+0x4f>
 c9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 c9e:	8b 00                	mov    (%eax),%eax
 ca0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 ca3:	77 1a                	ja     cbf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ca5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ca8:	8b 00                	mov    (%eax),%eax
 caa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 cad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 cb0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 cb3:	76 d4                	jbe    c89 <free+0x19>
 cb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 cb8:	8b 00                	mov    (%eax),%eax
 cba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 cbd:	76 ca                	jbe    c89 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 cbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 cc2:	8b 40 04             	mov    0x4(%eax),%eax
 cc5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 ccc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ccf:	01 c2                	add    %eax,%edx
 cd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 cd4:	8b 00                	mov    (%eax),%eax
 cd6:	39 c2                	cmp    %eax,%edx
 cd8:	75 24                	jne    cfe <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 cda:	8b 45 f8             	mov    -0x8(%ebp),%eax
 cdd:	8b 50 04             	mov    0x4(%eax),%edx
 ce0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ce3:	8b 00                	mov    (%eax),%eax
 ce5:	8b 40 04             	mov    0x4(%eax),%eax
 ce8:	01 c2                	add    %eax,%edx
 cea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ced:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 cf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 cf3:	8b 00                	mov    (%eax),%eax
 cf5:	8b 10                	mov    (%eax),%edx
 cf7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 cfa:	89 10                	mov    %edx,(%eax)
 cfc:	eb 0a                	jmp    d08 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 cfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d01:	8b 10                	mov    (%eax),%edx
 d03:	8b 45 f8             	mov    -0x8(%ebp),%eax
 d06:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 d08:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d0b:	8b 40 04             	mov    0x4(%eax),%eax
 d0e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 d15:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d18:	01 d0                	add    %edx,%eax
 d1a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 d1d:	75 20                	jne    d3f <free+0xcf>
    p->s.size += bp->s.size;
 d1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d22:	8b 50 04             	mov    0x4(%eax),%edx
 d25:	8b 45 f8             	mov    -0x8(%ebp),%eax
 d28:	8b 40 04             	mov    0x4(%eax),%eax
 d2b:	01 c2                	add    %eax,%edx
 d2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d30:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 d33:	8b 45 f8             	mov    -0x8(%ebp),%eax
 d36:	8b 10                	mov    (%eax),%edx
 d38:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d3b:	89 10                	mov    %edx,(%eax)
 d3d:	eb 08                	jmp    d47 <free+0xd7>
  } else
    p->s.ptr = bp;
 d3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d42:	8b 55 f8             	mov    -0x8(%ebp),%edx
 d45:	89 10                	mov    %edx,(%eax)
  freep = p;
 d47:	8b 45 fc             	mov    -0x4(%ebp),%eax
 d4a:	a3 08 11 00 00       	mov    %eax,0x1108
}
 d4f:	c9                   	leave  
 d50:	c3                   	ret    

00000d51 <morecore>:

static Header*
morecore(uint nu)
{
 d51:	55                   	push   %ebp
 d52:	89 e5                	mov    %esp,%ebp
 d54:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 d57:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 d5e:	77 07                	ja     d67 <morecore+0x16>
    nu = 4096;
 d60:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 d67:	8b 45 08             	mov    0x8(%ebp),%eax
 d6a:	c1 e0 03             	shl    $0x3,%eax
 d6d:	89 04 24             	mov    %eax,(%esp)
 d70:	e8 57 fb ff ff       	call   8cc <sbrk>
 d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 d78:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 d7c:	75 07                	jne    d85 <morecore+0x34>
    return 0;
 d7e:	b8 00 00 00 00       	mov    $0x0,%eax
 d83:	eb 22                	jmp    da7 <morecore+0x56>
  hp = (Header*)p;
 d85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 d8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d8e:	8b 55 08             	mov    0x8(%ebp),%edx
 d91:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 d94:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d97:	83 c0 08             	add    $0x8,%eax
 d9a:	89 04 24             	mov    %eax,(%esp)
 d9d:	e8 ce fe ff ff       	call   c70 <free>
  return freep;
 da2:	a1 08 11 00 00       	mov    0x1108,%eax
}
 da7:	c9                   	leave  
 da8:	c3                   	ret    

00000da9 <malloc>:

void*
malloc(uint nbytes)
{
 da9:	55                   	push   %ebp
 daa:	89 e5                	mov    %esp,%ebp
 dac:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 daf:	8b 45 08             	mov    0x8(%ebp),%eax
 db2:	83 c0 07             	add    $0x7,%eax
 db5:	c1 e8 03             	shr    $0x3,%eax
 db8:	83 c0 01             	add    $0x1,%eax
 dbb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 dbe:	a1 08 11 00 00       	mov    0x1108,%eax
 dc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 dc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 dca:	75 23                	jne    def <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 dcc:	c7 45 f0 00 11 00 00 	movl   $0x1100,-0x10(%ebp)
 dd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 dd6:	a3 08 11 00 00       	mov    %eax,0x1108
 ddb:	a1 08 11 00 00       	mov    0x1108,%eax
 de0:	a3 00 11 00 00       	mov    %eax,0x1100
    base.s.size = 0;
 de5:	c7 05 04 11 00 00 00 	movl   $0x0,0x1104
 dec:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 def:	8b 45 f0             	mov    -0x10(%ebp),%eax
 df2:	8b 00                	mov    (%eax),%eax
 df4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 dfa:	8b 40 04             	mov    0x4(%eax),%eax
 dfd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 e00:	72 4d                	jb     e4f <malloc+0xa6>
      if(p->s.size == nunits)
 e02:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e05:	8b 40 04             	mov    0x4(%eax),%eax
 e08:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 e0b:	75 0c                	jne    e19 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e10:	8b 10                	mov    (%eax),%edx
 e12:	8b 45 f0             	mov    -0x10(%ebp),%eax
 e15:	89 10                	mov    %edx,(%eax)
 e17:	eb 26                	jmp    e3f <malloc+0x96>
      else {
        p->s.size -= nunits;
 e19:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e1c:	8b 40 04             	mov    0x4(%eax),%eax
 e1f:	89 c2                	mov    %eax,%edx
 e21:	2b 55 ec             	sub    -0x14(%ebp),%edx
 e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e27:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 e2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e2d:	8b 40 04             	mov    0x4(%eax),%eax
 e30:	c1 e0 03             	shl    $0x3,%eax
 e33:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e39:	8b 55 ec             	mov    -0x14(%ebp),%edx
 e3c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 e3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 e42:	a3 08 11 00 00       	mov    %eax,0x1108
      return (void*)(p + 1);
 e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e4a:	83 c0 08             	add    $0x8,%eax
 e4d:	eb 38                	jmp    e87 <malloc+0xde>
    }
    if(p == freep)
 e4f:	a1 08 11 00 00       	mov    0x1108,%eax
 e54:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 e57:	75 1b                	jne    e74 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 e59:	8b 45 ec             	mov    -0x14(%ebp),%eax
 e5c:	89 04 24             	mov    %eax,(%esp)
 e5f:	e8 ed fe ff ff       	call   d51 <morecore>
 e64:	89 45 f4             	mov    %eax,-0xc(%ebp)
 e67:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 e6b:	75 07                	jne    e74 <malloc+0xcb>
        return 0;
 e6d:	b8 00 00 00 00       	mov    $0x0,%eax
 e72:	eb 13                	jmp    e87 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e77:	89 45 f0             	mov    %eax,-0x10(%ebp)
 e7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 e7d:	8b 00                	mov    (%eax),%eax
 e7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 e82:	e9 70 ff ff ff       	jmp    df7 <malloc+0x4e>
}
 e87:	c9                   	leave  
 e88:	c3                   	ret    
