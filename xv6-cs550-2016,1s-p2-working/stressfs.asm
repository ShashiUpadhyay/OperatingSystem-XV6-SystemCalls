
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	81 ec 30 02 00 00    	sub    $0x230,%esp
  int fd, i;
  char path[] = "stressfs0";
   c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
  13:	73 74 72 65 
  17:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
  1e:	73 73 66 73 
  22:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
  29:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	c7 44 24 04 8d 0b 00 	movl   $0xb8d,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 7d 07 00 00       	call   7bd <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  54:	89 04 24             	mov    %eax,(%esp)
  57:	e8 19 02 00 00       	call   275 <memset>

  for(i = 0; i < 4; i++)
  5c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  63:	00 00 00 00 
  67:	eb 11                	jmp    7a <main+0x7a>
    if(fork() > 0)
  69:	e8 d2 04 00 00       	call   540 <fork>
  6e:	85 c0                	test   %eax,%eax
  70:	7f 14                	jg     86 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  72:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
  79:	01 
  7a:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
  81:	03 
  82:	7e e5                	jle    69 <main+0x69>
  84:	eb 01                	jmp    87 <main+0x87>
    if(fork() > 0)
      break;
  86:	90                   	nop

  printf(1, "write %d\n", i);
  87:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  8e:	89 44 24 08          	mov    %eax,0x8(%esp)
  92:	c7 44 24 04 a0 0b 00 	movl   $0xba0,0x4(%esp)
  99:	00 
  9a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a1:	e8 17 07 00 00       	call   7bd <printf>

  path[8] += i;
  a6:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
  ad:	00 
  ae:	89 c2                	mov    %eax,%edx
  b0:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  b7:	01 d0                	add    %edx,%eax
  b9:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  c0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c7:	00 
  c8:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
  cf:	89 04 24             	mov    %eax,(%esp)
  d2:	e8 b1 04 00 00       	call   588 <open>
  d7:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
  de:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  e5:	00 00 00 00 
  e9:	eb 27                	jmp    112 <main+0x112>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  eb:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  f2:	00 
  f3:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  fb:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 102:	89 04 24             	mov    %eax,(%esp)
 105:	e8 5e 04 00 00       	call   568 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
 10a:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 111:	01 
 112:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 119:	13 
 11a:	7e cf                	jle    eb <main+0xeb>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
 11c:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 123:	89 04 24             	mov    %eax,(%esp)
 126:	e8 45 04 00 00       	call   570 <close>

  printf(1, "read\n");
 12b:	c7 44 24 04 aa 0b 00 	movl   $0xbaa,0x4(%esp)
 132:	00 
 133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13a:	e8 7e 06 00 00       	call   7bd <printf>

  fd = open(path, O_RDONLY);
 13f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 146:	00 
 147:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
 14e:	89 04 24             	mov    %eax,(%esp)
 151:	e8 32 04 00 00       	call   588 <open>
 156:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
 15d:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
 164:	00 00 00 00 
 168:	eb 27                	jmp    191 <main+0x191>
    read(fd, data, sizeof(data));
 16a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 171:	00 
 172:	8d 44 24 1e          	lea    0x1e(%esp),%eax
 176:	89 44 24 04          	mov    %eax,0x4(%esp)
 17a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 181:	89 04 24             	mov    %eax,(%esp)
 184:	e8 d7 03 00 00       	call   560 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 189:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 190:	01 
 191:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 198:	13 
 199:	7e cf                	jle    16a <main+0x16a>
    read(fd, data, sizeof(data));
  close(fd);
 19b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 1a2:	89 04 24             	mov    %eax,(%esp)
 1a5:	e8 c6 03 00 00       	call   570 <close>

  wait();
 1aa:	e8 a1 03 00 00       	call   550 <wait>
  
  exit();
 1af:	e8 94 03 00 00       	call   548 <exit>

000001b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bc:	8b 55 10             	mov    0x10(%ebp),%edx
 1bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c2:	89 cb                	mov    %ecx,%ebx
 1c4:	89 df                	mov    %ebx,%edi
 1c6:	89 d1                	mov    %edx,%ecx
 1c8:	fc                   	cld    
 1c9:	f3 aa                	rep stos %al,%es:(%edi)
 1cb:	89 ca                	mov    %ecx,%edx
 1cd:	89 fb                	mov    %edi,%ebx
 1cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d5:	5b                   	pop    %ebx
 1d6:	5f                   	pop    %edi
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    

000001d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
 1dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e5:	90                   	nop
 1e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e9:	0f b6 10             	movzbl (%eax),%edx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	88 10                	mov    %dl,(%eax)
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	0f b6 00             	movzbl (%eax),%eax
 1f7:	84 c0                	test   %al,%al
 1f9:	0f 95 c0             	setne  %al
 1fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 200:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 204:	84 c0                	test   %al,%al
 206:	75 de                	jne    1e6 <strcpy+0xd>
    ;
  return os;
 208:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20b:	c9                   	leave  
 20c:	c3                   	ret    

0000020d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 210:	eb 08                	jmp    21a <strcmp+0xd>
    p++, q++;
 212:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 216:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	84 c0                	test   %al,%al
 222:	74 10                	je     234 <strcmp+0x27>
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	0f b6 10             	movzbl (%eax),%edx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	0f b6 00             	movzbl (%eax),%eax
 230:	38 c2                	cmp    %al,%dl
 232:	74 de                	je     212 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 00             	movzbl (%eax),%eax
 23a:	0f b6 d0             	movzbl %al,%edx
 23d:	8b 45 0c             	mov    0xc(%ebp),%eax
 240:	0f b6 00             	movzbl (%eax),%eax
 243:	0f b6 c0             	movzbl %al,%eax
 246:	89 d1                	mov    %edx,%ecx
 248:	29 c1                	sub    %eax,%ecx
 24a:	89 c8                	mov    %ecx,%eax
}
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    

0000024e <strlen>:

uint
strlen(char *s)
{
 24e:	55                   	push   %ebp
 24f:	89 e5                	mov    %esp,%ebp
 251:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25b:	eb 04                	jmp    261 <strlen+0x13>
 25d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 261:	8b 55 fc             	mov    -0x4(%ebp),%edx
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	01 d0                	add    %edx,%eax
 269:	0f b6 00             	movzbl (%eax),%eax
 26c:	84 c0                	test   %al,%al
 26e:	75 ed                	jne    25d <strlen+0xf>
    ;
  return n;
 270:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 273:	c9                   	leave  
 274:	c3                   	ret    

00000275 <memset>:

void*
memset(void *dst, int c, uint n)
{
 275:	55                   	push   %ebp
 276:	89 e5                	mov    %esp,%ebp
 278:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 27b:	8b 45 10             	mov    0x10(%ebp),%eax
 27e:	89 44 24 08          	mov    %eax,0x8(%esp)
 282:	8b 45 0c             	mov    0xc(%ebp),%eax
 285:	89 44 24 04          	mov    %eax,0x4(%esp)
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	89 04 24             	mov    %eax,(%esp)
 28f:	e8 20 ff ff ff       	call   1b4 <stosb>
  return dst;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
}
 297:	c9                   	leave  
 298:	c3                   	ret    

00000299 <strchr>:

char*
strchr(const char *s, char c)
{
 299:	55                   	push   %ebp
 29a:	89 e5                	mov    %esp,%ebp
 29c:	83 ec 04             	sub    $0x4,%esp
 29f:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2a5:	eb 14                	jmp    2bb <strchr+0x22>
    if(*s == c)
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	0f b6 00             	movzbl (%eax),%eax
 2ad:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2b0:	75 05                	jne    2b7 <strchr+0x1e>
      return (char*)s;
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
 2b5:	eb 13                	jmp    2ca <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	0f b6 00             	movzbl (%eax),%eax
 2c1:	84 c0                	test   %al,%al
 2c3:	75 e2                	jne    2a7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ca:	c9                   	leave  
 2cb:	c3                   	ret    

000002cc <gets>:

char*
gets(char *buf, int max)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d9:	eb 46                	jmp    321 <gets+0x55>
    cc = read(0, &c, 1);
 2db:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e2:	00 
 2e3:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2f1:	e8 6a 02 00 00       	call   560 <read>
 2f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2fd:	7e 2f                	jle    32e <gets+0x62>
      break;
    buf[i++] = c;
 2ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	01 c2                	add    %eax,%edx
 307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30b:	88 02                	mov    %al,(%edx)
 30d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 311:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 315:	3c 0a                	cmp    $0xa,%al
 317:	74 16                	je     32f <gets+0x63>
 319:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31d:	3c 0d                	cmp    $0xd,%al
 31f:	74 0e                	je     32f <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 321:	8b 45 f4             	mov    -0xc(%ebp),%eax
 324:	83 c0 01             	add    $0x1,%eax
 327:	3b 45 0c             	cmp    0xc(%ebp),%eax
 32a:	7c af                	jl     2db <gets+0xf>
 32c:	eb 01                	jmp    32f <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 32e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 332:	8b 45 08             	mov    0x8(%ebp),%eax
 335:	01 d0                	add    %edx,%eax
 337:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 33a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 33d:	c9                   	leave  
 33e:	c3                   	ret    

0000033f <stat>:

int
stat(char *n, struct stat *st)
{
 33f:	55                   	push   %ebp
 340:	89 e5                	mov    %esp,%ebp
 342:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 345:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 34c:	00 
 34d:	8b 45 08             	mov    0x8(%ebp),%eax
 350:	89 04 24             	mov    %eax,(%esp)
 353:	e8 30 02 00 00       	call   588 <open>
 358:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 35b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 35f:	79 07                	jns    368 <stat+0x29>
    return -1;
 361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 366:	eb 23                	jmp    38b <stat+0x4c>
  r = fstat(fd, st);
 368:	8b 45 0c             	mov    0xc(%ebp),%eax
 36b:	89 44 24 04          	mov    %eax,0x4(%esp)
 36f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 372:	89 04 24             	mov    %eax,(%esp)
 375:	e8 26 02 00 00       	call   5a0 <fstat>
 37a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 37d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 380:	89 04 24             	mov    %eax,(%esp)
 383:	e8 e8 01 00 00       	call   570 <close>
  return r;
 388:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 38b:	c9                   	leave  
 38c:	c3                   	ret    

0000038d <atoi>:

int
atoi(const char *s)
{
 38d:	55                   	push   %ebp
 38e:	89 e5                	mov    %esp,%ebp
 390:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 393:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 39a:	eb 23                	jmp    3bf <atoi+0x32>
    n = n*10 + *s++ - '0';
 39c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 39f:	89 d0                	mov    %edx,%eax
 3a1:	c1 e0 02             	shl    $0x2,%eax
 3a4:	01 d0                	add    %edx,%eax
 3a6:	01 c0                	add    %eax,%eax
 3a8:	89 c2                	mov    %eax,%edx
 3aa:	8b 45 08             	mov    0x8(%ebp),%eax
 3ad:	0f b6 00             	movzbl (%eax),%eax
 3b0:	0f be c0             	movsbl %al,%eax
 3b3:	01 d0                	add    %edx,%eax
 3b5:	83 e8 30             	sub    $0x30,%eax
 3b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3bb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3bf:	8b 45 08             	mov    0x8(%ebp),%eax
 3c2:	0f b6 00             	movzbl (%eax),%eax
 3c5:	3c 2f                	cmp    $0x2f,%al
 3c7:	7e 0a                	jle    3d3 <atoi+0x46>
 3c9:	8b 45 08             	mov    0x8(%ebp),%eax
 3cc:	0f b6 00             	movzbl (%eax),%eax
 3cf:	3c 39                	cmp    $0x39,%al
 3d1:	7e c9                	jle    39c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d6:	c9                   	leave  
 3d7:	c3                   	ret    

000003d8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d8:	55                   	push   %ebp
 3d9:	89 e5                	mov    %esp,%ebp
 3db:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3de:	8b 45 08             	mov    0x8(%ebp),%eax
 3e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3ea:	eb 13                	jmp    3ff <memmove+0x27>
    *dst++ = *src++;
 3ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3ef:	0f b6 10             	movzbl (%eax),%edx
 3f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3f5:	88 10                	mov    %dl,(%eax)
 3f7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3fb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 403:	0f 9f c0             	setg   %al
 406:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 40a:	84 c0                	test   %al,%al
 40c:	75 de                	jne    3ec <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 40e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 411:	c9                   	leave  
 412:	c3                   	ret    
 413:	90                   	nop

00000414 <SYS_ls_call01>:
 414:	6c                   	insb   (%dx),%es:(%edi)
 415:	73 5f                	jae    476 <SYS_ls_call10+0x8>
 417:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 41a:	6c                   	insb   (%dx),%es:(%edi)
 41b:	30 31                	xor    %dh,(%ecx)
	...

0000041e <SYS_ls_call02>:
 41e:	6c                   	insb   (%dx),%es:(%edi)
 41f:	73 5f                	jae    480 <SYS_ls_call11+0x8>
 421:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 424:	6c                   	insb   (%dx),%es:(%edi)
 425:	30 32                	xor    %dh,(%edx)
	...

00000428 <SYS_ls_call03>:
 428:	6c                   	insb   (%dx),%es:(%edi)
 429:	73 5f                	jae    48a <SYS_ls_call12+0x8>
 42b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 42e:	6c                   	insb   (%dx),%es:(%edi)
 42f:	30 33                	xor    %dh,(%ebx)
	...

00000432 <SYS_ls_call04>:
 432:	6c                   	insb   (%dx),%es:(%edi)
 433:	73 5f                	jae    494 <SYS_ls_call13+0x8>
 435:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 438:	6c                   	insb   (%dx),%es:(%edi)
 439:	30 34 00             	xor    %dh,(%eax,%eax,1)

0000043c <SYS_ls_call05>:
 43c:	6c                   	insb   (%dx),%es:(%edi)
 43d:	73 5f                	jae    49e <SYS_ls_call14+0x8>
 43f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 442:	6c                   	insb   (%dx),%es:(%edi)
 443:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

00000446 <SYS_ls_call06>:
 446:	6c                   	insb   (%dx),%es:(%edi)
 447:	73 5f                	jae    4a8 <SYS_ls_call15+0x8>
 449:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 44c:	6c                   	insb   (%dx),%es:(%edi)
 44d:	30 36                	xor    %dh,(%esi)
	...

00000450 <SYS_ls_call07>:
 450:	6c                   	insb   (%dx),%es:(%edi)
 451:	73 5f                	jae    4b2 <SYS_ls_call16+0x8>
 453:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 456:	6c                   	insb   (%dx),%es:(%edi)
 457:	30 37                	xor    %dh,(%edi)
	...

0000045a <SYS_ls_call08>:
 45a:	6c                   	insb   (%dx),%es:(%edi)
 45b:	73 5f                	jae    4bc <SYS_ls_call17+0x8>
 45d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 460:	6c                   	insb   (%dx),%es:(%edi)
 461:	30 38                	xor    %bh,(%eax)
	...

00000464 <SYS_ls_call09>:
 464:	6c                   	insb   (%dx),%es:(%edi)
 465:	73 5f                	jae    4c6 <SYS_ls_call18+0x8>
 467:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 46a:	6c                   	insb   (%dx),%es:(%edi)
 46b:	30 39                	xor    %bh,(%ecx)
	...

0000046e <SYS_ls_call10>:
 46e:	6c                   	insb   (%dx),%es:(%edi)
 46f:	73 5f                	jae    4d0 <SYS_ls_call19+0x8>
 471:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 474:	6c                   	insb   (%dx),%es:(%edi)
 475:	31 30                	xor    %esi,(%eax)
	...

00000478 <SYS_ls_call11>:
 478:	6c                   	insb   (%dx),%es:(%edi)
 479:	73 5f                	jae    4da <SYS_ls_call20+0x8>
 47b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 47e:	6c                   	insb   (%dx),%es:(%edi)
 47f:	31 31                	xor    %esi,(%ecx)
	...

00000482 <SYS_ls_call12>:
 482:	6c                   	insb   (%dx),%es:(%edi)
 483:	73 5f                	jae    4e4 <SYS_ls_call21+0x8>
 485:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 488:	6c                   	insb   (%dx),%es:(%edi)
 489:	31 32                	xor    %esi,(%edx)
	...

0000048c <SYS_ls_call13>:
 48c:	6c                   	insb   (%dx),%es:(%edi)
 48d:	73 5f                	jae    4ee <SYS_ls_call22+0x8>
 48f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 492:	6c                   	insb   (%dx),%es:(%edi)
 493:	31 33                	xor    %esi,(%ebx)
	...

00000496 <SYS_ls_call14>:
 496:	6c                   	insb   (%dx),%es:(%edi)
 497:	73 5f                	jae    4f8 <SYS_ls_call23+0x8>
 499:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 49c:	6c                   	insb   (%dx),%es:(%edi)
 49d:	31 34 00             	xor    %esi,(%eax,%eax,1)

000004a0 <SYS_ls_call15>:
 4a0:	6c                   	insb   (%dx),%es:(%edi)
 4a1:	73 5f                	jae    502 <SYS_ls_call24+0x8>
 4a3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4a6:	6c                   	insb   (%dx),%es:(%edi)
 4a7:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

000004aa <SYS_ls_call16>:
 4aa:	6c                   	insb   (%dx),%es:(%edi)
 4ab:	73 5f                	jae    50c <SYS_ls_call25+0x8>
 4ad:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4b0:	6c                   	insb   (%dx),%es:(%edi)
 4b1:	31 36                	xor    %esi,(%esi)
	...

000004b4 <SYS_ls_call17>:
 4b4:	6c                   	insb   (%dx),%es:(%edi)
 4b5:	73 5f                	jae    516 <SYS_ls_call26+0x8>
 4b7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4ba:	6c                   	insb   (%dx),%es:(%edi)
 4bb:	31 37                	xor    %esi,(%edi)
	...

000004be <SYS_ls_call18>:
 4be:	6c                   	insb   (%dx),%es:(%edi)
 4bf:	73 5f                	jae    520 <SYS_ls_call27+0x8>
 4c1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4c4:	6c                   	insb   (%dx),%es:(%edi)
 4c5:	31 38                	xor    %edi,(%eax)
	...

000004c8 <SYS_ls_call19>:
 4c8:	6c                   	insb   (%dx),%es:(%edi)
 4c9:	73 5f                	jae    52a <SYS_ls_call28+0x8>
 4cb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4ce:	6c                   	insb   (%dx),%es:(%edi)
 4cf:	31 39                	xor    %edi,(%ecx)
	...

000004d2 <SYS_ls_call20>:
 4d2:	6c                   	insb   (%dx),%es:(%edi)
 4d3:	73 5f                	jae    534 <SYS_ls_call29+0x8>
 4d5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4d8:	6c                   	insb   (%dx),%es:(%edi)
 4d9:	32 30                	xor    (%eax),%dh
	...

000004dc <SYS_ls_call21>:
 4dc:	6c                   	insb   (%dx),%es:(%edi)
 4dd:	73 5f                	jae    53e <SYS_ls_call30+0x8>
 4df:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4e2:	6c                   	insb   (%dx),%es:(%edi)
 4e3:	32 31                	xor    (%ecx),%dh
	...

000004e6 <SYS_ls_call22>:
 4e6:	6c                   	insb   (%dx),%es:(%edi)
 4e7:	73 5f                	jae    548 <exit>
 4e9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4ec:	6c                   	insb   (%dx),%es:(%edi)
 4ed:	32 32                	xor    (%edx),%dh
	...

000004f0 <SYS_ls_call23>:
 4f0:	6c                   	insb   (%dx),%es:(%edi)
 4f1:	73 5f                	jae    552 <wait+0x2>
 4f3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4f6:	6c                   	insb   (%dx),%es:(%edi)
 4f7:	32 33                	xor    (%ebx),%dh
	...

000004fa <SYS_ls_call24>:
 4fa:	6c                   	insb   (%dx),%es:(%edi)
 4fb:	73 5f                	jae    55c <pipe+0x4>
 4fd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 500:	6c                   	insb   (%dx),%es:(%edi)
 501:	32 34 00             	xor    (%eax,%eax,1),%dh

00000504 <SYS_ls_call25>:
 504:	6c                   	insb   (%dx),%es:(%edi)
 505:	73 5f                	jae    566 <read+0x6>
 507:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 50a:	6c                   	insb   (%dx),%es:(%edi)
 50b:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

0000050e <SYS_ls_call26>:
 50e:	6c                   	insb   (%dx),%es:(%edi)
 50f:	73 5f                	jae    570 <close>
 511:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 514:	6c                   	insb   (%dx),%es:(%edi)
 515:	32 36                	xor    (%esi),%dh
	...

00000518 <SYS_ls_call27>:
 518:	6c                   	insb   (%dx),%es:(%edi)
 519:	73 5f                	jae    57a <kill+0x2>
 51b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 51e:	6c                   	insb   (%dx),%es:(%edi)
 51f:	32 37                	xor    (%edi),%dh
	...

00000522 <SYS_ls_call28>:
 522:	6c                   	insb   (%dx),%es:(%edi)
 523:	73 5f                	jae    584 <exec+0x4>
 525:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 528:	6c                   	insb   (%dx),%es:(%edi)
 529:	32 38                	xor    (%eax),%bh
	...

0000052c <SYS_ls_call29>:
 52c:	6c                   	insb   (%dx),%es:(%edi)
 52d:	73 5f                	jae    58e <open+0x6>
 52f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 532:	6c                   	insb   (%dx),%es:(%edi)
 533:	32 39                	xor    (%ecx),%bh
	...

00000536 <SYS_ls_call30>:
 536:	6c                   	insb   (%dx),%es:(%edi)
 537:	73 5f                	jae    598 <unlink>
 539:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 53c:	6c                   	insb   (%dx),%es:(%edi)
 53d:	33 30                	xor    (%eax),%esi
	...

00000540 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 540:	b8 01 00 00 00       	mov    $0x1,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <exit>:
SYSCALL(exit)
 548:	b8 02 00 00 00       	mov    $0x2,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <wait>:
SYSCALL(wait)
 550:	b8 03 00 00 00       	mov    $0x3,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <pipe>:
SYSCALL(pipe)
 558:	b8 04 00 00 00       	mov    $0x4,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <read>:
SYSCALL(read)
 560:	b8 05 00 00 00       	mov    $0x5,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <write>:
SYSCALL(write)
 568:	b8 10 00 00 00       	mov    $0x10,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <close>:
SYSCALL(close)
 570:	b8 15 00 00 00       	mov    $0x15,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <kill>:
SYSCALL(kill)
 578:	b8 06 00 00 00       	mov    $0x6,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <exec>:
SYSCALL(exec)
 580:	b8 07 00 00 00       	mov    $0x7,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <open>:
SYSCALL(open)
 588:	b8 0f 00 00 00       	mov    $0xf,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <mknod>:
SYSCALL(mknod)
 590:	b8 11 00 00 00       	mov    $0x11,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <unlink>:
SYSCALL(unlink)
 598:	b8 12 00 00 00       	mov    $0x12,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <fstat>:
SYSCALL(fstat)
 5a0:	b8 08 00 00 00       	mov    $0x8,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <link>:
SYSCALL(link)
 5a8:	b8 13 00 00 00       	mov    $0x13,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <mkdir>:
SYSCALL(mkdir)
 5b0:	b8 14 00 00 00       	mov    $0x14,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <chdir>:
SYSCALL(chdir)
 5b8:	b8 09 00 00 00       	mov    $0x9,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <dup>:
SYSCALL(dup)
 5c0:	b8 0a 00 00 00       	mov    $0xa,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <getpid>:
SYSCALL(getpid)
 5c8:	b8 0b 00 00 00       	mov    $0xb,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <sbrk>:
SYSCALL(sbrk)
 5d0:	b8 0c 00 00 00       	mov    $0xc,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <sleep>:
SYSCALL(sleep)
 5d8:	b8 0d 00 00 00       	mov    $0xd,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <uptime>:
SYSCALL(uptime)
 5e0:	b8 0e 00 00 00       	mov    $0xe,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <date>:
SYSCALL(date)
 5e8:	b8 16 00 00 00       	mov    $0x16,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <ls_call01>:

SYSCALL1(ls_call01)
 5f0:	b8 14 04 00 00       	mov    $0x414,%eax
 5f5:	cd 41                	int    $0x41
 5f7:	c3                   	ret    

000005f8 <ls_call02>:
SYSCALL1(ls_call02)
 5f8:	b8 1e 04 00 00       	mov    $0x41e,%eax
 5fd:	cd 41                	int    $0x41
 5ff:	c3                   	ret    

00000600 <ls_call03>:
SYSCALL1(ls_call03)
 600:	b8 28 04 00 00       	mov    $0x428,%eax
 605:	cd 41                	int    $0x41
 607:	c3                   	ret    

00000608 <ls_call04>:
SYSCALL1(ls_call04)
 608:	b8 32 04 00 00       	mov    $0x432,%eax
 60d:	cd 41                	int    $0x41
 60f:	c3                   	ret    

00000610 <ls_call05>:
SYSCALL1(ls_call05)
 610:	b8 3c 04 00 00       	mov    $0x43c,%eax
 615:	cd 41                	int    $0x41
 617:	c3                   	ret    

00000618 <ls_call06>:
SYSCALL1(ls_call06)
 618:	b8 46 04 00 00       	mov    $0x446,%eax
 61d:	cd 41                	int    $0x41
 61f:	c3                   	ret    

00000620 <ls_call07>:
SYSCALL1(ls_call07)
 620:	b8 50 04 00 00       	mov    $0x450,%eax
 625:	cd 41                	int    $0x41
 627:	c3                   	ret    

00000628 <ls_call08>:
SYSCALL1(ls_call08)
 628:	b8 5a 04 00 00       	mov    $0x45a,%eax
 62d:	cd 41                	int    $0x41
 62f:	c3                   	ret    

00000630 <ls_call09>:
SYSCALL1(ls_call09)
 630:	b8 64 04 00 00       	mov    $0x464,%eax
 635:	cd 41                	int    $0x41
 637:	c3                   	ret    

00000638 <ls_call10>:
SYSCALL1(ls_call10)
 638:	b8 6e 04 00 00       	mov    $0x46e,%eax
 63d:	cd 41                	int    $0x41
 63f:	c3                   	ret    

00000640 <ls_call11>:
SYSCALL1(ls_call11)
 640:	b8 78 04 00 00       	mov    $0x478,%eax
 645:	cd 41                	int    $0x41
 647:	c3                   	ret    

00000648 <ls_call12>:
SYSCALL1(ls_call12)
 648:	b8 82 04 00 00       	mov    $0x482,%eax
 64d:	cd 41                	int    $0x41
 64f:	c3                   	ret    

00000650 <ls_call13>:
SYSCALL1(ls_call13)
 650:	b8 8c 04 00 00       	mov    $0x48c,%eax
 655:	cd 41                	int    $0x41
 657:	c3                   	ret    

00000658 <ls_call14>:
SYSCALL1(ls_call14)
 658:	b8 96 04 00 00       	mov    $0x496,%eax
 65d:	cd 41                	int    $0x41
 65f:	c3                   	ret    

00000660 <ls_call15>:
SYSCALL1(ls_call15)
 660:	b8 a0 04 00 00       	mov    $0x4a0,%eax
 665:	cd 41                	int    $0x41
 667:	c3                   	ret    

00000668 <ls_call16>:
SYSCALL1(ls_call16)
 668:	b8 aa 04 00 00       	mov    $0x4aa,%eax
 66d:	cd 41                	int    $0x41
 66f:	c3                   	ret    

00000670 <ls_call17>:
SYSCALL1(ls_call17)
 670:	b8 b4 04 00 00       	mov    $0x4b4,%eax
 675:	cd 41                	int    $0x41
 677:	c3                   	ret    

00000678 <ls_call18>:
SYSCALL1(ls_call18)
 678:	b8 be 04 00 00       	mov    $0x4be,%eax
 67d:	cd 41                	int    $0x41
 67f:	c3                   	ret    

00000680 <ls_call19>:
SYSCALL1(ls_call19)
 680:	b8 c8 04 00 00       	mov    $0x4c8,%eax
 685:	cd 41                	int    $0x41
 687:	c3                   	ret    

00000688 <ls_call20>:
SYSCALL1(ls_call20)
 688:	b8 d2 04 00 00       	mov    $0x4d2,%eax
 68d:	cd 41                	int    $0x41
 68f:	c3                   	ret    

00000690 <ls_call21>:
SYSCALL1(ls_call21)
 690:	b8 dc 04 00 00       	mov    $0x4dc,%eax
 695:	cd 41                	int    $0x41
 697:	c3                   	ret    

00000698 <ls_call22>:
SYSCALL1(ls_call22)
 698:	b8 e6 04 00 00       	mov    $0x4e6,%eax
 69d:	cd 41                	int    $0x41
 69f:	c3                   	ret    

000006a0 <ls_call23>:
SYSCALL1(ls_call23)
 6a0:	b8 f0 04 00 00       	mov    $0x4f0,%eax
 6a5:	cd 41                	int    $0x41
 6a7:	c3                   	ret    

000006a8 <ls_call24>:
SYSCALL1(ls_call24)
 6a8:	b8 fa 04 00 00       	mov    $0x4fa,%eax
 6ad:	cd 41                	int    $0x41
 6af:	c3                   	ret    

000006b0 <ls_call25>:
SYSCALL1(ls_call25)
 6b0:	b8 04 05 00 00       	mov    $0x504,%eax
 6b5:	cd 41                	int    $0x41
 6b7:	c3                   	ret    

000006b8 <ls_call26>:
SYSCALL1(ls_call26)
 6b8:	b8 0e 05 00 00       	mov    $0x50e,%eax
 6bd:	cd 41                	int    $0x41
 6bf:	c3                   	ret    

000006c0 <ls_call27>:
SYSCALL1(ls_call27)
 6c0:	b8 18 05 00 00       	mov    $0x518,%eax
 6c5:	cd 41                	int    $0x41
 6c7:	c3                   	ret    

000006c8 <ls_call28>:
SYSCALL1(ls_call28)
 6c8:	b8 22 05 00 00       	mov    $0x522,%eax
 6cd:	cd 41                	int    $0x41
 6cf:	c3                   	ret    

000006d0 <ls_call29>:
SYSCALL1(ls_call29)
 6d0:	b8 2c 05 00 00       	mov    $0x52c,%eax
 6d5:	cd 41                	int    $0x41
 6d7:	c3                   	ret    

000006d8 <ls_call30>:
SYSCALL1(ls_call30)
 6d8:	b8 36 05 00 00       	mov    $0x536,%eax
 6dd:	cd 41                	int    $0x41
 6df:	c3                   	ret    

000006e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 28             	sub    $0x28,%esp
 6e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 6ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6f3:	00 
 6f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6fb:	8b 45 08             	mov    0x8(%ebp),%eax
 6fe:	89 04 24             	mov    %eax,(%esp)
 701:	e8 62 fe ff ff       	call   568 <write>
}
 706:	c9                   	leave  
 707:	c3                   	ret    

00000708 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 708:	55                   	push   %ebp
 709:	89 e5                	mov    %esp,%ebp
 70b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 70e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 715:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 719:	74 17                	je     732 <printint+0x2a>
 71b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 71f:	79 11                	jns    732 <printint+0x2a>
    neg = 1;
 721:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 728:	8b 45 0c             	mov    0xc(%ebp),%eax
 72b:	f7 d8                	neg    %eax
 72d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 730:	eb 06                	jmp    738 <printint+0x30>
  } else {
    x = xx;
 732:	8b 45 0c             	mov    0xc(%ebp),%eax
 735:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 738:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 73f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 742:	8b 45 ec             	mov    -0x14(%ebp),%eax
 745:	ba 00 00 00 00       	mov    $0x0,%edx
 74a:	f7 f1                	div    %ecx
 74c:	89 d0                	mov    %edx,%eax
 74e:	0f b6 80 f4 0d 00 00 	movzbl 0xdf4(%eax),%eax
 755:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 758:	8b 55 f4             	mov    -0xc(%ebp),%edx
 75b:	01 ca                	add    %ecx,%edx
 75d:	88 02                	mov    %al,(%edx)
 75f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 763:	8b 55 10             	mov    0x10(%ebp),%edx
 766:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 769:	8b 45 ec             	mov    -0x14(%ebp),%eax
 76c:	ba 00 00 00 00       	mov    $0x0,%edx
 771:	f7 75 d4             	divl   -0x2c(%ebp)
 774:	89 45 ec             	mov    %eax,-0x14(%ebp)
 777:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 77b:	75 c2                	jne    73f <printint+0x37>
  if(neg)
 77d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 781:	74 2e                	je     7b1 <printint+0xa9>
    buf[i++] = '-';
 783:	8d 55 dc             	lea    -0x24(%ebp),%edx
 786:	8b 45 f4             	mov    -0xc(%ebp),%eax
 789:	01 d0                	add    %edx,%eax
 78b:	c6 00 2d             	movb   $0x2d,(%eax)
 78e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 792:	eb 1d                	jmp    7b1 <printint+0xa9>
    putc(fd, buf[i]);
 794:	8d 55 dc             	lea    -0x24(%ebp),%edx
 797:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79a:	01 d0                	add    %edx,%eax
 79c:	0f b6 00             	movzbl (%eax),%eax
 79f:	0f be c0             	movsbl %al,%eax
 7a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 7a6:	8b 45 08             	mov    0x8(%ebp),%eax
 7a9:	89 04 24             	mov    %eax,(%esp)
 7ac:	e8 2f ff ff ff       	call   6e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7b1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 7b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b9:	79 d9                	jns    794 <printint+0x8c>
    putc(fd, buf[i]);
}
 7bb:	c9                   	leave  
 7bc:	c3                   	ret    

000007bd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7bd:	55                   	push   %ebp
 7be:	89 e5                	mov    %esp,%ebp
 7c0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 7c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7ca:	8d 45 0c             	lea    0xc(%ebp),%eax
 7cd:	83 c0 04             	add    $0x4,%eax
 7d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 7d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7da:	e9 7d 01 00 00       	jmp    95c <printf+0x19f>
    c = fmt[i] & 0xff;
 7df:	8b 55 0c             	mov    0xc(%ebp),%edx
 7e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e5:	01 d0                	add    %edx,%eax
 7e7:	0f b6 00             	movzbl (%eax),%eax
 7ea:	0f be c0             	movsbl %al,%eax
 7ed:	25 ff 00 00 00       	and    $0xff,%eax
 7f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7f9:	75 2c                	jne    827 <printf+0x6a>
      if(c == '%'){
 7fb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ff:	75 0c                	jne    80d <printf+0x50>
        state = '%';
 801:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 808:	e9 4b 01 00 00       	jmp    958 <printf+0x19b>
      } else {
        putc(fd, c);
 80d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 810:	0f be c0             	movsbl %al,%eax
 813:	89 44 24 04          	mov    %eax,0x4(%esp)
 817:	8b 45 08             	mov    0x8(%ebp),%eax
 81a:	89 04 24             	mov    %eax,(%esp)
 81d:	e8 be fe ff ff       	call   6e0 <putc>
 822:	e9 31 01 00 00       	jmp    958 <printf+0x19b>
      }
    } else if(state == '%'){
 827:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 82b:	0f 85 27 01 00 00    	jne    958 <printf+0x19b>
      if(c == 'd'){
 831:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 835:	75 2d                	jne    864 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 837:	8b 45 e8             	mov    -0x18(%ebp),%eax
 83a:	8b 00                	mov    (%eax),%eax
 83c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 843:	00 
 844:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 84b:	00 
 84c:	89 44 24 04          	mov    %eax,0x4(%esp)
 850:	8b 45 08             	mov    0x8(%ebp),%eax
 853:	89 04 24             	mov    %eax,(%esp)
 856:	e8 ad fe ff ff       	call   708 <printint>
        ap++;
 85b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 85f:	e9 ed 00 00 00       	jmp    951 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 864:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 868:	74 06                	je     870 <printf+0xb3>
 86a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 86e:	75 2d                	jne    89d <printf+0xe0>
        printint(fd, *ap, 16, 0);
 870:	8b 45 e8             	mov    -0x18(%ebp),%eax
 873:	8b 00                	mov    (%eax),%eax
 875:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 87c:	00 
 87d:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 884:	00 
 885:	89 44 24 04          	mov    %eax,0x4(%esp)
 889:	8b 45 08             	mov    0x8(%ebp),%eax
 88c:	89 04 24             	mov    %eax,(%esp)
 88f:	e8 74 fe ff ff       	call   708 <printint>
        ap++;
 894:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 898:	e9 b4 00 00 00       	jmp    951 <printf+0x194>
      } else if(c == 's'){
 89d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 8a1:	75 46                	jne    8e9 <printf+0x12c>
        s = (char*)*ap;
 8a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8a6:	8b 00                	mov    (%eax),%eax
 8a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 8ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 8af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8b3:	75 27                	jne    8dc <printf+0x11f>
          s = "(null)";
 8b5:	c7 45 f4 b0 0b 00 00 	movl   $0xbb0,-0xc(%ebp)
        while(*s != 0){
 8bc:	eb 1e                	jmp    8dc <printf+0x11f>
          putc(fd, *s);
 8be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c1:	0f b6 00             	movzbl (%eax),%eax
 8c4:	0f be c0             	movsbl %al,%eax
 8c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 8cb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ce:	89 04 24             	mov    %eax,(%esp)
 8d1:	e8 0a fe ff ff       	call   6e0 <putc>
          s++;
 8d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 8da:	eb 01                	jmp    8dd <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8dc:	90                   	nop
 8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e0:	0f b6 00             	movzbl (%eax),%eax
 8e3:	84 c0                	test   %al,%al
 8e5:	75 d7                	jne    8be <printf+0x101>
 8e7:	eb 68                	jmp    951 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8e9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 8ed:	75 1d                	jne    90c <printf+0x14f>
        putc(fd, *ap);
 8ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8f2:	8b 00                	mov    (%eax),%eax
 8f4:	0f be c0             	movsbl %al,%eax
 8f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 8fb:	8b 45 08             	mov    0x8(%ebp),%eax
 8fe:	89 04 24             	mov    %eax,(%esp)
 901:	e8 da fd ff ff       	call   6e0 <putc>
        ap++;
 906:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 90a:	eb 45                	jmp    951 <printf+0x194>
      } else if(c == '%'){
 90c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 910:	75 17                	jne    929 <printf+0x16c>
        putc(fd, c);
 912:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 915:	0f be c0             	movsbl %al,%eax
 918:	89 44 24 04          	mov    %eax,0x4(%esp)
 91c:	8b 45 08             	mov    0x8(%ebp),%eax
 91f:	89 04 24             	mov    %eax,(%esp)
 922:	e8 b9 fd ff ff       	call   6e0 <putc>
 927:	eb 28                	jmp    951 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 929:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 930:	00 
 931:	8b 45 08             	mov    0x8(%ebp),%eax
 934:	89 04 24             	mov    %eax,(%esp)
 937:	e8 a4 fd ff ff       	call   6e0 <putc>
        putc(fd, c);
 93c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 93f:	0f be c0             	movsbl %al,%eax
 942:	89 44 24 04          	mov    %eax,0x4(%esp)
 946:	8b 45 08             	mov    0x8(%ebp),%eax
 949:	89 04 24             	mov    %eax,(%esp)
 94c:	e8 8f fd ff ff       	call   6e0 <putc>
      }
      state = 0;
 951:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 958:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 95c:	8b 55 0c             	mov    0xc(%ebp),%edx
 95f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 962:	01 d0                	add    %edx,%eax
 964:	0f b6 00             	movzbl (%eax),%eax
 967:	84 c0                	test   %al,%al
 969:	0f 85 70 fe ff ff    	jne    7df <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 96f:	c9                   	leave  
 970:	c3                   	ret    
 971:	90                   	nop
 972:	90                   	nop
 973:	90                   	nop

00000974 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 974:	55                   	push   %ebp
 975:	89 e5                	mov    %esp,%ebp
 977:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 97a:	8b 45 08             	mov    0x8(%ebp),%eax
 97d:	83 e8 08             	sub    $0x8,%eax
 980:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 983:	a1 10 0e 00 00       	mov    0xe10,%eax
 988:	89 45 fc             	mov    %eax,-0x4(%ebp)
 98b:	eb 24                	jmp    9b1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 990:	8b 00                	mov    (%eax),%eax
 992:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 995:	77 12                	ja     9a9 <free+0x35>
 997:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 99d:	77 24                	ja     9c3 <free+0x4f>
 99f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a2:	8b 00                	mov    (%eax),%eax
 9a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9a7:	77 1a                	ja     9c3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ac:	8b 00                	mov    (%eax),%eax
 9ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
 9b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9b7:	76 d4                	jbe    98d <free+0x19>
 9b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bc:	8b 00                	mov    (%eax),%eax
 9be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9c1:	76 ca                	jbe    98d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c6:	8b 40 04             	mov    0x4(%eax),%eax
 9c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d3:	01 c2                	add    %eax,%edx
 9d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d8:	8b 00                	mov    (%eax),%eax
 9da:	39 c2                	cmp    %eax,%edx
 9dc:	75 24                	jne    a02 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 9de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9e1:	8b 50 04             	mov    0x4(%eax),%edx
 9e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e7:	8b 00                	mov    (%eax),%eax
 9e9:	8b 40 04             	mov    0x4(%eax),%eax
 9ec:	01 c2                	add    %eax,%edx
 9ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9f1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f7:	8b 00                	mov    (%eax),%eax
 9f9:	8b 10                	mov    (%eax),%edx
 9fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9fe:	89 10                	mov    %edx,(%eax)
 a00:	eb 0a                	jmp    a0c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 a02:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a05:	8b 10                	mov    (%eax),%edx
 a07:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a0a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 a0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a0f:	8b 40 04             	mov    0x4(%eax),%eax
 a12:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a19:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a1c:	01 d0                	add    %edx,%eax
 a1e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a21:	75 20                	jne    a43 <free+0xcf>
    p->s.size += bp->s.size;
 a23:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a26:	8b 50 04             	mov    0x4(%eax),%edx
 a29:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a2c:	8b 40 04             	mov    0x4(%eax),%eax
 a2f:	01 c2                	add    %eax,%edx
 a31:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a34:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a37:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a3a:	8b 10                	mov    (%eax),%edx
 a3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a3f:	89 10                	mov    %edx,(%eax)
 a41:	eb 08                	jmp    a4b <free+0xd7>
  } else
    p->s.ptr = bp;
 a43:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a46:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a49:	89 10                	mov    %edx,(%eax)
  freep = p;
 a4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a4e:	a3 10 0e 00 00       	mov    %eax,0xe10
}
 a53:	c9                   	leave  
 a54:	c3                   	ret    

00000a55 <morecore>:

static Header*
morecore(uint nu)
{
 a55:	55                   	push   %ebp
 a56:	89 e5                	mov    %esp,%ebp
 a58:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a5b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a62:	77 07                	ja     a6b <morecore+0x16>
    nu = 4096;
 a64:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a6b:	8b 45 08             	mov    0x8(%ebp),%eax
 a6e:	c1 e0 03             	shl    $0x3,%eax
 a71:	89 04 24             	mov    %eax,(%esp)
 a74:	e8 57 fb ff ff       	call   5d0 <sbrk>
 a79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a7c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a80:	75 07                	jne    a89 <morecore+0x34>
    return 0;
 a82:	b8 00 00 00 00       	mov    $0x0,%eax
 a87:	eb 22                	jmp    aab <morecore+0x56>
  hp = (Header*)p;
 a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a92:	8b 55 08             	mov    0x8(%ebp),%edx
 a95:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a9b:	83 c0 08             	add    $0x8,%eax
 a9e:	89 04 24             	mov    %eax,(%esp)
 aa1:	e8 ce fe ff ff       	call   974 <free>
  return freep;
 aa6:	a1 10 0e 00 00       	mov    0xe10,%eax
}
 aab:	c9                   	leave  
 aac:	c3                   	ret    

00000aad <malloc>:

void*
malloc(uint nbytes)
{
 aad:	55                   	push   %ebp
 aae:	89 e5                	mov    %esp,%ebp
 ab0:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ab3:	8b 45 08             	mov    0x8(%ebp),%eax
 ab6:	83 c0 07             	add    $0x7,%eax
 ab9:	c1 e8 03             	shr    $0x3,%eax
 abc:	83 c0 01             	add    $0x1,%eax
 abf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 ac2:	a1 10 0e 00 00       	mov    0xe10,%eax
 ac7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 aca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 ace:	75 23                	jne    af3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 ad0:	c7 45 f0 08 0e 00 00 	movl   $0xe08,-0x10(%ebp)
 ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ada:	a3 10 0e 00 00       	mov    %eax,0xe10
 adf:	a1 10 0e 00 00       	mov    0xe10,%eax
 ae4:	a3 08 0e 00 00       	mov    %eax,0xe08
    base.s.size = 0;
 ae9:	c7 05 0c 0e 00 00 00 	movl   $0x0,0xe0c
 af0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af6:	8b 00                	mov    (%eax),%eax
 af8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afe:	8b 40 04             	mov    0x4(%eax),%eax
 b01:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b04:	72 4d                	jb     b53 <malloc+0xa6>
      if(p->s.size == nunits)
 b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b09:	8b 40 04             	mov    0x4(%eax),%eax
 b0c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b0f:	75 0c                	jne    b1d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b14:	8b 10                	mov    (%eax),%edx
 b16:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b19:	89 10                	mov    %edx,(%eax)
 b1b:	eb 26                	jmp    b43 <malloc+0x96>
      else {
        p->s.size -= nunits;
 b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b20:	8b 40 04             	mov    0x4(%eax),%eax
 b23:	89 c2                	mov    %eax,%edx
 b25:	2b 55 ec             	sub    -0x14(%ebp),%edx
 b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b31:	8b 40 04             	mov    0x4(%eax),%eax
 b34:	c1 e0 03             	shl    $0x3,%eax
 b37:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b3d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b40:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b46:	a3 10 0e 00 00       	mov    %eax,0xe10
      return (void*)(p + 1);
 b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4e:	83 c0 08             	add    $0x8,%eax
 b51:	eb 38                	jmp    b8b <malloc+0xde>
    }
    if(p == freep)
 b53:	a1 10 0e 00 00       	mov    0xe10,%eax
 b58:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b5b:	75 1b                	jne    b78 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 b5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b60:	89 04 24             	mov    %eax,(%esp)
 b63:	e8 ed fe ff ff       	call   a55 <morecore>
 b68:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b6f:	75 07                	jne    b78 <malloc+0xcb>
        return 0;
 b71:	b8 00 00 00 00       	mov    $0x0,%eax
 b76:	eb 13                	jmp    b8b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b81:	8b 00                	mov    (%eax),%eax
 b83:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b86:	e9 70 ff ff ff       	jmp    afb <malloc+0x4e>
}
 b8b:	c9                   	leave  
 b8c:	c3                   	ret    
