
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 a2 03 00 00       	call   3b0 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 2a 04 00 00       	call   448 <sleep>
  exit();
  1e:	e8 95 03 00 00       	call   3b8 <exit>
  23:	90                   	nop

00000024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	57                   	push   %edi
  28:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2c:	8b 55 10             	mov    0x10(%ebp),%edx
  2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  32:	89 cb                	mov    %ecx,%ebx
  34:	89 df                	mov    %ebx,%edi
  36:	89 d1                	mov    %edx,%ecx
  38:	fc                   	cld    
  39:	f3 aa                	rep stos %al,%es:(%edi)
  3b:	89 ca                	mov    %ecx,%edx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  42:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  45:	5b                   	pop    %ebx
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4f:	8b 45 08             	mov    0x8(%ebp),%eax
  52:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  55:	90                   	nop
  56:	8b 45 0c             	mov    0xc(%ebp),%eax
  59:	0f b6 10             	movzbl (%eax),%edx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	88 10                	mov    %dl,(%eax)
  61:	8b 45 08             	mov    0x8(%ebp),%eax
  64:	0f b6 00             	movzbl (%eax),%eax
  67:	84 c0                	test   %al,%al
  69:	0f 95 c0             	setne  %al
  6c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  70:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  74:	84 c0                	test   %al,%al
  76:	75 de                	jne    56 <strcpy+0xd>
    ;
  return os;
  78:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7b:	c9                   	leave  
  7c:	c3                   	ret    

0000007d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7d:	55                   	push   %ebp
  7e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  80:	eb 08                	jmp    8a <strcmp+0xd>
    p++, q++;
  82:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  86:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8a:	8b 45 08             	mov    0x8(%ebp),%eax
  8d:	0f b6 00             	movzbl (%eax),%eax
  90:	84 c0                	test   %al,%al
  92:	74 10                	je     a4 <strcmp+0x27>
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	0f b6 10             	movzbl (%eax),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 00             	movzbl (%eax),%eax
  a0:	38 c2                	cmp    %al,%dl
  a2:	74 de                	je     82 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	0f b6 00             	movzbl (%eax),%eax
  aa:	0f b6 d0             	movzbl %al,%edx
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	0f b6 c0             	movzbl %al,%eax
  b6:	89 d1                	mov    %edx,%ecx
  b8:	29 c1                	sub    %eax,%ecx
  ba:	89 c8                	mov    %ecx,%eax
}
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    

000000be <strlen>:

uint
strlen(char *s)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cb:	eb 04                	jmp    d1 <strlen+0x13>
  cd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	01 d0                	add    %edx,%eax
  d9:	0f b6 00             	movzbl (%eax),%eax
  dc:	84 c0                	test   %al,%al
  de:	75 ed                	jne    cd <strlen+0xf>
    ;
  return n;
  e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e3:	c9                   	leave  
  e4:	c3                   	ret    

000000e5 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e5:	55                   	push   %ebp
  e6:	89 e5                	mov    %esp,%ebp
  e8:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  eb:	8b 45 10             	mov    0x10(%ebp),%eax
  ee:	89 44 24 08          	mov    %eax,0x8(%esp)
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  f9:	8b 45 08             	mov    0x8(%ebp),%eax
  fc:	89 04 24             	mov    %eax,(%esp)
  ff:	e8 20 ff ff ff       	call   24 <stosb>
  return dst;
 104:	8b 45 08             	mov    0x8(%ebp),%eax
}
 107:	c9                   	leave  
 108:	c3                   	ret    

00000109 <strchr>:

char*
strchr(const char *s, char c)
{
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	83 ec 04             	sub    $0x4,%esp
 10f:	8b 45 0c             	mov    0xc(%ebp),%eax
 112:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 115:	eb 14                	jmp    12b <strchr+0x22>
    if(*s == c)
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	0f b6 00             	movzbl (%eax),%eax
 11d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 120:	75 05                	jne    127 <strchr+0x1e>
      return (char*)s;
 122:	8b 45 08             	mov    0x8(%ebp),%eax
 125:	eb 13                	jmp    13a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 127:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 12b:	8b 45 08             	mov    0x8(%ebp),%eax
 12e:	0f b6 00             	movzbl (%eax),%eax
 131:	84 c0                	test   %al,%al
 133:	75 e2                	jne    117 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 135:	b8 00 00 00 00       	mov    $0x0,%eax
}
 13a:	c9                   	leave  
 13b:	c3                   	ret    

0000013c <gets>:

char*
gets(char *buf, int max)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 142:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 149:	eb 46                	jmp    191 <gets+0x55>
    cc = read(0, &c, 1);
 14b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 152:	00 
 153:	8d 45 ef             	lea    -0x11(%ebp),%eax
 156:	89 44 24 04          	mov    %eax,0x4(%esp)
 15a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 161:	e8 6a 02 00 00       	call   3d0 <read>
 166:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 169:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16d:	7e 2f                	jle    19e <gets+0x62>
      break;
    buf[i++] = c;
 16f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	01 c2                	add    %eax,%edx
 177:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17b:	88 02                	mov    %al,(%edx)
 17d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 181:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 185:	3c 0a                	cmp    $0xa,%al
 187:	74 16                	je     19f <gets+0x63>
 189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18d:	3c 0d                	cmp    $0xd,%al
 18f:	74 0e                	je     19f <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 191:	8b 45 f4             	mov    -0xc(%ebp),%eax
 194:	83 c0 01             	add    $0x1,%eax
 197:	3b 45 0c             	cmp    0xc(%ebp),%eax
 19a:	7c af                	jl     14b <gets+0xf>
 19c:	eb 01                	jmp    19f <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 19e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1a2:	8b 45 08             	mov    0x8(%ebp),%eax
 1a5:	01 d0                	add    %edx,%eax
 1a7:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1aa:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ad:	c9                   	leave  
 1ae:	c3                   	ret    

000001af <stat>:

int
stat(char *n, struct stat *st)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
 1b2:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1bc:	00 
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	89 04 24             	mov    %eax,(%esp)
 1c3:	e8 30 02 00 00       	call   3f8 <open>
 1c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1cf:	79 07                	jns    1d8 <stat+0x29>
    return -1;
 1d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d6:	eb 23                	jmp    1fb <stat+0x4c>
  r = fstat(fd, st);
 1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1db:	89 44 24 04          	mov    %eax,0x4(%esp)
 1df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e2:	89 04 24             	mov    %eax,(%esp)
 1e5:	e8 26 02 00 00       	call   410 <fstat>
 1ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f0:	89 04 24             	mov    %eax,(%esp)
 1f3:	e8 e8 01 00 00       	call   3e0 <close>
  return r;
 1f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1fb:	c9                   	leave  
 1fc:	c3                   	ret    

000001fd <atoi>:

int
atoi(const char *s)
{
 1fd:	55                   	push   %ebp
 1fe:	89 e5                	mov    %esp,%ebp
 200:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 203:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 20a:	eb 23                	jmp    22f <atoi+0x32>
    n = n*10 + *s++ - '0';
 20c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20f:	89 d0                	mov    %edx,%eax
 211:	c1 e0 02             	shl    $0x2,%eax
 214:	01 d0                	add    %edx,%eax
 216:	01 c0                	add    %eax,%eax
 218:	89 c2                	mov    %eax,%edx
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	0f be c0             	movsbl %al,%eax
 223:	01 d0                	add    %edx,%eax
 225:	83 e8 30             	sub    $0x30,%eax
 228:	89 45 fc             	mov    %eax,-0x4(%ebp)
 22b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	3c 2f                	cmp    $0x2f,%al
 237:	7e 0a                	jle    243 <atoi+0x46>
 239:	8b 45 08             	mov    0x8(%ebp),%eax
 23c:	0f b6 00             	movzbl (%eax),%eax
 23f:	3c 39                	cmp    $0x39,%al
 241:	7e c9                	jle    20c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 243:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 246:	c9                   	leave  
 247:	c3                   	ret    

00000248 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 254:	8b 45 0c             	mov    0xc(%ebp),%eax
 257:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 25a:	eb 13                	jmp    26f <memmove+0x27>
    *dst++ = *src++;
 25c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 25f:	0f b6 10             	movzbl (%eax),%edx
 262:	8b 45 fc             	mov    -0x4(%ebp),%eax
 265:	88 10                	mov    %dl,(%eax)
 267:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 26b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 273:	0f 9f c0             	setg   %al
 276:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 27a:	84 c0                	test   %al,%al
 27c:	75 de                	jne    25c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    
 283:	90                   	nop

00000284 <SYS_ls_call01>:
 284:	6c                   	insb   (%dx),%es:(%edi)
 285:	73 5f                	jae    2e6 <SYS_ls_call10+0x8>
 287:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 28a:	6c                   	insb   (%dx),%es:(%edi)
 28b:	30 31                	xor    %dh,(%ecx)
	...

0000028e <SYS_ls_call02>:
 28e:	6c                   	insb   (%dx),%es:(%edi)
 28f:	73 5f                	jae    2f0 <SYS_ls_call11+0x8>
 291:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 294:	6c                   	insb   (%dx),%es:(%edi)
 295:	30 32                	xor    %dh,(%edx)
	...

00000298 <SYS_ls_call03>:
 298:	6c                   	insb   (%dx),%es:(%edi)
 299:	73 5f                	jae    2fa <SYS_ls_call12+0x8>
 29b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 29e:	6c                   	insb   (%dx),%es:(%edi)
 29f:	30 33                	xor    %dh,(%ebx)
	...

000002a2 <SYS_ls_call04>:
 2a2:	6c                   	insb   (%dx),%es:(%edi)
 2a3:	73 5f                	jae    304 <SYS_ls_call13+0x8>
 2a5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2a8:	6c                   	insb   (%dx),%es:(%edi)
 2a9:	30 34 00             	xor    %dh,(%eax,%eax,1)

000002ac <SYS_ls_call05>:
 2ac:	6c                   	insb   (%dx),%es:(%edi)
 2ad:	73 5f                	jae    30e <SYS_ls_call14+0x8>
 2af:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2b2:	6c                   	insb   (%dx),%es:(%edi)
 2b3:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

000002b6 <SYS_ls_call06>:
 2b6:	6c                   	insb   (%dx),%es:(%edi)
 2b7:	73 5f                	jae    318 <SYS_ls_call15+0x8>
 2b9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2bc:	6c                   	insb   (%dx),%es:(%edi)
 2bd:	30 36                	xor    %dh,(%esi)
	...

000002c0 <SYS_ls_call07>:
 2c0:	6c                   	insb   (%dx),%es:(%edi)
 2c1:	73 5f                	jae    322 <SYS_ls_call16+0x8>
 2c3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2c6:	6c                   	insb   (%dx),%es:(%edi)
 2c7:	30 37                	xor    %dh,(%edi)
	...

000002ca <SYS_ls_call08>:
 2ca:	6c                   	insb   (%dx),%es:(%edi)
 2cb:	73 5f                	jae    32c <SYS_ls_call17+0x8>
 2cd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2d0:	6c                   	insb   (%dx),%es:(%edi)
 2d1:	30 38                	xor    %bh,(%eax)
	...

000002d4 <SYS_ls_call09>:
 2d4:	6c                   	insb   (%dx),%es:(%edi)
 2d5:	73 5f                	jae    336 <SYS_ls_call18+0x8>
 2d7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2da:	6c                   	insb   (%dx),%es:(%edi)
 2db:	30 39                	xor    %bh,(%ecx)
	...

000002de <SYS_ls_call10>:
 2de:	6c                   	insb   (%dx),%es:(%edi)
 2df:	73 5f                	jae    340 <SYS_ls_call19+0x8>
 2e1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2e4:	6c                   	insb   (%dx),%es:(%edi)
 2e5:	31 30                	xor    %esi,(%eax)
	...

000002e8 <SYS_ls_call11>:
 2e8:	6c                   	insb   (%dx),%es:(%edi)
 2e9:	73 5f                	jae    34a <SYS_ls_call20+0x8>
 2eb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2ee:	6c                   	insb   (%dx),%es:(%edi)
 2ef:	31 31                	xor    %esi,(%ecx)
	...

000002f2 <SYS_ls_call12>:
 2f2:	6c                   	insb   (%dx),%es:(%edi)
 2f3:	73 5f                	jae    354 <SYS_ls_call21+0x8>
 2f5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2f8:	6c                   	insb   (%dx),%es:(%edi)
 2f9:	31 32                	xor    %esi,(%edx)
	...

000002fc <SYS_ls_call13>:
 2fc:	6c                   	insb   (%dx),%es:(%edi)
 2fd:	73 5f                	jae    35e <SYS_ls_call22+0x8>
 2ff:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 302:	6c                   	insb   (%dx),%es:(%edi)
 303:	31 33                	xor    %esi,(%ebx)
	...

00000306 <SYS_ls_call14>:
 306:	6c                   	insb   (%dx),%es:(%edi)
 307:	73 5f                	jae    368 <SYS_ls_call23+0x8>
 309:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 30c:	6c                   	insb   (%dx),%es:(%edi)
 30d:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000310 <SYS_ls_call15>:
 310:	6c                   	insb   (%dx),%es:(%edi)
 311:	73 5f                	jae    372 <SYS_ls_call24+0x8>
 313:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 316:	6c                   	insb   (%dx),%es:(%edi)
 317:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

0000031a <SYS_ls_call16>:
 31a:	6c                   	insb   (%dx),%es:(%edi)
 31b:	73 5f                	jae    37c <SYS_ls_call25+0x8>
 31d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 320:	6c                   	insb   (%dx),%es:(%edi)
 321:	31 36                	xor    %esi,(%esi)
	...

00000324 <SYS_ls_call17>:
 324:	6c                   	insb   (%dx),%es:(%edi)
 325:	73 5f                	jae    386 <SYS_ls_call26+0x8>
 327:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 32a:	6c                   	insb   (%dx),%es:(%edi)
 32b:	31 37                	xor    %esi,(%edi)
	...

0000032e <SYS_ls_call18>:
 32e:	6c                   	insb   (%dx),%es:(%edi)
 32f:	73 5f                	jae    390 <SYS_ls_call27+0x8>
 331:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 334:	6c                   	insb   (%dx),%es:(%edi)
 335:	31 38                	xor    %edi,(%eax)
	...

00000338 <SYS_ls_call19>:
 338:	6c                   	insb   (%dx),%es:(%edi)
 339:	73 5f                	jae    39a <SYS_ls_call28+0x8>
 33b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 33e:	6c                   	insb   (%dx),%es:(%edi)
 33f:	31 39                	xor    %edi,(%ecx)
	...

00000342 <SYS_ls_call20>:
 342:	6c                   	insb   (%dx),%es:(%edi)
 343:	73 5f                	jae    3a4 <SYS_ls_call29+0x8>
 345:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 348:	6c                   	insb   (%dx),%es:(%edi)
 349:	32 30                	xor    (%eax),%dh
	...

0000034c <SYS_ls_call21>:
 34c:	6c                   	insb   (%dx),%es:(%edi)
 34d:	73 5f                	jae    3ae <SYS_ls_call30+0x8>
 34f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 352:	6c                   	insb   (%dx),%es:(%edi)
 353:	32 31                	xor    (%ecx),%dh
	...

00000356 <SYS_ls_call22>:
 356:	6c                   	insb   (%dx),%es:(%edi)
 357:	73 5f                	jae    3b8 <exit>
 359:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 35c:	6c                   	insb   (%dx),%es:(%edi)
 35d:	32 32                	xor    (%edx),%dh
	...

00000360 <SYS_ls_call23>:
 360:	6c                   	insb   (%dx),%es:(%edi)
 361:	73 5f                	jae    3c2 <wait+0x2>
 363:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 366:	6c                   	insb   (%dx),%es:(%edi)
 367:	32 33                	xor    (%ebx),%dh
	...

0000036a <SYS_ls_call24>:
 36a:	6c                   	insb   (%dx),%es:(%edi)
 36b:	73 5f                	jae    3cc <pipe+0x4>
 36d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 370:	6c                   	insb   (%dx),%es:(%edi)
 371:	32 34 00             	xor    (%eax,%eax,1),%dh

00000374 <SYS_ls_call25>:
 374:	6c                   	insb   (%dx),%es:(%edi)
 375:	73 5f                	jae    3d6 <read+0x6>
 377:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 37a:	6c                   	insb   (%dx),%es:(%edi)
 37b:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

0000037e <SYS_ls_call26>:
 37e:	6c                   	insb   (%dx),%es:(%edi)
 37f:	73 5f                	jae    3e0 <close>
 381:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 384:	6c                   	insb   (%dx),%es:(%edi)
 385:	32 36                	xor    (%esi),%dh
	...

00000388 <SYS_ls_call27>:
 388:	6c                   	insb   (%dx),%es:(%edi)
 389:	73 5f                	jae    3ea <kill+0x2>
 38b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 38e:	6c                   	insb   (%dx),%es:(%edi)
 38f:	32 37                	xor    (%edi),%dh
	...

00000392 <SYS_ls_call28>:
 392:	6c                   	insb   (%dx),%es:(%edi)
 393:	73 5f                	jae    3f4 <exec+0x4>
 395:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 398:	6c                   	insb   (%dx),%es:(%edi)
 399:	32 38                	xor    (%eax),%bh
	...

0000039c <SYS_ls_call29>:
 39c:	6c                   	insb   (%dx),%es:(%edi)
 39d:	73 5f                	jae    3fe <open+0x6>
 39f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a2:	6c                   	insb   (%dx),%es:(%edi)
 3a3:	32 39                	xor    (%ecx),%bh
	...

000003a6 <SYS_ls_call30>:
 3a6:	6c                   	insb   (%dx),%es:(%edi)
 3a7:	73 5f                	jae    408 <unlink>
 3a9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ac:	6c                   	insb   (%dx),%es:(%edi)
 3ad:	33 30                	xor    (%eax),%esi
	...

000003b0 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 3b0:	b8 01 00 00 00       	mov    $0x1,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <exit>:
SYSCALL(exit)
 3b8:	b8 02 00 00 00       	mov    $0x2,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <wait>:
SYSCALL(wait)
 3c0:	b8 03 00 00 00       	mov    $0x3,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <pipe>:
SYSCALL(pipe)
 3c8:	b8 04 00 00 00       	mov    $0x4,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <read>:
SYSCALL(read)
 3d0:	b8 05 00 00 00       	mov    $0x5,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <write>:
SYSCALL(write)
 3d8:	b8 10 00 00 00       	mov    $0x10,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <close>:
SYSCALL(close)
 3e0:	b8 15 00 00 00       	mov    $0x15,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <kill>:
SYSCALL(kill)
 3e8:	b8 06 00 00 00       	mov    $0x6,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <exec>:
SYSCALL(exec)
 3f0:	b8 07 00 00 00       	mov    $0x7,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <open>:
SYSCALL(open)
 3f8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <mknod>:
SYSCALL(mknod)
 400:	b8 11 00 00 00       	mov    $0x11,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <unlink>:
SYSCALL(unlink)
 408:	b8 12 00 00 00       	mov    $0x12,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <fstat>:
SYSCALL(fstat)
 410:	b8 08 00 00 00       	mov    $0x8,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <link>:
SYSCALL(link)
 418:	b8 13 00 00 00       	mov    $0x13,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <mkdir>:
SYSCALL(mkdir)
 420:	b8 14 00 00 00       	mov    $0x14,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <chdir>:
SYSCALL(chdir)
 428:	b8 09 00 00 00       	mov    $0x9,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <dup>:
SYSCALL(dup)
 430:	b8 0a 00 00 00       	mov    $0xa,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <getpid>:
SYSCALL(getpid)
 438:	b8 0b 00 00 00       	mov    $0xb,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <sbrk>:
SYSCALL(sbrk)
 440:	b8 0c 00 00 00       	mov    $0xc,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <sleep>:
SYSCALL(sleep)
 448:	b8 0d 00 00 00       	mov    $0xd,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <uptime>:
SYSCALL(uptime)
 450:	b8 0e 00 00 00       	mov    $0xe,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <date>:
SYSCALL(date)
 458:	b8 16 00 00 00       	mov    $0x16,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <ls_call01>:

SYSCALL1(ls_call01)
 460:	b8 84 02 00 00       	mov    $0x284,%eax
 465:	cd 41                	int    $0x41
 467:	c3                   	ret    

00000468 <ls_call02>:
SYSCALL1(ls_call02)
 468:	b8 8e 02 00 00       	mov    $0x28e,%eax
 46d:	cd 41                	int    $0x41
 46f:	c3                   	ret    

00000470 <ls_call03>:
SYSCALL1(ls_call03)
 470:	b8 98 02 00 00       	mov    $0x298,%eax
 475:	cd 41                	int    $0x41
 477:	c3                   	ret    

00000478 <ls_call04>:
SYSCALL1(ls_call04)
 478:	b8 a2 02 00 00       	mov    $0x2a2,%eax
 47d:	cd 41                	int    $0x41
 47f:	c3                   	ret    

00000480 <ls_call05>:
SYSCALL1(ls_call05)
 480:	b8 ac 02 00 00       	mov    $0x2ac,%eax
 485:	cd 41                	int    $0x41
 487:	c3                   	ret    

00000488 <ls_call06>:
SYSCALL1(ls_call06)
 488:	b8 b6 02 00 00       	mov    $0x2b6,%eax
 48d:	cd 41                	int    $0x41
 48f:	c3                   	ret    

00000490 <ls_call07>:
SYSCALL1(ls_call07)
 490:	b8 c0 02 00 00       	mov    $0x2c0,%eax
 495:	cd 41                	int    $0x41
 497:	c3                   	ret    

00000498 <ls_call08>:
SYSCALL1(ls_call08)
 498:	b8 ca 02 00 00       	mov    $0x2ca,%eax
 49d:	cd 41                	int    $0x41
 49f:	c3                   	ret    

000004a0 <ls_call09>:
SYSCALL1(ls_call09)
 4a0:	b8 d4 02 00 00       	mov    $0x2d4,%eax
 4a5:	cd 41                	int    $0x41
 4a7:	c3                   	ret    

000004a8 <ls_call10>:
SYSCALL1(ls_call10)
 4a8:	b8 de 02 00 00       	mov    $0x2de,%eax
 4ad:	cd 41                	int    $0x41
 4af:	c3                   	ret    

000004b0 <ls_call11>:
SYSCALL1(ls_call11)
 4b0:	b8 e8 02 00 00       	mov    $0x2e8,%eax
 4b5:	cd 41                	int    $0x41
 4b7:	c3                   	ret    

000004b8 <ls_call12>:
SYSCALL1(ls_call12)
 4b8:	b8 f2 02 00 00       	mov    $0x2f2,%eax
 4bd:	cd 41                	int    $0x41
 4bf:	c3                   	ret    

000004c0 <ls_call13>:
SYSCALL1(ls_call13)
 4c0:	b8 fc 02 00 00       	mov    $0x2fc,%eax
 4c5:	cd 41                	int    $0x41
 4c7:	c3                   	ret    

000004c8 <ls_call14>:
SYSCALL1(ls_call14)
 4c8:	b8 06 03 00 00       	mov    $0x306,%eax
 4cd:	cd 41                	int    $0x41
 4cf:	c3                   	ret    

000004d0 <ls_call15>:
SYSCALL1(ls_call15)
 4d0:	b8 10 03 00 00       	mov    $0x310,%eax
 4d5:	cd 41                	int    $0x41
 4d7:	c3                   	ret    

000004d8 <ls_call16>:
SYSCALL1(ls_call16)
 4d8:	b8 1a 03 00 00       	mov    $0x31a,%eax
 4dd:	cd 41                	int    $0x41
 4df:	c3                   	ret    

000004e0 <ls_call17>:
SYSCALL1(ls_call17)
 4e0:	b8 24 03 00 00       	mov    $0x324,%eax
 4e5:	cd 41                	int    $0x41
 4e7:	c3                   	ret    

000004e8 <ls_call18>:
SYSCALL1(ls_call18)
 4e8:	b8 2e 03 00 00       	mov    $0x32e,%eax
 4ed:	cd 41                	int    $0x41
 4ef:	c3                   	ret    

000004f0 <ls_call19>:
SYSCALL1(ls_call19)
 4f0:	b8 38 03 00 00       	mov    $0x338,%eax
 4f5:	cd 41                	int    $0x41
 4f7:	c3                   	ret    

000004f8 <ls_call20>:
SYSCALL1(ls_call20)
 4f8:	b8 42 03 00 00       	mov    $0x342,%eax
 4fd:	cd 41                	int    $0x41
 4ff:	c3                   	ret    

00000500 <ls_call21>:
SYSCALL1(ls_call21)
 500:	b8 4c 03 00 00       	mov    $0x34c,%eax
 505:	cd 41                	int    $0x41
 507:	c3                   	ret    

00000508 <ls_call22>:
SYSCALL1(ls_call22)
 508:	b8 56 03 00 00       	mov    $0x356,%eax
 50d:	cd 41                	int    $0x41
 50f:	c3                   	ret    

00000510 <ls_call23>:
SYSCALL1(ls_call23)
 510:	b8 60 03 00 00       	mov    $0x360,%eax
 515:	cd 41                	int    $0x41
 517:	c3                   	ret    

00000518 <ls_call24>:
SYSCALL1(ls_call24)
 518:	b8 6a 03 00 00       	mov    $0x36a,%eax
 51d:	cd 41                	int    $0x41
 51f:	c3                   	ret    

00000520 <ls_call25>:
SYSCALL1(ls_call25)
 520:	b8 74 03 00 00       	mov    $0x374,%eax
 525:	cd 41                	int    $0x41
 527:	c3                   	ret    

00000528 <ls_call26>:
SYSCALL1(ls_call26)
 528:	b8 7e 03 00 00       	mov    $0x37e,%eax
 52d:	cd 41                	int    $0x41
 52f:	c3                   	ret    

00000530 <ls_call27>:
SYSCALL1(ls_call27)
 530:	b8 88 03 00 00       	mov    $0x388,%eax
 535:	cd 41                	int    $0x41
 537:	c3                   	ret    

00000538 <ls_call28>:
SYSCALL1(ls_call28)
 538:	b8 92 03 00 00       	mov    $0x392,%eax
 53d:	cd 41                	int    $0x41
 53f:	c3                   	ret    

00000540 <ls_call29>:
SYSCALL1(ls_call29)
 540:	b8 9c 03 00 00       	mov    $0x39c,%eax
 545:	cd 41                	int    $0x41
 547:	c3                   	ret    

00000548 <ls_call30>:
SYSCALL1(ls_call30)
 548:	b8 a6 03 00 00       	mov    $0x3a6,%eax
 54d:	cd 41                	int    $0x41
 54f:	c3                   	ret    

00000550 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	83 ec 28             	sub    $0x28,%esp
 556:	8b 45 0c             	mov    0xc(%ebp),%eax
 559:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 55c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 563:	00 
 564:	8d 45 f4             	lea    -0xc(%ebp),%eax
 567:	89 44 24 04          	mov    %eax,0x4(%esp)
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	89 04 24             	mov    %eax,(%esp)
 571:	e8 62 fe ff ff       	call   3d8 <write>
}
 576:	c9                   	leave  
 577:	c3                   	ret    

00000578 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 578:	55                   	push   %ebp
 579:	89 e5                	mov    %esp,%ebp
 57b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 57e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 585:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 589:	74 17                	je     5a2 <printint+0x2a>
 58b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 58f:	79 11                	jns    5a2 <printint+0x2a>
    neg = 1;
 591:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 598:	8b 45 0c             	mov    0xc(%ebp),%eax
 59b:	f7 d8                	neg    %eax
 59d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5a0:	eb 06                	jmp    5a8 <printint+0x30>
  } else {
    x = xx;
 5a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5af:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b5:	ba 00 00 00 00       	mov    $0x0,%edx
 5ba:	f7 f1                	div    %ecx
 5bc:	89 d0                	mov    %edx,%eax
 5be:	0f b6 80 40 0c 00 00 	movzbl 0xc40(%eax),%eax
 5c5:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 5c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 5cb:	01 ca                	add    %ecx,%edx
 5cd:	88 02                	mov    %al,(%edx)
 5cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 5d3:	8b 55 10             	mov    0x10(%ebp),%edx
 5d6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5dc:	ba 00 00 00 00       	mov    $0x0,%edx
 5e1:	f7 75 d4             	divl   -0x2c(%ebp)
 5e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5eb:	75 c2                	jne    5af <printint+0x37>
  if(neg)
 5ed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5f1:	74 2e                	je     621 <printint+0xa9>
    buf[i++] = '-';
 5f3:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f9:	01 d0                	add    %edx,%eax
 5fb:	c6 00 2d             	movb   $0x2d,(%eax)
 5fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 602:	eb 1d                	jmp    621 <printint+0xa9>
    putc(fd, buf[i]);
 604:	8d 55 dc             	lea    -0x24(%ebp),%edx
 607:	8b 45 f4             	mov    -0xc(%ebp),%eax
 60a:	01 d0                	add    %edx,%eax
 60c:	0f b6 00             	movzbl (%eax),%eax
 60f:	0f be c0             	movsbl %al,%eax
 612:	89 44 24 04          	mov    %eax,0x4(%esp)
 616:	8b 45 08             	mov    0x8(%ebp),%eax
 619:	89 04 24             	mov    %eax,(%esp)
 61c:	e8 2f ff ff ff       	call   550 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 621:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 625:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 629:	79 d9                	jns    604 <printint+0x8c>
    putc(fd, buf[i]);
}
 62b:	c9                   	leave  
 62c:	c3                   	ret    

0000062d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 62d:	55                   	push   %ebp
 62e:	89 e5                	mov    %esp,%ebp
 630:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 63a:	8d 45 0c             	lea    0xc(%ebp),%eax
 63d:	83 c0 04             	add    $0x4,%eax
 640:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 643:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 64a:	e9 7d 01 00 00       	jmp    7cc <printf+0x19f>
    c = fmt[i] & 0xff;
 64f:	8b 55 0c             	mov    0xc(%ebp),%edx
 652:	8b 45 f0             	mov    -0x10(%ebp),%eax
 655:	01 d0                	add    %edx,%eax
 657:	0f b6 00             	movzbl (%eax),%eax
 65a:	0f be c0             	movsbl %al,%eax
 65d:	25 ff 00 00 00       	and    $0xff,%eax
 662:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 665:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 669:	75 2c                	jne    697 <printf+0x6a>
      if(c == '%'){
 66b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 66f:	75 0c                	jne    67d <printf+0x50>
        state = '%';
 671:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 678:	e9 4b 01 00 00       	jmp    7c8 <printf+0x19b>
      } else {
        putc(fd, c);
 67d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 680:	0f be c0             	movsbl %al,%eax
 683:	89 44 24 04          	mov    %eax,0x4(%esp)
 687:	8b 45 08             	mov    0x8(%ebp),%eax
 68a:	89 04 24             	mov    %eax,(%esp)
 68d:	e8 be fe ff ff       	call   550 <putc>
 692:	e9 31 01 00 00       	jmp    7c8 <printf+0x19b>
      }
    } else if(state == '%'){
 697:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 69b:	0f 85 27 01 00 00    	jne    7c8 <printf+0x19b>
      if(c == 'd'){
 6a1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6a5:	75 2d                	jne    6d4 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 6a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 6b3:	00 
 6b4:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 6bb:	00 
 6bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
 6c3:	89 04 24             	mov    %eax,(%esp)
 6c6:	e8 ad fe ff ff       	call   578 <printint>
        ap++;
 6cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6cf:	e9 ed 00 00 00       	jmp    7c1 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 6d4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6d8:	74 06                	je     6e0 <printf+0xb3>
 6da:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6de:	75 2d                	jne    70d <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e3:	8b 00                	mov    (%eax),%eax
 6e5:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6ec:	00 
 6ed:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6f4:	00 
 6f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
 6fc:	89 04 24             	mov    %eax,(%esp)
 6ff:	e8 74 fe ff ff       	call   578 <printint>
        ap++;
 704:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 708:	e9 b4 00 00 00       	jmp    7c1 <printf+0x194>
      } else if(c == 's'){
 70d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 711:	75 46                	jne    759 <printf+0x12c>
        s = (char*)*ap;
 713:	8b 45 e8             	mov    -0x18(%ebp),%eax
 716:	8b 00                	mov    (%eax),%eax
 718:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 71b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 71f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 723:	75 27                	jne    74c <printf+0x11f>
          s = "(null)";
 725:	c7 45 f4 fd 09 00 00 	movl   $0x9fd,-0xc(%ebp)
        while(*s != 0){
 72c:	eb 1e                	jmp    74c <printf+0x11f>
          putc(fd, *s);
 72e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 731:	0f b6 00             	movzbl (%eax),%eax
 734:	0f be c0             	movsbl %al,%eax
 737:	89 44 24 04          	mov    %eax,0x4(%esp)
 73b:	8b 45 08             	mov    0x8(%ebp),%eax
 73e:	89 04 24             	mov    %eax,(%esp)
 741:	e8 0a fe ff ff       	call   550 <putc>
          s++;
 746:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 74a:	eb 01                	jmp    74d <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 74c:	90                   	nop
 74d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 750:	0f b6 00             	movzbl (%eax),%eax
 753:	84 c0                	test   %al,%al
 755:	75 d7                	jne    72e <printf+0x101>
 757:	eb 68                	jmp    7c1 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 759:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 75d:	75 1d                	jne    77c <printf+0x14f>
        putc(fd, *ap);
 75f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	0f be c0             	movsbl %al,%eax
 767:	89 44 24 04          	mov    %eax,0x4(%esp)
 76b:	8b 45 08             	mov    0x8(%ebp),%eax
 76e:	89 04 24             	mov    %eax,(%esp)
 771:	e8 da fd ff ff       	call   550 <putc>
        ap++;
 776:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 77a:	eb 45                	jmp    7c1 <printf+0x194>
      } else if(c == '%'){
 77c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 780:	75 17                	jne    799 <printf+0x16c>
        putc(fd, c);
 782:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 785:	0f be c0             	movsbl %al,%eax
 788:	89 44 24 04          	mov    %eax,0x4(%esp)
 78c:	8b 45 08             	mov    0x8(%ebp),%eax
 78f:	89 04 24             	mov    %eax,(%esp)
 792:	e8 b9 fd ff ff       	call   550 <putc>
 797:	eb 28                	jmp    7c1 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 799:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 7a0:	00 
 7a1:	8b 45 08             	mov    0x8(%ebp),%eax
 7a4:	89 04 24             	mov    %eax,(%esp)
 7a7:	e8 a4 fd ff ff       	call   550 <putc>
        putc(fd, c);
 7ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7af:	0f be c0             	movsbl %al,%eax
 7b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b6:	8b 45 08             	mov    0x8(%ebp),%eax
 7b9:	89 04 24             	mov    %eax,(%esp)
 7bc:	e8 8f fd ff ff       	call   550 <putc>
      }
      state = 0;
 7c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7c8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7cc:	8b 55 0c             	mov    0xc(%ebp),%edx
 7cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d2:	01 d0                	add    %edx,%eax
 7d4:	0f b6 00             	movzbl (%eax),%eax
 7d7:	84 c0                	test   %al,%al
 7d9:	0f 85 70 fe ff ff    	jne    64f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7df:	c9                   	leave  
 7e0:	c3                   	ret    
 7e1:	90                   	nop
 7e2:	90                   	nop
 7e3:	90                   	nop

000007e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e4:	55                   	push   %ebp
 7e5:	89 e5                	mov    %esp,%ebp
 7e7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ea:	8b 45 08             	mov    0x8(%ebp),%eax
 7ed:	83 e8 08             	sub    $0x8,%eax
 7f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f3:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 7f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7fb:	eb 24                	jmp    821 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 800:	8b 00                	mov    (%eax),%eax
 802:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 805:	77 12                	ja     819 <free+0x35>
 807:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 80d:	77 24                	ja     833 <free+0x4f>
 80f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 817:	77 1a                	ja     833 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	8b 00                	mov    (%eax),%eax
 81e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 821:	8b 45 f8             	mov    -0x8(%ebp),%eax
 824:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 827:	76 d4                	jbe    7fd <free+0x19>
 829:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82c:	8b 00                	mov    (%eax),%eax
 82e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 831:	76 ca                	jbe    7fd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 833:	8b 45 f8             	mov    -0x8(%ebp),%eax
 836:	8b 40 04             	mov    0x4(%eax),%eax
 839:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 840:	8b 45 f8             	mov    -0x8(%ebp),%eax
 843:	01 c2                	add    %eax,%edx
 845:	8b 45 fc             	mov    -0x4(%ebp),%eax
 848:	8b 00                	mov    (%eax),%eax
 84a:	39 c2                	cmp    %eax,%edx
 84c:	75 24                	jne    872 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 84e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 851:	8b 50 04             	mov    0x4(%eax),%edx
 854:	8b 45 fc             	mov    -0x4(%ebp),%eax
 857:	8b 00                	mov    (%eax),%eax
 859:	8b 40 04             	mov    0x4(%eax),%eax
 85c:	01 c2                	add    %eax,%edx
 85e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 861:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	8b 00                	mov    (%eax),%eax
 869:	8b 10                	mov    (%eax),%edx
 86b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86e:	89 10                	mov    %edx,(%eax)
 870:	eb 0a                	jmp    87c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 872:	8b 45 fc             	mov    -0x4(%ebp),%eax
 875:	8b 10                	mov    (%eax),%edx
 877:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 87c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87f:	8b 40 04             	mov    0x4(%eax),%eax
 882:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 889:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88c:	01 d0                	add    %edx,%eax
 88e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 891:	75 20                	jne    8b3 <free+0xcf>
    p->s.size += bp->s.size;
 893:	8b 45 fc             	mov    -0x4(%ebp),%eax
 896:	8b 50 04             	mov    0x4(%eax),%edx
 899:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89c:	8b 40 04             	mov    0x4(%eax),%eax
 89f:	01 c2                	add    %eax,%edx
 8a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8aa:	8b 10                	mov    (%eax),%edx
 8ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8af:	89 10                	mov    %edx,(%eax)
 8b1:	eb 08                	jmp    8bb <free+0xd7>
  } else
    p->s.ptr = bp;
 8b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8b9:	89 10                	mov    %edx,(%eax)
  freep = p;
 8bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8be:	a3 5c 0c 00 00       	mov    %eax,0xc5c
}
 8c3:	c9                   	leave  
 8c4:	c3                   	ret    

000008c5 <morecore>:

static Header*
morecore(uint nu)
{
 8c5:	55                   	push   %ebp
 8c6:	89 e5                	mov    %esp,%ebp
 8c8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8cb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8d2:	77 07                	ja     8db <morecore+0x16>
    nu = 4096;
 8d4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8db:	8b 45 08             	mov    0x8(%ebp),%eax
 8de:	c1 e0 03             	shl    $0x3,%eax
 8e1:	89 04 24             	mov    %eax,(%esp)
 8e4:	e8 57 fb ff ff       	call   440 <sbrk>
 8e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8ec:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8f0:	75 07                	jne    8f9 <morecore+0x34>
    return 0;
 8f2:	b8 00 00 00 00       	mov    $0x0,%eax
 8f7:	eb 22                	jmp    91b <morecore+0x56>
  hp = (Header*)p;
 8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 902:	8b 55 08             	mov    0x8(%ebp),%edx
 905:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 908:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90b:	83 c0 08             	add    $0x8,%eax
 90e:	89 04 24             	mov    %eax,(%esp)
 911:	e8 ce fe ff ff       	call   7e4 <free>
  return freep;
 916:	a1 5c 0c 00 00       	mov    0xc5c,%eax
}
 91b:	c9                   	leave  
 91c:	c3                   	ret    

0000091d <malloc>:

void*
malloc(uint nbytes)
{
 91d:	55                   	push   %ebp
 91e:	89 e5                	mov    %esp,%ebp
 920:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 923:	8b 45 08             	mov    0x8(%ebp),%eax
 926:	83 c0 07             	add    $0x7,%eax
 929:	c1 e8 03             	shr    $0x3,%eax
 92c:	83 c0 01             	add    $0x1,%eax
 92f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 932:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 937:	89 45 f0             	mov    %eax,-0x10(%ebp)
 93a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 93e:	75 23                	jne    963 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 940:	c7 45 f0 54 0c 00 00 	movl   $0xc54,-0x10(%ebp)
 947:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94a:	a3 5c 0c 00 00       	mov    %eax,0xc5c
 94f:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 954:	a3 54 0c 00 00       	mov    %eax,0xc54
    base.s.size = 0;
 959:	c7 05 58 0c 00 00 00 	movl   $0x0,0xc58
 960:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 963:	8b 45 f0             	mov    -0x10(%ebp),%eax
 966:	8b 00                	mov    (%eax),%eax
 968:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 96b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96e:	8b 40 04             	mov    0x4(%eax),%eax
 971:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 974:	72 4d                	jb     9c3 <malloc+0xa6>
      if(p->s.size == nunits)
 976:	8b 45 f4             	mov    -0xc(%ebp),%eax
 979:	8b 40 04             	mov    0x4(%eax),%eax
 97c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 97f:	75 0c                	jne    98d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 981:	8b 45 f4             	mov    -0xc(%ebp),%eax
 984:	8b 10                	mov    (%eax),%edx
 986:	8b 45 f0             	mov    -0x10(%ebp),%eax
 989:	89 10                	mov    %edx,(%eax)
 98b:	eb 26                	jmp    9b3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 98d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 990:	8b 40 04             	mov    0x4(%eax),%eax
 993:	89 c2                	mov    %eax,%edx
 995:	2b 55 ec             	sub    -0x14(%ebp),%edx
 998:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 99e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a1:	8b 40 04             	mov    0x4(%eax),%eax
 9a4:	c1 e0 03             	shl    $0x3,%eax
 9a7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9b0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b6:	a3 5c 0c 00 00       	mov    %eax,0xc5c
      return (void*)(p + 1);
 9bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9be:	83 c0 08             	add    $0x8,%eax
 9c1:	eb 38                	jmp    9fb <malloc+0xde>
    }
    if(p == freep)
 9c3:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 9c8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9cb:	75 1b                	jne    9e8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 9cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d0:	89 04 24             	mov    %eax,(%esp)
 9d3:	e8 ed fe ff ff       	call   8c5 <morecore>
 9d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9df:	75 07                	jne    9e8 <malloc+0xcb>
        return 0;
 9e1:	b8 00 00 00 00       	mov    $0x0,%eax
 9e6:	eb 13                	jmp    9fb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f1:	8b 00                	mov    (%eax),%eax
 9f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9f6:	e9 70 ff ff ff       	jmp    96b <malloc+0x4e>
}
 9fb:	c9                   	leave  
 9fc:	c3                   	ret    
