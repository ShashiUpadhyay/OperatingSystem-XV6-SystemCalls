
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
       6:	a1 e8 62 00 00       	mov    0x62e8,%eax
       b:	c7 44 24 04 42 44 00 	movl   $0x4442,0x4(%esp)
      12:	00 
      13:	89 04 24             	mov    %eax,(%esp)
      16:	e8 3e 40 00 00       	call   4059 <printf>

  if(mkdir("iputdir") < 0){
      1b:	c7 04 24 4d 44 00 00 	movl   $0x444d,(%esp)
      22:	e8 1d 3f 00 00       	call   3f44 <mkdir>
      27:	85 c0                	test   %eax,%eax
      29:	79 1a                	jns    45 <iputtest+0x45>
    printf(stdout, "mkdir failed\n");
      2b:	a1 e8 62 00 00       	mov    0x62e8,%eax
      30:	c7 44 24 04 55 44 00 	movl   $0x4455,0x4(%esp)
      37:	00 
      38:	89 04 24             	mov    %eax,(%esp)
      3b:	e8 19 40 00 00       	call   4059 <printf>
    exit();
      40:	e8 97 3e 00 00       	call   3edc <exit>
  }
  if(chdir("iputdir") < 0){
      45:	c7 04 24 4d 44 00 00 	movl   $0x444d,(%esp)
      4c:	e8 fb 3e 00 00       	call   3f4c <chdir>
      51:	85 c0                	test   %eax,%eax
      53:	79 1a                	jns    6f <iputtest+0x6f>
    printf(stdout, "chdir iputdir failed\n");
      55:	a1 e8 62 00 00       	mov    0x62e8,%eax
      5a:	c7 44 24 04 63 44 00 	movl   $0x4463,0x4(%esp)
      61:	00 
      62:	89 04 24             	mov    %eax,(%esp)
      65:	e8 ef 3f 00 00       	call   4059 <printf>
    exit();
      6a:	e8 6d 3e 00 00       	call   3edc <exit>
  }
  if(unlink("../iputdir") < 0){
      6f:	c7 04 24 79 44 00 00 	movl   $0x4479,(%esp)
      76:	e8 b1 3e 00 00       	call   3f2c <unlink>
      7b:	85 c0                	test   %eax,%eax
      7d:	79 1a                	jns    99 <iputtest+0x99>
    printf(stdout, "unlink ../iputdir failed\n");
      7f:	a1 e8 62 00 00       	mov    0x62e8,%eax
      84:	c7 44 24 04 84 44 00 	movl   $0x4484,0x4(%esp)
      8b:	00 
      8c:	89 04 24             	mov    %eax,(%esp)
      8f:	e8 c5 3f 00 00       	call   4059 <printf>
    exit();
      94:	e8 43 3e 00 00       	call   3edc <exit>
  }
  if(chdir("/") < 0){
      99:	c7 04 24 9e 44 00 00 	movl   $0x449e,(%esp)
      a0:	e8 a7 3e 00 00       	call   3f4c <chdir>
      a5:	85 c0                	test   %eax,%eax
      a7:	79 1a                	jns    c3 <iputtest+0xc3>
    printf(stdout, "chdir / failed\n");
      a9:	a1 e8 62 00 00       	mov    0x62e8,%eax
      ae:	c7 44 24 04 a0 44 00 	movl   $0x44a0,0x4(%esp)
      b5:	00 
      b6:	89 04 24             	mov    %eax,(%esp)
      b9:	e8 9b 3f 00 00       	call   4059 <printf>
    exit();
      be:	e8 19 3e 00 00       	call   3edc <exit>
  }
  printf(stdout, "iput test ok\n");
      c3:	a1 e8 62 00 00       	mov    0x62e8,%eax
      c8:	c7 44 24 04 b0 44 00 	movl   $0x44b0,0x4(%esp)
      cf:	00 
      d0:	89 04 24             	mov    %eax,(%esp)
      d3:	e8 81 3f 00 00       	call   4059 <printf>
}
      d8:	c9                   	leave  
      d9:	c3                   	ret    

000000da <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      da:	55                   	push   %ebp
      db:	89 e5                	mov    %esp,%ebp
      dd:	83 ec 28             	sub    $0x28,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      e0:	a1 e8 62 00 00       	mov    0x62e8,%eax
      e5:	c7 44 24 04 be 44 00 	movl   $0x44be,0x4(%esp)
      ec:	00 
      ed:	89 04 24             	mov    %eax,(%esp)
      f0:	e8 64 3f 00 00       	call   4059 <printf>

  pid = fork();
      f5:	e8 da 3d 00 00       	call   3ed4 <fork>
      fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
      fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     101:	79 1a                	jns    11d <exitiputtest+0x43>
    printf(stdout, "fork failed\n");
     103:	a1 e8 62 00 00       	mov    0x62e8,%eax
     108:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
     10f:	00 
     110:	89 04 24             	mov    %eax,(%esp)
     113:	e8 41 3f 00 00       	call   4059 <printf>
    exit();
     118:	e8 bf 3d 00 00       	call   3edc <exit>
  }
  if(pid == 0){
     11d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     121:	0f 85 83 00 00 00    	jne    1aa <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
     127:	c7 04 24 4d 44 00 00 	movl   $0x444d,(%esp)
     12e:	e8 11 3e 00 00       	call   3f44 <mkdir>
     133:	85 c0                	test   %eax,%eax
     135:	79 1a                	jns    151 <exitiputtest+0x77>
      printf(stdout, "mkdir failed\n");
     137:	a1 e8 62 00 00       	mov    0x62e8,%eax
     13c:	c7 44 24 04 55 44 00 	movl   $0x4455,0x4(%esp)
     143:	00 
     144:	89 04 24             	mov    %eax,(%esp)
     147:	e8 0d 3f 00 00       	call   4059 <printf>
      exit();
     14c:	e8 8b 3d 00 00       	call   3edc <exit>
    }
    if(chdir("iputdir") < 0){
     151:	c7 04 24 4d 44 00 00 	movl   $0x444d,(%esp)
     158:	e8 ef 3d 00 00       	call   3f4c <chdir>
     15d:	85 c0                	test   %eax,%eax
     15f:	79 1a                	jns    17b <exitiputtest+0xa1>
      printf(stdout, "child chdir failed\n");
     161:	a1 e8 62 00 00       	mov    0x62e8,%eax
     166:	c7 44 24 04 da 44 00 	movl   $0x44da,0x4(%esp)
     16d:	00 
     16e:	89 04 24             	mov    %eax,(%esp)
     171:	e8 e3 3e 00 00       	call   4059 <printf>
      exit();
     176:	e8 61 3d 00 00       	call   3edc <exit>
    }
    if(unlink("../iputdir") < 0){
     17b:	c7 04 24 79 44 00 00 	movl   $0x4479,(%esp)
     182:	e8 a5 3d 00 00       	call   3f2c <unlink>
     187:	85 c0                	test   %eax,%eax
     189:	79 1a                	jns    1a5 <exitiputtest+0xcb>
      printf(stdout, "unlink ../iputdir failed\n");
     18b:	a1 e8 62 00 00       	mov    0x62e8,%eax
     190:	c7 44 24 04 84 44 00 	movl   $0x4484,0x4(%esp)
     197:	00 
     198:	89 04 24             	mov    %eax,(%esp)
     19b:	e8 b9 3e 00 00       	call   4059 <printf>
      exit();
     1a0:	e8 37 3d 00 00       	call   3edc <exit>
    }
    exit();
     1a5:	e8 32 3d 00 00       	call   3edc <exit>
  }
  wait();
     1aa:	e8 35 3d 00 00       	call   3ee4 <wait>
  printf(stdout, "exitiput test ok\n");
     1af:	a1 e8 62 00 00       	mov    0x62e8,%eax
     1b4:	c7 44 24 04 ee 44 00 	movl   $0x44ee,0x4(%esp)
     1bb:	00 
     1bc:	89 04 24             	mov    %eax,(%esp)
     1bf:	e8 95 3e 00 00       	call   4059 <printf>
}
     1c4:	c9                   	leave  
     1c5:	c3                   	ret    

000001c6 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     1c6:	55                   	push   %ebp
     1c7:	89 e5                	mov    %esp,%ebp
     1c9:	83 ec 28             	sub    $0x28,%esp
  int pid;

  printf(stdout, "openiput test\n");
     1cc:	a1 e8 62 00 00       	mov    0x62e8,%eax
     1d1:	c7 44 24 04 00 45 00 	movl   $0x4500,0x4(%esp)
     1d8:	00 
     1d9:	89 04 24             	mov    %eax,(%esp)
     1dc:	e8 78 3e 00 00       	call   4059 <printf>
  if(mkdir("oidir") < 0){
     1e1:	c7 04 24 0f 45 00 00 	movl   $0x450f,(%esp)
     1e8:	e8 57 3d 00 00       	call   3f44 <mkdir>
     1ed:	85 c0                	test   %eax,%eax
     1ef:	79 1a                	jns    20b <openiputtest+0x45>
    printf(stdout, "mkdir oidir failed\n");
     1f1:	a1 e8 62 00 00       	mov    0x62e8,%eax
     1f6:	c7 44 24 04 15 45 00 	movl   $0x4515,0x4(%esp)
     1fd:	00 
     1fe:	89 04 24             	mov    %eax,(%esp)
     201:	e8 53 3e 00 00       	call   4059 <printf>
    exit();
     206:	e8 d1 3c 00 00       	call   3edc <exit>
  }
  pid = fork();
     20b:	e8 c4 3c 00 00       	call   3ed4 <fork>
     210:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     213:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     217:	79 1a                	jns    233 <openiputtest+0x6d>
    printf(stdout, "fork failed\n");
     219:	a1 e8 62 00 00       	mov    0x62e8,%eax
     21e:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
     225:	00 
     226:	89 04 24             	mov    %eax,(%esp)
     229:	e8 2b 3e 00 00       	call   4059 <printf>
    exit();
     22e:	e8 a9 3c 00 00       	call   3edc <exit>
  }
  if(pid == 0){
     233:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     237:	75 3c                	jne    275 <openiputtest+0xaf>
    int fd = open("oidir", O_RDWR);
     239:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     240:	00 
     241:	c7 04 24 0f 45 00 00 	movl   $0x450f,(%esp)
     248:	e8 cf 3c 00 00       	call   3f1c <open>
     24d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     250:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     254:	78 1a                	js     270 <openiputtest+0xaa>
      printf(stdout, "open directory for write succeeded\n");
     256:	a1 e8 62 00 00       	mov    0x62e8,%eax
     25b:	c7 44 24 04 2c 45 00 	movl   $0x452c,0x4(%esp)
     262:	00 
     263:	89 04 24             	mov    %eax,(%esp)
     266:	e8 ee 3d 00 00       	call   4059 <printf>
      exit();
     26b:	e8 6c 3c 00 00       	call   3edc <exit>
    }
    exit();
     270:	e8 67 3c 00 00       	call   3edc <exit>
  }
  sleep(1);
     275:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     27c:	e8 eb 3c 00 00       	call   3f6c <sleep>
  if(unlink("oidir") != 0){
     281:	c7 04 24 0f 45 00 00 	movl   $0x450f,(%esp)
     288:	e8 9f 3c 00 00       	call   3f2c <unlink>
     28d:	85 c0                	test   %eax,%eax
     28f:	74 1a                	je     2ab <openiputtest+0xe5>
    printf(stdout, "unlink failed\n");
     291:	a1 e8 62 00 00       	mov    0x62e8,%eax
     296:	c7 44 24 04 50 45 00 	movl   $0x4550,0x4(%esp)
     29d:	00 
     29e:	89 04 24             	mov    %eax,(%esp)
     2a1:	e8 b3 3d 00 00       	call   4059 <printf>
    exit();
     2a6:	e8 31 3c 00 00       	call   3edc <exit>
  }
  wait();
     2ab:	e8 34 3c 00 00       	call   3ee4 <wait>
  printf(stdout, "openiput test ok\n");
     2b0:	a1 e8 62 00 00       	mov    0x62e8,%eax
     2b5:	c7 44 24 04 5f 45 00 	movl   $0x455f,0x4(%esp)
     2bc:	00 
     2bd:	89 04 24             	mov    %eax,(%esp)
     2c0:	e8 94 3d 00 00       	call   4059 <printf>
}
     2c5:	c9                   	leave  
     2c6:	c3                   	ret    

000002c7 <opentest>:

// simple file system tests

void
opentest(void)
{
     2c7:	55                   	push   %ebp
     2c8:	89 e5                	mov    %esp,%ebp
     2ca:	83 ec 28             	sub    $0x28,%esp
  int fd;

  printf(stdout, "open test\n");
     2cd:	a1 e8 62 00 00       	mov    0x62e8,%eax
     2d2:	c7 44 24 04 71 45 00 	movl   $0x4571,0x4(%esp)
     2d9:	00 
     2da:	89 04 24             	mov    %eax,(%esp)
     2dd:	e8 77 3d 00 00       	call   4059 <printf>
  fd = open("echo", 0);
     2e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2e9:	00 
     2ea:	c7 04 24 2c 44 00 00 	movl   $0x442c,(%esp)
     2f1:	e8 26 3c 00 00       	call   3f1c <open>
     2f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     2f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2fd:	79 1a                	jns    319 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
     2ff:	a1 e8 62 00 00       	mov    0x62e8,%eax
     304:	c7 44 24 04 7c 45 00 	movl   $0x457c,0x4(%esp)
     30b:	00 
     30c:	89 04 24             	mov    %eax,(%esp)
     30f:	e8 45 3d 00 00       	call   4059 <printf>
    exit();
     314:	e8 c3 3b 00 00       	call   3edc <exit>
  }
  close(fd);
     319:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31c:	89 04 24             	mov    %eax,(%esp)
     31f:	e8 e0 3b 00 00       	call   3f04 <close>
  fd = open("doesnotexist", 0);
     324:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     32b:	00 
     32c:	c7 04 24 8f 45 00 00 	movl   $0x458f,(%esp)
     333:	e8 e4 3b 00 00       	call   3f1c <open>
     338:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     33b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     33f:	78 1a                	js     35b <opentest+0x94>
    printf(stdout, "open doesnotexist succeeded!\n");
     341:	a1 e8 62 00 00       	mov    0x62e8,%eax
     346:	c7 44 24 04 9c 45 00 	movl   $0x459c,0x4(%esp)
     34d:	00 
     34e:	89 04 24             	mov    %eax,(%esp)
     351:	e8 03 3d 00 00       	call   4059 <printf>
    exit();
     356:	e8 81 3b 00 00       	call   3edc <exit>
  }
  printf(stdout, "open test ok\n");
     35b:	a1 e8 62 00 00       	mov    0x62e8,%eax
     360:	c7 44 24 04 ba 45 00 	movl   $0x45ba,0x4(%esp)
     367:	00 
     368:	89 04 24             	mov    %eax,(%esp)
     36b:	e8 e9 3c 00 00       	call   4059 <printf>
}
     370:	c9                   	leave  
     371:	c3                   	ret    

00000372 <writetest>:

void
writetest(void)
{
     372:	55                   	push   %ebp
     373:	89 e5                	mov    %esp,%ebp
     375:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     378:	a1 e8 62 00 00       	mov    0x62e8,%eax
     37d:	c7 44 24 04 c8 45 00 	movl   $0x45c8,0x4(%esp)
     384:	00 
     385:	89 04 24             	mov    %eax,(%esp)
     388:	e8 cc 3c 00 00       	call   4059 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     38d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     394:	00 
     395:	c7 04 24 d9 45 00 00 	movl   $0x45d9,(%esp)
     39c:	e8 7b 3b 00 00       	call   3f1c <open>
     3a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     3a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3a8:	78 21                	js     3cb <writetest+0x59>
    printf(stdout, "creat small succeeded; ok\n");
     3aa:	a1 e8 62 00 00       	mov    0x62e8,%eax
     3af:	c7 44 24 04 df 45 00 	movl   $0x45df,0x4(%esp)
     3b6:	00 
     3b7:	89 04 24             	mov    %eax,(%esp)
     3ba:	e8 9a 3c 00 00       	call   4059 <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     3bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     3c6:	e9 a0 00 00 00       	jmp    46b <writetest+0xf9>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     3cb:	a1 e8 62 00 00       	mov    0x62e8,%eax
     3d0:	c7 44 24 04 fa 45 00 	movl   $0x45fa,0x4(%esp)
     3d7:	00 
     3d8:	89 04 24             	mov    %eax,(%esp)
     3db:	e8 79 3c 00 00       	call   4059 <printf>
    exit();
     3e0:	e8 f7 3a 00 00       	call   3edc <exit>
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     3e5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     3ec:	00 
     3ed:	c7 44 24 04 16 46 00 	movl   $0x4616,0x4(%esp)
     3f4:	00 
     3f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     3f8:	89 04 24             	mov    %eax,(%esp)
     3fb:	e8 fc 3a 00 00       	call   3efc <write>
     400:	83 f8 0a             	cmp    $0xa,%eax
     403:	74 21                	je     426 <writetest+0xb4>
      printf(stdout, "error: write aa %d new file failed\n", i);
     405:	a1 e8 62 00 00       	mov    0x62e8,%eax
     40a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     40d:	89 54 24 08          	mov    %edx,0x8(%esp)
     411:	c7 44 24 04 24 46 00 	movl   $0x4624,0x4(%esp)
     418:	00 
     419:	89 04 24             	mov    %eax,(%esp)
     41c:	e8 38 3c 00 00       	call   4059 <printf>
      exit();
     421:	e8 b6 3a 00 00       	call   3edc <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     426:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     42d:	00 
     42e:	c7 44 24 04 48 46 00 	movl   $0x4648,0x4(%esp)
     435:	00 
     436:	8b 45 f0             	mov    -0x10(%ebp),%eax
     439:	89 04 24             	mov    %eax,(%esp)
     43c:	e8 bb 3a 00 00       	call   3efc <write>
     441:	83 f8 0a             	cmp    $0xa,%eax
     444:	74 21                	je     467 <writetest+0xf5>
      printf(stdout, "error: write bb %d new file failed\n", i);
     446:	a1 e8 62 00 00       	mov    0x62e8,%eax
     44b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     44e:	89 54 24 08          	mov    %edx,0x8(%esp)
     452:	c7 44 24 04 54 46 00 	movl   $0x4654,0x4(%esp)
     459:	00 
     45a:	89 04 24             	mov    %eax,(%esp)
     45d:	e8 f7 3b 00 00       	call   4059 <printf>
      exit();
     462:	e8 75 3a 00 00       	call   3edc <exit>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     467:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     46b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     46f:	0f 8e 70 ff ff ff    	jle    3e5 <writetest+0x73>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     475:	a1 e8 62 00 00       	mov    0x62e8,%eax
     47a:	c7 44 24 04 78 46 00 	movl   $0x4678,0x4(%esp)
     481:	00 
     482:	89 04 24             	mov    %eax,(%esp)
     485:	e8 cf 3b 00 00       	call   4059 <printf>
  close(fd);
     48a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     48d:	89 04 24             	mov    %eax,(%esp)
     490:	e8 6f 3a 00 00       	call   3f04 <close>
  fd = open("small", O_RDONLY);
     495:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     49c:	00 
     49d:	c7 04 24 d9 45 00 00 	movl   $0x45d9,(%esp)
     4a4:	e8 73 3a 00 00       	call   3f1c <open>
     4a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     4ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4b0:	78 3e                	js     4f0 <writetest+0x17e>
    printf(stdout, "open small succeeded ok\n");
     4b2:	a1 e8 62 00 00       	mov    0x62e8,%eax
     4b7:	c7 44 24 04 83 46 00 	movl   $0x4683,0x4(%esp)
     4be:	00 
     4bf:	89 04 24             	mov    %eax,(%esp)
     4c2:	e8 92 3b 00 00       	call   4059 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     4c7:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     4ce:	00 
     4cf:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
     4d6:	00 
     4d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4da:	89 04 24             	mov    %eax,(%esp)
     4dd:	e8 12 3a 00 00       	call   3ef4 <read>
     4e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     4e5:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     4ec:	74 1c                	je     50a <writetest+0x198>
     4ee:	eb 4c                	jmp    53c <writetest+0x1ca>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     4f0:	a1 e8 62 00 00       	mov    0x62e8,%eax
     4f5:	c7 44 24 04 9c 46 00 	movl   $0x469c,0x4(%esp)
     4fc:	00 
     4fd:	89 04 24             	mov    %eax,(%esp)
     500:	e8 54 3b 00 00       	call   4059 <printf>
    exit();
     505:	e8 d2 39 00 00       	call   3edc <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
     50a:	a1 e8 62 00 00       	mov    0x62e8,%eax
     50f:	c7 44 24 04 b7 46 00 	movl   $0x46b7,0x4(%esp)
     516:	00 
     517:	89 04 24             	mov    %eax,(%esp)
     51a:	e8 3a 3b 00 00       	call   4059 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     51f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     522:	89 04 24             	mov    %eax,(%esp)
     525:	e8 da 39 00 00       	call   3f04 <close>

  if(unlink("small") < 0){
     52a:	c7 04 24 d9 45 00 00 	movl   $0x45d9,(%esp)
     531:	e8 f6 39 00 00       	call   3f2c <unlink>
     536:	85 c0                	test   %eax,%eax
     538:	78 1c                	js     556 <writetest+0x1e4>
     53a:	eb 34                	jmp    570 <writetest+0x1fe>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     53c:	a1 e8 62 00 00       	mov    0x62e8,%eax
     541:	c7 44 24 04 ca 46 00 	movl   $0x46ca,0x4(%esp)
     548:	00 
     549:	89 04 24             	mov    %eax,(%esp)
     54c:	e8 08 3b 00 00       	call   4059 <printf>
    exit();
     551:	e8 86 39 00 00       	call   3edc <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     556:	a1 e8 62 00 00       	mov    0x62e8,%eax
     55b:	c7 44 24 04 d7 46 00 	movl   $0x46d7,0x4(%esp)
     562:	00 
     563:	89 04 24             	mov    %eax,(%esp)
     566:	e8 ee 3a 00 00       	call   4059 <printf>
    exit();
     56b:	e8 6c 39 00 00       	call   3edc <exit>
  }
  printf(stdout, "small file test ok\n");
     570:	a1 e8 62 00 00       	mov    0x62e8,%eax
     575:	c7 44 24 04 ec 46 00 	movl   $0x46ec,0x4(%esp)
     57c:	00 
     57d:	89 04 24             	mov    %eax,(%esp)
     580:	e8 d4 3a 00 00       	call   4059 <printf>
}
     585:	c9                   	leave  
     586:	c3                   	ret    

00000587 <writetest1>:

void
writetest1(void)
{
     587:	55                   	push   %ebp
     588:	89 e5                	mov    %esp,%ebp
     58a:	83 ec 28             	sub    $0x28,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     58d:	a1 e8 62 00 00       	mov    0x62e8,%eax
     592:	c7 44 24 04 00 47 00 	movl   $0x4700,0x4(%esp)
     599:	00 
     59a:	89 04 24             	mov    %eax,(%esp)
     59d:	e8 b7 3a 00 00       	call   4059 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     5a2:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     5a9:	00 
     5aa:	c7 04 24 10 47 00 00 	movl   $0x4710,(%esp)
     5b1:	e8 66 39 00 00       	call   3f1c <open>
     5b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     5b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5bd:	79 1a                	jns    5d9 <writetest1+0x52>
    printf(stdout, "error: creat big failed!\n");
     5bf:	a1 e8 62 00 00       	mov    0x62e8,%eax
     5c4:	c7 44 24 04 14 47 00 	movl   $0x4714,0x4(%esp)
     5cb:	00 
     5cc:	89 04 24             	mov    %eax,(%esp)
     5cf:	e8 85 3a 00 00       	call   4059 <printf>
    exit();
     5d4:	e8 03 39 00 00       	call   3edc <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     5d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     5e0:	eb 51                	jmp    633 <writetest1+0xac>
    ((int*)buf)[0] = i;
     5e2:	b8 e0 8a 00 00       	mov    $0x8ae0,%eax
     5e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5ea:	89 10                	mov    %edx,(%eax)
    if(write(fd, buf, 512) != 512){
     5ec:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     5f3:	00 
     5f4:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
     5fb:	00 
     5fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5ff:	89 04 24             	mov    %eax,(%esp)
     602:	e8 f5 38 00 00       	call   3efc <write>
     607:	3d 00 02 00 00       	cmp    $0x200,%eax
     60c:	74 21                	je     62f <writetest1+0xa8>
      printf(stdout, "error: write big file failed\n", i);
     60e:	a1 e8 62 00 00       	mov    0x62e8,%eax
     613:	8b 55 f4             	mov    -0xc(%ebp),%edx
     616:	89 54 24 08          	mov    %edx,0x8(%esp)
     61a:	c7 44 24 04 2e 47 00 	movl   $0x472e,0x4(%esp)
     621:	00 
     622:	89 04 24             	mov    %eax,(%esp)
     625:	e8 2f 3a 00 00       	call   4059 <printf>
      exit();
     62a:	e8 ad 38 00 00       	call   3edc <exit>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     62f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     633:	8b 45 f4             	mov    -0xc(%ebp),%eax
     636:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     63b:	76 a5                	jbe    5e2 <writetest1+0x5b>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     63d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     640:	89 04 24             	mov    %eax,(%esp)
     643:	e8 bc 38 00 00       	call   3f04 <close>

  fd = open("big", O_RDONLY);
     648:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     64f:	00 
     650:	c7 04 24 10 47 00 00 	movl   $0x4710,(%esp)
     657:	e8 c0 38 00 00       	call   3f1c <open>
     65c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     65f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     663:	79 1a                	jns    67f <writetest1+0xf8>
    printf(stdout, "error: open big failed!\n");
     665:	a1 e8 62 00 00       	mov    0x62e8,%eax
     66a:	c7 44 24 04 4c 47 00 	movl   $0x474c,0x4(%esp)
     671:	00 
     672:	89 04 24             	mov    %eax,(%esp)
     675:	e8 df 39 00 00       	call   4059 <printf>
    exit();
     67a:	e8 5d 38 00 00       	call   3edc <exit>
  }

  n = 0;
     67f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     686:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     68d:	00 
     68e:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
     695:	00 
     696:	8b 45 ec             	mov    -0x14(%ebp),%eax
     699:	89 04 24             	mov    %eax,(%esp)
     69c:	e8 53 38 00 00       	call   3ef4 <read>
     6a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     6a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6a8:	75 2e                	jne    6d8 <writetest1+0x151>
      if(n == MAXFILE - 1){
     6aa:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     6b1:	0f 85 8c 00 00 00    	jne    743 <writetest1+0x1bc>
        printf(stdout, "read only %d blocks from big", n);
     6b7:	a1 e8 62 00 00       	mov    0x62e8,%eax
     6bc:	8b 55 f0             	mov    -0x10(%ebp),%edx
     6bf:	89 54 24 08          	mov    %edx,0x8(%esp)
     6c3:	c7 44 24 04 65 47 00 	movl   $0x4765,0x4(%esp)
     6ca:	00 
     6cb:	89 04 24             	mov    %eax,(%esp)
     6ce:	e8 86 39 00 00       	call   4059 <printf>
        exit();
     6d3:	e8 04 38 00 00       	call   3edc <exit>
      }
      break;
    } else if(i != 512){
     6d8:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     6df:	74 21                	je     702 <writetest1+0x17b>
      printf(stdout, "read failed %d\n", i);
     6e1:	a1 e8 62 00 00       	mov    0x62e8,%eax
     6e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6e9:	89 54 24 08          	mov    %edx,0x8(%esp)
     6ed:	c7 44 24 04 82 47 00 	movl   $0x4782,0x4(%esp)
     6f4:	00 
     6f5:	89 04 24             	mov    %eax,(%esp)
     6f8:	e8 5c 39 00 00       	call   4059 <printf>
      exit();
     6fd:	e8 da 37 00 00       	call   3edc <exit>
    }
    if(((int*)buf)[0] != n){
     702:	b8 e0 8a 00 00       	mov    $0x8ae0,%eax
     707:	8b 00                	mov    (%eax),%eax
     709:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     70c:	74 2c                	je     73a <writetest1+0x1b3>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     70e:	b8 e0 8a 00 00       	mov    $0x8ae0,%eax
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     713:	8b 10                	mov    (%eax),%edx
     715:	a1 e8 62 00 00       	mov    0x62e8,%eax
     71a:	89 54 24 0c          	mov    %edx,0xc(%esp)
     71e:	8b 55 f0             	mov    -0x10(%ebp),%edx
     721:	89 54 24 08          	mov    %edx,0x8(%esp)
     725:	c7 44 24 04 94 47 00 	movl   $0x4794,0x4(%esp)
     72c:	00 
     72d:	89 04 24             	mov    %eax,(%esp)
     730:	e8 24 39 00 00       	call   4059 <printf>
             n, ((int*)buf)[0]);
      exit();
     735:	e8 a2 37 00 00       	call   3edc <exit>
    }
    n++;
     73a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }
     73e:	e9 43 ff ff ff       	jmp    686 <writetest1+0xff>
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
     743:	90                   	nop
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     744:	8b 45 ec             	mov    -0x14(%ebp),%eax
     747:	89 04 24             	mov    %eax,(%esp)
     74a:	e8 b5 37 00 00       	call   3f04 <close>
  if(unlink("big") < 0){
     74f:	c7 04 24 10 47 00 00 	movl   $0x4710,(%esp)
     756:	e8 d1 37 00 00       	call   3f2c <unlink>
     75b:	85 c0                	test   %eax,%eax
     75d:	79 1a                	jns    779 <writetest1+0x1f2>
    printf(stdout, "unlink big failed\n");
     75f:	a1 e8 62 00 00       	mov    0x62e8,%eax
     764:	c7 44 24 04 b4 47 00 	movl   $0x47b4,0x4(%esp)
     76b:	00 
     76c:	89 04 24             	mov    %eax,(%esp)
     76f:	e8 e5 38 00 00       	call   4059 <printf>
    exit();
     774:	e8 63 37 00 00       	call   3edc <exit>
  }
  printf(stdout, "big files ok\n");
     779:	a1 e8 62 00 00       	mov    0x62e8,%eax
     77e:	c7 44 24 04 c7 47 00 	movl   $0x47c7,0x4(%esp)
     785:	00 
     786:	89 04 24             	mov    %eax,(%esp)
     789:	e8 cb 38 00 00       	call   4059 <printf>
}
     78e:	c9                   	leave  
     78f:	c3                   	ret    

00000790 <createtest>:

void
createtest(void)
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	83 ec 28             	sub    $0x28,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     796:	a1 e8 62 00 00       	mov    0x62e8,%eax
     79b:	c7 44 24 04 d8 47 00 	movl   $0x47d8,0x4(%esp)
     7a2:	00 
     7a3:	89 04 24             	mov    %eax,(%esp)
     7a6:	e8 ae 38 00 00       	call   4059 <printf>

  name[0] = 'a';
     7ab:	c6 05 e0 aa 00 00 61 	movb   $0x61,0xaae0
  name[2] = '\0';
     7b2:	c6 05 e2 aa 00 00 00 	movb   $0x0,0xaae2
  for(i = 0; i < 52; i++){
     7b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7c0:	eb 31                	jmp    7f3 <createtest+0x63>
    name[1] = '0' + i;
     7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c5:	83 c0 30             	add    $0x30,%eax
     7c8:	a2 e1 aa 00 00       	mov    %al,0xaae1
    fd = open(name, O_CREATE|O_RDWR);
     7cd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     7d4:	00 
     7d5:	c7 04 24 e0 aa 00 00 	movl   $0xaae0,(%esp)
     7dc:	e8 3b 37 00 00       	call   3f1c <open>
     7e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     7e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e7:	89 04 24             	mov    %eax,(%esp)
     7ea:	e8 15 37 00 00       	call   3f04 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     7ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     7f3:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     7f7:	7e c9                	jle    7c2 <createtest+0x32>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     7f9:	c6 05 e0 aa 00 00 61 	movb   $0x61,0xaae0
  name[2] = '\0';
     800:	c6 05 e2 aa 00 00 00 	movb   $0x0,0xaae2
  for(i = 0; i < 52; i++){
     807:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     80e:	eb 1b                	jmp    82b <createtest+0x9b>
    name[1] = '0' + i;
     810:	8b 45 f4             	mov    -0xc(%ebp),%eax
     813:	83 c0 30             	add    $0x30,%eax
     816:	a2 e1 aa 00 00       	mov    %al,0xaae1
    unlink(name);
     81b:	c7 04 24 e0 aa 00 00 	movl   $0xaae0,(%esp)
     822:	e8 05 37 00 00       	call   3f2c <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     827:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     82b:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     82f:	7e df                	jle    810 <createtest+0x80>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     831:	a1 e8 62 00 00       	mov    0x62e8,%eax
     836:	c7 44 24 04 00 48 00 	movl   $0x4800,0x4(%esp)
     83d:	00 
     83e:	89 04 24             	mov    %eax,(%esp)
     841:	e8 13 38 00 00       	call   4059 <printf>
}
     846:	c9                   	leave  
     847:	c3                   	ret    

00000848 <dirtest>:

void dirtest(void)
{
     848:	55                   	push   %ebp
     849:	89 e5                	mov    %esp,%ebp
     84b:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     84e:	a1 e8 62 00 00       	mov    0x62e8,%eax
     853:	c7 44 24 04 26 48 00 	movl   $0x4826,0x4(%esp)
     85a:	00 
     85b:	89 04 24             	mov    %eax,(%esp)
     85e:	e8 f6 37 00 00       	call   4059 <printf>

  if(mkdir("dir0") < 0){
     863:	c7 04 24 32 48 00 00 	movl   $0x4832,(%esp)
     86a:	e8 d5 36 00 00       	call   3f44 <mkdir>
     86f:	85 c0                	test   %eax,%eax
     871:	79 1a                	jns    88d <dirtest+0x45>
    printf(stdout, "mkdir failed\n");
     873:	a1 e8 62 00 00       	mov    0x62e8,%eax
     878:	c7 44 24 04 55 44 00 	movl   $0x4455,0x4(%esp)
     87f:	00 
     880:	89 04 24             	mov    %eax,(%esp)
     883:	e8 d1 37 00 00       	call   4059 <printf>
    exit();
     888:	e8 4f 36 00 00       	call   3edc <exit>
  }

  if(chdir("dir0") < 0){
     88d:	c7 04 24 32 48 00 00 	movl   $0x4832,(%esp)
     894:	e8 b3 36 00 00       	call   3f4c <chdir>
     899:	85 c0                	test   %eax,%eax
     89b:	79 1a                	jns    8b7 <dirtest+0x6f>
    printf(stdout, "chdir dir0 failed\n");
     89d:	a1 e8 62 00 00       	mov    0x62e8,%eax
     8a2:	c7 44 24 04 37 48 00 	movl   $0x4837,0x4(%esp)
     8a9:	00 
     8aa:	89 04 24             	mov    %eax,(%esp)
     8ad:	e8 a7 37 00 00       	call   4059 <printf>
    exit();
     8b2:	e8 25 36 00 00       	call   3edc <exit>
  }

  if(chdir("..") < 0){
     8b7:	c7 04 24 4a 48 00 00 	movl   $0x484a,(%esp)
     8be:	e8 89 36 00 00       	call   3f4c <chdir>
     8c3:	85 c0                	test   %eax,%eax
     8c5:	79 1a                	jns    8e1 <dirtest+0x99>
    printf(stdout, "chdir .. failed\n");
     8c7:	a1 e8 62 00 00       	mov    0x62e8,%eax
     8cc:	c7 44 24 04 4d 48 00 	movl   $0x484d,0x4(%esp)
     8d3:	00 
     8d4:	89 04 24             	mov    %eax,(%esp)
     8d7:	e8 7d 37 00 00       	call   4059 <printf>
    exit();
     8dc:	e8 fb 35 00 00       	call   3edc <exit>
  }

  if(unlink("dir0") < 0){
     8e1:	c7 04 24 32 48 00 00 	movl   $0x4832,(%esp)
     8e8:	e8 3f 36 00 00       	call   3f2c <unlink>
     8ed:	85 c0                	test   %eax,%eax
     8ef:	79 1a                	jns    90b <dirtest+0xc3>
    printf(stdout, "unlink dir0 failed\n");
     8f1:	a1 e8 62 00 00       	mov    0x62e8,%eax
     8f6:	c7 44 24 04 5e 48 00 	movl   $0x485e,0x4(%esp)
     8fd:	00 
     8fe:	89 04 24             	mov    %eax,(%esp)
     901:	e8 53 37 00 00       	call   4059 <printf>
    exit();
     906:	e8 d1 35 00 00       	call   3edc <exit>
  }
  printf(stdout, "mkdir test ok\n");
     90b:	a1 e8 62 00 00       	mov    0x62e8,%eax
     910:	c7 44 24 04 72 48 00 	movl   $0x4872,0x4(%esp)
     917:	00 
     918:	89 04 24             	mov    %eax,(%esp)
     91b:	e8 39 37 00 00       	call   4059 <printf>
}
     920:	c9                   	leave  
     921:	c3                   	ret    

00000922 <exectest>:

void
exectest(void)
{
     922:	55                   	push   %ebp
     923:	89 e5                	mov    %esp,%ebp
     925:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
     928:	a1 e8 62 00 00       	mov    0x62e8,%eax
     92d:	c7 44 24 04 81 48 00 	movl   $0x4881,0x4(%esp)
     934:	00 
     935:	89 04 24             	mov    %eax,(%esp)
     938:	e8 1c 37 00 00       	call   4059 <printf>
  if(exec("echo", echoargv) < 0){
     93d:	c7 44 24 04 d4 62 00 	movl   $0x62d4,0x4(%esp)
     944:	00 
     945:	c7 04 24 2c 44 00 00 	movl   $0x442c,(%esp)
     94c:	e8 c3 35 00 00       	call   3f14 <exec>
     951:	85 c0                	test   %eax,%eax
     953:	79 1a                	jns    96f <exectest+0x4d>
    printf(stdout, "exec echo failed\n");
     955:	a1 e8 62 00 00       	mov    0x62e8,%eax
     95a:	c7 44 24 04 8c 48 00 	movl   $0x488c,0x4(%esp)
     961:	00 
     962:	89 04 24             	mov    %eax,(%esp)
     965:	e8 ef 36 00 00       	call   4059 <printf>
    exit();
     96a:	e8 6d 35 00 00       	call   3edc <exit>
  }
}
     96f:	c9                   	leave  
     970:	c3                   	ret    

00000971 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     971:	55                   	push   %ebp
     972:	89 e5                	mov    %esp,%ebp
     974:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     977:	8d 45 d8             	lea    -0x28(%ebp),%eax
     97a:	89 04 24             	mov    %eax,(%esp)
     97d:	e8 6a 35 00 00       	call   3eec <pipe>
     982:	85 c0                	test   %eax,%eax
     984:	74 19                	je     99f <pipe1+0x2e>
    printf(1, "pipe() failed\n");
     986:	c7 44 24 04 9e 48 00 	movl   $0x489e,0x4(%esp)
     98d:	00 
     98e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     995:	e8 bf 36 00 00       	call   4059 <printf>
    exit();
     99a:	e8 3d 35 00 00       	call   3edc <exit>
  }
  pid = fork();
     99f:	e8 30 35 00 00       	call   3ed4 <fork>
     9a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     9a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     9ae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     9b2:	0f 85 86 00 00 00    	jne    a3e <pipe1+0xcd>
    close(fds[0]);
     9b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9bb:	89 04 24             	mov    %eax,(%esp)
     9be:	e8 41 35 00 00       	call   3f04 <close>
    for(n = 0; n < 5; n++){
     9c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     9ca:	eb 67                	jmp    a33 <pipe1+0xc2>
      for(i = 0; i < 1033; i++)
     9cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     9d3:	eb 16                	jmp    9eb <pipe1+0x7a>
        buf[i] = seq++;
     9d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
     9db:	81 c2 e0 8a 00 00    	add    $0x8ae0,%edx
     9e1:	88 02                	mov    %al,(%edx)
     9e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     9e7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     9eb:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     9f2:	7e e1                	jle    9d5 <pipe1+0x64>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     9f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     9f7:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     9fe:	00 
     9ff:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
     a06:	00 
     a07:	89 04 24             	mov    %eax,(%esp)
     a0a:	e8 ed 34 00 00       	call   3efc <write>
     a0f:	3d 09 04 00 00       	cmp    $0x409,%eax
     a14:	74 19                	je     a2f <pipe1+0xbe>
        printf(1, "pipe1 oops 1\n");
     a16:	c7 44 24 04 ad 48 00 	movl   $0x48ad,0x4(%esp)
     a1d:	00 
     a1e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a25:	e8 2f 36 00 00       	call   4059 <printf>
        exit();
     a2a:	e8 ad 34 00 00       	call   3edc <exit>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     a2f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     a33:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     a37:	7e 93                	jle    9cc <pipe1+0x5b>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     a39:	e8 9e 34 00 00       	call   3edc <exit>
  } else if(pid > 0){
     a3e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a42:	0f 8e fc 00 00 00    	jle    b44 <pipe1+0x1d3>
    close(fds[1]);
     a48:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a4b:	89 04 24             	mov    %eax,(%esp)
     a4e:	e8 b1 34 00 00       	call   3f04 <close>
    total = 0;
     a53:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     a5a:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a61:	eb 6b                	jmp    ace <pipe1+0x15d>
      for(i = 0; i < n; i++){
     a63:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a6a:	eb 40                	jmp    aac <pipe1+0x13b>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a6f:	05 e0 8a 00 00       	add    $0x8ae0,%eax
     a74:	0f b6 00             	movzbl (%eax),%eax
     a77:	0f be c0             	movsbl %al,%eax
     a7a:	33 45 f4             	xor    -0xc(%ebp),%eax
     a7d:	25 ff 00 00 00       	and    $0xff,%eax
     a82:	85 c0                	test   %eax,%eax
     a84:	0f 95 c0             	setne  %al
     a87:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a8b:	84 c0                	test   %al,%al
     a8d:	74 19                	je     aa8 <pipe1+0x137>
          printf(1, "pipe1 oops 2\n");
     a8f:	c7 44 24 04 bb 48 00 	movl   $0x48bb,0x4(%esp)
     a96:	00 
     a97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a9e:	e8 b6 35 00 00       	call   4059 <printf>
     aa3:	e9 b5 00 00 00       	jmp    b5d <pipe1+0x1ec>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     aa8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aaf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ab2:	7c b8                	jl     a6c <pipe1+0xfb>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     ab4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ab7:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     aba:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     abd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac0:	3d 00 20 00 00       	cmp    $0x2000,%eax
     ac5:	76 07                	jbe    ace <pipe1+0x15d>
        cc = sizeof(buf);
     ac7:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     ace:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad1:	8b 55 e8             	mov    -0x18(%ebp),%edx
     ad4:	89 54 24 08          	mov    %edx,0x8(%esp)
     ad8:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
     adf:	00 
     ae0:	89 04 24             	mov    %eax,(%esp)
     ae3:	e8 0c 34 00 00       	call   3ef4 <read>
     ae8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     aeb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     aef:	0f 8f 6e ff ff ff    	jg     a63 <pipe1+0xf2>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     af5:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     afc:	74 20                	je     b1e <pipe1+0x1ad>
      printf(1, "pipe1 oops 3 total %d\n", total);
     afe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b01:	89 44 24 08          	mov    %eax,0x8(%esp)
     b05:	c7 44 24 04 c9 48 00 	movl   $0x48c9,0x4(%esp)
     b0c:	00 
     b0d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b14:	e8 40 35 00 00       	call   4059 <printf>
      exit();
     b19:	e8 be 33 00 00       	call   3edc <exit>
    }
    close(fds[0]);
     b1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b21:	89 04 24             	mov    %eax,(%esp)
     b24:	e8 db 33 00 00       	call   3f04 <close>
    wait();
     b29:	e8 b6 33 00 00       	call   3ee4 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b2e:	c7 44 24 04 e0 48 00 	movl   $0x48e0,0x4(%esp)
     b35:	00 
     b36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b3d:	e8 17 35 00 00       	call   4059 <printf>
     b42:	eb 19                	jmp    b5d <pipe1+0x1ec>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     b44:	c7 44 24 04 ea 48 00 	movl   $0x48ea,0x4(%esp)
     b4b:	00 
     b4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b53:	e8 01 35 00 00       	call   4059 <printf>
    exit();
     b58:	e8 7f 33 00 00       	call   3edc <exit>
  }
  printf(1, "pipe1 ok\n");
}
     b5d:	c9                   	leave  
     b5e:	c3                   	ret    

00000b5f <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     b5f:	55                   	push   %ebp
     b60:	89 e5                	mov    %esp,%ebp
     b62:	83 ec 38             	sub    $0x38,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     b65:	c7 44 24 04 f9 48 00 	movl   $0x48f9,0x4(%esp)
     b6c:	00 
     b6d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b74:	e8 e0 34 00 00       	call   4059 <printf>
  pid1 = fork();
     b79:	e8 56 33 00 00       	call   3ed4 <fork>
     b7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     b81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b85:	75 02                	jne    b89 <preempt+0x2a>
    for(;;)
      ;
     b87:	eb fe                	jmp    b87 <preempt+0x28>

  pid2 = fork();
     b89:	e8 46 33 00 00       	call   3ed4 <fork>
     b8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     b91:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     b95:	75 02                	jne    b99 <preempt+0x3a>
    for(;;)
      ;
     b97:	eb fe                	jmp    b97 <preempt+0x38>

  pipe(pfds);
     b99:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b9c:	89 04 24             	mov    %eax,(%esp)
     b9f:	e8 48 33 00 00       	call   3eec <pipe>
  pid3 = fork();
     ba4:	e8 2b 33 00 00       	call   3ed4 <fork>
     ba9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     bac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bb0:	75 4c                	jne    bfe <preempt+0x9f>
    close(pfds[0]);
     bb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bb5:	89 04 24             	mov    %eax,(%esp)
     bb8:	e8 47 33 00 00       	call   3f04 <close>
    if(write(pfds[1], "x", 1) != 1)
     bbd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bc0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     bc7:	00 
     bc8:	c7 44 24 04 03 49 00 	movl   $0x4903,0x4(%esp)
     bcf:	00 
     bd0:	89 04 24             	mov    %eax,(%esp)
     bd3:	e8 24 33 00 00       	call   3efc <write>
     bd8:	83 f8 01             	cmp    $0x1,%eax
     bdb:	74 14                	je     bf1 <preempt+0x92>
      printf(1, "preempt write error");
     bdd:	c7 44 24 04 05 49 00 	movl   $0x4905,0x4(%esp)
     be4:	00 
     be5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bec:	e8 68 34 00 00       	call   4059 <printf>
    close(pfds[1]);
     bf1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bf4:	89 04 24             	mov    %eax,(%esp)
     bf7:	e8 08 33 00 00       	call   3f04 <close>
    for(;;)
      ;
     bfc:	eb fe                	jmp    bfc <preempt+0x9d>
  }

  close(pfds[1]);
     bfe:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c01:	89 04 24             	mov    %eax,(%esp)
     c04:	e8 fb 32 00 00       	call   3f04 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c0c:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     c13:	00 
     c14:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
     c1b:	00 
     c1c:	89 04 24             	mov    %eax,(%esp)
     c1f:	e8 d0 32 00 00       	call   3ef4 <read>
     c24:	83 f8 01             	cmp    $0x1,%eax
     c27:	74 16                	je     c3f <preempt+0xe0>
    printf(1, "preempt read error");
     c29:	c7 44 24 04 19 49 00 	movl   $0x4919,0x4(%esp)
     c30:	00 
     c31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c38:	e8 1c 34 00 00       	call   4059 <printf>
     c3d:	eb 77                	jmp    cb6 <preempt+0x157>
    return;
  }
  close(pfds[0]);
     c3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c42:	89 04 24             	mov    %eax,(%esp)
     c45:	e8 ba 32 00 00       	call   3f04 <close>
  printf(1, "kill... ");
     c4a:	c7 44 24 04 2c 49 00 	movl   $0x492c,0x4(%esp)
     c51:	00 
     c52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c59:	e8 fb 33 00 00       	call   4059 <printf>
  kill(pid1);
     c5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c61:	89 04 24             	mov    %eax,(%esp)
     c64:	e8 a3 32 00 00       	call   3f0c <kill>
  kill(pid2);
     c69:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c6c:	89 04 24             	mov    %eax,(%esp)
     c6f:	e8 98 32 00 00       	call   3f0c <kill>
  kill(pid3);
     c74:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c77:	89 04 24             	mov    %eax,(%esp)
     c7a:	e8 8d 32 00 00       	call   3f0c <kill>
  printf(1, "wait... ");
     c7f:	c7 44 24 04 35 49 00 	movl   $0x4935,0x4(%esp)
     c86:	00 
     c87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c8e:	e8 c6 33 00 00       	call   4059 <printf>
  wait();
     c93:	e8 4c 32 00 00       	call   3ee4 <wait>
  wait();
     c98:	e8 47 32 00 00       	call   3ee4 <wait>
  wait();
     c9d:	e8 42 32 00 00       	call   3ee4 <wait>
  printf(1, "preempt ok\n");
     ca2:	c7 44 24 04 3e 49 00 	movl   $0x493e,0x4(%esp)
     ca9:	00 
     caa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cb1:	e8 a3 33 00 00       	call   4059 <printf>
}
     cb6:	c9                   	leave  
     cb7:	c3                   	ret    

00000cb8 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     cb8:	55                   	push   %ebp
     cb9:	89 e5                	mov    %esp,%ebp
     cbb:	83 ec 28             	sub    $0x28,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     cbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cc5:	eb 53                	jmp    d1a <exitwait+0x62>
    pid = fork();
     cc7:	e8 08 32 00 00       	call   3ed4 <fork>
     ccc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     ccf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     cd3:	79 16                	jns    ceb <exitwait+0x33>
      printf(1, "fork failed\n");
     cd5:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
     cdc:	00 
     cdd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ce4:	e8 70 33 00 00       	call   4059 <printf>
      return;
     ce9:	eb 49                	jmp    d34 <exitwait+0x7c>
    }
    if(pid){
     ceb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     cef:	74 20                	je     d11 <exitwait+0x59>
      if(wait() != pid){
     cf1:	e8 ee 31 00 00       	call   3ee4 <wait>
     cf6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cf9:	74 1b                	je     d16 <exitwait+0x5e>
        printf(1, "wait wrong pid\n");
     cfb:	c7 44 24 04 4a 49 00 	movl   $0x494a,0x4(%esp)
     d02:	00 
     d03:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d0a:	e8 4a 33 00 00       	call   4059 <printf>
        return;
     d0f:	eb 23                	jmp    d34 <exitwait+0x7c>
      }
    } else {
      exit();
     d11:	e8 c6 31 00 00       	call   3edc <exit>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     d16:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d1a:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     d1e:	7e a7                	jle    cc7 <exitwait+0xf>
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     d20:	c7 44 24 04 5a 49 00 	movl   $0x495a,0x4(%esp)
     d27:	00 
     d28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d2f:	e8 25 33 00 00       	call   4059 <printf>
}
     d34:	c9                   	leave  
     d35:	c3                   	ret    

00000d36 <mem>:

void
mem(void)
{
     d36:	55                   	push   %ebp
     d37:	89 e5                	mov    %esp,%ebp
     d39:	83 ec 28             	sub    $0x28,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     d3c:	c7 44 24 04 67 49 00 	movl   $0x4967,0x4(%esp)
     d43:	00 
     d44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d4b:	e8 09 33 00 00       	call   4059 <printf>
  ppid = getpid();
     d50:	e8 07 32 00 00       	call   3f5c <getpid>
     d55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     d58:	e8 77 31 00 00       	call   3ed4 <fork>
     d5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     d60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     d64:	0f 85 aa 00 00 00    	jne    e14 <mem+0xde>
    m1 = 0;
     d6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     d71:	eb 0e                	jmp    d81 <mem+0x4b>
      *(char**)m2 = m1;
     d73:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d76:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d79:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     d7b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d7e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     d81:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     d88:	e8 bc 35 00 00       	call   4349 <malloc>
     d8d:	89 45 e8             	mov    %eax,-0x18(%ebp)
     d90:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d94:	75 dd                	jne    d73 <mem+0x3d>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     d96:	eb 19                	jmp    db1 <mem+0x7b>
      m2 = *(char**)m1;
     d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9b:	8b 00                	mov    (%eax),%eax
     d9d:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     da0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da3:	89 04 24             	mov    %eax,(%esp)
     da6:	e8 65 34 00 00       	call   4210 <free>
      m1 = m2;
     dab:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     db1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     db5:	75 e1                	jne    d98 <mem+0x62>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     db7:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     dbe:	e8 86 35 00 00       	call   4349 <malloc>
     dc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     dc6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dca:	75 24                	jne    df0 <mem+0xba>
      printf(1, "couldn't allocate mem?!!\n");
     dcc:	c7 44 24 04 71 49 00 	movl   $0x4971,0x4(%esp)
     dd3:	00 
     dd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ddb:	e8 79 32 00 00       	call   4059 <printf>
      kill(ppid);
     de0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     de3:	89 04 24             	mov    %eax,(%esp)
     de6:	e8 21 31 00 00       	call   3f0c <kill>
      exit();
     deb:	e8 ec 30 00 00       	call   3edc <exit>
    }
    free(m1);
     df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df3:	89 04 24             	mov    %eax,(%esp)
     df6:	e8 15 34 00 00       	call   4210 <free>
    printf(1, "mem ok\n");
     dfb:	c7 44 24 04 8b 49 00 	movl   $0x498b,0x4(%esp)
     e02:	00 
     e03:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e0a:	e8 4a 32 00 00       	call   4059 <printf>
    exit();
     e0f:	e8 c8 30 00 00       	call   3edc <exit>
  } else {
    wait();
     e14:	e8 cb 30 00 00       	call   3ee4 <wait>
  }
}
     e19:	c9                   	leave  
     e1a:	c3                   	ret    

00000e1b <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e1b:	55                   	push   %ebp
     e1c:	89 e5                	mov    %esp,%ebp
     e1e:	83 ec 48             	sub    $0x48,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e21:	c7 44 24 04 93 49 00 	movl   $0x4993,0x4(%esp)
     e28:	00 
     e29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e30:	e8 24 32 00 00       	call   4059 <printf>

  unlink("sharedfd");
     e35:	c7 04 24 a2 49 00 00 	movl   $0x49a2,(%esp)
     e3c:	e8 eb 30 00 00       	call   3f2c <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e41:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     e48:	00 
     e49:	c7 04 24 a2 49 00 00 	movl   $0x49a2,(%esp)
     e50:	e8 c7 30 00 00       	call   3f1c <open>
     e55:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     e58:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e5c:	79 19                	jns    e77 <sharedfd+0x5c>
    printf(1, "fstests: cannot open sharedfd for writing");
     e5e:	c7 44 24 04 ac 49 00 	movl   $0x49ac,0x4(%esp)
     e65:	00 
     e66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e6d:	e8 e7 31 00 00       	call   4059 <printf>
     e72:	e9 a0 01 00 00       	jmp    1017 <sharedfd+0x1fc>
    return;
  }
  pid = fork();
     e77:	e8 58 30 00 00       	call   3ed4 <fork>
     e7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     e83:	75 07                	jne    e8c <sharedfd+0x71>
     e85:	b8 63 00 00 00       	mov    $0x63,%eax
     e8a:	eb 05                	jmp    e91 <sharedfd+0x76>
     e8c:	b8 70 00 00 00       	mov    $0x70,%eax
     e91:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     e98:	00 
     e99:	89 44 24 04          	mov    %eax,0x4(%esp)
     e9d:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ea0:	89 04 24             	mov    %eax,(%esp)
     ea3:	e8 8d 2e 00 00       	call   3d35 <memset>
  for(i = 0; i < 1000; i++){
     ea8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     eaf:	eb 39                	jmp    eea <sharedfd+0xcf>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     eb1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     eb8:	00 
     eb9:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ebc:	89 44 24 04          	mov    %eax,0x4(%esp)
     ec0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ec3:	89 04 24             	mov    %eax,(%esp)
     ec6:	e8 31 30 00 00       	call   3efc <write>
     ecb:	83 f8 0a             	cmp    $0xa,%eax
     ece:	74 16                	je     ee6 <sharedfd+0xcb>
      printf(1, "fstests: write sharedfd failed\n");
     ed0:	c7 44 24 04 d8 49 00 	movl   $0x49d8,0x4(%esp)
     ed7:	00 
     ed8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     edf:	e8 75 31 00 00       	call   4059 <printf>
      break;
     ee4:	eb 0d                	jmp    ef3 <sharedfd+0xd8>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 1000; i++){
     ee6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     eea:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     ef1:	7e be                	jle    eb1 <sharedfd+0x96>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
     ef3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ef7:	75 05                	jne    efe <sharedfd+0xe3>
    exit();
     ef9:	e8 de 2f 00 00       	call   3edc <exit>
  else
    wait();
     efe:	e8 e1 2f 00 00       	call   3ee4 <wait>
  close(fd);
     f03:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f06:	89 04 24             	mov    %eax,(%esp)
     f09:	e8 f6 2f 00 00       	call   3f04 <close>
  fd = open("sharedfd", 0);
     f0e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     f15:	00 
     f16:	c7 04 24 a2 49 00 00 	movl   $0x49a2,(%esp)
     f1d:	e8 fa 2f 00 00       	call   3f1c <open>
     f22:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     f25:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     f29:	79 19                	jns    f44 <sharedfd+0x129>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f2b:	c7 44 24 04 f8 49 00 	movl   $0x49f8,0x4(%esp)
     f32:	00 
     f33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f3a:	e8 1a 31 00 00       	call   4059 <printf>
     f3f:	e9 d3 00 00 00       	jmp    1017 <sharedfd+0x1fc>
    return;
  }
  nc = np = 0;
     f44:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f51:	eb 3b                	jmp    f8e <sharedfd+0x173>
    for(i = 0; i < sizeof(buf); i++){
     f53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f5a:	eb 2a                	jmp    f86 <sharedfd+0x16b>
      if(buf[i] == 'c')
     f5c:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     f5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f62:	01 d0                	add    %edx,%eax
     f64:	0f b6 00             	movzbl (%eax),%eax
     f67:	3c 63                	cmp    $0x63,%al
     f69:	75 04                	jne    f6f <sharedfd+0x154>
        nc++;
     f6b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
     f6f:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     f72:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f75:	01 d0                	add    %edx,%eax
     f77:	0f b6 00             	movzbl (%eax),%eax
     f7a:	3c 70                	cmp    $0x70,%al
     f7c:	75 04                	jne    f82 <sharedfd+0x167>
        np++;
     f7e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     f82:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f89:	83 f8 09             	cmp    $0x9,%eax
     f8c:	76 ce                	jbe    f5c <sharedfd+0x141>
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f8e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     f95:	00 
     f96:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f99:	89 44 24 04          	mov    %eax,0x4(%esp)
     f9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fa0:	89 04 24             	mov    %eax,(%esp)
     fa3:	e8 4c 2f 00 00       	call   3ef4 <read>
     fa8:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     faf:	7f a2                	jg     f53 <sharedfd+0x138>
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     fb1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fb4:	89 04 24             	mov    %eax,(%esp)
     fb7:	e8 48 2f 00 00       	call   3f04 <close>
  unlink("sharedfd");
     fbc:	c7 04 24 a2 49 00 00 	movl   $0x49a2,(%esp)
     fc3:	e8 64 2f 00 00       	call   3f2c <unlink>
  if(nc == 10000 && np == 10000){
     fc8:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     fcf:	75 1f                	jne    ff0 <sharedfd+0x1d5>
     fd1:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     fd8:	75 16                	jne    ff0 <sharedfd+0x1d5>
    printf(1, "sharedfd ok\n");
     fda:	c7 44 24 04 23 4a 00 	movl   $0x4a23,0x4(%esp)
     fe1:	00 
     fe2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fe9:	e8 6b 30 00 00       	call   4059 <printf>
     fee:	eb 27                	jmp    1017 <sharedfd+0x1fc>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     ff0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ff3:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ffa:	89 44 24 08          	mov    %eax,0x8(%esp)
     ffe:	c7 44 24 04 30 4a 00 	movl   $0x4a30,0x4(%esp)
    1005:	00 
    1006:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    100d:	e8 47 30 00 00       	call   4059 <printf>
    exit();
    1012:	e8 c5 2e 00 00       	call   3edc <exit>
  }
}
    1017:	c9                   	leave  
    1018:	c3                   	ret    

00001019 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1019:	55                   	push   %ebp
    101a:	89 e5                	mov    %esp,%ebp
    101c:	83 ec 48             	sub    $0x48,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    101f:	c7 45 c8 45 4a 00 00 	movl   $0x4a45,-0x38(%ebp)
    1026:	c7 45 cc 48 4a 00 00 	movl   $0x4a48,-0x34(%ebp)
    102d:	c7 45 d0 4b 4a 00 00 	movl   $0x4a4b,-0x30(%ebp)
    1034:	c7 45 d4 4e 4a 00 00 	movl   $0x4a4e,-0x2c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    103b:	c7 44 24 04 51 4a 00 	movl   $0x4a51,0x4(%esp)
    1042:	00 
    1043:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104a:	e8 0a 30 00 00       	call   4059 <printf>

  for(pi = 0; pi < 4; pi++){
    104f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1056:	e9 fc 00 00 00       	jmp    1157 <fourfiles+0x13e>
    fname = names[pi];
    105b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    105e:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    1062:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    unlink(fname);
    1065:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1068:	89 04 24             	mov    %eax,(%esp)
    106b:	e8 bc 2e 00 00       	call   3f2c <unlink>

    pid = fork();
    1070:	e8 5f 2e 00 00       	call   3ed4 <fork>
    1075:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(pid < 0){
    1078:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    107c:	79 19                	jns    1097 <fourfiles+0x7e>
      printf(1, "fork failed\n");
    107e:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
    1085:	00 
    1086:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    108d:	e8 c7 2f 00 00       	call   4059 <printf>
      exit();
    1092:	e8 45 2e 00 00       	call   3edc <exit>
    }

    if(pid == 0){
    1097:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    109b:	0f 85 b2 00 00 00    	jne    1153 <fourfiles+0x13a>
      fd = open(fname, O_CREATE | O_RDWR);
    10a1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    10a8:	00 
    10a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10ac:	89 04 24             	mov    %eax,(%esp)
    10af:	e8 68 2e 00 00       	call   3f1c <open>
    10b4:	89 45 dc             	mov    %eax,-0x24(%ebp)
      if(fd < 0){
    10b7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    10bb:	79 19                	jns    10d6 <fourfiles+0xbd>
        printf(1, "create failed\n");
    10bd:	c7 44 24 04 61 4a 00 	movl   $0x4a61,0x4(%esp)
    10c4:	00 
    10c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10cc:	e8 88 2f 00 00       	call   4059 <printf>
        exit();
    10d1:	e8 06 2e 00 00       	call   3edc <exit>
      }
      
      memset(buf, '0'+pi, 512);
    10d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10d9:	83 c0 30             	add    $0x30,%eax
    10dc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    10e3:	00 
    10e4:	89 44 24 04          	mov    %eax,0x4(%esp)
    10e8:	c7 04 24 e0 8a 00 00 	movl   $0x8ae0,(%esp)
    10ef:	e8 41 2c 00 00       	call   3d35 <memset>
      for(i = 0; i < 12; i++){
    10f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10fb:	eb 4b                	jmp    1148 <fourfiles+0x12f>
        if((n = write(fd, buf, 500)) != 500){
    10fd:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    1104:	00 
    1105:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    110c:	00 
    110d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1110:	89 04 24             	mov    %eax,(%esp)
    1113:	e8 e4 2d 00 00       	call   3efc <write>
    1118:	89 45 d8             	mov    %eax,-0x28(%ebp)
    111b:	81 7d d8 f4 01 00 00 	cmpl   $0x1f4,-0x28(%ebp)
    1122:	74 20                	je     1144 <fourfiles+0x12b>
          printf(1, "write failed %d\n", n);
    1124:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1127:	89 44 24 08          	mov    %eax,0x8(%esp)
    112b:	c7 44 24 04 70 4a 00 	movl   $0x4a70,0x4(%esp)
    1132:	00 
    1133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    113a:	e8 1a 2f 00 00       	call   4059 <printf>
          exit();
    113f:	e8 98 2d 00 00       	call   3edc <exit>
        printf(1, "create failed\n");
        exit();
      }
      
      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    1144:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1148:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    114c:	7e af                	jle    10fd <fourfiles+0xe4>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    114e:	e8 89 2d 00 00       	call   3edc <exit>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    1153:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1157:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    115b:	0f 8e fa fe ff ff    	jle    105b <fourfiles+0x42>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    1161:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1168:	eb 09                	jmp    1173 <fourfiles+0x15a>
    wait();
    116a:	e8 75 2d 00 00       	call   3ee4 <wait>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    116f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1173:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    1177:	7e f1                	jle    116a <fourfiles+0x151>
    wait();
  }

  for(i = 0; i < 2; i++){
    1179:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1180:	e9 dc 00 00 00       	jmp    1261 <fourfiles+0x248>
    fname = names[i];
    1185:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1188:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    118c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    fd = open(fname, 0);
    118f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1196:	00 
    1197:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    119a:	89 04 24             	mov    %eax,(%esp)
    119d:	e8 7a 2d 00 00       	call   3f1c <open>
    11a2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    total = 0;
    11a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11ac:	eb 4c                	jmp    11fa <fourfiles+0x1e1>
      for(j = 0; j < n; j++){
    11ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11b5:	eb 35                	jmp    11ec <fourfiles+0x1d3>
        if(buf[j] != '0'+i){
    11b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ba:	05 e0 8a 00 00       	add    $0x8ae0,%eax
    11bf:	0f b6 00             	movzbl (%eax),%eax
    11c2:	0f be c0             	movsbl %al,%eax
    11c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11c8:	83 c2 30             	add    $0x30,%edx
    11cb:	39 d0                	cmp    %edx,%eax
    11cd:	74 19                	je     11e8 <fourfiles+0x1cf>
          printf(1, "wrong char\n");
    11cf:	c7 44 24 04 81 4a 00 	movl   $0x4a81,0x4(%esp)
    11d6:	00 
    11d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11de:	e8 76 2e 00 00       	call   4059 <printf>
          exit();
    11e3:	e8 f4 2c 00 00       	call   3edc <exit>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    11e8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ef:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    11f2:	7c c3                	jl     11b7 <fourfiles+0x19e>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    11f4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    11f7:	01 45 ec             	add    %eax,-0x14(%ebp)

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11fa:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1201:	00 
    1202:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    1209:	00 
    120a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 df 2c 00 00       	call   3ef4 <read>
    1215:	89 45 d8             	mov    %eax,-0x28(%ebp)
    1218:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    121c:	7f 90                	jg     11ae <fourfiles+0x195>
          exit();
        }
      }
      total += n;
    }
    close(fd);
    121e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1221:	89 04 24             	mov    %eax,(%esp)
    1224:	e8 db 2c 00 00       	call   3f04 <close>
    if(total != 12*500){
    1229:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    1230:	74 20                	je     1252 <fourfiles+0x239>
      printf(1, "wrong length %d\n", total);
    1232:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1235:	89 44 24 08          	mov    %eax,0x8(%esp)
    1239:	c7 44 24 04 8d 4a 00 	movl   $0x4a8d,0x4(%esp)
    1240:	00 
    1241:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1248:	e8 0c 2e 00 00       	call   4059 <printf>
      exit();
    124d:	e8 8a 2c 00 00       	call   3edc <exit>
    }
    unlink(fname);
    1252:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1255:	89 04 24             	mov    %eax,(%esp)
    1258:	e8 cf 2c 00 00       	call   3f2c <unlink>

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    125d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1261:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    1265:	0f 8e 1a ff ff ff    	jle    1185 <fourfiles+0x16c>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    126b:	c7 44 24 04 9e 4a 00 	movl   $0x4a9e,0x4(%esp)
    1272:	00 
    1273:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    127a:	e8 da 2d 00 00       	call   4059 <printf>
}
    127f:	c9                   	leave  
    1280:	c3                   	ret    

00001281 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1281:	55                   	push   %ebp
    1282:	89 e5                	mov    %esp,%ebp
    1284:	83 ec 48             	sub    $0x48,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    1287:	c7 44 24 04 ac 4a 00 	movl   $0x4aac,0x4(%esp)
    128e:	00 
    128f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1296:	e8 be 2d 00 00       	call   4059 <printf>

  for(pi = 0; pi < 4; pi++){
    129b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12a2:	e9 f4 00 00 00       	jmp    139b <createdelete+0x11a>
    pid = fork();
    12a7:	e8 28 2c 00 00       	call   3ed4 <fork>
    12ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    12af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12b3:	79 19                	jns    12ce <createdelete+0x4d>
      printf(1, "fork failed\n");
    12b5:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
    12bc:	00 
    12bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12c4:	e8 90 2d 00 00       	call   4059 <printf>
      exit();
    12c9:	e8 0e 2c 00 00       	call   3edc <exit>
    }

    if(pid == 0){
    12ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12d2:	0f 85 bf 00 00 00    	jne    1397 <createdelete+0x116>
      name[0] = 'p' + pi;
    12d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12db:	83 c0 70             	add    $0x70,%eax
    12de:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    12e1:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    12e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12ec:	e9 97 00 00 00       	jmp    1388 <createdelete+0x107>
        name[1] = '0' + i;
    12f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12f4:	83 c0 30             	add    $0x30,%eax
    12f7:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    12fa:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1301:	00 
    1302:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1305:	89 04 24             	mov    %eax,(%esp)
    1308:	e8 0f 2c 00 00       	call   3f1c <open>
    130d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        if(fd < 0){
    1310:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1314:	79 19                	jns    132f <createdelete+0xae>
          printf(1, "create failed\n");
    1316:	c7 44 24 04 61 4a 00 	movl   $0x4a61,0x4(%esp)
    131d:	00 
    131e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1325:	e8 2f 2d 00 00       	call   4059 <printf>
          exit();
    132a:	e8 ad 2b 00 00       	call   3edc <exit>
        }
        close(fd);
    132f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1332:	89 04 24             	mov    %eax,(%esp)
    1335:	e8 ca 2b 00 00       	call   3f04 <close>
        if(i > 0 && (i % 2 ) == 0){
    133a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    133e:	7e 44                	jle    1384 <createdelete+0x103>
    1340:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1343:	83 e0 01             	and    $0x1,%eax
    1346:	85 c0                	test   %eax,%eax
    1348:	75 3a                	jne    1384 <createdelete+0x103>
          name[1] = '0' + (i / 2);
    134a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    134d:	89 c2                	mov    %eax,%edx
    134f:	c1 ea 1f             	shr    $0x1f,%edx
    1352:	01 d0                	add    %edx,%eax
    1354:	d1 f8                	sar    %eax
    1356:	83 c0 30             	add    $0x30,%eax
    1359:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    135c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    135f:	89 04 24             	mov    %eax,(%esp)
    1362:	e8 c5 2b 00 00       	call   3f2c <unlink>
    1367:	85 c0                	test   %eax,%eax
    1369:	79 19                	jns    1384 <createdelete+0x103>
            printf(1, "unlink failed\n");
    136b:	c7 44 24 04 50 45 00 	movl   $0x4550,0x4(%esp)
    1372:	00 
    1373:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    137a:	e8 da 2c 00 00       	call   4059 <printf>
            exit();
    137f:	e8 58 2b 00 00       	call   3edc <exit>
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
    1384:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1388:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    138c:	0f 8e 5f ff ff ff    	jle    12f1 <createdelete+0x70>
            printf(1, "unlink failed\n");
            exit();
          }
        }
      }
      exit();
    1392:	e8 45 2b 00 00       	call   3edc <exit>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1397:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    139b:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    139f:	0f 8e 02 ff ff ff    	jle    12a7 <createdelete+0x26>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    13a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13ac:	eb 09                	jmp    13b7 <createdelete+0x136>
    wait();
    13ae:	e8 31 2b 00 00       	call   3ee4 <wait>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    13b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13b7:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13bb:	7e f1                	jle    13ae <createdelete+0x12d>
    wait();
  }

  name[0] = name[1] = name[2] = 0;
    13bd:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13c1:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    13c5:	88 45 c9             	mov    %al,-0x37(%ebp)
    13c8:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    13cc:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    13cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13d6:	e9 bb 00 00 00       	jmp    1496 <createdelete+0x215>
    for(pi = 0; pi < 4; pi++){
    13db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13e2:	e9 a1 00 00 00       	jmp    1488 <createdelete+0x207>
      name[0] = 'p' + pi;
    13e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13ea:	83 c0 70             	add    $0x70,%eax
    13ed:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    13f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f3:	83 c0 30             	add    $0x30,%eax
    13f6:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    13f9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1400:	00 
    1401:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1404:	89 04 24             	mov    %eax,(%esp)
    1407:	e8 10 2b 00 00       	call   3f1c <open>
    140c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    140f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1413:	74 06                	je     141b <createdelete+0x19a>
    1415:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1419:	7e 26                	jle    1441 <createdelete+0x1c0>
    141b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    141f:	79 20                	jns    1441 <createdelete+0x1c0>
        printf(1, "oops createdelete %s didn't exist\n", name);
    1421:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1424:	89 44 24 08          	mov    %eax,0x8(%esp)
    1428:	c7 44 24 04 c0 4a 00 	movl   $0x4ac0,0x4(%esp)
    142f:	00 
    1430:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1437:	e8 1d 2c 00 00       	call   4059 <printf>
        exit();
    143c:	e8 9b 2a 00 00       	call   3edc <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1441:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1445:	7e 2c                	jle    1473 <createdelete+0x1f2>
    1447:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    144b:	7f 26                	jg     1473 <createdelete+0x1f2>
    144d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1451:	78 20                	js     1473 <createdelete+0x1f2>
        printf(1, "oops createdelete %s did exist\n", name);
    1453:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1456:	89 44 24 08          	mov    %eax,0x8(%esp)
    145a:	c7 44 24 04 e4 4a 00 	movl   $0x4ae4,0x4(%esp)
    1461:	00 
    1462:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1469:	e8 eb 2b 00 00       	call   4059 <printf>
        exit();
    146e:	e8 69 2a 00 00       	call   3edc <exit>
      }
      if(fd >= 0)
    1473:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1477:	78 0b                	js     1484 <createdelete+0x203>
        close(fd);
    1479:	8b 45 e8             	mov    -0x18(%ebp),%eax
    147c:	89 04 24             	mov    %eax,(%esp)
    147f:	e8 80 2a 00 00       	call   3f04 <close>
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1484:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1488:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    148c:	0f 8e 55 ff ff ff    	jle    13e7 <createdelete+0x166>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1492:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1496:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    149a:	0f 8e 3b ff ff ff    	jle    13db <createdelete+0x15a>
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    14a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14a7:	eb 34                	jmp    14dd <createdelete+0x25c>
    for(pi = 0; pi < 4; pi++){
    14a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14b0:	eb 21                	jmp    14d3 <createdelete+0x252>
      name[0] = 'p' + i;
    14b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b5:	83 c0 70             	add    $0x70,%eax
    14b8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    14bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14be:	83 c0 30             	add    $0x30,%eax
    14c1:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    14c4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14c7:	89 04 24             	mov    %eax,(%esp)
    14ca:	e8 5d 2a 00 00       	call   3f2c <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    14cf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14d3:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14d7:	7e d9                	jle    14b2 <createdelete+0x231>
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    14d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14dd:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    14e1:	7e c6                	jle    14a9 <createdelete+0x228>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    14e3:	c7 44 24 04 04 4b 00 	movl   $0x4b04,0x4(%esp)
    14ea:	00 
    14eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14f2:	e8 62 2b 00 00       	call   4059 <printf>
}
    14f7:	c9                   	leave  
    14f8:	c3                   	ret    

000014f9 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    14f9:	55                   	push   %ebp
    14fa:	89 e5                	mov    %esp,%ebp
    14fc:	83 ec 28             	sub    $0x28,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    14ff:	c7 44 24 04 15 4b 00 	movl   $0x4b15,0x4(%esp)
    1506:	00 
    1507:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    150e:	e8 46 2b 00 00       	call   4059 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1513:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    151a:	00 
    151b:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    1522:	e8 f5 29 00 00       	call   3f1c <open>
    1527:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    152a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    152e:	79 19                	jns    1549 <unlinkread+0x50>
    printf(1, "create unlinkread failed\n");
    1530:	c7 44 24 04 31 4b 00 	movl   $0x4b31,0x4(%esp)
    1537:	00 
    1538:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    153f:	e8 15 2b 00 00       	call   4059 <printf>
    exit();
    1544:	e8 93 29 00 00       	call   3edc <exit>
  }
  write(fd, "hello", 5);
    1549:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1550:	00 
    1551:	c7 44 24 04 4b 4b 00 	movl   $0x4b4b,0x4(%esp)
    1558:	00 
    1559:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155c:	89 04 24             	mov    %eax,(%esp)
    155f:	e8 98 29 00 00       	call   3efc <write>
  close(fd);
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	89 04 24             	mov    %eax,(%esp)
    156a:	e8 95 29 00 00       	call   3f04 <close>

  fd = open("unlinkread", O_RDWR);
    156f:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1576:	00 
    1577:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    157e:	e8 99 29 00 00       	call   3f1c <open>
    1583:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1586:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    158a:	79 19                	jns    15a5 <unlinkread+0xac>
    printf(1, "open unlinkread failed\n");
    158c:	c7 44 24 04 51 4b 00 	movl   $0x4b51,0x4(%esp)
    1593:	00 
    1594:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159b:	e8 b9 2a 00 00       	call   4059 <printf>
    exit();
    15a0:	e8 37 29 00 00       	call   3edc <exit>
  }
  if(unlink("unlinkread") != 0){
    15a5:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    15ac:	e8 7b 29 00 00       	call   3f2c <unlink>
    15b1:	85 c0                	test   %eax,%eax
    15b3:	74 19                	je     15ce <unlinkread+0xd5>
    printf(1, "unlink unlinkread failed\n");
    15b5:	c7 44 24 04 69 4b 00 	movl   $0x4b69,0x4(%esp)
    15bc:	00 
    15bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c4:	e8 90 2a 00 00       	call   4059 <printf>
    exit();
    15c9:	e8 0e 29 00 00       	call   3edc <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    15ce:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    15d5:	00 
    15d6:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    15dd:	e8 3a 29 00 00       	call   3f1c <open>
    15e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    15e5:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    15ec:	00 
    15ed:	c7 44 24 04 83 4b 00 	movl   $0x4b83,0x4(%esp)
    15f4:	00 
    15f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f8:	89 04 24             	mov    %eax,(%esp)
    15fb:	e8 fc 28 00 00       	call   3efc <write>
  close(fd1);
    1600:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1603:	89 04 24             	mov    %eax,(%esp)
    1606:	e8 f9 28 00 00       	call   3f04 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    160b:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1612:	00 
    1613:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    161a:	00 
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161e:	89 04 24             	mov    %eax,(%esp)
    1621:	e8 ce 28 00 00       	call   3ef4 <read>
    1626:	83 f8 05             	cmp    $0x5,%eax
    1629:	74 19                	je     1644 <unlinkread+0x14b>
    printf(1, "unlinkread read failed");
    162b:	c7 44 24 04 87 4b 00 	movl   $0x4b87,0x4(%esp)
    1632:	00 
    1633:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    163a:	e8 1a 2a 00 00       	call   4059 <printf>
    exit();
    163f:	e8 98 28 00 00       	call   3edc <exit>
  }
  if(buf[0] != 'h'){
    1644:	0f b6 05 e0 8a 00 00 	movzbl 0x8ae0,%eax
    164b:	3c 68                	cmp    $0x68,%al
    164d:	74 19                	je     1668 <unlinkread+0x16f>
    printf(1, "unlinkread wrong data\n");
    164f:	c7 44 24 04 9e 4b 00 	movl   $0x4b9e,0x4(%esp)
    1656:	00 
    1657:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    165e:	e8 f6 29 00 00       	call   4059 <printf>
    exit();
    1663:	e8 74 28 00 00       	call   3edc <exit>
  }
  if(write(fd, buf, 10) != 10){
    1668:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    166f:	00 
    1670:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    1677:	00 
    1678:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167b:	89 04 24             	mov    %eax,(%esp)
    167e:	e8 79 28 00 00       	call   3efc <write>
    1683:	83 f8 0a             	cmp    $0xa,%eax
    1686:	74 19                	je     16a1 <unlinkread+0x1a8>
    printf(1, "unlinkread write failed\n");
    1688:	c7 44 24 04 b5 4b 00 	movl   $0x4bb5,0x4(%esp)
    168f:	00 
    1690:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1697:	e8 bd 29 00 00       	call   4059 <printf>
    exit();
    169c:	e8 3b 28 00 00       	call   3edc <exit>
  }
  close(fd);
    16a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a4:	89 04 24             	mov    %eax,(%esp)
    16a7:	e8 58 28 00 00       	call   3f04 <close>
  unlink("unlinkread");
    16ac:	c7 04 24 26 4b 00 00 	movl   $0x4b26,(%esp)
    16b3:	e8 74 28 00 00       	call   3f2c <unlink>
  printf(1, "unlinkread ok\n");
    16b8:	c7 44 24 04 ce 4b 00 	movl   $0x4bce,0x4(%esp)
    16bf:	00 
    16c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16c7:	e8 8d 29 00 00       	call   4059 <printf>
}
    16cc:	c9                   	leave  
    16cd:	c3                   	ret    

000016ce <linktest>:

void
linktest(void)
{
    16ce:	55                   	push   %ebp
    16cf:	89 e5                	mov    %esp,%ebp
    16d1:	83 ec 28             	sub    $0x28,%esp
  int fd;

  printf(1, "linktest\n");
    16d4:	c7 44 24 04 dd 4b 00 	movl   $0x4bdd,0x4(%esp)
    16db:	00 
    16dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16e3:	e8 71 29 00 00       	call   4059 <printf>

  unlink("lf1");
    16e8:	c7 04 24 e7 4b 00 00 	movl   $0x4be7,(%esp)
    16ef:	e8 38 28 00 00       	call   3f2c <unlink>
  unlink("lf2");
    16f4:	c7 04 24 eb 4b 00 00 	movl   $0x4beb,(%esp)
    16fb:	e8 2c 28 00 00       	call   3f2c <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1700:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1707:	00 
    1708:	c7 04 24 e7 4b 00 00 	movl   $0x4be7,(%esp)
    170f:	e8 08 28 00 00       	call   3f1c <open>
    1714:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1717:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    171b:	79 19                	jns    1736 <linktest+0x68>
    printf(1, "create lf1 failed\n");
    171d:	c7 44 24 04 ef 4b 00 	movl   $0x4bef,0x4(%esp)
    1724:	00 
    1725:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    172c:	e8 28 29 00 00       	call   4059 <printf>
    exit();
    1731:	e8 a6 27 00 00       	call   3edc <exit>
  }
  if(write(fd, "hello", 5) != 5){
    1736:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    173d:	00 
    173e:	c7 44 24 04 4b 4b 00 	movl   $0x4b4b,0x4(%esp)
    1745:	00 
    1746:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1749:	89 04 24             	mov    %eax,(%esp)
    174c:	e8 ab 27 00 00       	call   3efc <write>
    1751:	83 f8 05             	cmp    $0x5,%eax
    1754:	74 19                	je     176f <linktest+0xa1>
    printf(1, "write lf1 failed\n");
    1756:	c7 44 24 04 02 4c 00 	movl   $0x4c02,0x4(%esp)
    175d:	00 
    175e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1765:	e8 ef 28 00 00       	call   4059 <printf>
    exit();
    176a:	e8 6d 27 00 00       	call   3edc <exit>
  }
  close(fd);
    176f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1772:	89 04 24             	mov    %eax,(%esp)
    1775:	e8 8a 27 00 00       	call   3f04 <close>

  if(link("lf1", "lf2") < 0){
    177a:	c7 44 24 04 eb 4b 00 	movl   $0x4beb,0x4(%esp)
    1781:	00 
    1782:	c7 04 24 e7 4b 00 00 	movl   $0x4be7,(%esp)
    1789:	e8 ae 27 00 00       	call   3f3c <link>
    178e:	85 c0                	test   %eax,%eax
    1790:	79 19                	jns    17ab <linktest+0xdd>
    printf(1, "link lf1 lf2 failed\n");
    1792:	c7 44 24 04 14 4c 00 	movl   $0x4c14,0x4(%esp)
    1799:	00 
    179a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17a1:	e8 b3 28 00 00       	call   4059 <printf>
    exit();
    17a6:	e8 31 27 00 00       	call   3edc <exit>
  }
  unlink("lf1");
    17ab:	c7 04 24 e7 4b 00 00 	movl   $0x4be7,(%esp)
    17b2:	e8 75 27 00 00       	call   3f2c <unlink>

  if(open("lf1", 0) >= 0){
    17b7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17be:	00 
    17bf:	c7 04 24 e7 4b 00 00 	movl   $0x4be7,(%esp)
    17c6:	e8 51 27 00 00       	call   3f1c <open>
    17cb:	85 c0                	test   %eax,%eax
    17cd:	78 19                	js     17e8 <linktest+0x11a>
    printf(1, "unlinked lf1 but it is still there!\n");
    17cf:	c7 44 24 04 2c 4c 00 	movl   $0x4c2c,0x4(%esp)
    17d6:	00 
    17d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17de:	e8 76 28 00 00       	call   4059 <printf>
    exit();
    17e3:	e8 f4 26 00 00       	call   3edc <exit>
  }

  fd = open("lf2", 0);
    17e8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17ef:	00 
    17f0:	c7 04 24 eb 4b 00 00 	movl   $0x4beb,(%esp)
    17f7:	e8 20 27 00 00       	call   3f1c <open>
    17fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    17ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1803:	79 19                	jns    181e <linktest+0x150>
    printf(1, "open lf2 failed\n");
    1805:	c7 44 24 04 51 4c 00 	movl   $0x4c51,0x4(%esp)
    180c:	00 
    180d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1814:	e8 40 28 00 00       	call   4059 <printf>
    exit();
    1819:	e8 be 26 00 00       	call   3edc <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    181e:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1825:	00 
    1826:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    182d:	00 
    182e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1831:	89 04 24             	mov    %eax,(%esp)
    1834:	e8 bb 26 00 00       	call   3ef4 <read>
    1839:	83 f8 05             	cmp    $0x5,%eax
    183c:	74 19                	je     1857 <linktest+0x189>
    printf(1, "read lf2 failed\n");
    183e:	c7 44 24 04 62 4c 00 	movl   $0x4c62,0x4(%esp)
    1845:	00 
    1846:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    184d:	e8 07 28 00 00       	call   4059 <printf>
    exit();
    1852:	e8 85 26 00 00       	call   3edc <exit>
  }
  close(fd);
    1857:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185a:	89 04 24             	mov    %eax,(%esp)
    185d:	e8 a2 26 00 00       	call   3f04 <close>

  if(link("lf2", "lf2") >= 0){
    1862:	c7 44 24 04 eb 4b 00 	movl   $0x4beb,0x4(%esp)
    1869:	00 
    186a:	c7 04 24 eb 4b 00 00 	movl   $0x4beb,(%esp)
    1871:	e8 c6 26 00 00       	call   3f3c <link>
    1876:	85 c0                	test   %eax,%eax
    1878:	78 19                	js     1893 <linktest+0x1c5>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    187a:	c7 44 24 04 73 4c 00 	movl   $0x4c73,0x4(%esp)
    1881:	00 
    1882:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1889:	e8 cb 27 00 00       	call   4059 <printf>
    exit();
    188e:	e8 49 26 00 00       	call   3edc <exit>
  }

  unlink("lf2");
    1893:	c7 04 24 eb 4b 00 00 	movl   $0x4beb,(%esp)
    189a:	e8 8d 26 00 00       	call   3f2c <unlink>
  if(link("lf2", "lf1") >= 0){
    189f:	c7 44 24 04 e7 4b 00 	movl   $0x4be7,0x4(%esp)
    18a6:	00 
    18a7:	c7 04 24 eb 4b 00 00 	movl   $0x4beb,(%esp)
    18ae:	e8 89 26 00 00       	call   3f3c <link>
    18b3:	85 c0                	test   %eax,%eax
    18b5:	78 19                	js     18d0 <linktest+0x202>
    printf(1, "link non-existant succeeded! oops\n");
    18b7:	c7 44 24 04 94 4c 00 	movl   $0x4c94,0x4(%esp)
    18be:	00 
    18bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18c6:	e8 8e 27 00 00       	call   4059 <printf>
    exit();
    18cb:	e8 0c 26 00 00       	call   3edc <exit>
  }

  if(link(".", "lf1") >= 0){
    18d0:	c7 44 24 04 e7 4b 00 	movl   $0x4be7,0x4(%esp)
    18d7:	00 
    18d8:	c7 04 24 b7 4c 00 00 	movl   $0x4cb7,(%esp)
    18df:	e8 58 26 00 00       	call   3f3c <link>
    18e4:	85 c0                	test   %eax,%eax
    18e6:	78 19                	js     1901 <linktest+0x233>
    printf(1, "link . lf1 succeeded! oops\n");
    18e8:	c7 44 24 04 b9 4c 00 	movl   $0x4cb9,0x4(%esp)
    18ef:	00 
    18f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18f7:	e8 5d 27 00 00       	call   4059 <printf>
    exit();
    18fc:	e8 db 25 00 00       	call   3edc <exit>
  }

  printf(1, "linktest ok\n");
    1901:	c7 44 24 04 d5 4c 00 	movl   $0x4cd5,0x4(%esp)
    1908:	00 
    1909:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1910:	e8 44 27 00 00       	call   4059 <printf>
}
    1915:	c9                   	leave  
    1916:	c3                   	ret    

00001917 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1917:	55                   	push   %ebp
    1918:	89 e5                	mov    %esp,%ebp
    191a:	83 ec 68             	sub    $0x68,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    191d:	c7 44 24 04 e2 4c 00 	movl   $0x4ce2,0x4(%esp)
    1924:	00 
    1925:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    192c:	e8 28 27 00 00       	call   4059 <printf>
  file[0] = 'C';
    1931:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1935:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1939:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1940:	e9 f7 00 00 00       	jmp    1a3c <concreate+0x125>
    file[1] = '0' + i;
    1945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1948:	83 c0 30             	add    $0x30,%eax
    194b:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    194e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1951:	89 04 24             	mov    %eax,(%esp)
    1954:	e8 d3 25 00 00       	call   3f2c <unlink>
    pid = fork();
    1959:	e8 76 25 00 00       	call   3ed4 <fork>
    195e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    1961:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1965:	74 3a                	je     19a1 <concreate+0x8a>
    1967:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    196a:	ba 56 55 55 55       	mov    $0x55555556,%edx
    196f:	89 c8                	mov    %ecx,%eax
    1971:	f7 ea                	imul   %edx
    1973:	89 c8                	mov    %ecx,%eax
    1975:	c1 f8 1f             	sar    $0x1f,%eax
    1978:	29 c2                	sub    %eax,%edx
    197a:	89 d0                	mov    %edx,%eax
    197c:	01 c0                	add    %eax,%eax
    197e:	01 d0                	add    %edx,%eax
    1980:	89 ca                	mov    %ecx,%edx
    1982:	29 c2                	sub    %eax,%edx
    1984:	83 fa 01             	cmp    $0x1,%edx
    1987:	75 18                	jne    19a1 <concreate+0x8a>
      link("C0", file);
    1989:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    198c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1990:	c7 04 24 f2 4c 00 00 	movl   $0x4cf2,(%esp)
    1997:	e8 a0 25 00 00       	call   3f3c <link>
    199c:	e9 87 00 00 00       	jmp    1a28 <concreate+0x111>
    } else if(pid == 0 && (i % 5) == 1){
    19a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19a5:	75 3a                	jne    19e1 <concreate+0xca>
    19a7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    19aa:	ba 67 66 66 66       	mov    $0x66666667,%edx
    19af:	89 c8                	mov    %ecx,%eax
    19b1:	f7 ea                	imul   %edx
    19b3:	d1 fa                	sar    %edx
    19b5:	89 c8                	mov    %ecx,%eax
    19b7:	c1 f8 1f             	sar    $0x1f,%eax
    19ba:	29 c2                	sub    %eax,%edx
    19bc:	89 d0                	mov    %edx,%eax
    19be:	c1 e0 02             	shl    $0x2,%eax
    19c1:	01 d0                	add    %edx,%eax
    19c3:	89 ca                	mov    %ecx,%edx
    19c5:	29 c2                	sub    %eax,%edx
    19c7:	83 fa 01             	cmp    $0x1,%edx
    19ca:	75 15                	jne    19e1 <concreate+0xca>
      link("C0", file);
    19cc:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    19d3:	c7 04 24 f2 4c 00 00 	movl   $0x4cf2,(%esp)
    19da:	e8 5d 25 00 00       	call   3f3c <link>
    19df:	eb 47                	jmp    1a28 <concreate+0x111>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    19e1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    19e8:	00 
    19e9:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ec:	89 04 24             	mov    %eax,(%esp)
    19ef:	e8 28 25 00 00       	call   3f1c <open>
    19f4:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    19f7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    19fb:	79 20                	jns    1a1d <concreate+0x106>
        printf(1, "concreate create %s failed\n", file);
    19fd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a00:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a04:	c7 44 24 04 f5 4c 00 	movl   $0x4cf5,0x4(%esp)
    1a0b:	00 
    1a0c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a13:	e8 41 26 00 00       	call   4059 <printf>
        exit();
    1a18:	e8 bf 24 00 00       	call   3edc <exit>
      }
      close(fd);
    1a1d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a20:	89 04 24             	mov    %eax,(%esp)
    1a23:	e8 dc 24 00 00       	call   3f04 <close>
    }
    if(pid == 0)
    1a28:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a2c:	75 05                	jne    1a33 <concreate+0x11c>
      exit();
    1a2e:	e8 a9 24 00 00       	call   3edc <exit>
    else
      wait();
    1a33:	e8 ac 24 00 00       	call   3ee4 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1a38:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a3c:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1a40:	0f 8e ff fe ff ff    	jle    1945 <concreate+0x2e>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1a46:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    1a4d:	00 
    1a4e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a55:	00 
    1a56:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1a59:	89 04 24             	mov    %eax,(%esp)
    1a5c:	e8 d4 22 00 00       	call   3d35 <memset>
  fd = open(".", 0);
    1a61:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a68:	00 
    1a69:	c7 04 24 b7 4c 00 00 	movl   $0x4cb7,(%esp)
    1a70:	e8 a7 24 00 00       	call   3f1c <open>
    1a75:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    1a78:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1a7f:	e9 a7 00 00 00       	jmp    1b2b <concreate+0x214>
    if(de.inum == 0)
    1a84:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1a88:	66 85 c0             	test   %ax,%ax
    1a8b:	0f 84 99 00 00 00    	je     1b2a <concreate+0x213>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1a91:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1a95:	3c 43                	cmp    $0x43,%al
    1a97:	0f 85 8e 00 00 00    	jne    1b2b <concreate+0x214>
    1a9d:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1aa1:	84 c0                	test   %al,%al
    1aa3:	0f 85 82 00 00 00    	jne    1b2b <concreate+0x214>
      i = de.name[1] - '0';
    1aa9:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1aad:	0f be c0             	movsbl %al,%eax
    1ab0:	83 e8 30             	sub    $0x30,%eax
    1ab3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1ab6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1aba:	78 08                	js     1ac4 <concreate+0x1ad>
    1abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abf:	83 f8 27             	cmp    $0x27,%eax
    1ac2:	76 23                	jbe    1ae7 <concreate+0x1d0>
        printf(1, "concreate weird file %s\n", de.name);
    1ac4:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1ac7:	83 c0 02             	add    $0x2,%eax
    1aca:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ace:	c7 44 24 04 11 4d 00 	movl   $0x4d11,0x4(%esp)
    1ad5:	00 
    1ad6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1add:	e8 77 25 00 00       	call   4059 <printf>
        exit();
    1ae2:	e8 f5 23 00 00       	call   3edc <exit>
      }
      if(fa[i]){
    1ae7:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aed:	01 d0                	add    %edx,%eax
    1aef:	0f b6 00             	movzbl (%eax),%eax
    1af2:	84 c0                	test   %al,%al
    1af4:	74 23                	je     1b19 <concreate+0x202>
        printf(1, "concreate duplicate file %s\n", de.name);
    1af6:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1af9:	83 c0 02             	add    $0x2,%eax
    1afc:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b00:	c7 44 24 04 2a 4d 00 	movl   $0x4d2a,0x4(%esp)
    1b07:	00 
    1b08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b0f:	e8 45 25 00 00       	call   4059 <printf>
        exit();
    1b14:	e8 c3 23 00 00       	call   3edc <exit>
      }
      fa[i] = 1;
    1b19:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b1f:	01 d0                	add    %edx,%eax
    1b21:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1b24:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1b28:	eb 01                	jmp    1b2b <concreate+0x214>
  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    if(de.inum == 0)
      continue;
    1b2a:	90                   	nop
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1b2b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1b32:	00 
    1b33:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1b36:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b3d:	89 04 24             	mov    %eax,(%esp)
    1b40:	e8 af 23 00 00       	call   3ef4 <read>
    1b45:	85 c0                	test   %eax,%eax
    1b47:	0f 8f 37 ff ff ff    	jg     1a84 <concreate+0x16d>
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    1b4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b50:	89 04 24             	mov    %eax,(%esp)
    1b53:	e8 ac 23 00 00       	call   3f04 <close>

  if(n != 40){
    1b58:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1b5c:	74 19                	je     1b77 <concreate+0x260>
    printf(1, "concreate not enough files in directory listing\n");
    1b5e:	c7 44 24 04 48 4d 00 	movl   $0x4d48,0x4(%esp)
    1b65:	00 
    1b66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b6d:	e8 e7 24 00 00       	call   4059 <printf>
    exit();
    1b72:	e8 65 23 00 00       	call   3edc <exit>
  }

  for(i = 0; i < 40; i++){
    1b77:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b7e:	e9 2d 01 00 00       	jmp    1cb0 <concreate+0x399>
    file[1] = '0' + i;
    1b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b86:	83 c0 30             	add    $0x30,%eax
    1b89:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1b8c:	e8 43 23 00 00       	call   3ed4 <fork>
    1b91:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    1b94:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b98:	79 19                	jns    1bb3 <concreate+0x29c>
      printf(1, "fork failed\n");
    1b9a:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
    1ba1:	00 
    1ba2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ba9:	e8 ab 24 00 00       	call   4059 <printf>
      exit();
    1bae:	e8 29 23 00 00       	call   3edc <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1bb3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1bb6:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1bbb:	89 c8                	mov    %ecx,%eax
    1bbd:	f7 ea                	imul   %edx
    1bbf:	89 c8                	mov    %ecx,%eax
    1bc1:	c1 f8 1f             	sar    $0x1f,%eax
    1bc4:	29 c2                	sub    %eax,%edx
    1bc6:	89 d0                	mov    %edx,%eax
    1bc8:	01 c0                	add    %eax,%eax
    1bca:	01 d0                	add    %edx,%eax
    1bcc:	89 ca                	mov    %ecx,%edx
    1bce:	29 c2                	sub    %eax,%edx
    1bd0:	85 d2                	test   %edx,%edx
    1bd2:	75 06                	jne    1bda <concreate+0x2c3>
    1bd4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bd8:	74 28                	je     1c02 <concreate+0x2eb>
       ((i % 3) == 1 && pid != 0)){
    1bda:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1bdd:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1be2:	89 c8                	mov    %ecx,%eax
    1be4:	f7 ea                	imul   %edx
    1be6:	89 c8                	mov    %ecx,%eax
    1be8:	c1 f8 1f             	sar    $0x1f,%eax
    1beb:	29 c2                	sub    %eax,%edx
    1bed:	89 d0                	mov    %edx,%eax
    1bef:	01 c0                	add    %eax,%eax
    1bf1:	01 d0                	add    %edx,%eax
    1bf3:	89 ca                	mov    %ecx,%edx
    1bf5:	29 c2                	sub    %eax,%edx
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1bf7:	83 fa 01             	cmp    $0x1,%edx
    1bfa:	75 74                	jne    1c70 <concreate+0x359>
       ((i % 3) == 1 && pid != 0)){
    1bfc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c00:	74 6e                	je     1c70 <concreate+0x359>
      close(open(file, 0));
    1c02:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c09:	00 
    1c0a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c0d:	89 04 24             	mov    %eax,(%esp)
    1c10:	e8 07 23 00 00       	call   3f1c <open>
    1c15:	89 04 24             	mov    %eax,(%esp)
    1c18:	e8 e7 22 00 00       	call   3f04 <close>
      close(open(file, 0));
    1c1d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c24:	00 
    1c25:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c28:	89 04 24             	mov    %eax,(%esp)
    1c2b:	e8 ec 22 00 00       	call   3f1c <open>
    1c30:	89 04 24             	mov    %eax,(%esp)
    1c33:	e8 cc 22 00 00       	call   3f04 <close>
      close(open(file, 0));
    1c38:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c3f:	00 
    1c40:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c43:	89 04 24             	mov    %eax,(%esp)
    1c46:	e8 d1 22 00 00       	call   3f1c <open>
    1c4b:	89 04 24             	mov    %eax,(%esp)
    1c4e:	e8 b1 22 00 00       	call   3f04 <close>
      close(open(file, 0));
    1c53:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c5a:	00 
    1c5b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c5e:	89 04 24             	mov    %eax,(%esp)
    1c61:	e8 b6 22 00 00       	call   3f1c <open>
    1c66:	89 04 24             	mov    %eax,(%esp)
    1c69:	e8 96 22 00 00       	call   3f04 <close>
    1c6e:	eb 2c                	jmp    1c9c <concreate+0x385>
    } else {
      unlink(file);
    1c70:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c73:	89 04 24             	mov    %eax,(%esp)
    1c76:	e8 b1 22 00 00       	call   3f2c <unlink>
      unlink(file);
    1c7b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c7e:	89 04 24             	mov    %eax,(%esp)
    1c81:	e8 a6 22 00 00       	call   3f2c <unlink>
      unlink(file);
    1c86:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c89:	89 04 24             	mov    %eax,(%esp)
    1c8c:	e8 9b 22 00 00       	call   3f2c <unlink>
      unlink(file);
    1c91:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c94:	89 04 24             	mov    %eax,(%esp)
    1c97:	e8 90 22 00 00       	call   3f2c <unlink>
    }
    if(pid == 0)
    1c9c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ca0:	75 05                	jne    1ca7 <concreate+0x390>
      exit();
    1ca2:	e8 35 22 00 00       	call   3edc <exit>
    else
      wait();
    1ca7:	e8 38 22 00 00       	call   3ee4 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1cac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cb0:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1cb4:	0f 8e c9 fe ff ff    	jle    1b83 <concreate+0x26c>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1cba:	c7 44 24 04 79 4d 00 	movl   $0x4d79,0x4(%esp)
    1cc1:	00 
    1cc2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cc9:	e8 8b 23 00 00       	call   4059 <printf>
}
    1cce:	c9                   	leave  
    1ccf:	c3                   	ret    

00001cd0 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1cd0:	55                   	push   %ebp
    1cd1:	89 e5                	mov    %esp,%ebp
    1cd3:	83 ec 28             	sub    $0x28,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1cd6:	c7 44 24 04 87 4d 00 	movl   $0x4d87,0x4(%esp)
    1cdd:	00 
    1cde:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ce5:	e8 6f 23 00 00       	call   4059 <printf>

  unlink("x");
    1cea:	c7 04 24 03 49 00 00 	movl   $0x4903,(%esp)
    1cf1:	e8 36 22 00 00       	call   3f2c <unlink>
  pid = fork();
    1cf6:	e8 d9 21 00 00       	call   3ed4 <fork>
    1cfb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1cfe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d02:	79 19                	jns    1d1d <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1d04:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
    1d0b:	00 
    1d0c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d13:	e8 41 23 00 00       	call   4059 <printf>
    exit();
    1d18:	e8 bf 21 00 00       	call   3edc <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1d1d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d21:	74 07                	je     1d2a <linkunlink+0x5a>
    1d23:	b8 01 00 00 00       	mov    $0x1,%eax
    1d28:	eb 05                	jmp    1d2f <linkunlink+0x5f>
    1d2a:	b8 61 00 00 00       	mov    $0x61,%eax
    1d2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1d32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d39:	e9 8e 00 00 00       	jmp    1dcc <linkunlink+0xfc>
    x = x * 1103515245 + 12345;
    1d3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d41:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1d47:	05 39 30 00 00       	add    $0x3039,%eax
    1d4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1d4f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d52:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1d57:	89 c8                	mov    %ecx,%eax
    1d59:	f7 e2                	mul    %edx
    1d5b:	d1 ea                	shr    %edx
    1d5d:	89 d0                	mov    %edx,%eax
    1d5f:	01 c0                	add    %eax,%eax
    1d61:	01 d0                	add    %edx,%eax
    1d63:	89 ca                	mov    %ecx,%edx
    1d65:	29 c2                	sub    %eax,%edx
    1d67:	85 d2                	test   %edx,%edx
    1d69:	75 1e                	jne    1d89 <linkunlink+0xb9>
      close(open("x", O_RDWR | O_CREATE));
    1d6b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1d72:	00 
    1d73:	c7 04 24 03 49 00 00 	movl   $0x4903,(%esp)
    1d7a:	e8 9d 21 00 00       	call   3f1c <open>
    1d7f:	89 04 24             	mov    %eax,(%esp)
    1d82:	e8 7d 21 00 00       	call   3f04 <close>
    1d87:	eb 3f                	jmp    1dc8 <linkunlink+0xf8>
    } else if((x % 3) == 1){
    1d89:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d8c:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1d91:	89 c8                	mov    %ecx,%eax
    1d93:	f7 e2                	mul    %edx
    1d95:	d1 ea                	shr    %edx
    1d97:	89 d0                	mov    %edx,%eax
    1d99:	01 c0                	add    %eax,%eax
    1d9b:	01 d0                	add    %edx,%eax
    1d9d:	89 ca                	mov    %ecx,%edx
    1d9f:	29 c2                	sub    %eax,%edx
    1da1:	83 fa 01             	cmp    $0x1,%edx
    1da4:	75 16                	jne    1dbc <linkunlink+0xec>
      link("cat", "x");
    1da6:	c7 44 24 04 03 49 00 	movl   $0x4903,0x4(%esp)
    1dad:	00 
    1dae:	c7 04 24 98 4d 00 00 	movl   $0x4d98,(%esp)
    1db5:	e8 82 21 00 00       	call   3f3c <link>
    1dba:	eb 0c                	jmp    1dc8 <linkunlink+0xf8>
    } else {
      unlink("x");
    1dbc:	c7 04 24 03 49 00 00 	movl   $0x4903,(%esp)
    1dc3:	e8 64 21 00 00       	call   3f2c <unlink>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1dc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1dcc:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1dd0:	0f 8e 68 ff ff ff    	jle    1d3e <linkunlink+0x6e>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1dd6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1dda:	74 1b                	je     1df7 <linkunlink+0x127>
    wait();
    1ddc:	e8 03 21 00 00       	call   3ee4 <wait>
  else 
    exit();

  printf(1, "linkunlink ok\n");
    1de1:	c7 44 24 04 9c 4d 00 	movl   $0x4d9c,0x4(%esp)
    1de8:	00 
    1de9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1df0:	e8 64 22 00 00       	call   4059 <printf>
    1df5:	eb 05                	jmp    1dfc <linkunlink+0x12c>
  }

  if(pid)
    wait();
  else 
    exit();
    1df7:	e8 e0 20 00 00       	call   3edc <exit>

  printf(1, "linkunlink ok\n");
}
    1dfc:	c9                   	leave  
    1dfd:	c3                   	ret    

00001dfe <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1dfe:	55                   	push   %ebp
    1dff:	89 e5                	mov    %esp,%ebp
    1e01:	83 ec 38             	sub    $0x38,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1e04:	c7 44 24 04 ab 4d 00 	movl   $0x4dab,0x4(%esp)
    1e0b:	00 
    1e0c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e13:	e8 41 22 00 00       	call   4059 <printf>
  unlink("bd");
    1e18:	c7 04 24 b8 4d 00 00 	movl   $0x4db8,(%esp)
    1e1f:	e8 08 21 00 00       	call   3f2c <unlink>

  fd = open("bd", O_CREATE);
    1e24:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1e2b:	00 
    1e2c:	c7 04 24 b8 4d 00 00 	movl   $0x4db8,(%esp)
    1e33:	e8 e4 20 00 00       	call   3f1c <open>
    1e38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1e3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e3f:	79 19                	jns    1e5a <bigdir+0x5c>
    printf(1, "bigdir create failed\n");
    1e41:	c7 44 24 04 bb 4d 00 	movl   $0x4dbb,0x4(%esp)
    1e48:	00 
    1e49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e50:	e8 04 22 00 00       	call   4059 <printf>
    exit();
    1e55:	e8 82 20 00 00       	call   3edc <exit>
  }
  close(fd);
    1e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e5d:	89 04 24             	mov    %eax,(%esp)
    1e60:	e8 9f 20 00 00       	call   3f04 <close>

  for(i = 0; i < 500; i++){
    1e65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e6c:	eb 6a                	jmp    1ed8 <bigdir+0xda>
    name[0] = 'x';
    1e6e:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e75:	89 c2                	mov    %eax,%edx
    1e77:	c1 fa 1f             	sar    $0x1f,%edx
    1e7a:	c1 ea 1a             	shr    $0x1a,%edx
    1e7d:	01 d0                	add    %edx,%eax
    1e7f:	c1 f8 06             	sar    $0x6,%eax
    1e82:	83 c0 30             	add    $0x30,%eax
    1e85:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1e88:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e8b:	89 c2                	mov    %eax,%edx
    1e8d:	c1 fa 1f             	sar    $0x1f,%edx
    1e90:	c1 ea 1a             	shr    $0x1a,%edx
    1e93:	01 d0                	add    %edx,%eax
    1e95:	83 e0 3f             	and    $0x3f,%eax
    1e98:	29 d0                	sub    %edx,%eax
    1e9a:	83 c0 30             	add    $0x30,%eax
    1e9d:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1ea0:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1ea4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1ea7:	89 44 24 04          	mov    %eax,0x4(%esp)
    1eab:	c7 04 24 b8 4d 00 00 	movl   $0x4db8,(%esp)
    1eb2:	e8 85 20 00 00       	call   3f3c <link>
    1eb7:	85 c0                	test   %eax,%eax
    1eb9:	74 19                	je     1ed4 <bigdir+0xd6>
      printf(1, "bigdir link failed\n");
    1ebb:	c7 44 24 04 d1 4d 00 	movl   $0x4dd1,0x4(%esp)
    1ec2:	00 
    1ec3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1eca:	e8 8a 21 00 00       	call   4059 <printf>
      exit();
    1ecf:	e8 08 20 00 00       	call   3edc <exit>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1ed4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ed8:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1edf:	7e 8d                	jle    1e6e <bigdir+0x70>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1ee1:	c7 04 24 b8 4d 00 00 	movl   $0x4db8,(%esp)
    1ee8:	e8 3f 20 00 00       	call   3f2c <unlink>
  for(i = 0; i < 500; i++){
    1eed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ef4:	eb 62                	jmp    1f58 <bigdir+0x15a>
    name[0] = 'x';
    1ef6:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1efa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1efd:	89 c2                	mov    %eax,%edx
    1eff:	c1 fa 1f             	sar    $0x1f,%edx
    1f02:	c1 ea 1a             	shr    $0x1a,%edx
    1f05:	01 d0                	add    %edx,%eax
    1f07:	c1 f8 06             	sar    $0x6,%eax
    1f0a:	83 c0 30             	add    $0x30,%eax
    1f0d:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1f10:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f13:	89 c2                	mov    %eax,%edx
    1f15:	c1 fa 1f             	sar    $0x1f,%edx
    1f18:	c1 ea 1a             	shr    $0x1a,%edx
    1f1b:	01 d0                	add    %edx,%eax
    1f1d:	83 e0 3f             	and    $0x3f,%eax
    1f20:	29 d0                	sub    %edx,%eax
    1f22:	83 c0 30             	add    $0x30,%eax
    1f25:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1f28:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1f2c:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1f2f:	89 04 24             	mov    %eax,(%esp)
    1f32:	e8 f5 1f 00 00       	call   3f2c <unlink>
    1f37:	85 c0                	test   %eax,%eax
    1f39:	74 19                	je     1f54 <bigdir+0x156>
      printf(1, "bigdir unlink failed");
    1f3b:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    1f42:	00 
    1f43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f4a:	e8 0a 21 00 00       	call   4059 <printf>
      exit();
    1f4f:	e8 88 1f 00 00       	call   3edc <exit>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1f54:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f58:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1f5f:	7e 95                	jle    1ef6 <bigdir+0xf8>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1f61:	c7 44 24 04 fa 4d 00 	movl   $0x4dfa,0x4(%esp)
    1f68:	00 
    1f69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f70:	e8 e4 20 00 00       	call   4059 <printf>
}
    1f75:	c9                   	leave  
    1f76:	c3                   	ret    

00001f77 <subdir>:

void
subdir(void)
{
    1f77:	55                   	push   %ebp
    1f78:	89 e5                	mov    %esp,%ebp
    1f7a:	83 ec 28             	sub    $0x28,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1f7d:	c7 44 24 04 05 4e 00 	movl   $0x4e05,0x4(%esp)
    1f84:	00 
    1f85:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f8c:	e8 c8 20 00 00       	call   4059 <printf>

  unlink("ff");
    1f91:	c7 04 24 12 4e 00 00 	movl   $0x4e12,(%esp)
    1f98:	e8 8f 1f 00 00       	call   3f2c <unlink>
  if(mkdir("dd") != 0){
    1f9d:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    1fa4:	e8 9b 1f 00 00       	call   3f44 <mkdir>
    1fa9:	85 c0                	test   %eax,%eax
    1fab:	74 19                	je     1fc6 <subdir+0x4f>
    printf(1, "subdir mkdir dd failed\n");
    1fad:	c7 44 24 04 18 4e 00 	movl   $0x4e18,0x4(%esp)
    1fb4:	00 
    1fb5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fbc:	e8 98 20 00 00       	call   4059 <printf>
    exit();
    1fc1:	e8 16 1f 00 00       	call   3edc <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1fc6:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1fcd:	00 
    1fce:	c7 04 24 30 4e 00 00 	movl   $0x4e30,(%esp)
    1fd5:	e8 42 1f 00 00       	call   3f1c <open>
    1fda:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1fdd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fe1:	79 19                	jns    1ffc <subdir+0x85>
    printf(1, "create dd/ff failed\n");
    1fe3:	c7 44 24 04 36 4e 00 	movl   $0x4e36,0x4(%esp)
    1fea:	00 
    1feb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ff2:	e8 62 20 00 00       	call   4059 <printf>
    exit();
    1ff7:	e8 e0 1e 00 00       	call   3edc <exit>
  }
  write(fd, "ff", 2);
    1ffc:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    2003:	00 
    2004:	c7 44 24 04 12 4e 00 	movl   $0x4e12,0x4(%esp)
    200b:	00 
    200c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    200f:	89 04 24             	mov    %eax,(%esp)
    2012:	e8 e5 1e 00 00       	call   3efc <write>
  close(fd);
    2017:	8b 45 f4             	mov    -0xc(%ebp),%eax
    201a:	89 04 24             	mov    %eax,(%esp)
    201d:	e8 e2 1e 00 00       	call   3f04 <close>
  
  if(unlink("dd") >= 0){
    2022:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    2029:	e8 fe 1e 00 00       	call   3f2c <unlink>
    202e:	85 c0                	test   %eax,%eax
    2030:	78 19                	js     204b <subdir+0xd4>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2032:	c7 44 24 04 4c 4e 00 	movl   $0x4e4c,0x4(%esp)
    2039:	00 
    203a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2041:	e8 13 20 00 00       	call   4059 <printf>
    exit();
    2046:	e8 91 1e 00 00       	call   3edc <exit>
  }

  if(mkdir("/dd/dd") != 0){
    204b:	c7 04 24 72 4e 00 00 	movl   $0x4e72,(%esp)
    2052:	e8 ed 1e 00 00       	call   3f44 <mkdir>
    2057:	85 c0                	test   %eax,%eax
    2059:	74 19                	je     2074 <subdir+0xfd>
    printf(1, "subdir mkdir dd/dd failed\n");
    205b:	c7 44 24 04 79 4e 00 	movl   $0x4e79,0x4(%esp)
    2062:	00 
    2063:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    206a:	e8 ea 1f 00 00       	call   4059 <printf>
    exit();
    206f:	e8 68 1e 00 00       	call   3edc <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2074:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    207b:	00 
    207c:	c7 04 24 94 4e 00 00 	movl   $0x4e94,(%esp)
    2083:	e8 94 1e 00 00       	call   3f1c <open>
    2088:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    208b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    208f:	79 19                	jns    20aa <subdir+0x133>
    printf(1, "create dd/dd/ff failed\n");
    2091:	c7 44 24 04 9d 4e 00 	movl   $0x4e9d,0x4(%esp)
    2098:	00 
    2099:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20a0:	e8 b4 1f 00 00       	call   4059 <printf>
    exit();
    20a5:	e8 32 1e 00 00       	call   3edc <exit>
  }
  write(fd, "FF", 2);
    20aa:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    20b1:	00 
    20b2:	c7 44 24 04 b5 4e 00 	movl   $0x4eb5,0x4(%esp)
    20b9:	00 
    20ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20bd:	89 04 24             	mov    %eax,(%esp)
    20c0:	e8 37 1e 00 00       	call   3efc <write>
  close(fd);
    20c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20c8:	89 04 24             	mov    %eax,(%esp)
    20cb:	e8 34 1e 00 00       	call   3f04 <close>

  fd = open("dd/dd/../ff", 0);
    20d0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    20d7:	00 
    20d8:	c7 04 24 b8 4e 00 00 	movl   $0x4eb8,(%esp)
    20df:	e8 38 1e 00 00       	call   3f1c <open>
    20e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    20e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20eb:	79 19                	jns    2106 <subdir+0x18f>
    printf(1, "open dd/dd/../ff failed\n");
    20ed:	c7 44 24 04 c4 4e 00 	movl   $0x4ec4,0x4(%esp)
    20f4:	00 
    20f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20fc:	e8 58 1f 00 00       	call   4059 <printf>
    exit();
    2101:	e8 d6 1d 00 00       	call   3edc <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    2106:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    210d:	00 
    210e:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    2115:	00 
    2116:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2119:	89 04 24             	mov    %eax,(%esp)
    211c:	e8 d3 1d 00 00       	call   3ef4 <read>
    2121:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    2124:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    2128:	75 0b                	jne    2135 <subdir+0x1be>
    212a:	0f b6 05 e0 8a 00 00 	movzbl 0x8ae0,%eax
    2131:	3c 66                	cmp    $0x66,%al
    2133:	74 19                	je     214e <subdir+0x1d7>
    printf(1, "dd/dd/../ff wrong content\n");
    2135:	c7 44 24 04 dd 4e 00 	movl   $0x4edd,0x4(%esp)
    213c:	00 
    213d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2144:	e8 10 1f 00 00       	call   4059 <printf>
    exit();
    2149:	e8 8e 1d 00 00       	call   3edc <exit>
  }
  close(fd);
    214e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2151:	89 04 24             	mov    %eax,(%esp)
    2154:	e8 ab 1d 00 00       	call   3f04 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2159:	c7 44 24 04 f8 4e 00 	movl   $0x4ef8,0x4(%esp)
    2160:	00 
    2161:	c7 04 24 94 4e 00 00 	movl   $0x4e94,(%esp)
    2168:	e8 cf 1d 00 00       	call   3f3c <link>
    216d:	85 c0                	test   %eax,%eax
    216f:	74 19                	je     218a <subdir+0x213>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2171:	c7 44 24 04 04 4f 00 	movl   $0x4f04,0x4(%esp)
    2178:	00 
    2179:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2180:	e8 d4 1e 00 00       	call   4059 <printf>
    exit();
    2185:	e8 52 1d 00 00       	call   3edc <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    218a:	c7 04 24 94 4e 00 00 	movl   $0x4e94,(%esp)
    2191:	e8 96 1d 00 00       	call   3f2c <unlink>
    2196:	85 c0                	test   %eax,%eax
    2198:	74 19                	je     21b3 <subdir+0x23c>
    printf(1, "unlink dd/dd/ff failed\n");
    219a:	c7 44 24 04 25 4f 00 	movl   $0x4f25,0x4(%esp)
    21a1:	00 
    21a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21a9:	e8 ab 1e 00 00       	call   4059 <printf>
    exit();
    21ae:	e8 29 1d 00 00       	call   3edc <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    21b3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    21ba:	00 
    21bb:	c7 04 24 94 4e 00 00 	movl   $0x4e94,(%esp)
    21c2:	e8 55 1d 00 00       	call   3f1c <open>
    21c7:	85 c0                	test   %eax,%eax
    21c9:	78 19                	js     21e4 <subdir+0x26d>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    21cb:	c7 44 24 04 40 4f 00 	movl   $0x4f40,0x4(%esp)
    21d2:	00 
    21d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21da:	e8 7a 1e 00 00       	call   4059 <printf>
    exit();
    21df:	e8 f8 1c 00 00       	call   3edc <exit>
  }

  if(chdir("dd") != 0){
    21e4:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    21eb:	e8 5c 1d 00 00       	call   3f4c <chdir>
    21f0:	85 c0                	test   %eax,%eax
    21f2:	74 19                	je     220d <subdir+0x296>
    printf(1, "chdir dd failed\n");
    21f4:	c7 44 24 04 64 4f 00 	movl   $0x4f64,0x4(%esp)
    21fb:	00 
    21fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2203:	e8 51 1e 00 00       	call   4059 <printf>
    exit();
    2208:	e8 cf 1c 00 00       	call   3edc <exit>
  }
  if(chdir("dd/../../dd") != 0){
    220d:	c7 04 24 75 4f 00 00 	movl   $0x4f75,(%esp)
    2214:	e8 33 1d 00 00       	call   3f4c <chdir>
    2219:	85 c0                	test   %eax,%eax
    221b:	74 19                	je     2236 <subdir+0x2bf>
    printf(1, "chdir dd/../../dd failed\n");
    221d:	c7 44 24 04 81 4f 00 	movl   $0x4f81,0x4(%esp)
    2224:	00 
    2225:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    222c:	e8 28 1e 00 00       	call   4059 <printf>
    exit();
    2231:	e8 a6 1c 00 00       	call   3edc <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    2236:	c7 04 24 9b 4f 00 00 	movl   $0x4f9b,(%esp)
    223d:	e8 0a 1d 00 00       	call   3f4c <chdir>
    2242:	85 c0                	test   %eax,%eax
    2244:	74 19                	je     225f <subdir+0x2e8>
    printf(1, "chdir dd/../../dd failed\n");
    2246:	c7 44 24 04 81 4f 00 	movl   $0x4f81,0x4(%esp)
    224d:	00 
    224e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2255:	e8 ff 1d 00 00       	call   4059 <printf>
    exit();
    225a:	e8 7d 1c 00 00       	call   3edc <exit>
  }
  if(chdir("./..") != 0){
    225f:	c7 04 24 aa 4f 00 00 	movl   $0x4faa,(%esp)
    2266:	e8 e1 1c 00 00       	call   3f4c <chdir>
    226b:	85 c0                	test   %eax,%eax
    226d:	74 19                	je     2288 <subdir+0x311>
    printf(1, "chdir ./.. failed\n");
    226f:	c7 44 24 04 af 4f 00 	movl   $0x4faf,0x4(%esp)
    2276:	00 
    2277:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    227e:	e8 d6 1d 00 00       	call   4059 <printf>
    exit();
    2283:	e8 54 1c 00 00       	call   3edc <exit>
  }

  fd = open("dd/dd/ffff", 0);
    2288:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    228f:	00 
    2290:	c7 04 24 f8 4e 00 00 	movl   $0x4ef8,(%esp)
    2297:	e8 80 1c 00 00       	call   3f1c <open>
    229c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    229f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22a3:	79 19                	jns    22be <subdir+0x347>
    printf(1, "open dd/dd/ffff failed\n");
    22a5:	c7 44 24 04 c2 4f 00 	movl   $0x4fc2,0x4(%esp)
    22ac:	00 
    22ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22b4:	e8 a0 1d 00 00       	call   4059 <printf>
    exit();
    22b9:	e8 1e 1c 00 00       	call   3edc <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    22be:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    22c5:	00 
    22c6:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    22cd:	00 
    22ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22d1:	89 04 24             	mov    %eax,(%esp)
    22d4:	e8 1b 1c 00 00       	call   3ef4 <read>
    22d9:	83 f8 02             	cmp    $0x2,%eax
    22dc:	74 19                	je     22f7 <subdir+0x380>
    printf(1, "read dd/dd/ffff wrong len\n");
    22de:	c7 44 24 04 da 4f 00 	movl   $0x4fda,0x4(%esp)
    22e5:	00 
    22e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22ed:	e8 67 1d 00 00       	call   4059 <printf>
    exit();
    22f2:	e8 e5 1b 00 00       	call   3edc <exit>
  }
  close(fd);
    22f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22fa:	89 04 24             	mov    %eax,(%esp)
    22fd:	e8 02 1c 00 00       	call   3f04 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2302:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2309:	00 
    230a:	c7 04 24 94 4e 00 00 	movl   $0x4e94,(%esp)
    2311:	e8 06 1c 00 00       	call   3f1c <open>
    2316:	85 c0                	test   %eax,%eax
    2318:	78 19                	js     2333 <subdir+0x3bc>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    231a:	c7 44 24 04 f8 4f 00 	movl   $0x4ff8,0x4(%esp)
    2321:	00 
    2322:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2329:	e8 2b 1d 00 00       	call   4059 <printf>
    exit();
    232e:	e8 a9 1b 00 00       	call   3edc <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2333:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    233a:	00 
    233b:	c7 04 24 1d 50 00 00 	movl   $0x501d,(%esp)
    2342:	e8 d5 1b 00 00       	call   3f1c <open>
    2347:	85 c0                	test   %eax,%eax
    2349:	78 19                	js     2364 <subdir+0x3ed>
    printf(1, "create dd/ff/ff succeeded!\n");
    234b:	c7 44 24 04 26 50 00 	movl   $0x5026,0x4(%esp)
    2352:	00 
    2353:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    235a:	e8 fa 1c 00 00       	call   4059 <printf>
    exit();
    235f:	e8 78 1b 00 00       	call   3edc <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2364:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    236b:	00 
    236c:	c7 04 24 42 50 00 00 	movl   $0x5042,(%esp)
    2373:	e8 a4 1b 00 00       	call   3f1c <open>
    2378:	85 c0                	test   %eax,%eax
    237a:	78 19                	js     2395 <subdir+0x41e>
    printf(1, "create dd/xx/ff succeeded!\n");
    237c:	c7 44 24 04 4b 50 00 	movl   $0x504b,0x4(%esp)
    2383:	00 
    2384:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    238b:	e8 c9 1c 00 00       	call   4059 <printf>
    exit();
    2390:	e8 47 1b 00 00       	call   3edc <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    2395:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    239c:	00 
    239d:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    23a4:	e8 73 1b 00 00       	call   3f1c <open>
    23a9:	85 c0                	test   %eax,%eax
    23ab:	78 19                	js     23c6 <subdir+0x44f>
    printf(1, "create dd succeeded!\n");
    23ad:	c7 44 24 04 67 50 00 	movl   $0x5067,0x4(%esp)
    23b4:	00 
    23b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23bc:	e8 98 1c 00 00       	call   4059 <printf>
    exit();
    23c1:	e8 16 1b 00 00       	call   3edc <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    23c6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    23cd:	00 
    23ce:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    23d5:	e8 42 1b 00 00       	call   3f1c <open>
    23da:	85 c0                	test   %eax,%eax
    23dc:	78 19                	js     23f7 <subdir+0x480>
    printf(1, "open dd rdwr succeeded!\n");
    23de:	c7 44 24 04 7d 50 00 	movl   $0x507d,0x4(%esp)
    23e5:	00 
    23e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23ed:	e8 67 1c 00 00       	call   4059 <printf>
    exit();
    23f2:	e8 e5 1a 00 00       	call   3edc <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    23f7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    23fe:	00 
    23ff:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    2406:	e8 11 1b 00 00       	call   3f1c <open>
    240b:	85 c0                	test   %eax,%eax
    240d:	78 19                	js     2428 <subdir+0x4b1>
    printf(1, "open dd wronly succeeded!\n");
    240f:	c7 44 24 04 96 50 00 	movl   $0x5096,0x4(%esp)
    2416:	00 
    2417:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    241e:	e8 36 1c 00 00       	call   4059 <printf>
    exit();
    2423:	e8 b4 1a 00 00       	call   3edc <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2428:	c7 44 24 04 b1 50 00 	movl   $0x50b1,0x4(%esp)
    242f:	00 
    2430:	c7 04 24 1d 50 00 00 	movl   $0x501d,(%esp)
    2437:	e8 00 1b 00 00       	call   3f3c <link>
    243c:	85 c0                	test   %eax,%eax
    243e:	75 19                	jne    2459 <subdir+0x4e2>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2440:	c7 44 24 04 bc 50 00 	movl   $0x50bc,0x4(%esp)
    2447:	00 
    2448:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    244f:	e8 05 1c 00 00       	call   4059 <printf>
    exit();
    2454:	e8 83 1a 00 00       	call   3edc <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2459:	c7 44 24 04 b1 50 00 	movl   $0x50b1,0x4(%esp)
    2460:	00 
    2461:	c7 04 24 42 50 00 00 	movl   $0x5042,(%esp)
    2468:	e8 cf 1a 00 00       	call   3f3c <link>
    246d:	85 c0                	test   %eax,%eax
    246f:	75 19                	jne    248a <subdir+0x513>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2471:	c7 44 24 04 e0 50 00 	movl   $0x50e0,0x4(%esp)
    2478:	00 
    2479:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2480:	e8 d4 1b 00 00       	call   4059 <printf>
    exit();
    2485:	e8 52 1a 00 00       	call   3edc <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    248a:	c7 44 24 04 f8 4e 00 	movl   $0x4ef8,0x4(%esp)
    2491:	00 
    2492:	c7 04 24 30 4e 00 00 	movl   $0x4e30,(%esp)
    2499:	e8 9e 1a 00 00       	call   3f3c <link>
    249e:	85 c0                	test   %eax,%eax
    24a0:	75 19                	jne    24bb <subdir+0x544>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    24a2:	c7 44 24 04 04 51 00 	movl   $0x5104,0x4(%esp)
    24a9:	00 
    24aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24b1:	e8 a3 1b 00 00       	call   4059 <printf>
    exit();
    24b6:	e8 21 1a 00 00       	call   3edc <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    24bb:	c7 04 24 1d 50 00 00 	movl   $0x501d,(%esp)
    24c2:	e8 7d 1a 00 00       	call   3f44 <mkdir>
    24c7:	85 c0                	test   %eax,%eax
    24c9:	75 19                	jne    24e4 <subdir+0x56d>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    24cb:	c7 44 24 04 26 51 00 	movl   $0x5126,0x4(%esp)
    24d2:	00 
    24d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24da:	e8 7a 1b 00 00       	call   4059 <printf>
    exit();
    24df:	e8 f8 19 00 00       	call   3edc <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    24e4:	c7 04 24 42 50 00 00 	movl   $0x5042,(%esp)
    24eb:	e8 54 1a 00 00       	call   3f44 <mkdir>
    24f0:	85 c0                	test   %eax,%eax
    24f2:	75 19                	jne    250d <subdir+0x596>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    24f4:	c7 44 24 04 41 51 00 	movl   $0x5141,0x4(%esp)
    24fb:	00 
    24fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2503:	e8 51 1b 00 00       	call   4059 <printf>
    exit();
    2508:	e8 cf 19 00 00       	call   3edc <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    250d:	c7 04 24 f8 4e 00 00 	movl   $0x4ef8,(%esp)
    2514:	e8 2b 1a 00 00       	call   3f44 <mkdir>
    2519:	85 c0                	test   %eax,%eax
    251b:	75 19                	jne    2536 <subdir+0x5bf>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    251d:	c7 44 24 04 5c 51 00 	movl   $0x515c,0x4(%esp)
    2524:	00 
    2525:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    252c:	e8 28 1b 00 00       	call   4059 <printf>
    exit();
    2531:	e8 a6 19 00 00       	call   3edc <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    2536:	c7 04 24 42 50 00 00 	movl   $0x5042,(%esp)
    253d:	e8 ea 19 00 00       	call   3f2c <unlink>
    2542:	85 c0                	test   %eax,%eax
    2544:	75 19                	jne    255f <subdir+0x5e8>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2546:	c7 44 24 04 79 51 00 	movl   $0x5179,0x4(%esp)
    254d:	00 
    254e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2555:	e8 ff 1a 00 00       	call   4059 <printf>
    exit();
    255a:	e8 7d 19 00 00       	call   3edc <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    255f:	c7 04 24 1d 50 00 00 	movl   $0x501d,(%esp)
    2566:	e8 c1 19 00 00       	call   3f2c <unlink>
    256b:	85 c0                	test   %eax,%eax
    256d:	75 19                	jne    2588 <subdir+0x611>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    256f:	c7 44 24 04 95 51 00 	movl   $0x5195,0x4(%esp)
    2576:	00 
    2577:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    257e:	e8 d6 1a 00 00       	call   4059 <printf>
    exit();
    2583:	e8 54 19 00 00       	call   3edc <exit>
  }
  if(chdir("dd/ff") == 0){
    2588:	c7 04 24 30 4e 00 00 	movl   $0x4e30,(%esp)
    258f:	e8 b8 19 00 00       	call   3f4c <chdir>
    2594:	85 c0                	test   %eax,%eax
    2596:	75 19                	jne    25b1 <subdir+0x63a>
    printf(1, "chdir dd/ff succeeded!\n");
    2598:	c7 44 24 04 b1 51 00 	movl   $0x51b1,0x4(%esp)
    259f:	00 
    25a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25a7:	e8 ad 1a 00 00       	call   4059 <printf>
    exit();
    25ac:	e8 2b 19 00 00       	call   3edc <exit>
  }
  if(chdir("dd/xx") == 0){
    25b1:	c7 04 24 c9 51 00 00 	movl   $0x51c9,(%esp)
    25b8:	e8 8f 19 00 00       	call   3f4c <chdir>
    25bd:	85 c0                	test   %eax,%eax
    25bf:	75 19                	jne    25da <subdir+0x663>
    printf(1, "chdir dd/xx succeeded!\n");
    25c1:	c7 44 24 04 cf 51 00 	movl   $0x51cf,0x4(%esp)
    25c8:	00 
    25c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25d0:	e8 84 1a 00 00       	call   4059 <printf>
    exit();
    25d5:	e8 02 19 00 00       	call   3edc <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    25da:	c7 04 24 f8 4e 00 00 	movl   $0x4ef8,(%esp)
    25e1:	e8 46 19 00 00       	call   3f2c <unlink>
    25e6:	85 c0                	test   %eax,%eax
    25e8:	74 19                	je     2603 <subdir+0x68c>
    printf(1, "unlink dd/dd/ff failed\n");
    25ea:	c7 44 24 04 25 4f 00 	movl   $0x4f25,0x4(%esp)
    25f1:	00 
    25f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25f9:	e8 5b 1a 00 00       	call   4059 <printf>
    exit();
    25fe:	e8 d9 18 00 00       	call   3edc <exit>
  }
  if(unlink("dd/ff") != 0){
    2603:	c7 04 24 30 4e 00 00 	movl   $0x4e30,(%esp)
    260a:	e8 1d 19 00 00       	call   3f2c <unlink>
    260f:	85 c0                	test   %eax,%eax
    2611:	74 19                	je     262c <subdir+0x6b5>
    printf(1, "unlink dd/ff failed\n");
    2613:	c7 44 24 04 e7 51 00 	movl   $0x51e7,0x4(%esp)
    261a:	00 
    261b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2622:	e8 32 1a 00 00       	call   4059 <printf>
    exit();
    2627:	e8 b0 18 00 00       	call   3edc <exit>
  }
  if(unlink("dd") == 0){
    262c:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    2633:	e8 f4 18 00 00       	call   3f2c <unlink>
    2638:	85 c0                	test   %eax,%eax
    263a:	75 19                	jne    2655 <subdir+0x6de>
    printf(1, "unlink non-empty dd succeeded!\n");
    263c:	c7 44 24 04 fc 51 00 	movl   $0x51fc,0x4(%esp)
    2643:	00 
    2644:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    264b:	e8 09 1a 00 00       	call   4059 <printf>
    exit();
    2650:	e8 87 18 00 00       	call   3edc <exit>
  }
  if(unlink("dd/dd") < 0){
    2655:	c7 04 24 1c 52 00 00 	movl   $0x521c,(%esp)
    265c:	e8 cb 18 00 00       	call   3f2c <unlink>
    2661:	85 c0                	test   %eax,%eax
    2663:	79 19                	jns    267e <subdir+0x707>
    printf(1, "unlink dd/dd failed\n");
    2665:	c7 44 24 04 22 52 00 	movl   $0x5222,0x4(%esp)
    266c:	00 
    266d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2674:	e8 e0 19 00 00       	call   4059 <printf>
    exit();
    2679:	e8 5e 18 00 00       	call   3edc <exit>
  }
  if(unlink("dd") < 0){
    267e:	c7 04 24 15 4e 00 00 	movl   $0x4e15,(%esp)
    2685:	e8 a2 18 00 00       	call   3f2c <unlink>
    268a:	85 c0                	test   %eax,%eax
    268c:	79 19                	jns    26a7 <subdir+0x730>
    printf(1, "unlink dd failed\n");
    268e:	c7 44 24 04 37 52 00 	movl   $0x5237,0x4(%esp)
    2695:	00 
    2696:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    269d:	e8 b7 19 00 00       	call   4059 <printf>
    exit();
    26a2:	e8 35 18 00 00       	call   3edc <exit>
  }

  printf(1, "subdir ok\n");
    26a7:	c7 44 24 04 49 52 00 	movl   $0x5249,0x4(%esp)
    26ae:	00 
    26af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26b6:	e8 9e 19 00 00       	call   4059 <printf>
}
    26bb:	c9                   	leave  
    26bc:	c3                   	ret    

000026bd <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    26bd:	55                   	push   %ebp
    26be:	89 e5                	mov    %esp,%ebp
    26c0:	83 ec 28             	sub    $0x28,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    26c3:	c7 44 24 04 54 52 00 	movl   $0x5254,0x4(%esp)
    26ca:	00 
    26cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26d2:	e8 82 19 00 00       	call   4059 <printf>

  unlink("bigwrite");
    26d7:	c7 04 24 63 52 00 00 	movl   $0x5263,(%esp)
    26de:	e8 49 18 00 00       	call   3f2c <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    26e3:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    26ea:	e9 b3 00 00 00       	jmp    27a2 <bigwrite+0xe5>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    26ef:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    26f6:	00 
    26f7:	c7 04 24 63 52 00 00 	movl   $0x5263,(%esp)
    26fe:	e8 19 18 00 00       	call   3f1c <open>
    2703:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    2706:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    270a:	79 19                	jns    2725 <bigwrite+0x68>
      printf(1, "cannot create bigwrite\n");
    270c:	c7 44 24 04 6c 52 00 	movl   $0x526c,0x4(%esp)
    2713:	00 
    2714:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    271b:	e8 39 19 00 00       	call   4059 <printf>
      exit();
    2720:	e8 b7 17 00 00       	call   3edc <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    2725:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    272c:	eb 50                	jmp    277e <bigwrite+0xc1>
      int cc = write(fd, buf, sz);
    272e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2731:	89 44 24 08          	mov    %eax,0x8(%esp)
    2735:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    273c:	00 
    273d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2740:	89 04 24             	mov    %eax,(%esp)
    2743:	e8 b4 17 00 00       	call   3efc <write>
    2748:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    274b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    274e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2751:	74 27                	je     277a <bigwrite+0xbd>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2753:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2756:	89 44 24 0c          	mov    %eax,0xc(%esp)
    275a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    275d:	89 44 24 08          	mov    %eax,0x8(%esp)
    2761:	c7 44 24 04 84 52 00 	movl   $0x5284,0x4(%esp)
    2768:	00 
    2769:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2770:	e8 e4 18 00 00       	call   4059 <printf>
        exit();
    2775:	e8 62 17 00 00       	call   3edc <exit>
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
    277a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    277e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2782:	7e aa                	jle    272e <bigwrite+0x71>
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    2784:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2787:	89 04 24             	mov    %eax,(%esp)
    278a:	e8 75 17 00 00       	call   3f04 <close>
    unlink("bigwrite");
    278f:	c7 04 24 63 52 00 00 	movl   $0x5263,(%esp)
    2796:	e8 91 17 00 00       	call   3f2c <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    279b:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    27a2:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    27a9:	0f 8e 40 ff ff ff    	jle    26ef <bigwrite+0x32>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    27af:	c7 44 24 04 96 52 00 	movl   $0x5296,0x4(%esp)
    27b6:	00 
    27b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27be:	e8 96 18 00 00       	call   4059 <printf>
}
    27c3:	c9                   	leave  
    27c4:	c3                   	ret    

000027c5 <bigfile>:

void
bigfile(void)
{
    27c5:	55                   	push   %ebp
    27c6:	89 e5                	mov    %esp,%ebp
    27c8:	83 ec 28             	sub    $0x28,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    27cb:	c7 44 24 04 a3 52 00 	movl   $0x52a3,0x4(%esp)
    27d2:	00 
    27d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27da:	e8 7a 18 00 00       	call   4059 <printf>

  unlink("bigfile");
    27df:	c7 04 24 b1 52 00 00 	movl   $0x52b1,(%esp)
    27e6:	e8 41 17 00 00       	call   3f2c <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    27eb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    27f2:	00 
    27f3:	c7 04 24 b1 52 00 00 	movl   $0x52b1,(%esp)
    27fa:	e8 1d 17 00 00       	call   3f1c <open>
    27ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2802:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2806:	79 19                	jns    2821 <bigfile+0x5c>
    printf(1, "cannot create bigfile");
    2808:	c7 44 24 04 b9 52 00 	movl   $0x52b9,0x4(%esp)
    280f:	00 
    2810:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2817:	e8 3d 18 00 00       	call   4059 <printf>
    exit();
    281c:	e8 bb 16 00 00       	call   3edc <exit>
  }
  for(i = 0; i < 20; i++){
    2821:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2828:	eb 5a                	jmp    2884 <bigfile+0xbf>
    memset(buf, i, 600);
    282a:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    2831:	00 
    2832:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2835:	89 44 24 04          	mov    %eax,0x4(%esp)
    2839:	c7 04 24 e0 8a 00 00 	movl   $0x8ae0,(%esp)
    2840:	e8 f0 14 00 00       	call   3d35 <memset>
    if(write(fd, buf, 600) != 600){
    2845:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    284c:	00 
    284d:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    2854:	00 
    2855:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2858:	89 04 24             	mov    %eax,(%esp)
    285b:	e8 9c 16 00 00       	call   3efc <write>
    2860:	3d 58 02 00 00       	cmp    $0x258,%eax
    2865:	74 19                	je     2880 <bigfile+0xbb>
      printf(1, "write bigfile failed\n");
    2867:	c7 44 24 04 cf 52 00 	movl   $0x52cf,0x4(%esp)
    286e:	00 
    286f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2876:	e8 de 17 00 00       	call   4059 <printf>
      exit();
    287b:	e8 5c 16 00 00       	call   3edc <exit>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    2880:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2884:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2888:	7e a0                	jle    282a <bigfile+0x65>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    288a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    288d:	89 04 24             	mov    %eax,(%esp)
    2890:	e8 6f 16 00 00       	call   3f04 <close>

  fd = open("bigfile", 0);
    2895:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    289c:	00 
    289d:	c7 04 24 b1 52 00 00 	movl   $0x52b1,(%esp)
    28a4:	e8 73 16 00 00       	call   3f1c <open>
    28a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    28ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    28b0:	79 19                	jns    28cb <bigfile+0x106>
    printf(1, "cannot open bigfile\n");
    28b2:	c7 44 24 04 e5 52 00 	movl   $0x52e5,0x4(%esp)
    28b9:	00 
    28ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28c1:	e8 93 17 00 00       	call   4059 <printf>
    exit();
    28c6:	e8 11 16 00 00       	call   3edc <exit>
  }
  total = 0;
    28cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    28d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    28d9:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    28e0:	00 
    28e1:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    28e8:	00 
    28e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    28ec:	89 04 24             	mov    %eax,(%esp)
    28ef:	e8 00 16 00 00       	call   3ef4 <read>
    28f4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    28f7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28fb:	79 19                	jns    2916 <bigfile+0x151>
      printf(1, "read bigfile failed\n");
    28fd:	c7 44 24 04 fa 52 00 	movl   $0x52fa,0x4(%esp)
    2904:	00 
    2905:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    290c:	e8 48 17 00 00       	call   4059 <printf>
      exit();
    2911:	e8 c6 15 00 00       	call   3edc <exit>
    }
    if(cc == 0)
    2916:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    291a:	74 7e                	je     299a <bigfile+0x1d5>
      break;
    if(cc != 300){
    291c:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2923:	74 19                	je     293e <bigfile+0x179>
      printf(1, "short read bigfile\n");
    2925:	c7 44 24 04 0f 53 00 	movl   $0x530f,0x4(%esp)
    292c:	00 
    292d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2934:	e8 20 17 00 00       	call   4059 <printf>
      exit();
    2939:	e8 9e 15 00 00       	call   3edc <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    293e:	0f b6 05 e0 8a 00 00 	movzbl 0x8ae0,%eax
    2945:	0f be d0             	movsbl %al,%edx
    2948:	8b 45 f4             	mov    -0xc(%ebp),%eax
    294b:	89 c1                	mov    %eax,%ecx
    294d:	c1 e9 1f             	shr    $0x1f,%ecx
    2950:	01 c8                	add    %ecx,%eax
    2952:	d1 f8                	sar    %eax
    2954:	39 c2                	cmp    %eax,%edx
    2956:	75 1a                	jne    2972 <bigfile+0x1ad>
    2958:	0f b6 05 0b 8c 00 00 	movzbl 0x8c0b,%eax
    295f:	0f be d0             	movsbl %al,%edx
    2962:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2965:	89 c1                	mov    %eax,%ecx
    2967:	c1 e9 1f             	shr    $0x1f,%ecx
    296a:	01 c8                	add    %ecx,%eax
    296c:	d1 f8                	sar    %eax
    296e:	39 c2                	cmp    %eax,%edx
    2970:	74 19                	je     298b <bigfile+0x1c6>
      printf(1, "read bigfile wrong data\n");
    2972:	c7 44 24 04 23 53 00 	movl   $0x5323,0x4(%esp)
    2979:	00 
    297a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2981:	e8 d3 16 00 00       	call   4059 <printf>
      exit();
    2986:	e8 51 15 00 00       	call   3edc <exit>
    }
    total += cc;
    298b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    298e:	01 45 f0             	add    %eax,-0x10(%ebp)
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    2991:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
    2995:	e9 3f ff ff ff       	jmp    28d9 <bigfile+0x114>
    if(cc < 0){
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    299a:	90                   	nop
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    299b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    299e:	89 04 24             	mov    %eax,(%esp)
    29a1:	e8 5e 15 00 00       	call   3f04 <close>
  if(total != 20*600){
    29a6:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    29ad:	74 19                	je     29c8 <bigfile+0x203>
    printf(1, "read bigfile wrong total\n");
    29af:	c7 44 24 04 3c 53 00 	movl   $0x533c,0x4(%esp)
    29b6:	00 
    29b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29be:	e8 96 16 00 00       	call   4059 <printf>
    exit();
    29c3:	e8 14 15 00 00       	call   3edc <exit>
  }
  unlink("bigfile");
    29c8:	c7 04 24 b1 52 00 00 	movl   $0x52b1,(%esp)
    29cf:	e8 58 15 00 00       	call   3f2c <unlink>

  printf(1, "bigfile test ok\n");
    29d4:	c7 44 24 04 56 53 00 	movl   $0x5356,0x4(%esp)
    29db:	00 
    29dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29e3:	e8 71 16 00 00       	call   4059 <printf>
}
    29e8:	c9                   	leave  
    29e9:	c3                   	ret    

000029ea <fourteen>:

void
fourteen(void)
{
    29ea:	55                   	push   %ebp
    29eb:	89 e5                	mov    %esp,%ebp
    29ed:	83 ec 28             	sub    $0x28,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    29f0:	c7 44 24 04 67 53 00 	movl   $0x5367,0x4(%esp)
    29f7:	00 
    29f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29ff:	e8 55 16 00 00       	call   4059 <printf>

  if(mkdir("12345678901234") != 0){
    2a04:	c7 04 24 76 53 00 00 	movl   $0x5376,(%esp)
    2a0b:	e8 34 15 00 00       	call   3f44 <mkdir>
    2a10:	85 c0                	test   %eax,%eax
    2a12:	74 19                	je     2a2d <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    2a14:	c7 44 24 04 85 53 00 	movl   $0x5385,0x4(%esp)
    2a1b:	00 
    2a1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a23:	e8 31 16 00 00       	call   4059 <printf>
    exit();
    2a28:	e8 af 14 00 00       	call   3edc <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2a2d:	c7 04 24 a4 53 00 00 	movl   $0x53a4,(%esp)
    2a34:	e8 0b 15 00 00       	call   3f44 <mkdir>
    2a39:	85 c0                	test   %eax,%eax
    2a3b:	74 19                	je     2a56 <fourteen+0x6c>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2a3d:	c7 44 24 04 c4 53 00 	movl   $0x53c4,0x4(%esp)
    2a44:	00 
    2a45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a4c:	e8 08 16 00 00       	call   4059 <printf>
    exit();
    2a51:	e8 86 14 00 00       	call   3edc <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2a56:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2a5d:	00 
    2a5e:	c7 04 24 f4 53 00 00 	movl   $0x53f4,(%esp)
    2a65:	e8 b2 14 00 00       	call   3f1c <open>
    2a6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a6d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a71:	79 19                	jns    2a8c <fourteen+0xa2>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2a73:	c7 44 24 04 24 54 00 	movl   $0x5424,0x4(%esp)
    2a7a:	00 
    2a7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a82:	e8 d2 15 00 00       	call   4059 <printf>
    exit();
    2a87:	e8 50 14 00 00       	call   3edc <exit>
  }
  close(fd);
    2a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a8f:	89 04 24             	mov    %eax,(%esp)
    2a92:	e8 6d 14 00 00       	call   3f04 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2a97:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2a9e:	00 
    2a9f:	c7 04 24 64 54 00 00 	movl   $0x5464,(%esp)
    2aa6:	e8 71 14 00 00       	call   3f1c <open>
    2aab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2aae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ab2:	79 19                	jns    2acd <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2ab4:	c7 44 24 04 94 54 00 	movl   $0x5494,0x4(%esp)
    2abb:	00 
    2abc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ac3:	e8 91 15 00 00       	call   4059 <printf>
    exit();
    2ac8:	e8 0f 14 00 00       	call   3edc <exit>
  }
  close(fd);
    2acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ad0:	89 04 24             	mov    %eax,(%esp)
    2ad3:	e8 2c 14 00 00       	call   3f04 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2ad8:	c7 04 24 ce 54 00 00 	movl   $0x54ce,(%esp)
    2adf:	e8 60 14 00 00       	call   3f44 <mkdir>
    2ae4:	85 c0                	test   %eax,%eax
    2ae6:	75 19                	jne    2b01 <fourteen+0x117>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2ae8:	c7 44 24 04 ec 54 00 	movl   $0x54ec,0x4(%esp)
    2aef:	00 
    2af0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2af7:	e8 5d 15 00 00       	call   4059 <printf>
    exit();
    2afc:	e8 db 13 00 00       	call   3edc <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2b01:	c7 04 24 1c 55 00 00 	movl   $0x551c,(%esp)
    2b08:	e8 37 14 00 00       	call   3f44 <mkdir>
    2b0d:	85 c0                	test   %eax,%eax
    2b0f:	75 19                	jne    2b2a <fourteen+0x140>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2b11:	c7 44 24 04 3c 55 00 	movl   $0x553c,0x4(%esp)
    2b18:	00 
    2b19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b20:	e8 34 15 00 00       	call   4059 <printf>
    exit();
    2b25:	e8 b2 13 00 00       	call   3edc <exit>
  }

  printf(1, "fourteen ok\n");
    2b2a:	c7 44 24 04 6d 55 00 	movl   $0x556d,0x4(%esp)
    2b31:	00 
    2b32:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b39:	e8 1b 15 00 00       	call   4059 <printf>
}
    2b3e:	c9                   	leave  
    2b3f:	c3                   	ret    

00002b40 <rmdot>:

void
rmdot(void)
{
    2b40:	55                   	push   %ebp
    2b41:	89 e5                	mov    %esp,%ebp
    2b43:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    2b46:	c7 44 24 04 7a 55 00 	movl   $0x557a,0x4(%esp)
    2b4d:	00 
    2b4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b55:	e8 ff 14 00 00       	call   4059 <printf>
  if(mkdir("dots") != 0){
    2b5a:	c7 04 24 86 55 00 00 	movl   $0x5586,(%esp)
    2b61:	e8 de 13 00 00       	call   3f44 <mkdir>
    2b66:	85 c0                	test   %eax,%eax
    2b68:	74 19                	je     2b83 <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    2b6a:	c7 44 24 04 8b 55 00 	movl   $0x558b,0x4(%esp)
    2b71:	00 
    2b72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b79:	e8 db 14 00 00       	call   4059 <printf>
    exit();
    2b7e:	e8 59 13 00 00       	call   3edc <exit>
  }
  if(chdir("dots") != 0){
    2b83:	c7 04 24 86 55 00 00 	movl   $0x5586,(%esp)
    2b8a:	e8 bd 13 00 00       	call   3f4c <chdir>
    2b8f:	85 c0                	test   %eax,%eax
    2b91:	74 19                	je     2bac <rmdot+0x6c>
    printf(1, "chdir dots failed\n");
    2b93:	c7 44 24 04 9e 55 00 	movl   $0x559e,0x4(%esp)
    2b9a:	00 
    2b9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ba2:	e8 b2 14 00 00       	call   4059 <printf>
    exit();
    2ba7:	e8 30 13 00 00       	call   3edc <exit>
  }
  if(unlink(".") == 0){
    2bac:	c7 04 24 b7 4c 00 00 	movl   $0x4cb7,(%esp)
    2bb3:	e8 74 13 00 00       	call   3f2c <unlink>
    2bb8:	85 c0                	test   %eax,%eax
    2bba:	75 19                	jne    2bd5 <rmdot+0x95>
    printf(1, "rm . worked!\n");
    2bbc:	c7 44 24 04 b1 55 00 	movl   $0x55b1,0x4(%esp)
    2bc3:	00 
    2bc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bcb:	e8 89 14 00 00       	call   4059 <printf>
    exit();
    2bd0:	e8 07 13 00 00       	call   3edc <exit>
  }
  if(unlink("..") == 0){
    2bd5:	c7 04 24 4a 48 00 00 	movl   $0x484a,(%esp)
    2bdc:	e8 4b 13 00 00       	call   3f2c <unlink>
    2be1:	85 c0                	test   %eax,%eax
    2be3:	75 19                	jne    2bfe <rmdot+0xbe>
    printf(1, "rm .. worked!\n");
    2be5:	c7 44 24 04 bf 55 00 	movl   $0x55bf,0x4(%esp)
    2bec:	00 
    2bed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bf4:	e8 60 14 00 00       	call   4059 <printf>
    exit();
    2bf9:	e8 de 12 00 00       	call   3edc <exit>
  }
  if(chdir("/") != 0){
    2bfe:	c7 04 24 9e 44 00 00 	movl   $0x449e,(%esp)
    2c05:	e8 42 13 00 00       	call   3f4c <chdir>
    2c0a:	85 c0                	test   %eax,%eax
    2c0c:	74 19                	je     2c27 <rmdot+0xe7>
    printf(1, "chdir / failed\n");
    2c0e:	c7 44 24 04 a0 44 00 	movl   $0x44a0,0x4(%esp)
    2c15:	00 
    2c16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c1d:	e8 37 14 00 00       	call   4059 <printf>
    exit();
    2c22:	e8 b5 12 00 00       	call   3edc <exit>
  }
  if(unlink("dots/.") == 0){
    2c27:	c7 04 24 ce 55 00 00 	movl   $0x55ce,(%esp)
    2c2e:	e8 f9 12 00 00       	call   3f2c <unlink>
    2c33:	85 c0                	test   %eax,%eax
    2c35:	75 19                	jne    2c50 <rmdot+0x110>
    printf(1, "unlink dots/. worked!\n");
    2c37:	c7 44 24 04 d5 55 00 	movl   $0x55d5,0x4(%esp)
    2c3e:	00 
    2c3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c46:	e8 0e 14 00 00       	call   4059 <printf>
    exit();
    2c4b:	e8 8c 12 00 00       	call   3edc <exit>
  }
  if(unlink("dots/..") == 0){
    2c50:	c7 04 24 ec 55 00 00 	movl   $0x55ec,(%esp)
    2c57:	e8 d0 12 00 00       	call   3f2c <unlink>
    2c5c:	85 c0                	test   %eax,%eax
    2c5e:	75 19                	jne    2c79 <rmdot+0x139>
    printf(1, "unlink dots/.. worked!\n");
    2c60:	c7 44 24 04 f4 55 00 	movl   $0x55f4,0x4(%esp)
    2c67:	00 
    2c68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c6f:	e8 e5 13 00 00       	call   4059 <printf>
    exit();
    2c74:	e8 63 12 00 00       	call   3edc <exit>
  }
  if(unlink("dots") != 0){
    2c79:	c7 04 24 86 55 00 00 	movl   $0x5586,(%esp)
    2c80:	e8 a7 12 00 00       	call   3f2c <unlink>
    2c85:	85 c0                	test   %eax,%eax
    2c87:	74 19                	je     2ca2 <rmdot+0x162>
    printf(1, "unlink dots failed!\n");
    2c89:	c7 44 24 04 0c 56 00 	movl   $0x560c,0x4(%esp)
    2c90:	00 
    2c91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c98:	e8 bc 13 00 00       	call   4059 <printf>
    exit();
    2c9d:	e8 3a 12 00 00       	call   3edc <exit>
  }
  printf(1, "rmdot ok\n");
    2ca2:	c7 44 24 04 21 56 00 	movl   $0x5621,0x4(%esp)
    2ca9:	00 
    2caa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cb1:	e8 a3 13 00 00       	call   4059 <printf>
}
    2cb6:	c9                   	leave  
    2cb7:	c3                   	ret    

00002cb8 <dirfile>:

void
dirfile(void)
{
    2cb8:	55                   	push   %ebp
    2cb9:	89 e5                	mov    %esp,%ebp
    2cbb:	83 ec 28             	sub    $0x28,%esp
  int fd;

  printf(1, "dir vs file\n");
    2cbe:	c7 44 24 04 2b 56 00 	movl   $0x562b,0x4(%esp)
    2cc5:	00 
    2cc6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ccd:	e8 87 13 00 00       	call   4059 <printf>

  fd = open("dirfile", O_CREATE);
    2cd2:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2cd9:	00 
    2cda:	c7 04 24 38 56 00 00 	movl   $0x5638,(%esp)
    2ce1:	e8 36 12 00 00       	call   3f1c <open>
    2ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2ce9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ced:	79 19                	jns    2d08 <dirfile+0x50>
    printf(1, "create dirfile failed\n");
    2cef:	c7 44 24 04 40 56 00 	movl   $0x5640,0x4(%esp)
    2cf6:	00 
    2cf7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cfe:	e8 56 13 00 00       	call   4059 <printf>
    exit();
    2d03:	e8 d4 11 00 00       	call   3edc <exit>
  }
  close(fd);
    2d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d0b:	89 04 24             	mov    %eax,(%esp)
    2d0e:	e8 f1 11 00 00       	call   3f04 <close>
  if(chdir("dirfile") == 0){
    2d13:	c7 04 24 38 56 00 00 	movl   $0x5638,(%esp)
    2d1a:	e8 2d 12 00 00       	call   3f4c <chdir>
    2d1f:	85 c0                	test   %eax,%eax
    2d21:	75 19                	jne    2d3c <dirfile+0x84>
    printf(1, "chdir dirfile succeeded!\n");
    2d23:	c7 44 24 04 57 56 00 	movl   $0x5657,0x4(%esp)
    2d2a:	00 
    2d2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d32:	e8 22 13 00 00       	call   4059 <printf>
    exit();
    2d37:	e8 a0 11 00 00       	call   3edc <exit>
  }
  fd = open("dirfile/xx", 0);
    2d3c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2d43:	00 
    2d44:	c7 04 24 71 56 00 00 	movl   $0x5671,(%esp)
    2d4b:	e8 cc 11 00 00       	call   3f1c <open>
    2d50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2d53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d57:	78 19                	js     2d72 <dirfile+0xba>
    printf(1, "create dirfile/xx succeeded!\n");
    2d59:	c7 44 24 04 7c 56 00 	movl   $0x567c,0x4(%esp)
    2d60:	00 
    2d61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d68:	e8 ec 12 00 00       	call   4059 <printf>
    exit();
    2d6d:	e8 6a 11 00 00       	call   3edc <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2d72:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2d79:	00 
    2d7a:	c7 04 24 71 56 00 00 	movl   $0x5671,(%esp)
    2d81:	e8 96 11 00 00       	call   3f1c <open>
    2d86:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2d89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d8d:	78 19                	js     2da8 <dirfile+0xf0>
    printf(1, "create dirfile/xx succeeded!\n");
    2d8f:	c7 44 24 04 7c 56 00 	movl   $0x567c,0x4(%esp)
    2d96:	00 
    2d97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d9e:	e8 b6 12 00 00       	call   4059 <printf>
    exit();
    2da3:	e8 34 11 00 00       	call   3edc <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2da8:	c7 04 24 71 56 00 00 	movl   $0x5671,(%esp)
    2daf:	e8 90 11 00 00       	call   3f44 <mkdir>
    2db4:	85 c0                	test   %eax,%eax
    2db6:	75 19                	jne    2dd1 <dirfile+0x119>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2db8:	c7 44 24 04 9a 56 00 	movl   $0x569a,0x4(%esp)
    2dbf:	00 
    2dc0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dc7:	e8 8d 12 00 00       	call   4059 <printf>
    exit();
    2dcc:	e8 0b 11 00 00       	call   3edc <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2dd1:	c7 04 24 71 56 00 00 	movl   $0x5671,(%esp)
    2dd8:	e8 4f 11 00 00       	call   3f2c <unlink>
    2ddd:	85 c0                	test   %eax,%eax
    2ddf:	75 19                	jne    2dfa <dirfile+0x142>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2de1:	c7 44 24 04 b7 56 00 	movl   $0x56b7,0x4(%esp)
    2de8:	00 
    2de9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2df0:	e8 64 12 00 00       	call   4059 <printf>
    exit();
    2df5:	e8 e2 10 00 00       	call   3edc <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2dfa:	c7 44 24 04 71 56 00 	movl   $0x5671,0x4(%esp)
    2e01:	00 
    2e02:	c7 04 24 d5 56 00 00 	movl   $0x56d5,(%esp)
    2e09:	e8 2e 11 00 00       	call   3f3c <link>
    2e0e:	85 c0                	test   %eax,%eax
    2e10:	75 19                	jne    2e2b <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2e12:	c7 44 24 04 dc 56 00 	movl   $0x56dc,0x4(%esp)
    2e19:	00 
    2e1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e21:	e8 33 12 00 00       	call   4059 <printf>
    exit();
    2e26:	e8 b1 10 00 00       	call   3edc <exit>
  }
  if(unlink("dirfile") != 0){
    2e2b:	c7 04 24 38 56 00 00 	movl   $0x5638,(%esp)
    2e32:	e8 f5 10 00 00       	call   3f2c <unlink>
    2e37:	85 c0                	test   %eax,%eax
    2e39:	74 19                	je     2e54 <dirfile+0x19c>
    printf(1, "unlink dirfile failed!\n");
    2e3b:	c7 44 24 04 fb 56 00 	movl   $0x56fb,0x4(%esp)
    2e42:	00 
    2e43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e4a:	e8 0a 12 00 00       	call   4059 <printf>
    exit();
    2e4f:	e8 88 10 00 00       	call   3edc <exit>
  }

  fd = open(".", O_RDWR);
    2e54:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    2e5b:	00 
    2e5c:	c7 04 24 b7 4c 00 00 	movl   $0x4cb7,(%esp)
    2e63:	e8 b4 10 00 00       	call   3f1c <open>
    2e68:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2e6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e6f:	78 19                	js     2e8a <dirfile+0x1d2>
    printf(1, "open . for writing succeeded!\n");
    2e71:	c7 44 24 04 14 57 00 	movl   $0x5714,0x4(%esp)
    2e78:	00 
    2e79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e80:	e8 d4 11 00 00       	call   4059 <printf>
    exit();
    2e85:	e8 52 10 00 00       	call   3edc <exit>
  }
  fd = open(".", 0);
    2e8a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2e91:	00 
    2e92:	c7 04 24 b7 4c 00 00 	movl   $0x4cb7,(%esp)
    2e99:	e8 7e 10 00 00       	call   3f1c <open>
    2e9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2ea1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2ea8:	00 
    2ea9:	c7 44 24 04 03 49 00 	movl   $0x4903,0x4(%esp)
    2eb0:	00 
    2eb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2eb4:	89 04 24             	mov    %eax,(%esp)
    2eb7:	e8 40 10 00 00       	call   3efc <write>
    2ebc:	85 c0                	test   %eax,%eax
    2ebe:	7e 19                	jle    2ed9 <dirfile+0x221>
    printf(1, "write . succeeded!\n");
    2ec0:	c7 44 24 04 33 57 00 	movl   $0x5733,0x4(%esp)
    2ec7:	00 
    2ec8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ecf:	e8 85 11 00 00       	call   4059 <printf>
    exit();
    2ed4:	e8 03 10 00 00       	call   3edc <exit>
  }
  close(fd);
    2ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2edc:	89 04 24             	mov    %eax,(%esp)
    2edf:	e8 20 10 00 00       	call   3f04 <close>

  printf(1, "dir vs file OK\n");
    2ee4:	c7 44 24 04 47 57 00 	movl   $0x5747,0x4(%esp)
    2eeb:	00 
    2eec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ef3:	e8 61 11 00 00       	call   4059 <printf>
}
    2ef8:	c9                   	leave  
    2ef9:	c3                   	ret    

00002efa <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2efa:	55                   	push   %ebp
    2efb:	89 e5                	mov    %esp,%ebp
    2efd:	83 ec 28             	sub    $0x28,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2f00:	c7 44 24 04 57 57 00 	movl   $0x5757,0x4(%esp)
    2f07:	00 
    2f08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f0f:	e8 45 11 00 00       	call   4059 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2f14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2f1b:	e9 d2 00 00 00       	jmp    2ff2 <iref+0xf8>
    if(mkdir("irefd") != 0){
    2f20:	c7 04 24 68 57 00 00 	movl   $0x5768,(%esp)
    2f27:	e8 18 10 00 00       	call   3f44 <mkdir>
    2f2c:	85 c0                	test   %eax,%eax
    2f2e:	74 19                	je     2f49 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2f30:	c7 44 24 04 6e 57 00 	movl   $0x576e,0x4(%esp)
    2f37:	00 
    2f38:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f3f:	e8 15 11 00 00       	call   4059 <printf>
      exit();
    2f44:	e8 93 0f 00 00       	call   3edc <exit>
    }
    if(chdir("irefd") != 0){
    2f49:	c7 04 24 68 57 00 00 	movl   $0x5768,(%esp)
    2f50:	e8 f7 0f 00 00       	call   3f4c <chdir>
    2f55:	85 c0                	test   %eax,%eax
    2f57:	74 19                	je     2f72 <iref+0x78>
      printf(1, "chdir irefd failed\n");
    2f59:	c7 44 24 04 82 57 00 	movl   $0x5782,0x4(%esp)
    2f60:	00 
    2f61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f68:	e8 ec 10 00 00       	call   4059 <printf>
      exit();
    2f6d:	e8 6a 0f 00 00       	call   3edc <exit>
    }

    mkdir("");
    2f72:	c7 04 24 96 57 00 00 	movl   $0x5796,(%esp)
    2f79:	e8 c6 0f 00 00       	call   3f44 <mkdir>
    link("README", "");
    2f7e:	c7 44 24 04 96 57 00 	movl   $0x5796,0x4(%esp)
    2f85:	00 
    2f86:	c7 04 24 d5 56 00 00 	movl   $0x56d5,(%esp)
    2f8d:	e8 aa 0f 00 00       	call   3f3c <link>
    fd = open("", O_CREATE);
    2f92:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2f99:	00 
    2f9a:	c7 04 24 96 57 00 00 	movl   $0x5796,(%esp)
    2fa1:	e8 76 0f 00 00       	call   3f1c <open>
    2fa6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2fa9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fad:	78 0b                	js     2fba <iref+0xc0>
      close(fd);
    2faf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2fb2:	89 04 24             	mov    %eax,(%esp)
    2fb5:	e8 4a 0f 00 00       	call   3f04 <close>
    fd = open("xx", O_CREATE);
    2fba:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2fc1:	00 
    2fc2:	c7 04 24 97 57 00 00 	movl   $0x5797,(%esp)
    2fc9:	e8 4e 0f 00 00       	call   3f1c <open>
    2fce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2fd1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fd5:	78 0b                	js     2fe2 <iref+0xe8>
      close(fd);
    2fd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2fda:	89 04 24             	mov    %eax,(%esp)
    2fdd:	e8 22 0f 00 00       	call   3f04 <close>
    unlink("xx");
    2fe2:	c7 04 24 97 57 00 00 	movl   $0x5797,(%esp)
    2fe9:	e8 3e 0f 00 00       	call   3f2c <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2fee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2ff2:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2ff6:	0f 8e 24 ff ff ff    	jle    2f20 <iref+0x26>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2ffc:	c7 04 24 9e 44 00 00 	movl   $0x449e,(%esp)
    3003:	e8 44 0f 00 00       	call   3f4c <chdir>
  printf(1, "empty file name OK\n");
    3008:	c7 44 24 04 9a 57 00 	movl   $0x579a,0x4(%esp)
    300f:	00 
    3010:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3017:	e8 3d 10 00 00       	call   4059 <printf>
}
    301c:	c9                   	leave  
    301d:	c3                   	ret    

0000301e <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    301e:	55                   	push   %ebp
    301f:	89 e5                	mov    %esp,%ebp
    3021:	83 ec 28             	sub    $0x28,%esp
  int n, pid;

  printf(1, "fork test\n");
    3024:	c7 44 24 04 ae 57 00 	movl   $0x57ae,0x4(%esp)
    302b:	00 
    302c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3033:	e8 21 10 00 00       	call   4059 <printf>

  for(n=0; n<1000; n++){
    3038:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    303f:	eb 1d                	jmp    305e <forktest+0x40>
    pid = fork();
    3041:	e8 8e 0e 00 00       	call   3ed4 <fork>
    3046:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    3049:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    304d:	78 1a                	js     3069 <forktest+0x4b>
      break;
    if(pid == 0)
    304f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3053:	75 05                	jne    305a <forktest+0x3c>
      exit();
    3055:	e8 82 0e 00 00       	call   3edc <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    305a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    305e:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    3065:	7e da                	jle    3041 <forktest+0x23>
    3067:	eb 01                	jmp    306a <forktest+0x4c>
    pid = fork();
    if(pid < 0)
      break;
    3069:	90                   	nop
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    306a:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    3071:	75 3f                	jne    30b2 <forktest+0x94>
    printf(1, "fork claimed to work 1000 times!\n");
    3073:	c7 44 24 04 bc 57 00 	movl   $0x57bc,0x4(%esp)
    307a:	00 
    307b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3082:	e8 d2 0f 00 00       	call   4059 <printf>
    exit();
    3087:	e8 50 0e 00 00       	call   3edc <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    308c:	e8 53 0e 00 00       	call   3ee4 <wait>
    3091:	85 c0                	test   %eax,%eax
    3093:	79 19                	jns    30ae <forktest+0x90>
      printf(1, "wait stopped early\n");
    3095:	c7 44 24 04 de 57 00 	movl   $0x57de,0x4(%esp)
    309c:	00 
    309d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30a4:	e8 b0 0f 00 00       	call   4059 <printf>
      exit();
    30a9:	e8 2e 0e 00 00       	call   3edc <exit>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    30ae:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    30b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30b6:	7f d4                	jg     308c <forktest+0x6e>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
    30b8:	e8 27 0e 00 00       	call   3ee4 <wait>
    30bd:	83 f8 ff             	cmp    $0xffffffff,%eax
    30c0:	74 19                	je     30db <forktest+0xbd>
    printf(1, "wait got too many\n");
    30c2:	c7 44 24 04 f2 57 00 	movl   $0x57f2,0x4(%esp)
    30c9:	00 
    30ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30d1:	e8 83 0f 00 00       	call   4059 <printf>
    exit();
    30d6:	e8 01 0e 00 00       	call   3edc <exit>
  }
  
  printf(1, "fork test OK\n");
    30db:	c7 44 24 04 05 58 00 	movl   $0x5805,0x4(%esp)
    30e2:	00 
    30e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30ea:	e8 6a 0f 00 00       	call   4059 <printf>
}
    30ef:	c9                   	leave  
    30f0:	c3                   	ret    

000030f1 <sbrktest>:

void
sbrktest(void)
{
    30f1:	55                   	push   %ebp
    30f2:	89 e5                	mov    %esp,%ebp
    30f4:	53                   	push   %ebx
    30f5:	81 ec 84 00 00 00    	sub    $0x84,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    30fb:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3100:	c7 44 24 04 13 58 00 	movl   $0x5813,0x4(%esp)
    3107:	00 
    3108:	89 04 24             	mov    %eax,(%esp)
    310b:	e8 49 0f 00 00       	call   4059 <printf>
  oldbrk = sbrk(0);
    3110:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3117:	e8 48 0e 00 00       	call   3f64 <sbrk>
    311c:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    311f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3126:	e8 39 0e 00 00       	call   3f64 <sbrk>
    312b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    312e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3135:	eb 59                	jmp    3190 <sbrktest+0x9f>
    b = sbrk(1);
    3137:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    313e:	e8 21 0e 00 00       	call   3f64 <sbrk>
    3143:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    3146:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3149:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    314c:	74 2f                	je     317d <sbrktest+0x8c>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    314e:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3153:	8b 55 e8             	mov    -0x18(%ebp),%edx
    3156:	89 54 24 10          	mov    %edx,0x10(%esp)
    315a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    315d:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3161:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3164:	89 54 24 08          	mov    %edx,0x8(%esp)
    3168:	c7 44 24 04 1e 58 00 	movl   $0x581e,0x4(%esp)
    316f:	00 
    3170:	89 04 24             	mov    %eax,(%esp)
    3173:	e8 e1 0e 00 00       	call   4059 <printf>
      exit();
    3178:	e8 5f 0d 00 00       	call   3edc <exit>
    }
    *b = 1;
    317d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3180:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    3183:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3186:	83 c0 01             	add    $0x1,%eax
    3189:	89 45 f4             	mov    %eax,-0xc(%ebp)
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){ 
    318c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3190:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    3197:	7e 9e                	jle    3137 <sbrktest+0x46>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    3199:	e8 36 0d 00 00       	call   3ed4 <fork>
    319e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    31a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    31a5:	79 1a                	jns    31c1 <sbrktest+0xd0>
    printf(stdout, "sbrk test fork failed\n");
    31a7:	a1 e8 62 00 00       	mov    0x62e8,%eax
    31ac:	c7 44 24 04 39 58 00 	movl   $0x5839,0x4(%esp)
    31b3:	00 
    31b4:	89 04 24             	mov    %eax,(%esp)
    31b7:	e8 9d 0e 00 00       	call   4059 <printf>
    exit();
    31bc:	e8 1b 0d 00 00       	call   3edc <exit>
  }
  c = sbrk(1);
    31c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31c8:	e8 97 0d 00 00       	call   3f64 <sbrk>
    31cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    31d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31d7:	e8 88 0d 00 00       	call   3f64 <sbrk>
    31dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    31df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    31e2:	83 c0 01             	add    $0x1,%eax
    31e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    31e8:	74 1a                	je     3204 <sbrktest+0x113>
    printf(stdout, "sbrk test failed post-fork\n");
    31ea:	a1 e8 62 00 00       	mov    0x62e8,%eax
    31ef:	c7 44 24 04 50 58 00 	movl   $0x5850,0x4(%esp)
    31f6:	00 
    31f7:	89 04 24             	mov    %eax,(%esp)
    31fa:	e8 5a 0e 00 00       	call   4059 <printf>
    exit();
    31ff:	e8 d8 0c 00 00       	call   3edc <exit>
  }
  if(pid == 0)
    3204:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3208:	75 05                	jne    320f <sbrktest+0x11e>
    exit();
    320a:	e8 cd 0c 00 00       	call   3edc <exit>
  wait();
    320f:	e8 d0 0c 00 00       	call   3ee4 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3214:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    321b:	e8 44 0d 00 00       	call   3f64 <sbrk>
    3220:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    3223:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3226:	ba 00 00 40 06       	mov    $0x6400000,%edx
    322b:	89 d1                	mov    %edx,%ecx
    322d:	29 c1                	sub    %eax,%ecx
    322f:	89 c8                	mov    %ecx,%eax
    3231:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    3234:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3237:	89 04 24             	mov    %eax,(%esp)
    323a:	e8 25 0d 00 00       	call   3f64 <sbrk>
    323f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    3242:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3245:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3248:	74 1a                	je     3264 <sbrktest+0x173>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    324a:	a1 e8 62 00 00       	mov    0x62e8,%eax
    324f:	c7 44 24 04 6c 58 00 	movl   $0x586c,0x4(%esp)
    3256:	00 
    3257:	89 04 24             	mov    %eax,(%esp)
    325a:	e8 fa 0d 00 00       	call   4059 <printf>
    exit();
    325f:	e8 78 0c 00 00       	call   3edc <exit>
  }
  lastaddr = (char*) (BIG-1);
    3264:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    326b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    326e:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    3271:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3278:	e8 e7 0c 00 00       	call   3f64 <sbrk>
    327d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    3280:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    3287:	e8 d8 0c 00 00       	call   3f64 <sbrk>
    328c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    328f:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3293:	75 1a                	jne    32af <sbrktest+0x1be>
    printf(stdout, "sbrk could not deallocate\n");
    3295:	a1 e8 62 00 00       	mov    0x62e8,%eax
    329a:	c7 44 24 04 aa 58 00 	movl   $0x58aa,0x4(%esp)
    32a1:	00 
    32a2:	89 04 24             	mov    %eax,(%esp)
    32a5:	e8 af 0d 00 00       	call   4059 <printf>
    exit();
    32aa:	e8 2d 0c 00 00       	call   3edc <exit>
  }
  c = sbrk(0);
    32af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32b6:	e8 a9 0c 00 00       	call   3f64 <sbrk>
    32bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    32be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    32c1:	2d 00 10 00 00       	sub    $0x1000,%eax
    32c6:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    32c9:	74 28                	je     32f3 <sbrktest+0x202>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    32cb:	a1 e8 62 00 00       	mov    0x62e8,%eax
    32d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    32d3:	89 54 24 0c          	mov    %edx,0xc(%esp)
    32d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    32da:	89 54 24 08          	mov    %edx,0x8(%esp)
    32de:	c7 44 24 04 c8 58 00 	movl   $0x58c8,0x4(%esp)
    32e5:	00 
    32e6:	89 04 24             	mov    %eax,(%esp)
    32e9:	e8 6b 0d 00 00       	call   4059 <printf>
    exit();
    32ee:	e8 e9 0b 00 00       	call   3edc <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    32f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32fa:	e8 65 0c 00 00       	call   3f64 <sbrk>
    32ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    3302:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    3309:	e8 56 0c 00 00       	call   3f64 <sbrk>
    330e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    3311:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3314:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3317:	75 19                	jne    3332 <sbrktest+0x241>
    3319:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3320:	e8 3f 0c 00 00       	call   3f64 <sbrk>
    3325:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3328:	81 c2 00 10 00 00    	add    $0x1000,%edx
    332e:	39 d0                	cmp    %edx,%eax
    3330:	74 28                	je     335a <sbrktest+0x269>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3332:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3337:	8b 55 e0             	mov    -0x20(%ebp),%edx
    333a:	89 54 24 0c          	mov    %edx,0xc(%esp)
    333e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3341:	89 54 24 08          	mov    %edx,0x8(%esp)
    3345:	c7 44 24 04 00 59 00 	movl   $0x5900,0x4(%esp)
    334c:	00 
    334d:	89 04 24             	mov    %eax,(%esp)
    3350:	e8 04 0d 00 00       	call   4059 <printf>
    exit();
    3355:	e8 82 0b 00 00       	call   3edc <exit>
  }
  if(*lastaddr == 99){
    335a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    335d:	0f b6 00             	movzbl (%eax),%eax
    3360:	3c 63                	cmp    $0x63,%al
    3362:	75 1a                	jne    337e <sbrktest+0x28d>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3364:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3369:	c7 44 24 04 28 59 00 	movl   $0x5928,0x4(%esp)
    3370:	00 
    3371:	89 04 24             	mov    %eax,(%esp)
    3374:	e8 e0 0c 00 00       	call   4059 <printf>
    exit();
    3379:	e8 5e 0b 00 00       	call   3edc <exit>
  }

  a = sbrk(0);
    337e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3385:	e8 da 0b 00 00       	call   3f64 <sbrk>
    338a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    338d:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3390:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3397:	e8 c8 0b 00 00       	call   3f64 <sbrk>
    339c:	89 da                	mov    %ebx,%edx
    339e:	29 c2                	sub    %eax,%edx
    33a0:	89 d0                	mov    %edx,%eax
    33a2:	89 04 24             	mov    %eax,(%esp)
    33a5:	e8 ba 0b 00 00       	call   3f64 <sbrk>
    33aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    33ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    33b0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    33b3:	74 28                	je     33dd <sbrktest+0x2ec>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    33b5:	a1 e8 62 00 00       	mov    0x62e8,%eax
    33ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
    33bd:	89 54 24 0c          	mov    %edx,0xc(%esp)
    33c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    33c4:	89 54 24 08          	mov    %edx,0x8(%esp)
    33c8:	c7 44 24 04 58 59 00 	movl   $0x5958,0x4(%esp)
    33cf:	00 
    33d0:	89 04 24             	mov    %eax,(%esp)
    33d3:	e8 81 0c 00 00       	call   4059 <printf>
    exit();
    33d8:	e8 ff 0a 00 00       	call   3edc <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    33dd:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    33e4:	eb 7b                	jmp    3461 <sbrktest+0x370>
    ppid = getpid();
    33e6:	e8 71 0b 00 00       	call   3f5c <getpid>
    33eb:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork();
    33ee:	e8 e1 0a 00 00       	call   3ed4 <fork>
    33f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    33f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    33fa:	79 1a                	jns    3416 <sbrktest+0x325>
      printf(stdout, "fork failed\n");
    33fc:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3401:	c7 44 24 04 cd 44 00 	movl   $0x44cd,0x4(%esp)
    3408:	00 
    3409:	89 04 24             	mov    %eax,(%esp)
    340c:	e8 48 0c 00 00       	call   4059 <printf>
      exit();
    3411:	e8 c6 0a 00 00       	call   3edc <exit>
    }
    if(pid == 0){
    3416:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    341a:	75 39                	jne    3455 <sbrktest+0x364>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    341c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    341f:	0f b6 00             	movzbl (%eax),%eax
    3422:	0f be d0             	movsbl %al,%edx
    3425:	a1 e8 62 00 00       	mov    0x62e8,%eax
    342a:	89 54 24 0c          	mov    %edx,0xc(%esp)
    342e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3431:	89 54 24 08          	mov    %edx,0x8(%esp)
    3435:	c7 44 24 04 79 59 00 	movl   $0x5979,0x4(%esp)
    343c:	00 
    343d:	89 04 24             	mov    %eax,(%esp)
    3440:	e8 14 0c 00 00       	call   4059 <printf>
      kill(ppid);
    3445:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3448:	89 04 24             	mov    %eax,(%esp)
    344b:	e8 bc 0a 00 00       	call   3f0c <kill>
      exit();
    3450:	e8 87 0a 00 00       	call   3edc <exit>
    }
    wait();
    3455:	e8 8a 0a 00 00       	call   3ee4 <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    345a:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3461:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    3468:	0f 86 78 ff ff ff    	jbe    33e6 <sbrktest+0x2f5>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    346e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3471:	89 04 24             	mov    %eax,(%esp)
    3474:	e8 73 0a 00 00       	call   3eec <pipe>
    3479:	85 c0                	test   %eax,%eax
    347b:	74 19                	je     3496 <sbrktest+0x3a5>
    printf(1, "pipe() failed\n");
    347d:	c7 44 24 04 9e 48 00 	movl   $0x489e,0x4(%esp)
    3484:	00 
    3485:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    348c:	e8 c8 0b 00 00       	call   4059 <printf>
    exit();
    3491:	e8 46 0a 00 00       	call   3edc <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3496:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    349d:	e9 89 00 00 00       	jmp    352b <sbrktest+0x43a>
    if((pids[i] = fork()) == 0){
    34a2:	e8 2d 0a 00 00       	call   3ed4 <fork>
    34a7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    34aa:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    34ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34b1:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34b5:	85 c0                	test   %eax,%eax
    34b7:	75 48                	jne    3501 <sbrktest+0x410>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    34b9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34c0:	e8 9f 0a 00 00       	call   3f64 <sbrk>
    34c5:	ba 00 00 40 06       	mov    $0x6400000,%edx
    34ca:	89 d1                	mov    %edx,%ecx
    34cc:	29 c1                	sub    %eax,%ecx
    34ce:	89 c8                	mov    %ecx,%eax
    34d0:	89 04 24             	mov    %eax,(%esp)
    34d3:	e8 8c 0a 00 00       	call   3f64 <sbrk>
      write(fds[1], "x", 1);
    34d8:	8b 45 cc             	mov    -0x34(%ebp),%eax
    34db:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    34e2:	00 
    34e3:	c7 44 24 04 03 49 00 	movl   $0x4903,0x4(%esp)
    34ea:	00 
    34eb:	89 04 24             	mov    %eax,(%esp)
    34ee:	e8 09 0a 00 00       	call   3efc <write>
      // sit around until killed
      for(;;) sleep(1000);
    34f3:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    34fa:	e8 6d 0a 00 00       	call   3f6c <sleep>
    34ff:	eb f2                	jmp    34f3 <sbrktest+0x402>
    }
    if(pids[i] != -1)
    3501:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3504:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3508:	83 f8 ff             	cmp    $0xffffffff,%eax
    350b:	74 1a                	je     3527 <sbrktest+0x436>
      read(fds[0], &scratch, 1);
    350d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3510:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3517:	00 
    3518:	8d 55 9f             	lea    -0x61(%ebp),%edx
    351b:	89 54 24 04          	mov    %edx,0x4(%esp)
    351f:	89 04 24             	mov    %eax,(%esp)
    3522:	e8 cd 09 00 00       	call   3ef4 <read>
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3527:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    352b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    352e:	83 f8 09             	cmp    $0x9,%eax
    3531:	0f 86 6b ff ff ff    	jbe    34a2 <sbrktest+0x3b1>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3537:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    353e:	e8 21 0a 00 00       	call   3f64 <sbrk>
    3543:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3546:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    354d:	eb 27                	jmp    3576 <sbrktest+0x485>
    if(pids[i] == -1)
    354f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3552:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3556:	83 f8 ff             	cmp    $0xffffffff,%eax
    3559:	74 16                	je     3571 <sbrktest+0x480>
      continue;
    kill(pids[i]);
    355b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    355e:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3562:	89 04 24             	mov    %eax,(%esp)
    3565:	e8 a2 09 00 00       	call   3f0c <kill>
    wait();
    356a:	e8 75 09 00 00       	call   3ee4 <wait>
    356f:	eb 01                	jmp    3572 <sbrktest+0x481>
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
      continue;
    3571:	90                   	nop
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3572:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3576:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3579:	83 f8 09             	cmp    $0x9,%eax
    357c:	76 d1                	jbe    354f <sbrktest+0x45e>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    357e:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3582:	75 1a                	jne    359e <sbrktest+0x4ad>
    printf(stdout, "failed sbrk leaked memory\n");
    3584:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3589:	c7 44 24 04 92 59 00 	movl   $0x5992,0x4(%esp)
    3590:	00 
    3591:	89 04 24             	mov    %eax,(%esp)
    3594:	e8 c0 0a 00 00       	call   4059 <printf>
    exit();
    3599:	e8 3e 09 00 00       	call   3edc <exit>
  }

  if(sbrk(0) > oldbrk)
    359e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35a5:	e8 ba 09 00 00       	call   3f64 <sbrk>
    35aa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    35ad:	76 1d                	jbe    35cc <sbrktest+0x4db>
    sbrk(-(sbrk(0) - oldbrk));
    35af:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    35b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35b9:	e8 a6 09 00 00       	call   3f64 <sbrk>
    35be:	89 da                	mov    %ebx,%edx
    35c0:	29 c2                	sub    %eax,%edx
    35c2:	89 d0                	mov    %edx,%eax
    35c4:	89 04 24             	mov    %eax,(%esp)
    35c7:	e8 98 09 00 00       	call   3f64 <sbrk>

  printf(stdout, "sbrk test OK\n");
    35cc:	a1 e8 62 00 00       	mov    0x62e8,%eax
    35d1:	c7 44 24 04 ad 59 00 	movl   $0x59ad,0x4(%esp)
    35d8:	00 
    35d9:	89 04 24             	mov    %eax,(%esp)
    35dc:	e8 78 0a 00 00       	call   4059 <printf>
}
    35e1:	81 c4 84 00 00 00    	add    $0x84,%esp
    35e7:	5b                   	pop    %ebx
    35e8:	5d                   	pop    %ebp
    35e9:	c3                   	ret    

000035ea <validateint>:

void
validateint(int *p)
{
    35ea:	55                   	push   %ebp
    35eb:	89 e5                	mov    %esp,%ebp
    35ed:	56                   	push   %esi
    35ee:	53                   	push   %ebx
    35ef:	83 ec 14             	sub    $0x14,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    35f2:	c7 45 e4 0d 00 00 00 	movl   $0xd,-0x1c(%ebp)
    35f9:	8b 55 08             	mov    0x8(%ebp),%edx
    35fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    35ff:	89 d1                	mov    %edx,%ecx
    3601:	89 e3                	mov    %esp,%ebx
    3603:	89 cc                	mov    %ecx,%esp
    3605:	cd 40                	int    $0x40
    3607:	89 dc                	mov    %ebx,%esp
    3609:	89 c6                	mov    %eax,%esi
    360b:	89 75 f4             	mov    %esi,-0xc(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    360e:	83 c4 14             	add    $0x14,%esp
    3611:	5b                   	pop    %ebx
    3612:	5e                   	pop    %esi
    3613:	5d                   	pop    %ebp
    3614:	c3                   	ret    

00003615 <validatetest>:

void
validatetest(void)
{
    3615:	55                   	push   %ebp
    3616:	89 e5                	mov    %esp,%ebp
    3618:	83 ec 28             	sub    $0x28,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    361b:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3620:	c7 44 24 04 bb 59 00 	movl   $0x59bb,0x4(%esp)
    3627:	00 
    3628:	89 04 24             	mov    %eax,(%esp)
    362b:	e8 29 0a 00 00       	call   4059 <printf>
  hi = 1100*1024;
    3630:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    3637:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    363e:	eb 7f                	jmp    36bf <validatetest+0xaa>
    if((pid = fork()) == 0){
    3640:	e8 8f 08 00 00       	call   3ed4 <fork>
    3645:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3648:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    364c:	75 10                	jne    365e <validatetest+0x49>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    364e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3651:	89 04 24             	mov    %eax,(%esp)
    3654:	e8 91 ff ff ff       	call   35ea <validateint>
      exit();
    3659:	e8 7e 08 00 00       	call   3edc <exit>
    }
    sleep(0);
    365e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3665:	e8 02 09 00 00       	call   3f6c <sleep>
    sleep(0);
    366a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3671:	e8 f6 08 00 00       	call   3f6c <sleep>
    kill(pid);
    3676:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3679:	89 04 24             	mov    %eax,(%esp)
    367c:	e8 8b 08 00 00       	call   3f0c <kill>
    wait();
    3681:	e8 5e 08 00 00       	call   3ee4 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3686:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3689:	89 44 24 04          	mov    %eax,0x4(%esp)
    368d:	c7 04 24 ca 59 00 00 	movl   $0x59ca,(%esp)
    3694:	e8 a3 08 00 00       	call   3f3c <link>
    3699:	83 f8 ff             	cmp    $0xffffffff,%eax
    369c:	74 1a                	je     36b8 <validatetest+0xa3>
      printf(stdout, "link should not succeed\n");
    369e:	a1 e8 62 00 00       	mov    0x62e8,%eax
    36a3:	c7 44 24 04 d5 59 00 	movl   $0x59d5,0x4(%esp)
    36aa:	00 
    36ab:	89 04 24             	mov    %eax,(%esp)
    36ae:	e8 a6 09 00 00       	call   4059 <printf>
      exit();
    36b3:	e8 24 08 00 00       	call   3edc <exit>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    36b8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    36bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    36c2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    36c5:	0f 83 75 ff ff ff    	jae    3640 <validatetest+0x2b>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    36cb:	a1 e8 62 00 00       	mov    0x62e8,%eax
    36d0:	c7 44 24 04 ee 59 00 	movl   $0x59ee,0x4(%esp)
    36d7:	00 
    36d8:	89 04 24             	mov    %eax,(%esp)
    36db:	e8 79 09 00 00       	call   4059 <printf>
}
    36e0:	c9                   	leave  
    36e1:	c3                   	ret    

000036e2 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    36e2:	55                   	push   %ebp
    36e3:	89 e5                	mov    %esp,%ebp
    36e5:	83 ec 28             	sub    $0x28,%esp
  int i;

  printf(stdout, "bss test\n");
    36e8:	a1 e8 62 00 00       	mov    0x62e8,%eax
    36ed:	c7 44 24 04 fb 59 00 	movl   $0x59fb,0x4(%esp)
    36f4:	00 
    36f5:	89 04 24             	mov    %eax,(%esp)
    36f8:	e8 5c 09 00 00       	call   4059 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    36fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3704:	eb 2d                	jmp    3733 <bsstest+0x51>
    if(uninit[i] != '\0'){
    3706:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3709:	05 c0 63 00 00       	add    $0x63c0,%eax
    370e:	0f b6 00             	movzbl (%eax),%eax
    3711:	84 c0                	test   %al,%al
    3713:	74 1a                	je     372f <bsstest+0x4d>
      printf(stdout, "bss test failed\n");
    3715:	a1 e8 62 00 00       	mov    0x62e8,%eax
    371a:	c7 44 24 04 05 5a 00 	movl   $0x5a05,0x4(%esp)
    3721:	00 
    3722:	89 04 24             	mov    %eax,(%esp)
    3725:	e8 2f 09 00 00       	call   4059 <printf>
      exit();
    372a:	e8 ad 07 00 00       	call   3edc <exit>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    372f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3736:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    373b:	76 c9                	jbe    3706 <bsstest+0x24>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    373d:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3742:	c7 44 24 04 16 5a 00 	movl   $0x5a16,0x4(%esp)
    3749:	00 
    374a:	89 04 24             	mov    %eax,(%esp)
    374d:	e8 07 09 00 00       	call   4059 <printf>
}
    3752:	c9                   	leave  
    3753:	c3                   	ret    

00003754 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3754:	55                   	push   %ebp
    3755:	89 e5                	mov    %esp,%ebp
    3757:	83 ec 28             	sub    $0x28,%esp
  int pid, fd;

  unlink("bigarg-ok");
    375a:	c7 04 24 23 5a 00 00 	movl   $0x5a23,(%esp)
    3761:	e8 c6 07 00 00       	call   3f2c <unlink>
  pid = fork();
    3766:	e8 69 07 00 00       	call   3ed4 <fork>
    376b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    376e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3772:	0f 85 90 00 00 00    	jne    3808 <bigargtest+0xb4>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3778:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    377f:	eb 12                	jmp    3793 <bigargtest+0x3f>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3784:	c7 04 85 20 63 00 00 	movl   $0x5a30,0x6320(,%eax,4)
    378b:	30 5a 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    378f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3793:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    3797:	7e e8                	jle    3781 <bigargtest+0x2d>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    3799:	c7 05 9c 63 00 00 00 	movl   $0x0,0x639c
    37a0:	00 00 00 
    printf(stdout, "bigarg test\n");
    37a3:	a1 e8 62 00 00       	mov    0x62e8,%eax
    37a8:	c7 44 24 04 0d 5b 00 	movl   $0x5b0d,0x4(%esp)
    37af:	00 
    37b0:	89 04 24             	mov    %eax,(%esp)
    37b3:	e8 a1 08 00 00       	call   4059 <printf>
    exec("echo", args);
    37b8:	c7 44 24 04 20 63 00 	movl   $0x6320,0x4(%esp)
    37bf:	00 
    37c0:	c7 04 24 2c 44 00 00 	movl   $0x442c,(%esp)
    37c7:	e8 48 07 00 00       	call   3f14 <exec>
    printf(stdout, "bigarg test ok\n");
    37cc:	a1 e8 62 00 00       	mov    0x62e8,%eax
    37d1:	c7 44 24 04 1a 5b 00 	movl   $0x5b1a,0x4(%esp)
    37d8:	00 
    37d9:	89 04 24             	mov    %eax,(%esp)
    37dc:	e8 78 08 00 00       	call   4059 <printf>
    fd = open("bigarg-ok", O_CREATE);
    37e1:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    37e8:	00 
    37e9:	c7 04 24 23 5a 00 00 	movl   $0x5a23,(%esp)
    37f0:	e8 27 07 00 00       	call   3f1c <open>
    37f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    37f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    37fb:	89 04 24             	mov    %eax,(%esp)
    37fe:	e8 01 07 00 00       	call   3f04 <close>
    exit();
    3803:	e8 d4 06 00 00       	call   3edc <exit>
  } else if(pid < 0){
    3808:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    380c:	79 1a                	jns    3828 <bigargtest+0xd4>
    printf(stdout, "bigargtest: fork failed\n");
    380e:	a1 e8 62 00 00       	mov    0x62e8,%eax
    3813:	c7 44 24 04 2a 5b 00 	movl   $0x5b2a,0x4(%esp)
    381a:	00 
    381b:	89 04 24             	mov    %eax,(%esp)
    381e:	e8 36 08 00 00       	call   4059 <printf>
    exit();
    3823:	e8 b4 06 00 00       	call   3edc <exit>
  }
  wait();
    3828:	e8 b7 06 00 00       	call   3ee4 <wait>
  fd = open("bigarg-ok", 0);
    382d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3834:	00 
    3835:	c7 04 24 23 5a 00 00 	movl   $0x5a23,(%esp)
    383c:	e8 db 06 00 00       	call   3f1c <open>
    3841:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3844:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3848:	79 1a                	jns    3864 <bigargtest+0x110>
    printf(stdout, "bigarg test failed!\n");
    384a:	a1 e8 62 00 00       	mov    0x62e8,%eax
    384f:	c7 44 24 04 43 5b 00 	movl   $0x5b43,0x4(%esp)
    3856:	00 
    3857:	89 04 24             	mov    %eax,(%esp)
    385a:	e8 fa 07 00 00       	call   4059 <printf>
    exit();
    385f:	e8 78 06 00 00       	call   3edc <exit>
  }
  close(fd);
    3864:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3867:	89 04 24             	mov    %eax,(%esp)
    386a:	e8 95 06 00 00       	call   3f04 <close>
  unlink("bigarg-ok");
    386f:	c7 04 24 23 5a 00 00 	movl   $0x5a23,(%esp)
    3876:	e8 b1 06 00 00       	call   3f2c <unlink>
}
    387b:	c9                   	leave  
    387c:	c3                   	ret    

0000387d <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    387d:	55                   	push   %ebp
    387e:	89 e5                	mov    %esp,%ebp
    3880:	53                   	push   %ebx
    3881:	83 ec 74             	sub    $0x74,%esp
  int nfiles;
  int fsblocks = 0;
    3884:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    388b:	c7 44 24 04 58 5b 00 	movl   $0x5b58,0x4(%esp)
    3892:	00 
    3893:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    389a:	e8 ba 07 00 00       	call   4059 <printf>

  for(nfiles = 0; ; nfiles++){
    389f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    38a6:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    38aa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    38ad:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    38b2:	89 c8                	mov    %ecx,%eax
    38b4:	f7 ea                	imul   %edx
    38b6:	c1 fa 06             	sar    $0x6,%edx
    38b9:	89 c8                	mov    %ecx,%eax
    38bb:	c1 f8 1f             	sar    $0x1f,%eax
    38be:	89 d1                	mov    %edx,%ecx
    38c0:	29 c1                	sub    %eax,%ecx
    38c2:	89 c8                	mov    %ecx,%eax
    38c4:	83 c0 30             	add    $0x30,%eax
    38c7:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    38ca:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    38cd:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    38d2:	89 d8                	mov    %ebx,%eax
    38d4:	f7 ea                	imul   %edx
    38d6:	c1 fa 06             	sar    $0x6,%edx
    38d9:	89 d8                	mov    %ebx,%eax
    38db:	c1 f8 1f             	sar    $0x1f,%eax
    38de:	89 d1                	mov    %edx,%ecx
    38e0:	29 c1                	sub    %eax,%ecx
    38e2:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    38e8:	89 d9                	mov    %ebx,%ecx
    38ea:	29 c1                	sub    %eax,%ecx
    38ec:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    38f1:	89 c8                	mov    %ecx,%eax
    38f3:	f7 ea                	imul   %edx
    38f5:	c1 fa 05             	sar    $0x5,%edx
    38f8:	89 c8                	mov    %ecx,%eax
    38fa:	c1 f8 1f             	sar    $0x1f,%eax
    38fd:	89 d1                	mov    %edx,%ecx
    38ff:	29 c1                	sub    %eax,%ecx
    3901:	89 c8                	mov    %ecx,%eax
    3903:	83 c0 30             	add    $0x30,%eax
    3906:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3909:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    390c:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3911:	89 d8                	mov    %ebx,%eax
    3913:	f7 ea                	imul   %edx
    3915:	c1 fa 05             	sar    $0x5,%edx
    3918:	89 d8                	mov    %ebx,%eax
    391a:	c1 f8 1f             	sar    $0x1f,%eax
    391d:	89 d1                	mov    %edx,%ecx
    391f:	29 c1                	sub    %eax,%ecx
    3921:	6b c1 64             	imul   $0x64,%ecx,%eax
    3924:	89 d9                	mov    %ebx,%ecx
    3926:	29 c1                	sub    %eax,%ecx
    3928:	ba 67 66 66 66       	mov    $0x66666667,%edx
    392d:	89 c8                	mov    %ecx,%eax
    392f:	f7 ea                	imul   %edx
    3931:	c1 fa 02             	sar    $0x2,%edx
    3934:	89 c8                	mov    %ecx,%eax
    3936:	c1 f8 1f             	sar    $0x1f,%eax
    3939:	89 d1                	mov    %edx,%ecx
    393b:	29 c1                	sub    %eax,%ecx
    393d:	89 c8                	mov    %ecx,%eax
    393f:	83 c0 30             	add    $0x30,%eax
    3942:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3945:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3948:	ba 67 66 66 66       	mov    $0x66666667,%edx
    394d:	89 c8                	mov    %ecx,%eax
    394f:	f7 ea                	imul   %edx
    3951:	c1 fa 02             	sar    $0x2,%edx
    3954:	89 c8                	mov    %ecx,%eax
    3956:	c1 f8 1f             	sar    $0x1f,%eax
    3959:	29 c2                	sub    %eax,%edx
    395b:	89 d0                	mov    %edx,%eax
    395d:	c1 e0 02             	shl    $0x2,%eax
    3960:	01 d0                	add    %edx,%eax
    3962:	01 c0                	add    %eax,%eax
    3964:	89 ca                	mov    %ecx,%edx
    3966:	29 c2                	sub    %eax,%edx
    3968:	89 d0                	mov    %edx,%eax
    396a:	83 c0 30             	add    $0x30,%eax
    396d:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3970:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    3974:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3977:	89 44 24 08          	mov    %eax,0x8(%esp)
    397b:	c7 44 24 04 65 5b 00 	movl   $0x5b65,0x4(%esp)
    3982:	00 
    3983:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    398a:	e8 ca 06 00 00       	call   4059 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    398f:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    3996:	00 
    3997:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    399a:	89 04 24             	mov    %eax,(%esp)
    399d:	e8 7a 05 00 00       	call   3f1c <open>
    39a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    39a5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    39a9:	79 20                	jns    39cb <fsfull+0x14e>
      printf(1, "open %s failed\n", name);
    39ab:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    39ae:	89 44 24 08          	mov    %eax,0x8(%esp)
    39b2:	c7 44 24 04 71 5b 00 	movl   $0x5b71,0x4(%esp)
    39b9:	00 
    39ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    39c1:	e8 93 06 00 00       	call   4059 <printf>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    39c6:	e9 51 01 00 00       	jmp    3b1c <fsfull+0x29f>
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    39cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    39d2:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    39d9:	00 
    39da:	c7 44 24 04 e0 8a 00 	movl   $0x8ae0,0x4(%esp)
    39e1:	00 
    39e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    39e5:	89 04 24             	mov    %eax,(%esp)
    39e8:	e8 0f 05 00 00       	call   3efc <write>
    39ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    39f0:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    39f7:	7e 0c                	jle    3a05 <fsfull+0x188>
        break;
      total += cc;
    39f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    39fc:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    39ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }
    3a03:	eb cd                	jmp    39d2 <fsfull+0x155>
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
    3a05:	90                   	nop
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3a06:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3a09:	89 44 24 08          	mov    %eax,0x8(%esp)
    3a0d:	c7 44 24 04 81 5b 00 	movl   $0x5b81,0x4(%esp)
    3a14:	00 
    3a15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3a1c:	e8 38 06 00 00       	call   4059 <printf>
    close(fd);
    3a21:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3a24:	89 04 24             	mov    %eax,(%esp)
    3a27:	e8 d8 04 00 00       	call   3f04 <close>
    if(total == 0)
    3a2c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3a30:	0f 84 e6 00 00 00    	je     3b1c <fsfull+0x29f>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3a36:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3a3a:	e9 67 fe ff ff       	jmp    38a6 <fsfull+0x29>

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    3a3f:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3a43:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3a46:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3a4b:	89 c8                	mov    %ecx,%eax
    3a4d:	f7 ea                	imul   %edx
    3a4f:	c1 fa 06             	sar    $0x6,%edx
    3a52:	89 c8                	mov    %ecx,%eax
    3a54:	c1 f8 1f             	sar    $0x1f,%eax
    3a57:	89 d1                	mov    %edx,%ecx
    3a59:	29 c1                	sub    %eax,%ecx
    3a5b:	89 c8                	mov    %ecx,%eax
    3a5d:	83 c0 30             	add    $0x30,%eax
    3a60:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3a63:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3a66:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3a6b:	89 d8                	mov    %ebx,%eax
    3a6d:	f7 ea                	imul   %edx
    3a6f:	c1 fa 06             	sar    $0x6,%edx
    3a72:	89 d8                	mov    %ebx,%eax
    3a74:	c1 f8 1f             	sar    $0x1f,%eax
    3a77:	89 d1                	mov    %edx,%ecx
    3a79:	29 c1                	sub    %eax,%ecx
    3a7b:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3a81:	89 d9                	mov    %ebx,%ecx
    3a83:	29 c1                	sub    %eax,%ecx
    3a85:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3a8a:	89 c8                	mov    %ecx,%eax
    3a8c:	f7 ea                	imul   %edx
    3a8e:	c1 fa 05             	sar    $0x5,%edx
    3a91:	89 c8                	mov    %ecx,%eax
    3a93:	c1 f8 1f             	sar    $0x1f,%eax
    3a96:	89 d1                	mov    %edx,%ecx
    3a98:	29 c1                	sub    %eax,%ecx
    3a9a:	89 c8                	mov    %ecx,%eax
    3a9c:	83 c0 30             	add    $0x30,%eax
    3a9f:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3aa2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3aa5:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3aaa:	89 d8                	mov    %ebx,%eax
    3aac:	f7 ea                	imul   %edx
    3aae:	c1 fa 05             	sar    $0x5,%edx
    3ab1:	89 d8                	mov    %ebx,%eax
    3ab3:	c1 f8 1f             	sar    $0x1f,%eax
    3ab6:	89 d1                	mov    %edx,%ecx
    3ab8:	29 c1                	sub    %eax,%ecx
    3aba:	6b c1 64             	imul   $0x64,%ecx,%eax
    3abd:	89 d9                	mov    %ebx,%ecx
    3abf:	29 c1                	sub    %eax,%ecx
    3ac1:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3ac6:	89 c8                	mov    %ecx,%eax
    3ac8:	f7 ea                	imul   %edx
    3aca:	c1 fa 02             	sar    $0x2,%edx
    3acd:	89 c8                	mov    %ecx,%eax
    3acf:	c1 f8 1f             	sar    $0x1f,%eax
    3ad2:	89 d1                	mov    %edx,%ecx
    3ad4:	29 c1                	sub    %eax,%ecx
    3ad6:	89 c8                	mov    %ecx,%eax
    3ad8:	83 c0 30             	add    $0x30,%eax
    3adb:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3ade:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3ae1:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3ae6:	89 c8                	mov    %ecx,%eax
    3ae8:	f7 ea                	imul   %edx
    3aea:	c1 fa 02             	sar    $0x2,%edx
    3aed:	89 c8                	mov    %ecx,%eax
    3aef:	c1 f8 1f             	sar    $0x1f,%eax
    3af2:	29 c2                	sub    %eax,%edx
    3af4:	89 d0                	mov    %edx,%eax
    3af6:	c1 e0 02             	shl    $0x2,%eax
    3af9:	01 d0                	add    %edx,%eax
    3afb:	01 c0                	add    %eax,%eax
    3afd:	89 ca                	mov    %ecx,%edx
    3aff:	29 c2                	sub    %eax,%edx
    3b01:	89 d0                	mov    %edx,%eax
    3b03:	83 c0 30             	add    $0x30,%eax
    3b06:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3b09:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3b0d:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3b10:	89 04 24             	mov    %eax,(%esp)
    3b13:	e8 14 04 00 00       	call   3f2c <unlink>
    nfiles--;
    3b18:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3b1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b20:	0f 89 19 ff ff ff    	jns    3a3f <fsfull+0x1c2>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3b26:	c7 44 24 04 91 5b 00 	movl   $0x5b91,0x4(%esp)
    3b2d:	00 
    3b2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b35:	e8 1f 05 00 00       	call   4059 <printf>
}
    3b3a:	83 c4 74             	add    $0x74,%esp
    3b3d:	5b                   	pop    %ebx
    3b3e:	5d                   	pop    %ebp
    3b3f:	c3                   	ret    

00003b40 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3b40:	55                   	push   %ebp
    3b41:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3b43:	a1 ec 62 00 00       	mov    0x62ec,%eax
    3b48:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    3b4e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3b53:	a3 ec 62 00 00       	mov    %eax,0x62ec
  return randstate;
    3b58:	a1 ec 62 00 00       	mov    0x62ec,%eax
}
    3b5d:	5d                   	pop    %ebp
    3b5e:	c3                   	ret    

00003b5f <main>:

int
main(int argc, char *argv[])
{
    3b5f:	55                   	push   %ebp
    3b60:	89 e5                	mov    %esp,%ebp
    3b62:	83 e4 f0             	and    $0xfffffff0,%esp
    3b65:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
    3b68:	c7 44 24 04 a7 5b 00 	movl   $0x5ba7,0x4(%esp)
    3b6f:	00 
    3b70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b77:	e8 dd 04 00 00       	call   4059 <printf>

  if(open("usertests.ran", 0) >= 0){
    3b7c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3b83:	00 
    3b84:	c7 04 24 bb 5b 00 00 	movl   $0x5bbb,(%esp)
    3b8b:	e8 8c 03 00 00       	call   3f1c <open>
    3b90:	85 c0                	test   %eax,%eax
    3b92:	78 19                	js     3bad <main+0x4e>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3b94:	c7 44 24 04 cc 5b 00 	movl   $0x5bcc,0x4(%esp)
    3b9b:	00 
    3b9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ba3:	e8 b1 04 00 00       	call   4059 <printf>
    exit();
    3ba8:	e8 2f 03 00 00       	call   3edc <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3bad:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3bb4:	00 
    3bb5:	c7 04 24 bb 5b 00 00 	movl   $0x5bbb,(%esp)
    3bbc:	e8 5b 03 00 00       	call   3f1c <open>
    3bc1:	89 04 24             	mov    %eax,(%esp)
    3bc4:	e8 3b 03 00 00       	call   3f04 <close>

  createdelete();
    3bc9:	e8 b3 d6 ff ff       	call   1281 <createdelete>
  linkunlink();
    3bce:	e8 fd e0 ff ff       	call   1cd0 <linkunlink>
  concreate();
    3bd3:	e8 3f dd ff ff       	call   1917 <concreate>
  fourfiles();
    3bd8:	e8 3c d4 ff ff       	call   1019 <fourfiles>
  sharedfd();
    3bdd:	e8 39 d2 ff ff       	call   e1b <sharedfd>

  bigargtest();
    3be2:	e8 6d fb ff ff       	call   3754 <bigargtest>
  bigwrite();
    3be7:	e8 d1 ea ff ff       	call   26bd <bigwrite>
  bigargtest();
    3bec:	e8 63 fb ff ff       	call   3754 <bigargtest>
  bsstest();
    3bf1:	e8 ec fa ff ff       	call   36e2 <bsstest>
  sbrktest();
    3bf6:	e8 f6 f4 ff ff       	call   30f1 <sbrktest>
  validatetest();
    3bfb:	e8 15 fa ff ff       	call   3615 <validatetest>

  opentest();
    3c00:	e8 c2 c6 ff ff       	call   2c7 <opentest>
  writetest();
    3c05:	e8 68 c7 ff ff       	call   372 <writetest>
  writetest1();
    3c0a:	e8 78 c9 ff ff       	call   587 <writetest1>
  createtest();
    3c0f:	e8 7c cb ff ff       	call   790 <createtest>

  openiputtest();
    3c14:	e8 ad c5 ff ff       	call   1c6 <openiputtest>
  exitiputtest();
    3c19:	e8 bc c4 ff ff       	call   da <exitiputtest>
  iputtest();
    3c1e:	e8 dd c3 ff ff       	call   0 <iputtest>

  mem();
    3c23:	e8 0e d1 ff ff       	call   d36 <mem>
  pipe1();
    3c28:	e8 44 cd ff ff       	call   971 <pipe1>
  preempt();
    3c2d:	e8 2d cf ff ff       	call   b5f <preempt>
  exitwait();
    3c32:	e8 81 d0 ff ff       	call   cb8 <exitwait>

  rmdot();
    3c37:	e8 04 ef ff ff       	call   2b40 <rmdot>
  fourteen();
    3c3c:	e8 a9 ed ff ff       	call   29ea <fourteen>
  bigfile();
    3c41:	e8 7f eb ff ff       	call   27c5 <bigfile>
  subdir();
    3c46:	e8 2c e3 ff ff       	call   1f77 <subdir>
  linktest();
    3c4b:	e8 7e da ff ff       	call   16ce <linktest>
  unlinkread();
    3c50:	e8 a4 d8 ff ff       	call   14f9 <unlinkread>
  dirfile();
    3c55:	e8 5e f0 ff ff       	call   2cb8 <dirfile>
  iref();
    3c5a:	e8 9b f2 ff ff       	call   2efa <iref>
  forktest();
    3c5f:	e8 ba f3 ff ff       	call   301e <forktest>
  bigdir(); // slow
    3c64:	e8 95 e1 ff ff       	call   1dfe <bigdir>
  exectest();
    3c69:	e8 b4 cc ff ff       	call   922 <exectest>

  exit();
    3c6e:	e8 69 02 00 00       	call   3edc <exit>
    3c73:	90                   	nop

00003c74 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3c74:	55                   	push   %ebp
    3c75:	89 e5                	mov    %esp,%ebp
    3c77:	57                   	push   %edi
    3c78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3c79:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3c7c:	8b 55 10             	mov    0x10(%ebp),%edx
    3c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c82:	89 cb                	mov    %ecx,%ebx
    3c84:	89 df                	mov    %ebx,%edi
    3c86:	89 d1                	mov    %edx,%ecx
    3c88:	fc                   	cld    
    3c89:	f3 aa                	rep stos %al,%es:(%edi)
    3c8b:	89 ca                	mov    %ecx,%edx
    3c8d:	89 fb                	mov    %edi,%ebx
    3c8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3c92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3c95:	5b                   	pop    %ebx
    3c96:	5f                   	pop    %edi
    3c97:	5d                   	pop    %ebp
    3c98:	c3                   	ret    

00003c99 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3c99:	55                   	push   %ebp
    3c9a:	89 e5                	mov    %esp,%ebp
    3c9c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3c9f:	8b 45 08             	mov    0x8(%ebp),%eax
    3ca2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3ca5:	90                   	nop
    3ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ca9:	0f b6 10             	movzbl (%eax),%edx
    3cac:	8b 45 08             	mov    0x8(%ebp),%eax
    3caf:	88 10                	mov    %dl,(%eax)
    3cb1:	8b 45 08             	mov    0x8(%ebp),%eax
    3cb4:	0f b6 00             	movzbl (%eax),%eax
    3cb7:	84 c0                	test   %al,%al
    3cb9:	0f 95 c0             	setne  %al
    3cbc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3cc0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    3cc4:	84 c0                	test   %al,%al
    3cc6:	75 de                	jne    3ca6 <strcpy+0xd>
    ;
  return os;
    3cc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3ccb:	c9                   	leave  
    3ccc:	c3                   	ret    

00003ccd <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3ccd:	55                   	push   %ebp
    3cce:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3cd0:	eb 08                	jmp    3cda <strcmp+0xd>
    p++, q++;
    3cd2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3cd6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3cda:	8b 45 08             	mov    0x8(%ebp),%eax
    3cdd:	0f b6 00             	movzbl (%eax),%eax
    3ce0:	84 c0                	test   %al,%al
    3ce2:	74 10                	je     3cf4 <strcmp+0x27>
    3ce4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ce7:	0f b6 10             	movzbl (%eax),%edx
    3cea:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ced:	0f b6 00             	movzbl (%eax),%eax
    3cf0:	38 c2                	cmp    %al,%dl
    3cf2:	74 de                	je     3cd2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3cf4:	8b 45 08             	mov    0x8(%ebp),%eax
    3cf7:	0f b6 00             	movzbl (%eax),%eax
    3cfa:	0f b6 d0             	movzbl %al,%edx
    3cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d00:	0f b6 00             	movzbl (%eax),%eax
    3d03:	0f b6 c0             	movzbl %al,%eax
    3d06:	89 d1                	mov    %edx,%ecx
    3d08:	29 c1                	sub    %eax,%ecx
    3d0a:	89 c8                	mov    %ecx,%eax
}
    3d0c:	5d                   	pop    %ebp
    3d0d:	c3                   	ret    

00003d0e <strlen>:

uint
strlen(char *s)
{
    3d0e:	55                   	push   %ebp
    3d0f:	89 e5                	mov    %esp,%ebp
    3d11:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3d1b:	eb 04                	jmp    3d21 <strlen+0x13>
    3d1d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3d21:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3d24:	8b 45 08             	mov    0x8(%ebp),%eax
    3d27:	01 d0                	add    %edx,%eax
    3d29:	0f b6 00             	movzbl (%eax),%eax
    3d2c:	84 c0                	test   %al,%al
    3d2e:	75 ed                	jne    3d1d <strlen+0xf>
    ;
  return n;
    3d30:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3d33:	c9                   	leave  
    3d34:	c3                   	ret    

00003d35 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3d35:	55                   	push   %ebp
    3d36:	89 e5                	mov    %esp,%ebp
    3d38:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    3d3b:	8b 45 10             	mov    0x10(%ebp),%eax
    3d3e:	89 44 24 08          	mov    %eax,0x8(%esp)
    3d42:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d45:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d49:	8b 45 08             	mov    0x8(%ebp),%eax
    3d4c:	89 04 24             	mov    %eax,(%esp)
    3d4f:	e8 20 ff ff ff       	call   3c74 <stosb>
  return dst;
    3d54:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3d57:	c9                   	leave  
    3d58:	c3                   	ret    

00003d59 <strchr>:

char*
strchr(const char *s, char c)
{
    3d59:	55                   	push   %ebp
    3d5a:	89 e5                	mov    %esp,%ebp
    3d5c:	83 ec 04             	sub    $0x4,%esp
    3d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d62:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3d65:	eb 14                	jmp    3d7b <strchr+0x22>
    if(*s == c)
    3d67:	8b 45 08             	mov    0x8(%ebp),%eax
    3d6a:	0f b6 00             	movzbl (%eax),%eax
    3d6d:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3d70:	75 05                	jne    3d77 <strchr+0x1e>
      return (char*)s;
    3d72:	8b 45 08             	mov    0x8(%ebp),%eax
    3d75:	eb 13                	jmp    3d8a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3d77:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3d7b:	8b 45 08             	mov    0x8(%ebp),%eax
    3d7e:	0f b6 00             	movzbl (%eax),%eax
    3d81:	84 c0                	test   %al,%al
    3d83:	75 e2                	jne    3d67 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    3d85:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3d8a:	c9                   	leave  
    3d8b:	c3                   	ret    

00003d8c <gets>:

char*
gets(char *buf, int max)
{
    3d8c:	55                   	push   %ebp
    3d8d:	89 e5                	mov    %esp,%ebp
    3d8f:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3d99:	eb 46                	jmp    3de1 <gets+0x55>
    cc = read(0, &c, 1);
    3d9b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3da2:	00 
    3da3:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3da6:	89 44 24 04          	mov    %eax,0x4(%esp)
    3daa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3db1:	e8 3e 01 00 00       	call   3ef4 <read>
    3db6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3db9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3dbd:	7e 2f                	jle    3dee <gets+0x62>
      break;
    buf[i++] = c;
    3dbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3dc2:	8b 45 08             	mov    0x8(%ebp),%eax
    3dc5:	01 c2                	add    %eax,%edx
    3dc7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3dcb:	88 02                	mov    %al,(%edx)
    3dcd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
    3dd1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3dd5:	3c 0a                	cmp    $0xa,%al
    3dd7:	74 16                	je     3def <gets+0x63>
    3dd9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3ddd:	3c 0d                	cmp    $0xd,%al
    3ddf:	74 0e                	je     3def <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3de1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3de4:	83 c0 01             	add    $0x1,%eax
    3de7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3dea:	7c af                	jl     3d9b <gets+0xf>
    3dec:	eb 01                	jmp    3def <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    3dee:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3def:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3df2:	8b 45 08             	mov    0x8(%ebp),%eax
    3df5:	01 d0                	add    %edx,%eax
    3df7:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3dfa:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3dfd:	c9                   	leave  
    3dfe:	c3                   	ret    

00003dff <stat>:

int
stat(char *n, struct stat *st)
{
    3dff:	55                   	push   %ebp
    3e00:	89 e5                	mov    %esp,%ebp
    3e02:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3e05:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3e0c:	00 
    3e0d:	8b 45 08             	mov    0x8(%ebp),%eax
    3e10:	89 04 24             	mov    %eax,(%esp)
    3e13:	e8 04 01 00 00       	call   3f1c <open>
    3e18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3e1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3e1f:	79 07                	jns    3e28 <stat+0x29>
    return -1;
    3e21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3e26:	eb 23                	jmp    3e4b <stat+0x4c>
  r = fstat(fd, st);
    3e28:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e2b:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e32:	89 04 24             	mov    %eax,(%esp)
    3e35:	e8 fa 00 00 00       	call   3f34 <fstat>
    3e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e40:	89 04 24             	mov    %eax,(%esp)
    3e43:	e8 bc 00 00 00       	call   3f04 <close>
  return r;
    3e48:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3e4b:	c9                   	leave  
    3e4c:	c3                   	ret    

00003e4d <atoi>:

int
atoi(const char *s)
{
    3e4d:	55                   	push   %ebp
    3e4e:	89 e5                	mov    %esp,%ebp
    3e50:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3e53:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3e5a:	eb 23                	jmp    3e7f <atoi+0x32>
    n = n*10 + *s++ - '0';
    3e5c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3e5f:	89 d0                	mov    %edx,%eax
    3e61:	c1 e0 02             	shl    $0x2,%eax
    3e64:	01 d0                	add    %edx,%eax
    3e66:	01 c0                	add    %eax,%eax
    3e68:	89 c2                	mov    %eax,%edx
    3e6a:	8b 45 08             	mov    0x8(%ebp),%eax
    3e6d:	0f b6 00             	movzbl (%eax),%eax
    3e70:	0f be c0             	movsbl %al,%eax
    3e73:	01 d0                	add    %edx,%eax
    3e75:	83 e8 30             	sub    $0x30,%eax
    3e78:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3e7b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3e7f:	8b 45 08             	mov    0x8(%ebp),%eax
    3e82:	0f b6 00             	movzbl (%eax),%eax
    3e85:	3c 2f                	cmp    $0x2f,%al
    3e87:	7e 0a                	jle    3e93 <atoi+0x46>
    3e89:	8b 45 08             	mov    0x8(%ebp),%eax
    3e8c:	0f b6 00             	movzbl (%eax),%eax
    3e8f:	3c 39                	cmp    $0x39,%al
    3e91:	7e c9                	jle    3e5c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    3e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3e96:	c9                   	leave  
    3e97:	c3                   	ret    

00003e98 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3e98:	55                   	push   %ebp
    3e99:	89 e5                	mov    %esp,%ebp
    3e9b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3e9e:	8b 45 08             	mov    0x8(%ebp),%eax
    3ea1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ea7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3eaa:	eb 13                	jmp    3ebf <memmove+0x27>
    *dst++ = *src++;
    3eac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3eaf:	0f b6 10             	movzbl (%eax),%edx
    3eb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3eb5:	88 10                	mov    %dl,(%eax)
    3eb7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3ebb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3ebf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    3ec3:	0f 9f c0             	setg   %al
    3ec6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    3eca:	84 c0                	test   %al,%al
    3ecc:	75 de                	jne    3eac <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    3ece:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3ed1:	c9                   	leave  
    3ed2:	c3                   	ret    
    3ed3:	90                   	nop

00003ed4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3ed4:	b8 01 00 00 00       	mov    $0x1,%eax
    3ed9:	cd 40                	int    $0x40
    3edb:	c3                   	ret    

00003edc <exit>:
SYSCALL(exit)
    3edc:	b8 02 00 00 00       	mov    $0x2,%eax
    3ee1:	cd 40                	int    $0x40
    3ee3:	c3                   	ret    

00003ee4 <wait>:
SYSCALL(wait)
    3ee4:	b8 03 00 00 00       	mov    $0x3,%eax
    3ee9:	cd 40                	int    $0x40
    3eeb:	c3                   	ret    

00003eec <pipe>:
SYSCALL(pipe)
    3eec:	b8 04 00 00 00       	mov    $0x4,%eax
    3ef1:	cd 40                	int    $0x40
    3ef3:	c3                   	ret    

00003ef4 <read>:
SYSCALL(read)
    3ef4:	b8 05 00 00 00       	mov    $0x5,%eax
    3ef9:	cd 40                	int    $0x40
    3efb:	c3                   	ret    

00003efc <write>:
SYSCALL(write)
    3efc:	b8 10 00 00 00       	mov    $0x10,%eax
    3f01:	cd 40                	int    $0x40
    3f03:	c3                   	ret    

00003f04 <close>:
SYSCALL(close)
    3f04:	b8 15 00 00 00       	mov    $0x15,%eax
    3f09:	cd 40                	int    $0x40
    3f0b:	c3                   	ret    

00003f0c <kill>:
SYSCALL(kill)
    3f0c:	b8 06 00 00 00       	mov    $0x6,%eax
    3f11:	cd 40                	int    $0x40
    3f13:	c3                   	ret    

00003f14 <exec>:
SYSCALL(exec)
    3f14:	b8 07 00 00 00       	mov    $0x7,%eax
    3f19:	cd 40                	int    $0x40
    3f1b:	c3                   	ret    

00003f1c <open>:
SYSCALL(open)
    3f1c:	b8 0f 00 00 00       	mov    $0xf,%eax
    3f21:	cd 40                	int    $0x40
    3f23:	c3                   	ret    

00003f24 <mknod>:
SYSCALL(mknod)
    3f24:	b8 11 00 00 00       	mov    $0x11,%eax
    3f29:	cd 40                	int    $0x40
    3f2b:	c3                   	ret    

00003f2c <unlink>:
SYSCALL(unlink)
    3f2c:	b8 12 00 00 00       	mov    $0x12,%eax
    3f31:	cd 40                	int    $0x40
    3f33:	c3                   	ret    

00003f34 <fstat>:
SYSCALL(fstat)
    3f34:	b8 08 00 00 00       	mov    $0x8,%eax
    3f39:	cd 40                	int    $0x40
    3f3b:	c3                   	ret    

00003f3c <link>:
SYSCALL(link)
    3f3c:	b8 13 00 00 00       	mov    $0x13,%eax
    3f41:	cd 40                	int    $0x40
    3f43:	c3                   	ret    

00003f44 <mkdir>:
SYSCALL(mkdir)
    3f44:	b8 14 00 00 00       	mov    $0x14,%eax
    3f49:	cd 40                	int    $0x40
    3f4b:	c3                   	ret    

00003f4c <chdir>:
SYSCALL(chdir)
    3f4c:	b8 09 00 00 00       	mov    $0x9,%eax
    3f51:	cd 40                	int    $0x40
    3f53:	c3                   	ret    

00003f54 <dup>:
SYSCALL(dup)
    3f54:	b8 0a 00 00 00       	mov    $0xa,%eax
    3f59:	cd 40                	int    $0x40
    3f5b:	c3                   	ret    

00003f5c <getpid>:
SYSCALL(getpid)
    3f5c:	b8 0b 00 00 00       	mov    $0xb,%eax
    3f61:	cd 40                	int    $0x40
    3f63:	c3                   	ret    

00003f64 <sbrk>:
SYSCALL(sbrk)
    3f64:	b8 0c 00 00 00       	mov    $0xc,%eax
    3f69:	cd 40                	int    $0x40
    3f6b:	c3                   	ret    

00003f6c <sleep>:
SYSCALL(sleep)
    3f6c:	b8 0d 00 00 00       	mov    $0xd,%eax
    3f71:	cd 40                	int    $0x40
    3f73:	c3                   	ret    

00003f74 <uptime>:
SYSCALL(uptime)
    3f74:	b8 0e 00 00 00       	mov    $0xe,%eax
    3f79:	cd 40                	int    $0x40
    3f7b:	c3                   	ret    

00003f7c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3f7c:	55                   	push   %ebp
    3f7d:	89 e5                	mov    %esp,%ebp
    3f7f:	83 ec 28             	sub    $0x28,%esp
    3f82:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f85:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    3f88:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3f8f:	00 
    3f90:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3f93:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f97:	8b 45 08             	mov    0x8(%ebp),%eax
    3f9a:	89 04 24             	mov    %eax,(%esp)
    3f9d:	e8 5a ff ff ff       	call   3efc <write>
}
    3fa2:	c9                   	leave  
    3fa3:	c3                   	ret    

00003fa4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3fa4:	55                   	push   %ebp
    3fa5:	89 e5                	mov    %esp,%ebp
    3fa7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3faa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    3fb1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3fb5:	74 17                	je     3fce <printint+0x2a>
    3fb7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3fbb:	79 11                	jns    3fce <printint+0x2a>
    neg = 1;
    3fbd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    3fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fc7:	f7 d8                	neg    %eax
    3fc9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3fcc:	eb 06                	jmp    3fd4 <printint+0x30>
  } else {
    x = xx;
    3fce:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fd1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    3fd4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    3fdb:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3fde:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3fe1:	ba 00 00 00 00       	mov    $0x0,%edx
    3fe6:	f7 f1                	div    %ecx
    3fe8:	89 d0                	mov    %edx,%eax
    3fea:	0f b6 80 f0 62 00 00 	movzbl 0x62f0(%eax),%eax
    3ff1:	8d 4d dc             	lea    -0x24(%ebp),%ecx
    3ff4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3ff7:	01 ca                	add    %ecx,%edx
    3ff9:	88 02                	mov    %al,(%edx)
    3ffb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
    3fff:	8b 55 10             	mov    0x10(%ebp),%edx
    4002:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    4005:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4008:	ba 00 00 00 00       	mov    $0x0,%edx
    400d:	f7 75 d4             	divl   -0x2c(%ebp)
    4010:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4013:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4017:	75 c2                	jne    3fdb <printint+0x37>
  if(neg)
    4019:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    401d:	74 2e                	je     404d <printint+0xa9>
    buf[i++] = '-';
    401f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    4022:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4025:	01 d0                	add    %edx,%eax
    4027:	c6 00 2d             	movb   $0x2d,(%eax)
    402a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
    402e:	eb 1d                	jmp    404d <printint+0xa9>
    putc(fd, buf[i]);
    4030:	8d 55 dc             	lea    -0x24(%ebp),%edx
    4033:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4036:	01 d0                	add    %edx,%eax
    4038:	0f b6 00             	movzbl (%eax),%eax
    403b:	0f be c0             	movsbl %al,%eax
    403e:	89 44 24 04          	mov    %eax,0x4(%esp)
    4042:	8b 45 08             	mov    0x8(%ebp),%eax
    4045:	89 04 24             	mov    %eax,(%esp)
    4048:	e8 2f ff ff ff       	call   3f7c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    404d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    4051:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4055:	79 d9                	jns    4030 <printint+0x8c>
    putc(fd, buf[i]);
}
    4057:	c9                   	leave  
    4058:	c3                   	ret    

00004059 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4059:	55                   	push   %ebp
    405a:	89 e5                	mov    %esp,%ebp
    405c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    405f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4066:	8d 45 0c             	lea    0xc(%ebp),%eax
    4069:	83 c0 04             	add    $0x4,%eax
    406c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    406f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4076:	e9 7d 01 00 00       	jmp    41f8 <printf+0x19f>
    c = fmt[i] & 0xff;
    407b:	8b 55 0c             	mov    0xc(%ebp),%edx
    407e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4081:	01 d0                	add    %edx,%eax
    4083:	0f b6 00             	movzbl (%eax),%eax
    4086:	0f be c0             	movsbl %al,%eax
    4089:	25 ff 00 00 00       	and    $0xff,%eax
    408e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    4091:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4095:	75 2c                	jne    40c3 <printf+0x6a>
      if(c == '%'){
    4097:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    409b:	75 0c                	jne    40a9 <printf+0x50>
        state = '%';
    409d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    40a4:	e9 4b 01 00 00       	jmp    41f4 <printf+0x19b>
      } else {
        putc(fd, c);
    40a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    40ac:	0f be c0             	movsbl %al,%eax
    40af:	89 44 24 04          	mov    %eax,0x4(%esp)
    40b3:	8b 45 08             	mov    0x8(%ebp),%eax
    40b6:	89 04 24             	mov    %eax,(%esp)
    40b9:	e8 be fe ff ff       	call   3f7c <putc>
    40be:	e9 31 01 00 00       	jmp    41f4 <printf+0x19b>
      }
    } else if(state == '%'){
    40c3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    40c7:	0f 85 27 01 00 00    	jne    41f4 <printf+0x19b>
      if(c == 'd'){
    40cd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    40d1:	75 2d                	jne    4100 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    40d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    40d6:	8b 00                	mov    (%eax),%eax
    40d8:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    40df:	00 
    40e0:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    40e7:	00 
    40e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    40ec:	8b 45 08             	mov    0x8(%ebp),%eax
    40ef:	89 04 24             	mov    %eax,(%esp)
    40f2:	e8 ad fe ff ff       	call   3fa4 <printint>
        ap++;
    40f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    40fb:	e9 ed 00 00 00       	jmp    41ed <printf+0x194>
      } else if(c == 'x' || c == 'p'){
    4100:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    4104:	74 06                	je     410c <printf+0xb3>
    4106:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    410a:	75 2d                	jne    4139 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    410c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    410f:	8b 00                	mov    (%eax),%eax
    4111:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    4118:	00 
    4119:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    4120:	00 
    4121:	89 44 24 04          	mov    %eax,0x4(%esp)
    4125:	8b 45 08             	mov    0x8(%ebp),%eax
    4128:	89 04 24             	mov    %eax,(%esp)
    412b:	e8 74 fe ff ff       	call   3fa4 <printint>
        ap++;
    4130:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4134:	e9 b4 00 00 00       	jmp    41ed <printf+0x194>
      } else if(c == 's'){
    4139:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    413d:	75 46                	jne    4185 <printf+0x12c>
        s = (char*)*ap;
    413f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4142:	8b 00                	mov    (%eax),%eax
    4144:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4147:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    414b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    414f:	75 27                	jne    4178 <printf+0x11f>
          s = "(null)";
    4151:	c7 45 f4 f6 5b 00 00 	movl   $0x5bf6,-0xc(%ebp)
        while(*s != 0){
    4158:	eb 1e                	jmp    4178 <printf+0x11f>
          putc(fd, *s);
    415a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    415d:	0f b6 00             	movzbl (%eax),%eax
    4160:	0f be c0             	movsbl %al,%eax
    4163:	89 44 24 04          	mov    %eax,0x4(%esp)
    4167:	8b 45 08             	mov    0x8(%ebp),%eax
    416a:	89 04 24             	mov    %eax,(%esp)
    416d:	e8 0a fe ff ff       	call   3f7c <putc>
          s++;
    4172:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    4176:	eb 01                	jmp    4179 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4178:	90                   	nop
    4179:	8b 45 f4             	mov    -0xc(%ebp),%eax
    417c:	0f b6 00             	movzbl (%eax),%eax
    417f:	84 c0                	test   %al,%al
    4181:	75 d7                	jne    415a <printf+0x101>
    4183:	eb 68                	jmp    41ed <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4185:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4189:	75 1d                	jne    41a8 <printf+0x14f>
        putc(fd, *ap);
    418b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    418e:	8b 00                	mov    (%eax),%eax
    4190:	0f be c0             	movsbl %al,%eax
    4193:	89 44 24 04          	mov    %eax,0x4(%esp)
    4197:	8b 45 08             	mov    0x8(%ebp),%eax
    419a:	89 04 24             	mov    %eax,(%esp)
    419d:	e8 da fd ff ff       	call   3f7c <putc>
        ap++;
    41a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    41a6:	eb 45                	jmp    41ed <printf+0x194>
      } else if(c == '%'){
    41a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    41ac:	75 17                	jne    41c5 <printf+0x16c>
        putc(fd, c);
    41ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    41b1:	0f be c0             	movsbl %al,%eax
    41b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    41b8:	8b 45 08             	mov    0x8(%ebp),%eax
    41bb:	89 04 24             	mov    %eax,(%esp)
    41be:	e8 b9 fd ff ff       	call   3f7c <putc>
    41c3:	eb 28                	jmp    41ed <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    41c5:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    41cc:	00 
    41cd:	8b 45 08             	mov    0x8(%ebp),%eax
    41d0:	89 04 24             	mov    %eax,(%esp)
    41d3:	e8 a4 fd ff ff       	call   3f7c <putc>
        putc(fd, c);
    41d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    41db:	0f be c0             	movsbl %al,%eax
    41de:	89 44 24 04          	mov    %eax,0x4(%esp)
    41e2:	8b 45 08             	mov    0x8(%ebp),%eax
    41e5:	89 04 24             	mov    %eax,(%esp)
    41e8:	e8 8f fd ff ff       	call   3f7c <putc>
      }
      state = 0;
    41ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    41f4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    41f8:	8b 55 0c             	mov    0xc(%ebp),%edx
    41fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    41fe:	01 d0                	add    %edx,%eax
    4200:	0f b6 00             	movzbl (%eax),%eax
    4203:	84 c0                	test   %al,%al
    4205:	0f 85 70 fe ff ff    	jne    407b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    420b:	c9                   	leave  
    420c:	c3                   	ret    
    420d:	90                   	nop
    420e:	90                   	nop
    420f:	90                   	nop

00004210 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4210:	55                   	push   %ebp
    4211:	89 e5                	mov    %esp,%ebp
    4213:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4216:	8b 45 08             	mov    0x8(%ebp),%eax
    4219:	83 e8 08             	sub    $0x8,%eax
    421c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    421f:	a1 a8 63 00 00       	mov    0x63a8,%eax
    4224:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4227:	eb 24                	jmp    424d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4229:	8b 45 fc             	mov    -0x4(%ebp),%eax
    422c:	8b 00                	mov    (%eax),%eax
    422e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4231:	77 12                	ja     4245 <free+0x35>
    4233:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4236:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4239:	77 24                	ja     425f <free+0x4f>
    423b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    423e:	8b 00                	mov    (%eax),%eax
    4240:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4243:	77 1a                	ja     425f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4245:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4248:	8b 00                	mov    (%eax),%eax
    424a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    424d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4250:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4253:	76 d4                	jbe    4229 <free+0x19>
    4255:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4258:	8b 00                	mov    (%eax),%eax
    425a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    425d:	76 ca                	jbe    4229 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    425f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4262:	8b 40 04             	mov    0x4(%eax),%eax
    4265:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    426c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    426f:	01 c2                	add    %eax,%edx
    4271:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4274:	8b 00                	mov    (%eax),%eax
    4276:	39 c2                	cmp    %eax,%edx
    4278:	75 24                	jne    429e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    427a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    427d:	8b 50 04             	mov    0x4(%eax),%edx
    4280:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4283:	8b 00                	mov    (%eax),%eax
    4285:	8b 40 04             	mov    0x4(%eax),%eax
    4288:	01 c2                	add    %eax,%edx
    428a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    428d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    4290:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4293:	8b 00                	mov    (%eax),%eax
    4295:	8b 10                	mov    (%eax),%edx
    4297:	8b 45 f8             	mov    -0x8(%ebp),%eax
    429a:	89 10                	mov    %edx,(%eax)
    429c:	eb 0a                	jmp    42a8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    429e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42a1:	8b 10                	mov    (%eax),%edx
    42a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42a6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    42a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42ab:	8b 40 04             	mov    0x4(%eax),%eax
    42ae:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    42b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42b8:	01 d0                	add    %edx,%eax
    42ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    42bd:	75 20                	jne    42df <free+0xcf>
    p->s.size += bp->s.size;
    42bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42c2:	8b 50 04             	mov    0x4(%eax),%edx
    42c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42c8:	8b 40 04             	mov    0x4(%eax),%eax
    42cb:	01 c2                	add    %eax,%edx
    42cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42d0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    42d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42d6:	8b 10                	mov    (%eax),%edx
    42d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42db:	89 10                	mov    %edx,(%eax)
    42dd:	eb 08                	jmp    42e7 <free+0xd7>
  } else
    p->s.ptr = bp;
    42df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42e2:	8b 55 f8             	mov    -0x8(%ebp),%edx
    42e5:	89 10                	mov    %edx,(%eax)
  freep = p;
    42e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42ea:	a3 a8 63 00 00       	mov    %eax,0x63a8
}
    42ef:	c9                   	leave  
    42f0:	c3                   	ret    

000042f1 <morecore>:

static Header*
morecore(uint nu)
{
    42f1:	55                   	push   %ebp
    42f2:	89 e5                	mov    %esp,%ebp
    42f4:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    42f7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    42fe:	77 07                	ja     4307 <morecore+0x16>
    nu = 4096;
    4300:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4307:	8b 45 08             	mov    0x8(%ebp),%eax
    430a:	c1 e0 03             	shl    $0x3,%eax
    430d:	89 04 24             	mov    %eax,(%esp)
    4310:	e8 4f fc ff ff       	call   3f64 <sbrk>
    4315:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4318:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    431c:	75 07                	jne    4325 <morecore+0x34>
    return 0;
    431e:	b8 00 00 00 00       	mov    $0x0,%eax
    4323:	eb 22                	jmp    4347 <morecore+0x56>
  hp = (Header*)p;
    4325:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4328:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    432b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    432e:	8b 55 08             	mov    0x8(%ebp),%edx
    4331:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4334:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4337:	83 c0 08             	add    $0x8,%eax
    433a:	89 04 24             	mov    %eax,(%esp)
    433d:	e8 ce fe ff ff       	call   4210 <free>
  return freep;
    4342:	a1 a8 63 00 00       	mov    0x63a8,%eax
}
    4347:	c9                   	leave  
    4348:	c3                   	ret    

00004349 <malloc>:

void*
malloc(uint nbytes)
{
    4349:	55                   	push   %ebp
    434a:	89 e5                	mov    %esp,%ebp
    434c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    434f:	8b 45 08             	mov    0x8(%ebp),%eax
    4352:	83 c0 07             	add    $0x7,%eax
    4355:	c1 e8 03             	shr    $0x3,%eax
    4358:	83 c0 01             	add    $0x1,%eax
    435b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    435e:	a1 a8 63 00 00       	mov    0x63a8,%eax
    4363:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4366:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    436a:	75 23                	jne    438f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    436c:	c7 45 f0 a0 63 00 00 	movl   $0x63a0,-0x10(%ebp)
    4373:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4376:	a3 a8 63 00 00       	mov    %eax,0x63a8
    437b:	a1 a8 63 00 00       	mov    0x63a8,%eax
    4380:	a3 a0 63 00 00       	mov    %eax,0x63a0
    base.s.size = 0;
    4385:	c7 05 a4 63 00 00 00 	movl   $0x0,0x63a4
    438c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    438f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4392:	8b 00                	mov    (%eax),%eax
    4394:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4397:	8b 45 f4             	mov    -0xc(%ebp),%eax
    439a:	8b 40 04             	mov    0x4(%eax),%eax
    439d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    43a0:	72 4d                	jb     43ef <malloc+0xa6>
      if(p->s.size == nunits)
    43a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43a5:	8b 40 04             	mov    0x4(%eax),%eax
    43a8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    43ab:	75 0c                	jne    43b9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    43ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43b0:	8b 10                	mov    (%eax),%edx
    43b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43b5:	89 10                	mov    %edx,(%eax)
    43b7:	eb 26                	jmp    43df <malloc+0x96>
      else {
        p->s.size -= nunits;
    43b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43bc:	8b 40 04             	mov    0x4(%eax),%eax
    43bf:	89 c2                	mov    %eax,%edx
    43c1:	2b 55 ec             	sub    -0x14(%ebp),%edx
    43c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43c7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    43ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43cd:	8b 40 04             	mov    0x4(%eax),%eax
    43d0:	c1 e0 03             	shl    $0x3,%eax
    43d3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    43d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
    43dc:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    43df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43e2:	a3 a8 63 00 00       	mov    %eax,0x63a8
      return (void*)(p + 1);
    43e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43ea:	83 c0 08             	add    $0x8,%eax
    43ed:	eb 38                	jmp    4427 <malloc+0xde>
    }
    if(p == freep)
    43ef:	a1 a8 63 00 00       	mov    0x63a8,%eax
    43f4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    43f7:	75 1b                	jne    4414 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    43f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    43fc:	89 04 24             	mov    %eax,(%esp)
    43ff:	e8 ed fe ff ff       	call   42f1 <morecore>
    4404:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4407:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    440b:	75 07                	jne    4414 <malloc+0xcb>
        return 0;
    440d:	b8 00 00 00 00       	mov    $0x0,%eax
    4412:	eb 13                	jmp    4427 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4414:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4417:	89 45 f0             	mov    %eax,-0x10(%ebp)
    441a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    441d:	8b 00                	mov    (%eax),%eax
    441f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    4422:	e9 70 ff ff ff       	jmp    4397 <malloc+0x4e>
}
    4427:	c9                   	leave  
    4428:	c3                   	ret    
