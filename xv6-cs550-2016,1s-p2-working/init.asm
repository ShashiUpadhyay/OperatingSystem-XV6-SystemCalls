
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10:	00 
  11:	c7 04 24 f0 0a 00 00 	movl   $0xaf0,(%esp)
  18:	e8 cb 04 00 00       	call   4e8 <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 f0 0a 00 00 	movl   $0xaf0,(%esp)
  38:	e8 b3 04 00 00       	call   4f0 <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 f0 0a 00 00 	movl   $0xaf0,(%esp)
  4c:	e8 97 04 00 00       	call   4e8 <open>
  }
  dup(0);  // stdout
  51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  58:	e8 c3 04 00 00       	call   520 <dup>
  dup(0);  // stderr
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 b7 04 00 00       	call   520 <dup>
  69:	eb 01                	jmp    6c <main+0x6c>
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  }
  6b:	90                   	nop
  }
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
  6c:	c7 44 24 04 f8 0a 00 	movl   $0xaf8,0x4(%esp)
  73:	00 
  74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7b:	e8 9d 06 00 00       	call   71d <printf>
    pid = fork();
  80:	e8 1b 04 00 00       	call   4a0 <fork>
  85:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  89:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  8e:	79 19                	jns    a9 <main+0xa9>
      printf(1, "init: fork failed\n");
  90:	c7 44 24 04 0b 0b 00 	movl   $0xb0b,0x4(%esp)
  97:	00 
  98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9f:	e8 79 06 00 00       	call   71d <printf>
      exit();
  a4:	e8 ff 03 00 00       	call   4a8 <exit>
    }
    if(pid == 0){
  a9:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  ae:	75 41                	jne    f1 <main+0xf1>
      exec("sh", argv);
  b0:	c7 44 24 04 80 0d 00 	movl   $0xd80,0x4(%esp)
  b7:	00 
  b8:	c7 04 24 ed 0a 00 00 	movl   $0xaed,(%esp)
  bf:	e8 1c 04 00 00       	call   4e0 <exec>
      printf(1, "init: exec sh failed\n");
  c4:	c7 44 24 04 1e 0b 00 	movl   $0xb1e,0x4(%esp)
  cb:	00 
  cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d3:	e8 45 06 00 00       	call   71d <printf>
      exit();
  d8:	e8 cb 03 00 00       	call   4a8 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  dd:	c7 44 24 04 34 0b 00 	movl   $0xb34,0x4(%esp)
  e4:	00 
  e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ec:	e8 2c 06 00 00       	call   71d <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  f1:	e8 ba 03 00 00       	call   4b0 <wait>
  f6:	89 44 24 18          	mov    %eax,0x18(%esp)
  fa:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  ff:	0f 88 66 ff ff ff    	js     6b <main+0x6b>
 105:	8b 44 24 18          	mov    0x18(%esp),%eax
 109:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 10d:	75 ce                	jne    dd <main+0xdd>
      printf(1, "zombie!\n");
  }
 10f:	e9 57 ff ff ff       	jmp    6b <main+0x6b>

00000114 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 119:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11c:	8b 55 10             	mov    0x10(%ebp),%edx
 11f:	8b 45 0c             	mov    0xc(%ebp),%eax
 122:	89 cb                	mov    %ecx,%ebx
 124:	89 df                	mov    %ebx,%edi
 126:	89 d1                	mov    %edx,%ecx
 128:	fc                   	cld    
 129:	f3 aa                	rep stos %al,%es:(%edi)
 12b:	89 ca                	mov    %ecx,%edx
 12d:	89 fb                	mov    %edi,%ebx
 12f:	89 5d 08             	mov    %ebx,0x8(%ebp)
 132:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 135:	5b                   	pop    %ebx
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 145:	90                   	nop
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	0f b6 10             	movzbl (%eax),%edx
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	88 10                	mov    %dl,(%eax)
 151:	8b 45 08             	mov    0x8(%ebp),%eax
 154:	0f b6 00             	movzbl (%eax),%eax
 157:	84 c0                	test   %al,%al
 159:	0f 95 c0             	setne  %al
 15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 164:	84 c0                	test   %al,%al
 166:	75 de                	jne    146 <strcpy+0xd>
    ;
  return os;
 168:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16b:	c9                   	leave  
 16c:	c3                   	ret    

0000016d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16d:	55                   	push   %ebp
 16e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 170:	eb 08                	jmp    17a <strcmp+0xd>
    p++, q++;
 172:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 176:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	0f b6 00             	movzbl (%eax),%eax
 180:	84 c0                	test   %al,%al
 182:	74 10                	je     194 <strcmp+0x27>
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 10             	movzbl (%eax),%edx
 18a:	8b 45 0c             	mov    0xc(%ebp),%eax
 18d:	0f b6 00             	movzbl (%eax),%eax
 190:	38 c2                	cmp    %al,%dl
 192:	74 de                	je     172 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	0f b6 00             	movzbl (%eax),%eax
 19a:	0f b6 d0             	movzbl %al,%edx
 19d:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a0:	0f b6 00             	movzbl (%eax),%eax
 1a3:	0f b6 c0             	movzbl %al,%eax
 1a6:	89 d1                	mov    %edx,%ecx
 1a8:	29 c1                	sub    %eax,%ecx
 1aa:	89 c8                	mov    %ecx,%eax
}
 1ac:	5d                   	pop    %ebp
 1ad:	c3                   	ret    

000001ae <strlen>:

uint
strlen(char *s)
{
 1ae:	55                   	push   %ebp
 1af:	89 e5                	mov    %esp,%ebp
 1b1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1bb:	eb 04                	jmp    1c1 <strlen+0x13>
 1bd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	01 d0                	add    %edx,%eax
 1c9:	0f b6 00             	movzbl (%eax),%eax
 1cc:	84 c0                	test   %al,%al
 1ce:	75 ed                	jne    1bd <strlen+0xf>
    ;
  return n;
 1d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d3:	c9                   	leave  
 1d4:	c3                   	ret    

000001d5 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d5:	55                   	push   %ebp
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1db:	8b 45 10             	mov    0x10(%ebp),%eax
 1de:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	89 04 24             	mov    %eax,(%esp)
 1ef:	e8 20 ff ff ff       	call   114 <stosb>
  return dst;
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    

000001f9 <strchr>:

char*
strchr(const char *s, char c)
{
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 04             	sub    $0x4,%esp
 1ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 202:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 205:	eb 14                	jmp    21b <strchr+0x22>
    if(*s == c)
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	0f b6 00             	movzbl (%eax),%eax
 20d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 210:	75 05                	jne    217 <strchr+0x1e>
      return (char*)s;
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	eb 13                	jmp    22a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 217:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21b:	8b 45 08             	mov    0x8(%ebp),%eax
 21e:	0f b6 00             	movzbl (%eax),%eax
 221:	84 c0                	test   %al,%al
 223:	75 e2                	jne    207 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 225:	b8 00 00 00 00       	mov    $0x0,%eax
}
 22a:	c9                   	leave  
 22b:	c3                   	ret    

0000022c <gets>:

char*
gets(char *buf, int max)
{
 22c:	55                   	push   %ebp
 22d:	89 e5                	mov    %esp,%ebp
 22f:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 232:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 239:	eb 46                	jmp    281 <gets+0x55>
    cc = read(0, &c, 1);
 23b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 242:	00 
 243:	8d 45 ef             	lea    -0x11(%ebp),%eax
 246:	89 44 24 04          	mov    %eax,0x4(%esp)
 24a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 251:	e8 6a 02 00 00       	call   4c0 <read>
 256:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 259:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 25d:	7e 2f                	jle    28e <gets+0x62>
      break;
    buf[i++] = c;
 25f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	01 c2                	add    %eax,%edx
 267:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26b:	88 02                	mov    %al,(%edx)
 26d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 271:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 275:	3c 0a                	cmp    $0xa,%al
 277:	74 16                	je     28f <gets+0x63>
 279:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27d:	3c 0d                	cmp    $0xd,%al
 27f:	74 0e                	je     28f <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 281:	8b 45 f4             	mov    -0xc(%ebp),%eax
 284:	83 c0 01             	add    $0x1,%eax
 287:	3b 45 0c             	cmp    0xc(%ebp),%eax
 28a:	7c af                	jl     23b <gets+0xf>
 28c:	eb 01                	jmp    28f <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 28e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 28f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	01 d0                	add    %edx,%eax
 297:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 29d:	c9                   	leave  
 29e:	c3                   	ret    

0000029f <stat>:

int
stat(char *n, struct stat *st)
{
 29f:	55                   	push   %ebp
 2a0:	89 e5                	mov    %esp,%ebp
 2a2:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2ac:	00 
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	89 04 24             	mov    %eax,(%esp)
 2b3:	e8 30 02 00 00       	call   4e8 <open>
 2b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2bf:	79 07                	jns    2c8 <stat+0x29>
    return -1;
 2c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c6:	eb 23                	jmp    2eb <stat+0x4c>
  r = fstat(fd, st);
 2c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d2:	89 04 24             	mov    %eax,(%esp)
 2d5:	e8 26 02 00 00       	call   500 <fstat>
 2da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e0:	89 04 24             	mov    %eax,(%esp)
 2e3:	e8 e8 01 00 00       	call   4d0 <close>
  return r;
 2e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2eb:	c9                   	leave  
 2ec:	c3                   	ret    

000002ed <atoi>:

int
atoi(const char *s)
{
 2ed:	55                   	push   %ebp
 2ee:	89 e5                	mov    %esp,%ebp
 2f0:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fa:	eb 23                	jmp    31f <atoi+0x32>
    n = n*10 + *s++ - '0';
 2fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ff:	89 d0                	mov    %edx,%eax
 301:	c1 e0 02             	shl    $0x2,%eax
 304:	01 d0                	add    %edx,%eax
 306:	01 c0                	add    %eax,%eax
 308:	89 c2                	mov    %eax,%edx
 30a:	8b 45 08             	mov    0x8(%ebp),%eax
 30d:	0f b6 00             	movzbl (%eax),%eax
 310:	0f be c0             	movsbl %al,%eax
 313:	01 d0                	add    %edx,%eax
 315:	83 e8 30             	sub    $0x30,%eax
 318:	89 45 fc             	mov    %eax,-0x4(%ebp)
 31b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	0f b6 00             	movzbl (%eax),%eax
 325:	3c 2f                	cmp    $0x2f,%al
 327:	7e 0a                	jle    333 <atoi+0x46>
 329:	8b 45 08             	mov    0x8(%ebp),%eax
 32c:	0f b6 00             	movzbl (%eax),%eax
 32f:	3c 39                	cmp    $0x39,%al
 331:	7e c9                	jle    2fc <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 333:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 336:	c9                   	leave  
 337:	c3                   	ret    

00000338 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 33e:	8b 45 08             	mov    0x8(%ebp),%eax
 341:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 344:	8b 45 0c             	mov    0xc(%ebp),%eax
 347:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 34a:	eb 13                	jmp    35f <memmove+0x27>
    *dst++ = *src++;
 34c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 34f:	0f b6 10             	movzbl (%eax),%edx
 352:	8b 45 fc             	mov    -0x4(%ebp),%eax
 355:	88 10                	mov    %dl,(%eax)
 357:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 35b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 363:	0f 9f c0             	setg   %al
 366:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 36a:	84 c0                	test   %al,%al
 36c:	75 de                	jne    34c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 36e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 371:	c9                   	leave  
 372:	c3                   	ret    
 373:	90                   	nop

00000374 <SYS_ls_call01>:
 374:	6c                   	insb   (%dx),%es:(%edi)
 375:	73 5f                	jae    3d6 <SYS_ls_call10+0x8>
 377:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 37a:	6c                   	insb   (%dx),%es:(%edi)
 37b:	30 31                	xor    %dh,(%ecx)
	...

0000037e <SYS_ls_call02>:
 37e:	6c                   	insb   (%dx),%es:(%edi)
 37f:	73 5f                	jae    3e0 <SYS_ls_call11+0x8>
 381:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 384:	6c                   	insb   (%dx),%es:(%edi)
 385:	30 32                	xor    %dh,(%edx)
	...

00000388 <SYS_ls_call03>:
 388:	6c                   	insb   (%dx),%es:(%edi)
 389:	73 5f                	jae    3ea <SYS_ls_call12+0x8>
 38b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 38e:	6c                   	insb   (%dx),%es:(%edi)
 38f:	30 33                	xor    %dh,(%ebx)
	...

00000392 <SYS_ls_call04>:
 392:	6c                   	insb   (%dx),%es:(%edi)
 393:	73 5f                	jae    3f4 <SYS_ls_call13+0x8>
 395:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 398:	6c                   	insb   (%dx),%es:(%edi)
 399:	30 34 00             	xor    %dh,(%eax,%eax,1)

0000039c <SYS_ls_call05>:
 39c:	6c                   	insb   (%dx),%es:(%edi)
 39d:	73 5f                	jae    3fe <SYS_ls_call14+0x8>
 39f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a2:	6c                   	insb   (%dx),%es:(%edi)
 3a3:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

000003a6 <SYS_ls_call06>:
 3a6:	6c                   	insb   (%dx),%es:(%edi)
 3a7:	73 5f                	jae    408 <SYS_ls_call15+0x8>
 3a9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ac:	6c                   	insb   (%dx),%es:(%edi)
 3ad:	30 36                	xor    %dh,(%esi)
	...

000003b0 <SYS_ls_call07>:
 3b0:	6c                   	insb   (%dx),%es:(%edi)
 3b1:	73 5f                	jae    412 <SYS_ls_call16+0x8>
 3b3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b6:	6c                   	insb   (%dx),%es:(%edi)
 3b7:	30 37                	xor    %dh,(%edi)
	...

000003ba <SYS_ls_call08>:
 3ba:	6c                   	insb   (%dx),%es:(%edi)
 3bb:	73 5f                	jae    41c <SYS_ls_call17+0x8>
 3bd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c0:	6c                   	insb   (%dx),%es:(%edi)
 3c1:	30 38                	xor    %bh,(%eax)
	...

000003c4 <SYS_ls_call09>:
 3c4:	6c                   	insb   (%dx),%es:(%edi)
 3c5:	73 5f                	jae    426 <SYS_ls_call18+0x8>
 3c7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ca:	6c                   	insb   (%dx),%es:(%edi)
 3cb:	30 39                	xor    %bh,(%ecx)
	...

000003ce <SYS_ls_call10>:
 3ce:	6c                   	insb   (%dx),%es:(%edi)
 3cf:	73 5f                	jae    430 <SYS_ls_call19+0x8>
 3d1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d4:	6c                   	insb   (%dx),%es:(%edi)
 3d5:	31 30                	xor    %esi,(%eax)
	...

000003d8 <SYS_ls_call11>:
 3d8:	6c                   	insb   (%dx),%es:(%edi)
 3d9:	73 5f                	jae    43a <SYS_ls_call20+0x8>
 3db:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3de:	6c                   	insb   (%dx),%es:(%edi)
 3df:	31 31                	xor    %esi,(%ecx)
	...

000003e2 <SYS_ls_call12>:
 3e2:	6c                   	insb   (%dx),%es:(%edi)
 3e3:	73 5f                	jae    444 <SYS_ls_call21+0x8>
 3e5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e8:	6c                   	insb   (%dx),%es:(%edi)
 3e9:	31 32                	xor    %esi,(%edx)
	...

000003ec <SYS_ls_call13>:
 3ec:	6c                   	insb   (%dx),%es:(%edi)
 3ed:	73 5f                	jae    44e <SYS_ls_call22+0x8>
 3ef:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f2:	6c                   	insb   (%dx),%es:(%edi)
 3f3:	31 33                	xor    %esi,(%ebx)
	...

000003f6 <SYS_ls_call14>:
 3f6:	6c                   	insb   (%dx),%es:(%edi)
 3f7:	73 5f                	jae    458 <SYS_ls_call23+0x8>
 3f9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3fc:	6c                   	insb   (%dx),%es:(%edi)
 3fd:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000400 <SYS_ls_call15>:
 400:	6c                   	insb   (%dx),%es:(%edi)
 401:	73 5f                	jae    462 <SYS_ls_call24+0x8>
 403:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 406:	6c                   	insb   (%dx),%es:(%edi)
 407:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

0000040a <SYS_ls_call16>:
 40a:	6c                   	insb   (%dx),%es:(%edi)
 40b:	73 5f                	jae    46c <SYS_ls_call25+0x8>
 40d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 410:	6c                   	insb   (%dx),%es:(%edi)
 411:	31 36                	xor    %esi,(%esi)
	...

00000414 <SYS_ls_call17>:
 414:	6c                   	insb   (%dx),%es:(%edi)
 415:	73 5f                	jae    476 <SYS_ls_call26+0x8>
 417:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 41a:	6c                   	insb   (%dx),%es:(%edi)
 41b:	31 37                	xor    %esi,(%edi)
	...

0000041e <SYS_ls_call18>:
 41e:	6c                   	insb   (%dx),%es:(%edi)
 41f:	73 5f                	jae    480 <SYS_ls_call27+0x8>
 421:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 424:	6c                   	insb   (%dx),%es:(%edi)
 425:	31 38                	xor    %edi,(%eax)
	...

00000428 <SYS_ls_call19>:
 428:	6c                   	insb   (%dx),%es:(%edi)
 429:	73 5f                	jae    48a <SYS_ls_call28+0x8>
 42b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 42e:	6c                   	insb   (%dx),%es:(%edi)
 42f:	31 39                	xor    %edi,(%ecx)
	...

00000432 <SYS_ls_call20>:
 432:	6c                   	insb   (%dx),%es:(%edi)
 433:	73 5f                	jae    494 <SYS_ls_call29+0x8>
 435:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 438:	6c                   	insb   (%dx),%es:(%edi)
 439:	32 30                	xor    (%eax),%dh
	...

0000043c <SYS_ls_call21>:
 43c:	6c                   	insb   (%dx),%es:(%edi)
 43d:	73 5f                	jae    49e <SYS_ls_call30+0x8>
 43f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 442:	6c                   	insb   (%dx),%es:(%edi)
 443:	32 31                	xor    (%ecx),%dh
	...

00000446 <SYS_ls_call22>:
 446:	6c                   	insb   (%dx),%es:(%edi)
 447:	73 5f                	jae    4a8 <exit>
 449:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 44c:	6c                   	insb   (%dx),%es:(%edi)
 44d:	32 32                	xor    (%edx),%dh
	...

00000450 <SYS_ls_call23>:
 450:	6c                   	insb   (%dx),%es:(%edi)
 451:	73 5f                	jae    4b2 <wait+0x2>
 453:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 456:	6c                   	insb   (%dx),%es:(%edi)
 457:	32 33                	xor    (%ebx),%dh
	...

0000045a <SYS_ls_call24>:
 45a:	6c                   	insb   (%dx),%es:(%edi)
 45b:	73 5f                	jae    4bc <pipe+0x4>
 45d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 460:	6c                   	insb   (%dx),%es:(%edi)
 461:	32 34 00             	xor    (%eax,%eax,1),%dh

00000464 <SYS_ls_call25>:
 464:	6c                   	insb   (%dx),%es:(%edi)
 465:	73 5f                	jae    4c6 <read+0x6>
 467:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 46a:	6c                   	insb   (%dx),%es:(%edi)
 46b:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

0000046e <SYS_ls_call26>:
 46e:	6c                   	insb   (%dx),%es:(%edi)
 46f:	73 5f                	jae    4d0 <close>
 471:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 474:	6c                   	insb   (%dx),%es:(%edi)
 475:	32 36                	xor    (%esi),%dh
	...

00000478 <SYS_ls_call27>:
 478:	6c                   	insb   (%dx),%es:(%edi)
 479:	73 5f                	jae    4da <kill+0x2>
 47b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 47e:	6c                   	insb   (%dx),%es:(%edi)
 47f:	32 37                	xor    (%edi),%dh
	...

00000482 <SYS_ls_call28>:
 482:	6c                   	insb   (%dx),%es:(%edi)
 483:	73 5f                	jae    4e4 <exec+0x4>
 485:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 488:	6c                   	insb   (%dx),%es:(%edi)
 489:	32 38                	xor    (%eax),%bh
	...

0000048c <SYS_ls_call29>:
 48c:	6c                   	insb   (%dx),%es:(%edi)
 48d:	73 5f                	jae    4ee <open+0x6>
 48f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 492:	6c                   	insb   (%dx),%es:(%edi)
 493:	32 39                	xor    (%ecx),%bh
	...

00000496 <SYS_ls_call30>:
 496:	6c                   	insb   (%dx),%es:(%edi)
 497:	73 5f                	jae    4f8 <unlink>
 499:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 49c:	6c                   	insb   (%dx),%es:(%edi)
 49d:	33 30                	xor    (%eax),%esi
	...

000004a0 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 4a0:	b8 01 00 00 00       	mov    $0x1,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <exit>:
SYSCALL(exit)
 4a8:	b8 02 00 00 00       	mov    $0x2,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <wait>:
SYSCALL(wait)
 4b0:	b8 03 00 00 00       	mov    $0x3,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <pipe>:
SYSCALL(pipe)
 4b8:	b8 04 00 00 00       	mov    $0x4,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <read>:
SYSCALL(read)
 4c0:	b8 05 00 00 00       	mov    $0x5,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <write>:
SYSCALL(write)
 4c8:	b8 10 00 00 00       	mov    $0x10,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <close>:
SYSCALL(close)
 4d0:	b8 15 00 00 00       	mov    $0x15,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <kill>:
SYSCALL(kill)
 4d8:	b8 06 00 00 00       	mov    $0x6,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <exec>:
SYSCALL(exec)
 4e0:	b8 07 00 00 00       	mov    $0x7,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <open>:
SYSCALL(open)
 4e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <mknod>:
SYSCALL(mknod)
 4f0:	b8 11 00 00 00       	mov    $0x11,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <unlink>:
SYSCALL(unlink)
 4f8:	b8 12 00 00 00       	mov    $0x12,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <fstat>:
SYSCALL(fstat)
 500:	b8 08 00 00 00       	mov    $0x8,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <link>:
SYSCALL(link)
 508:	b8 13 00 00 00       	mov    $0x13,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <mkdir>:
SYSCALL(mkdir)
 510:	b8 14 00 00 00       	mov    $0x14,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <chdir>:
SYSCALL(chdir)
 518:	b8 09 00 00 00       	mov    $0x9,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <dup>:
SYSCALL(dup)
 520:	b8 0a 00 00 00       	mov    $0xa,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <getpid>:
SYSCALL(getpid)
 528:	b8 0b 00 00 00       	mov    $0xb,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <sbrk>:
SYSCALL(sbrk)
 530:	b8 0c 00 00 00       	mov    $0xc,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <sleep>:
SYSCALL(sleep)
 538:	b8 0d 00 00 00       	mov    $0xd,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <uptime>:
SYSCALL(uptime)
 540:	b8 0e 00 00 00       	mov    $0xe,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <date>:
SYSCALL(date)
 548:	b8 16 00 00 00       	mov    $0x16,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <ls_call01>:

SYSCALL1(ls_call01)
 550:	b8 74 03 00 00       	mov    $0x374,%eax
 555:	cd 41                	int    $0x41
 557:	c3                   	ret    

00000558 <ls_call02>:
SYSCALL1(ls_call02)
 558:	b8 7e 03 00 00       	mov    $0x37e,%eax
 55d:	cd 41                	int    $0x41
 55f:	c3                   	ret    

00000560 <ls_call03>:
SYSCALL1(ls_call03)
 560:	b8 88 03 00 00       	mov    $0x388,%eax
 565:	cd 41                	int    $0x41
 567:	c3                   	ret    

00000568 <ls_call04>:
SYSCALL1(ls_call04)
 568:	b8 92 03 00 00       	mov    $0x392,%eax
 56d:	cd 41                	int    $0x41
 56f:	c3                   	ret    

00000570 <ls_call05>:
SYSCALL1(ls_call05)
 570:	b8 9c 03 00 00       	mov    $0x39c,%eax
 575:	cd 41                	int    $0x41
 577:	c3                   	ret    

00000578 <ls_call06>:
SYSCALL1(ls_call06)
 578:	b8 a6 03 00 00       	mov    $0x3a6,%eax
 57d:	cd 41                	int    $0x41
 57f:	c3                   	ret    

00000580 <ls_call07>:
SYSCALL1(ls_call07)
 580:	b8 b0 03 00 00       	mov    $0x3b0,%eax
 585:	cd 41                	int    $0x41
 587:	c3                   	ret    

00000588 <ls_call08>:
SYSCALL1(ls_call08)
 588:	b8 ba 03 00 00       	mov    $0x3ba,%eax
 58d:	cd 41                	int    $0x41
 58f:	c3                   	ret    

00000590 <ls_call09>:
SYSCALL1(ls_call09)
 590:	b8 c4 03 00 00       	mov    $0x3c4,%eax
 595:	cd 41                	int    $0x41
 597:	c3                   	ret    

00000598 <ls_call10>:
SYSCALL1(ls_call10)
 598:	b8 ce 03 00 00       	mov    $0x3ce,%eax
 59d:	cd 41                	int    $0x41
 59f:	c3                   	ret    

000005a0 <ls_call11>:
SYSCALL1(ls_call11)
 5a0:	b8 d8 03 00 00       	mov    $0x3d8,%eax
 5a5:	cd 41                	int    $0x41
 5a7:	c3                   	ret    

000005a8 <ls_call12>:
SYSCALL1(ls_call12)
 5a8:	b8 e2 03 00 00       	mov    $0x3e2,%eax
 5ad:	cd 41                	int    $0x41
 5af:	c3                   	ret    

000005b0 <ls_call13>:
SYSCALL1(ls_call13)
 5b0:	b8 ec 03 00 00       	mov    $0x3ec,%eax
 5b5:	cd 41                	int    $0x41
 5b7:	c3                   	ret    

000005b8 <ls_call14>:
SYSCALL1(ls_call14)
 5b8:	b8 f6 03 00 00       	mov    $0x3f6,%eax
 5bd:	cd 41                	int    $0x41
 5bf:	c3                   	ret    

000005c0 <ls_call15>:
SYSCALL1(ls_call15)
 5c0:	b8 00 04 00 00       	mov    $0x400,%eax
 5c5:	cd 41                	int    $0x41
 5c7:	c3                   	ret    

000005c8 <ls_call16>:
SYSCALL1(ls_call16)
 5c8:	b8 0a 04 00 00       	mov    $0x40a,%eax
 5cd:	cd 41                	int    $0x41
 5cf:	c3                   	ret    

000005d0 <ls_call17>:
SYSCALL1(ls_call17)
 5d0:	b8 14 04 00 00       	mov    $0x414,%eax
 5d5:	cd 41                	int    $0x41
 5d7:	c3                   	ret    

000005d8 <ls_call18>:
SYSCALL1(ls_call18)
 5d8:	b8 1e 04 00 00       	mov    $0x41e,%eax
 5dd:	cd 41                	int    $0x41
 5df:	c3                   	ret    

000005e0 <ls_call19>:
SYSCALL1(ls_call19)
 5e0:	b8 28 04 00 00       	mov    $0x428,%eax
 5e5:	cd 41                	int    $0x41
 5e7:	c3                   	ret    

000005e8 <ls_call20>:
SYSCALL1(ls_call20)
 5e8:	b8 32 04 00 00       	mov    $0x432,%eax
 5ed:	cd 41                	int    $0x41
 5ef:	c3                   	ret    

000005f0 <ls_call21>:
SYSCALL1(ls_call21)
 5f0:	b8 3c 04 00 00       	mov    $0x43c,%eax
 5f5:	cd 41                	int    $0x41
 5f7:	c3                   	ret    

000005f8 <ls_call22>:
SYSCALL1(ls_call22)
 5f8:	b8 46 04 00 00       	mov    $0x446,%eax
 5fd:	cd 41                	int    $0x41
 5ff:	c3                   	ret    

00000600 <ls_call23>:
SYSCALL1(ls_call23)
 600:	b8 50 04 00 00       	mov    $0x450,%eax
 605:	cd 41                	int    $0x41
 607:	c3                   	ret    

00000608 <ls_call24>:
SYSCALL1(ls_call24)
 608:	b8 5a 04 00 00       	mov    $0x45a,%eax
 60d:	cd 41                	int    $0x41
 60f:	c3                   	ret    

00000610 <ls_call25>:
SYSCALL1(ls_call25)
 610:	b8 64 04 00 00       	mov    $0x464,%eax
 615:	cd 41                	int    $0x41
 617:	c3                   	ret    

00000618 <ls_call26>:
SYSCALL1(ls_call26)
 618:	b8 6e 04 00 00       	mov    $0x46e,%eax
 61d:	cd 41                	int    $0x41
 61f:	c3                   	ret    

00000620 <ls_call27>:
SYSCALL1(ls_call27)
 620:	b8 78 04 00 00       	mov    $0x478,%eax
 625:	cd 41                	int    $0x41
 627:	c3                   	ret    

00000628 <ls_call28>:
SYSCALL1(ls_call28)
 628:	b8 82 04 00 00       	mov    $0x482,%eax
 62d:	cd 41                	int    $0x41
 62f:	c3                   	ret    

00000630 <ls_call29>:
SYSCALL1(ls_call29)
 630:	b8 8c 04 00 00       	mov    $0x48c,%eax
 635:	cd 41                	int    $0x41
 637:	c3                   	ret    

00000638 <ls_call30>:
SYSCALL1(ls_call30)
 638:	b8 96 04 00 00       	mov    $0x496,%eax
 63d:	cd 41                	int    $0x41
 63f:	c3                   	ret    

00000640 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	83 ec 28             	sub    $0x28,%esp
 646:	8b 45 0c             	mov    0xc(%ebp),%eax
 649:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 64c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 653:	00 
 654:	8d 45 f4             	lea    -0xc(%ebp),%eax
 657:	89 44 24 04          	mov    %eax,0x4(%esp)
 65b:	8b 45 08             	mov    0x8(%ebp),%eax
 65e:	89 04 24             	mov    %eax,(%esp)
 661:	e8 62 fe ff ff       	call   4c8 <write>
}
 666:	c9                   	leave  
 667:	c3                   	ret    

00000668 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 668:	55                   	push   %ebp
 669:	89 e5                	mov    %esp,%ebp
 66b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 66e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 675:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 679:	74 17                	je     692 <printint+0x2a>
 67b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 67f:	79 11                	jns    692 <printint+0x2a>
    neg = 1;
 681:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 688:	8b 45 0c             	mov    0xc(%ebp),%eax
 68b:	f7 d8                	neg    %eax
 68d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 690:	eb 06                	jmp    698 <printint+0x30>
  } else {
    x = xx;
 692:	8b 45 0c             	mov    0xc(%ebp),%eax
 695:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 698:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 69f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6a5:	ba 00 00 00 00       	mov    $0x0,%edx
 6aa:	f7 f1                	div    %ecx
 6ac:	89 d0                	mov    %edx,%eax
 6ae:	0f b6 80 88 0d 00 00 	movzbl 0xd88(%eax),%eax
 6b5:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 6b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6bb:	01 ca                	add    %ecx,%edx
 6bd:	88 02                	mov    %al,(%edx)
 6bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 6c3:	8b 55 10             	mov    0x10(%ebp),%edx
 6c6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 6c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6cc:	ba 00 00 00 00       	mov    $0x0,%edx
 6d1:	f7 75 d4             	divl   -0x2c(%ebp)
 6d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6db:	75 c2                	jne    69f <printint+0x37>
  if(neg)
 6dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6e1:	74 2e                	je     711 <printint+0xa9>
    buf[i++] = '-';
 6e3:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e9:	01 d0                	add    %edx,%eax
 6eb:	c6 00 2d             	movb   $0x2d,(%eax)
 6ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 6f2:	eb 1d                	jmp    711 <printint+0xa9>
    putc(fd, buf[i]);
 6f4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fa:	01 d0                	add    %edx,%eax
 6fc:	0f b6 00             	movzbl (%eax),%eax
 6ff:	0f be c0             	movsbl %al,%eax
 702:	89 44 24 04          	mov    %eax,0x4(%esp)
 706:	8b 45 08             	mov    0x8(%ebp),%eax
 709:	89 04 24             	mov    %eax,(%esp)
 70c:	e8 2f ff ff ff       	call   640 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 711:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 715:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 719:	79 d9                	jns    6f4 <printint+0x8c>
    putc(fd, buf[i]);
}
 71b:	c9                   	leave  
 71c:	c3                   	ret    

0000071d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 71d:	55                   	push   %ebp
 71e:	89 e5                	mov    %esp,%ebp
 720:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 723:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 72a:	8d 45 0c             	lea    0xc(%ebp),%eax
 72d:	83 c0 04             	add    $0x4,%eax
 730:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 733:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 73a:	e9 7d 01 00 00       	jmp    8bc <printf+0x19f>
    c = fmt[i] & 0xff;
 73f:	8b 55 0c             	mov    0xc(%ebp),%edx
 742:	8b 45 f0             	mov    -0x10(%ebp),%eax
 745:	01 d0                	add    %edx,%eax
 747:	0f b6 00             	movzbl (%eax),%eax
 74a:	0f be c0             	movsbl %al,%eax
 74d:	25 ff 00 00 00       	and    $0xff,%eax
 752:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 755:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 759:	75 2c                	jne    787 <printf+0x6a>
      if(c == '%'){
 75b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 75f:	75 0c                	jne    76d <printf+0x50>
        state = '%';
 761:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 768:	e9 4b 01 00 00       	jmp    8b8 <printf+0x19b>
      } else {
        putc(fd, c);
 76d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 770:	0f be c0             	movsbl %al,%eax
 773:	89 44 24 04          	mov    %eax,0x4(%esp)
 777:	8b 45 08             	mov    0x8(%ebp),%eax
 77a:	89 04 24             	mov    %eax,(%esp)
 77d:	e8 be fe ff ff       	call   640 <putc>
 782:	e9 31 01 00 00       	jmp    8b8 <printf+0x19b>
      }
    } else if(state == '%'){
 787:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 78b:	0f 85 27 01 00 00    	jne    8b8 <printf+0x19b>
      if(c == 'd'){
 791:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 795:	75 2d                	jne    7c4 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 797:	8b 45 e8             	mov    -0x18(%ebp),%eax
 79a:	8b 00                	mov    (%eax),%eax
 79c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7a3:	00 
 7a4:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7ab:	00 
 7ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b0:	8b 45 08             	mov    0x8(%ebp),%eax
 7b3:	89 04 24             	mov    %eax,(%esp)
 7b6:	e8 ad fe ff ff       	call   668 <printint>
        ap++;
 7bb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7bf:	e9 ed 00 00 00       	jmp    8b1 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 7c4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7c8:	74 06                	je     7d0 <printf+0xb3>
 7ca:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7ce:	75 2d                	jne    7fd <printf+0xe0>
        printint(fd, *ap, 16, 0);
 7d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7d3:	8b 00                	mov    (%eax),%eax
 7d5:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 7dc:	00 
 7dd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 7e4:	00 
 7e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ec:	89 04 24             	mov    %eax,(%esp)
 7ef:	e8 74 fe ff ff       	call   668 <printint>
        ap++;
 7f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f8:	e9 b4 00 00 00       	jmp    8b1 <printf+0x194>
      } else if(c == 's'){
 7fd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 801:	75 46                	jne    849 <printf+0x12c>
        s = (char*)*ap;
 803:	8b 45 e8             	mov    -0x18(%ebp),%eax
 806:	8b 00                	mov    (%eax),%eax
 808:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 80b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 80f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 813:	75 27                	jne    83c <printf+0x11f>
          s = "(null)";
 815:	c7 45 f4 3d 0b 00 00 	movl   $0xb3d,-0xc(%ebp)
        while(*s != 0){
 81c:	eb 1e                	jmp    83c <printf+0x11f>
          putc(fd, *s);
 81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 821:	0f b6 00             	movzbl (%eax),%eax
 824:	0f be c0             	movsbl %al,%eax
 827:	89 44 24 04          	mov    %eax,0x4(%esp)
 82b:	8b 45 08             	mov    0x8(%ebp),%eax
 82e:	89 04 24             	mov    %eax,(%esp)
 831:	e8 0a fe ff ff       	call   640 <putc>
          s++;
 836:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 83a:	eb 01                	jmp    83d <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 83c:	90                   	nop
 83d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 840:	0f b6 00             	movzbl (%eax),%eax
 843:	84 c0                	test   %al,%al
 845:	75 d7                	jne    81e <printf+0x101>
 847:	eb 68                	jmp    8b1 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 849:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 84d:	75 1d                	jne    86c <printf+0x14f>
        putc(fd, *ap);
 84f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 852:	8b 00                	mov    (%eax),%eax
 854:	0f be c0             	movsbl %al,%eax
 857:	89 44 24 04          	mov    %eax,0x4(%esp)
 85b:	8b 45 08             	mov    0x8(%ebp),%eax
 85e:	89 04 24             	mov    %eax,(%esp)
 861:	e8 da fd ff ff       	call   640 <putc>
        ap++;
 866:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 86a:	eb 45                	jmp    8b1 <printf+0x194>
      } else if(c == '%'){
 86c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 870:	75 17                	jne    889 <printf+0x16c>
        putc(fd, c);
 872:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 875:	0f be c0             	movsbl %al,%eax
 878:	89 44 24 04          	mov    %eax,0x4(%esp)
 87c:	8b 45 08             	mov    0x8(%ebp),%eax
 87f:	89 04 24             	mov    %eax,(%esp)
 882:	e8 b9 fd ff ff       	call   640 <putc>
 887:	eb 28                	jmp    8b1 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 889:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 890:	00 
 891:	8b 45 08             	mov    0x8(%ebp),%eax
 894:	89 04 24             	mov    %eax,(%esp)
 897:	e8 a4 fd ff ff       	call   640 <putc>
        putc(fd, c);
 89c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 89f:	0f be c0             	movsbl %al,%eax
 8a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a6:	8b 45 08             	mov    0x8(%ebp),%eax
 8a9:	89 04 24             	mov    %eax,(%esp)
 8ac:	e8 8f fd ff ff       	call   640 <putc>
      }
      state = 0;
 8b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8b8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8bc:	8b 55 0c             	mov    0xc(%ebp),%edx
 8bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c2:	01 d0                	add    %edx,%eax
 8c4:	0f b6 00             	movzbl (%eax),%eax
 8c7:	84 c0                	test   %al,%al
 8c9:	0f 85 70 fe ff ff    	jne    73f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8cf:	c9                   	leave  
 8d0:	c3                   	ret    
 8d1:	90                   	nop
 8d2:	90                   	nop
 8d3:	90                   	nop

000008d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d4:	55                   	push   %ebp
 8d5:	89 e5                	mov    %esp,%ebp
 8d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8da:	8b 45 08             	mov    0x8(%ebp),%eax
 8dd:	83 e8 08             	sub    $0x8,%eax
 8e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e3:	a1 a4 0d 00 00       	mov    0xda4,%eax
 8e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8eb:	eb 24                	jmp    911 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f0:	8b 00                	mov    (%eax),%eax
 8f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8f5:	77 12                	ja     909 <free+0x35>
 8f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8fd:	77 24                	ja     923 <free+0x4f>
 8ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 902:	8b 00                	mov    (%eax),%eax
 904:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 907:	77 1a                	ja     923 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 909:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90c:	8b 00                	mov    (%eax),%eax
 90e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 911:	8b 45 f8             	mov    -0x8(%ebp),%eax
 914:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 917:	76 d4                	jbe    8ed <free+0x19>
 919:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91c:	8b 00                	mov    (%eax),%eax
 91e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 921:	76 ca                	jbe    8ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 923:	8b 45 f8             	mov    -0x8(%ebp),%eax
 926:	8b 40 04             	mov    0x4(%eax),%eax
 929:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 930:	8b 45 f8             	mov    -0x8(%ebp),%eax
 933:	01 c2                	add    %eax,%edx
 935:	8b 45 fc             	mov    -0x4(%ebp),%eax
 938:	8b 00                	mov    (%eax),%eax
 93a:	39 c2                	cmp    %eax,%edx
 93c:	75 24                	jne    962 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 93e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 941:	8b 50 04             	mov    0x4(%eax),%edx
 944:	8b 45 fc             	mov    -0x4(%ebp),%eax
 947:	8b 00                	mov    (%eax),%eax
 949:	8b 40 04             	mov    0x4(%eax),%eax
 94c:	01 c2                	add    %eax,%edx
 94e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 951:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 954:	8b 45 fc             	mov    -0x4(%ebp),%eax
 957:	8b 00                	mov    (%eax),%eax
 959:	8b 10                	mov    (%eax),%edx
 95b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95e:	89 10                	mov    %edx,(%eax)
 960:	eb 0a                	jmp    96c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 962:	8b 45 fc             	mov    -0x4(%ebp),%eax
 965:	8b 10                	mov    (%eax),%edx
 967:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 96c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 96f:	8b 40 04             	mov    0x4(%eax),%eax
 972:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 979:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97c:	01 d0                	add    %edx,%eax
 97e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 981:	75 20                	jne    9a3 <free+0xcf>
    p->s.size += bp->s.size;
 983:	8b 45 fc             	mov    -0x4(%ebp),%eax
 986:	8b 50 04             	mov    0x4(%eax),%edx
 989:	8b 45 f8             	mov    -0x8(%ebp),%eax
 98c:	8b 40 04             	mov    0x4(%eax),%eax
 98f:	01 c2                	add    %eax,%edx
 991:	8b 45 fc             	mov    -0x4(%ebp),%eax
 994:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 997:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99a:	8b 10                	mov    (%eax),%edx
 99c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 99f:	89 10                	mov    %edx,(%eax)
 9a1:	eb 08                	jmp    9ab <free+0xd7>
  } else
    p->s.ptr = bp;
 9a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9a9:	89 10                	mov    %edx,(%eax)
  freep = p;
 9ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ae:	a3 a4 0d 00 00       	mov    %eax,0xda4
}
 9b3:	c9                   	leave  
 9b4:	c3                   	ret    

000009b5 <morecore>:

static Header*
morecore(uint nu)
{
 9b5:	55                   	push   %ebp
 9b6:	89 e5                	mov    %esp,%ebp
 9b8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9bb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9c2:	77 07                	ja     9cb <morecore+0x16>
    nu = 4096;
 9c4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9cb:	8b 45 08             	mov    0x8(%ebp),%eax
 9ce:	c1 e0 03             	shl    $0x3,%eax
 9d1:	89 04 24             	mov    %eax,(%esp)
 9d4:	e8 57 fb ff ff       	call   530 <sbrk>
 9d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9dc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9e0:	75 07                	jne    9e9 <morecore+0x34>
    return 0;
 9e2:	b8 00 00 00 00       	mov    $0x0,%eax
 9e7:	eb 22                	jmp    a0b <morecore+0x56>
  hp = (Header*)p;
 9e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f2:	8b 55 08             	mov    0x8(%ebp),%edx
 9f5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9fb:	83 c0 08             	add    $0x8,%eax
 9fe:	89 04 24             	mov    %eax,(%esp)
 a01:	e8 ce fe ff ff       	call   8d4 <free>
  return freep;
 a06:	a1 a4 0d 00 00       	mov    0xda4,%eax
}
 a0b:	c9                   	leave  
 a0c:	c3                   	ret    

00000a0d <malloc>:

void*
malloc(uint nbytes)
{
 a0d:	55                   	push   %ebp
 a0e:	89 e5                	mov    %esp,%ebp
 a10:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a13:	8b 45 08             	mov    0x8(%ebp),%eax
 a16:	83 c0 07             	add    $0x7,%eax
 a19:	c1 e8 03             	shr    $0x3,%eax
 a1c:	83 c0 01             	add    $0x1,%eax
 a1f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a22:	a1 a4 0d 00 00       	mov    0xda4,%eax
 a27:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a2a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a2e:	75 23                	jne    a53 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a30:	c7 45 f0 9c 0d 00 00 	movl   $0xd9c,-0x10(%ebp)
 a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a3a:	a3 a4 0d 00 00       	mov    %eax,0xda4
 a3f:	a1 a4 0d 00 00       	mov    0xda4,%eax
 a44:	a3 9c 0d 00 00       	mov    %eax,0xd9c
    base.s.size = 0;
 a49:	c7 05 a0 0d 00 00 00 	movl   $0x0,0xda0
 a50:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a53:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a56:	8b 00                	mov    (%eax),%eax
 a58:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5e:	8b 40 04             	mov    0x4(%eax),%eax
 a61:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a64:	72 4d                	jb     ab3 <malloc+0xa6>
      if(p->s.size == nunits)
 a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a69:	8b 40 04             	mov    0x4(%eax),%eax
 a6c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a6f:	75 0c                	jne    a7d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a74:	8b 10                	mov    (%eax),%edx
 a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a79:	89 10                	mov    %edx,(%eax)
 a7b:	eb 26                	jmp    aa3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a80:	8b 40 04             	mov    0x4(%eax),%eax
 a83:	89 c2                	mov    %eax,%edx
 a85:	2b 55 ec             	sub    -0x14(%ebp),%edx
 a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a91:	8b 40 04             	mov    0x4(%eax),%eax
 a94:	c1 e0 03             	shl    $0x3,%eax
 a97:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a9d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aa0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa6:	a3 a4 0d 00 00       	mov    %eax,0xda4
      return (void*)(p + 1);
 aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aae:	83 c0 08             	add    $0x8,%eax
 ab1:	eb 38                	jmp    aeb <malloc+0xde>
    }
    if(p == freep)
 ab3:	a1 a4 0d 00 00       	mov    0xda4,%eax
 ab8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 abb:	75 1b                	jne    ad8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 abd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ac0:	89 04 24             	mov    %eax,(%esp)
 ac3:	e8 ed fe ff ff       	call   9b5 <morecore>
 ac8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 acb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 acf:	75 07                	jne    ad8 <malloc+0xcb>
        return 0;
 ad1:	b8 00 00 00 00       	mov    $0x0,%eax
 ad6:	eb 13                	jmp    aeb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae1:	8b 00                	mov    (%eax),%eax
 ae3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 ae6:	e9 70 ff ff ff       	jmp    a5b <malloc+0x4e>
}
 aeb:	c9                   	leave  
 aec:	c3                   	ret    
