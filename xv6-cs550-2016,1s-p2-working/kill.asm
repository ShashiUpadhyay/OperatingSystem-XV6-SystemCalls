
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "usage: kill pid...\n");
   f:	c7 44 24 04 41 0a 00 	movl   $0xa41,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 4e 06 00 00       	call   671 <printf>
    exit();
  23:	e8 d4 03 00 00       	call   3fc <exit>
  }
  for(i=1; i<argc; i++)
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 27                	jmp    59 <main+0x59>
    kill(atoi(argv[i]));
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 f5 01 00 00       	call   241 <atoi>
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 d8 03 00 00       	call   42c <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  54:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  59:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5d:	3b 45 08             	cmp    0x8(%ebp),%eax
  60:	7c d0                	jl     32 <main+0x32>
    kill(atoi(argv[i]));
  exit();
  62:	e8 95 03 00 00       	call   3fc <exit>
  67:	90                   	nop

00000068 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	57                   	push   %edi
  6c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  70:	8b 55 10             	mov    0x10(%ebp),%edx
  73:	8b 45 0c             	mov    0xc(%ebp),%eax
  76:	89 cb                	mov    %ecx,%ebx
  78:	89 df                	mov    %ebx,%edi
  7a:	89 d1                	mov    %edx,%ecx
  7c:	fc                   	cld    
  7d:	f3 aa                	rep stos %al,%es:(%edi)
  7f:	89 ca                	mov    %ecx,%edx
  81:	89 fb                	mov    %edi,%ebx
  83:	89 5d 08             	mov    %ebx,0x8(%ebp)
  86:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  89:	5b                   	pop    %ebx
  8a:	5f                   	pop    %edi
  8b:	5d                   	pop    %ebp
  8c:	c3                   	ret    

0000008d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8d:	55                   	push   %ebp
  8e:	89 e5                	mov    %esp,%ebp
  90:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  99:	90                   	nop
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 10             	movzbl (%eax),%edx
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	88 10                	mov    %dl,(%eax)
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 00             	movzbl (%eax),%eax
  ab:	84 c0                	test   %al,%al
  ad:	0f 95 c0             	setne  %al
  b0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  b8:	84 c0                	test   %al,%al
  ba:	75 de                	jne    9a <strcpy+0xd>
    ;
  return os;
  bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bf:	c9                   	leave  
  c0:	c3                   	ret    

000000c1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c4:	eb 08                	jmp    ce <strcmp+0xd>
    p++, q++;
  c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ca:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	8b 45 08             	mov    0x8(%ebp),%eax
  d1:	0f b6 00             	movzbl (%eax),%eax
  d4:	84 c0                	test   %al,%al
  d6:	74 10                	je     e8 <strcmp+0x27>
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	0f b6 10             	movzbl (%eax),%edx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	0f b6 00             	movzbl (%eax),%eax
  e4:	38 c2                	cmp    %al,%dl
  e6:	74 de                	je     c6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	0f b6 d0             	movzbl %al,%edx
  f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 c0             	movzbl %al,%eax
  fa:	89 d1                	mov    %edx,%ecx
  fc:	29 c1                	sub    %eax,%ecx
  fe:	89 c8                	mov    %ecx,%eax
}
 100:	5d                   	pop    %ebp
 101:	c3                   	ret    

00000102 <strlen>:

uint
strlen(char *s)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 108:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10f:	eb 04                	jmp    115 <strlen+0x13>
 111:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 115:	8b 55 fc             	mov    -0x4(%ebp),%edx
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	01 d0                	add    %edx,%eax
 11d:	0f b6 00             	movzbl (%eax),%eax
 120:	84 c0                	test   %al,%al
 122:	75 ed                	jne    111 <strlen+0xf>
    ;
  return n;
 124:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 127:	c9                   	leave  
 128:	c3                   	ret    

00000129 <memset>:

void*
memset(void *dst, int c, uint n)
{
 129:	55                   	push   %ebp
 12a:	89 e5                	mov    %esp,%ebp
 12c:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 12f:	8b 45 10             	mov    0x10(%ebp),%eax
 132:	89 44 24 08          	mov    %eax,0x8(%esp)
 136:	8b 45 0c             	mov    0xc(%ebp),%eax
 139:	89 44 24 04          	mov    %eax,0x4(%esp)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	89 04 24             	mov    %eax,(%esp)
 143:	e8 20 ff ff ff       	call   68 <stosb>
  return dst;
 148:	8b 45 08             	mov    0x8(%ebp),%eax
}
 14b:	c9                   	leave  
 14c:	c3                   	ret    

0000014d <strchr>:

char*
strchr(const char *s, char c)
{
 14d:	55                   	push   %ebp
 14e:	89 e5                	mov    %esp,%ebp
 150:	83 ec 04             	sub    $0x4,%esp
 153:	8b 45 0c             	mov    0xc(%ebp),%eax
 156:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 159:	eb 14                	jmp    16f <strchr+0x22>
    if(*s == c)
 15b:	8b 45 08             	mov    0x8(%ebp),%eax
 15e:	0f b6 00             	movzbl (%eax),%eax
 161:	3a 45 fc             	cmp    -0x4(%ebp),%al
 164:	75 05                	jne    16b <strchr+0x1e>
      return (char*)s;
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	eb 13                	jmp    17e <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 16b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16f:	8b 45 08             	mov    0x8(%ebp),%eax
 172:	0f b6 00             	movzbl (%eax),%eax
 175:	84 c0                	test   %al,%al
 177:	75 e2                	jne    15b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 179:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17e:	c9                   	leave  
 17f:	c3                   	ret    

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 186:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18d:	eb 46                	jmp    1d5 <gets+0x55>
    cc = read(0, &c, 1);
 18f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 196:	00 
 197:	8d 45 ef             	lea    -0x11(%ebp),%eax
 19a:	89 44 24 04          	mov    %eax,0x4(%esp)
 19e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1a5:	e8 6a 02 00 00       	call   414 <read>
 1aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b1:	7e 2f                	jle    1e2 <gets+0x62>
      break;
    buf[i++] = c;
 1b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
 1b9:	01 c2                	add    %eax,%edx
 1bb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bf:	88 02                	mov    %al,(%edx)
 1c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 16                	je     1e3 <gets+0x63>
 1cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d1:	3c 0d                	cmp    $0xd,%al
 1d3:	74 0e                	je     1e3 <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d8:	83 c0 01             	add    $0x1,%eax
 1db:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1de:	7c af                	jl     18f <gets+0xf>
 1e0:	eb 01                	jmp    1e3 <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1e2:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	01 d0                	add    %edx,%eax
 1eb:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f1:	c9                   	leave  
 1f2:	c3                   	ret    

000001f3 <stat>:

int
stat(char *n, struct stat *st)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 200:	00 
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	89 04 24             	mov    %eax,(%esp)
 207:	e8 30 02 00 00       	call   43c <open>
 20c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 213:	79 07                	jns    21c <stat+0x29>
    return -1;
 215:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 21a:	eb 23                	jmp    23f <stat+0x4c>
  r = fstat(fd, st);
 21c:	8b 45 0c             	mov    0xc(%ebp),%eax
 21f:	89 44 24 04          	mov    %eax,0x4(%esp)
 223:	8b 45 f4             	mov    -0xc(%ebp),%eax
 226:	89 04 24             	mov    %eax,(%esp)
 229:	e8 26 02 00 00       	call   454 <fstat>
 22e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 231:	8b 45 f4             	mov    -0xc(%ebp),%eax
 234:	89 04 24             	mov    %eax,(%esp)
 237:	e8 e8 01 00 00       	call   424 <close>
  return r;
 23c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23f:	c9                   	leave  
 240:	c3                   	ret    

00000241 <atoi>:

int
atoi(const char *s)
{
 241:	55                   	push   %ebp
 242:	89 e5                	mov    %esp,%ebp
 244:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 247:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24e:	eb 23                	jmp    273 <atoi+0x32>
    n = n*10 + *s++ - '0';
 250:	8b 55 fc             	mov    -0x4(%ebp),%edx
 253:	89 d0                	mov    %edx,%eax
 255:	c1 e0 02             	shl    $0x2,%eax
 258:	01 d0                	add    %edx,%eax
 25a:	01 c0                	add    %eax,%eax
 25c:	89 c2                	mov    %eax,%edx
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	0f b6 00             	movzbl (%eax),%eax
 264:	0f be c0             	movsbl %al,%eax
 267:	01 d0                	add    %edx,%eax
 269:	83 e8 30             	sub    $0x30,%eax
 26c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 26f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	3c 2f                	cmp    $0x2f,%al
 27b:	7e 0a                	jle    287 <atoi+0x46>
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	0f b6 00             	movzbl (%eax),%eax
 283:	3c 39                	cmp    $0x39,%al
 285:	7e c9                	jle    250 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 287:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 28a:	c9                   	leave  
 28b:	c3                   	ret    

0000028c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28c:	55                   	push   %ebp
 28d:	89 e5                	mov    %esp,%ebp
 28f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 298:	8b 45 0c             	mov    0xc(%ebp),%eax
 29b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29e:	eb 13                	jmp    2b3 <memmove+0x27>
    *dst++ = *src++;
 2a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2a3:	0f b6 10             	movzbl (%eax),%edx
 2a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a9:	88 10                	mov    %dl,(%eax)
 2ab:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2af:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2b7:	0f 9f c0             	setg   %al
 2ba:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2be:	84 c0                	test   %al,%al
 2c0:	75 de                	jne    2a0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c5:	c9                   	leave  
 2c6:	c3                   	ret    
 2c7:	90                   	nop

000002c8 <SYS_ls_call01>:
 2c8:	6c                   	insb   (%dx),%es:(%edi)
 2c9:	73 5f                	jae    32a <SYS_ls_call10+0x8>
 2cb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2ce:	6c                   	insb   (%dx),%es:(%edi)
 2cf:	30 31                	xor    %dh,(%ecx)
	...

000002d2 <SYS_ls_call02>:
 2d2:	6c                   	insb   (%dx),%es:(%edi)
 2d3:	73 5f                	jae    334 <SYS_ls_call11+0x8>
 2d5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2d8:	6c                   	insb   (%dx),%es:(%edi)
 2d9:	30 32                	xor    %dh,(%edx)
	...

000002dc <SYS_ls_call03>:
 2dc:	6c                   	insb   (%dx),%es:(%edi)
 2dd:	73 5f                	jae    33e <SYS_ls_call12+0x8>
 2df:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2e2:	6c                   	insb   (%dx),%es:(%edi)
 2e3:	30 33                	xor    %dh,(%ebx)
	...

000002e6 <SYS_ls_call04>:
 2e6:	6c                   	insb   (%dx),%es:(%edi)
 2e7:	73 5f                	jae    348 <SYS_ls_call13+0x8>
 2e9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2ec:	6c                   	insb   (%dx),%es:(%edi)
 2ed:	30 34 00             	xor    %dh,(%eax,%eax,1)

000002f0 <SYS_ls_call05>:
 2f0:	6c                   	insb   (%dx),%es:(%edi)
 2f1:	73 5f                	jae    352 <SYS_ls_call14+0x8>
 2f3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2f6:	6c                   	insb   (%dx),%es:(%edi)
 2f7:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

000002fa <SYS_ls_call06>:
 2fa:	6c                   	insb   (%dx),%es:(%edi)
 2fb:	73 5f                	jae    35c <SYS_ls_call15+0x8>
 2fd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 300:	6c                   	insb   (%dx),%es:(%edi)
 301:	30 36                	xor    %dh,(%esi)
	...

00000304 <SYS_ls_call07>:
 304:	6c                   	insb   (%dx),%es:(%edi)
 305:	73 5f                	jae    366 <SYS_ls_call16+0x8>
 307:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 30a:	6c                   	insb   (%dx),%es:(%edi)
 30b:	30 37                	xor    %dh,(%edi)
	...

0000030e <SYS_ls_call08>:
 30e:	6c                   	insb   (%dx),%es:(%edi)
 30f:	73 5f                	jae    370 <SYS_ls_call17+0x8>
 311:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 314:	6c                   	insb   (%dx),%es:(%edi)
 315:	30 38                	xor    %bh,(%eax)
	...

00000318 <SYS_ls_call09>:
 318:	6c                   	insb   (%dx),%es:(%edi)
 319:	73 5f                	jae    37a <SYS_ls_call18+0x8>
 31b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 31e:	6c                   	insb   (%dx),%es:(%edi)
 31f:	30 39                	xor    %bh,(%ecx)
	...

00000322 <SYS_ls_call10>:
 322:	6c                   	insb   (%dx),%es:(%edi)
 323:	73 5f                	jae    384 <SYS_ls_call19+0x8>
 325:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 328:	6c                   	insb   (%dx),%es:(%edi)
 329:	31 30                	xor    %esi,(%eax)
	...

0000032c <SYS_ls_call11>:
 32c:	6c                   	insb   (%dx),%es:(%edi)
 32d:	73 5f                	jae    38e <SYS_ls_call20+0x8>
 32f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 332:	6c                   	insb   (%dx),%es:(%edi)
 333:	31 31                	xor    %esi,(%ecx)
	...

00000336 <SYS_ls_call12>:
 336:	6c                   	insb   (%dx),%es:(%edi)
 337:	73 5f                	jae    398 <SYS_ls_call21+0x8>
 339:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 33c:	6c                   	insb   (%dx),%es:(%edi)
 33d:	31 32                	xor    %esi,(%edx)
	...

00000340 <SYS_ls_call13>:
 340:	6c                   	insb   (%dx),%es:(%edi)
 341:	73 5f                	jae    3a2 <SYS_ls_call22+0x8>
 343:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 346:	6c                   	insb   (%dx),%es:(%edi)
 347:	31 33                	xor    %esi,(%ebx)
	...

0000034a <SYS_ls_call14>:
 34a:	6c                   	insb   (%dx),%es:(%edi)
 34b:	73 5f                	jae    3ac <SYS_ls_call23+0x8>
 34d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 350:	6c                   	insb   (%dx),%es:(%edi)
 351:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000354 <SYS_ls_call15>:
 354:	6c                   	insb   (%dx),%es:(%edi)
 355:	73 5f                	jae    3b6 <SYS_ls_call24+0x8>
 357:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 35a:	6c                   	insb   (%dx),%es:(%edi)
 35b:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

0000035e <SYS_ls_call16>:
 35e:	6c                   	insb   (%dx),%es:(%edi)
 35f:	73 5f                	jae    3c0 <SYS_ls_call25+0x8>
 361:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 364:	6c                   	insb   (%dx),%es:(%edi)
 365:	31 36                	xor    %esi,(%esi)
	...

00000368 <SYS_ls_call17>:
 368:	6c                   	insb   (%dx),%es:(%edi)
 369:	73 5f                	jae    3ca <SYS_ls_call26+0x8>
 36b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 36e:	6c                   	insb   (%dx),%es:(%edi)
 36f:	31 37                	xor    %esi,(%edi)
	...

00000372 <SYS_ls_call18>:
 372:	6c                   	insb   (%dx),%es:(%edi)
 373:	73 5f                	jae    3d4 <SYS_ls_call27+0x8>
 375:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 378:	6c                   	insb   (%dx),%es:(%edi)
 379:	31 38                	xor    %edi,(%eax)
	...

0000037c <SYS_ls_call19>:
 37c:	6c                   	insb   (%dx),%es:(%edi)
 37d:	73 5f                	jae    3de <SYS_ls_call28+0x8>
 37f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 382:	6c                   	insb   (%dx),%es:(%edi)
 383:	31 39                	xor    %edi,(%ecx)
	...

00000386 <SYS_ls_call20>:
 386:	6c                   	insb   (%dx),%es:(%edi)
 387:	73 5f                	jae    3e8 <SYS_ls_call29+0x8>
 389:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 38c:	6c                   	insb   (%dx),%es:(%edi)
 38d:	32 30                	xor    (%eax),%dh
	...

00000390 <SYS_ls_call21>:
 390:	6c                   	insb   (%dx),%es:(%edi)
 391:	73 5f                	jae    3f2 <SYS_ls_call30+0x8>
 393:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 396:	6c                   	insb   (%dx),%es:(%edi)
 397:	32 31                	xor    (%ecx),%dh
	...

0000039a <SYS_ls_call22>:
 39a:	6c                   	insb   (%dx),%es:(%edi)
 39b:	73 5f                	jae    3fc <exit>
 39d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a0:	6c                   	insb   (%dx),%es:(%edi)
 3a1:	32 32                	xor    (%edx),%dh
	...

000003a4 <SYS_ls_call23>:
 3a4:	6c                   	insb   (%dx),%es:(%edi)
 3a5:	73 5f                	jae    406 <wait+0x2>
 3a7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3aa:	6c                   	insb   (%dx),%es:(%edi)
 3ab:	32 33                	xor    (%ebx),%dh
	...

000003ae <SYS_ls_call24>:
 3ae:	6c                   	insb   (%dx),%es:(%edi)
 3af:	73 5f                	jae    410 <pipe+0x4>
 3b1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b4:	6c                   	insb   (%dx),%es:(%edi)
 3b5:	32 34 00             	xor    (%eax,%eax,1),%dh

000003b8 <SYS_ls_call25>:
 3b8:	6c                   	insb   (%dx),%es:(%edi)
 3b9:	73 5f                	jae    41a <read+0x6>
 3bb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3be:	6c                   	insb   (%dx),%es:(%edi)
 3bf:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000003c2 <SYS_ls_call26>:
 3c2:	6c                   	insb   (%dx),%es:(%edi)
 3c3:	73 5f                	jae    424 <close>
 3c5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c8:	6c                   	insb   (%dx),%es:(%edi)
 3c9:	32 36                	xor    (%esi),%dh
	...

000003cc <SYS_ls_call27>:
 3cc:	6c                   	insb   (%dx),%es:(%edi)
 3cd:	73 5f                	jae    42e <kill+0x2>
 3cf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d2:	6c                   	insb   (%dx),%es:(%edi)
 3d3:	32 37                	xor    (%edi),%dh
	...

000003d6 <SYS_ls_call28>:
 3d6:	6c                   	insb   (%dx),%es:(%edi)
 3d7:	73 5f                	jae    438 <exec+0x4>
 3d9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3dc:	6c                   	insb   (%dx),%es:(%edi)
 3dd:	32 38                	xor    (%eax),%bh
	...

000003e0 <SYS_ls_call29>:
 3e0:	6c                   	insb   (%dx),%es:(%edi)
 3e1:	73 5f                	jae    442 <open+0x6>
 3e3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e6:	6c                   	insb   (%dx),%es:(%edi)
 3e7:	32 39                	xor    (%ecx),%bh
	...

000003ea <SYS_ls_call30>:
 3ea:	6c                   	insb   (%dx),%es:(%edi)
 3eb:	73 5f                	jae    44c <unlink>
 3ed:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f0:	6c                   	insb   (%dx),%es:(%edi)
 3f1:	33 30                	xor    (%eax),%esi
	...

000003f4 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 3f4:	b8 01 00 00 00       	mov    $0x1,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <exit>:
SYSCALL(exit)
 3fc:	b8 02 00 00 00       	mov    $0x2,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <wait>:
SYSCALL(wait)
 404:	b8 03 00 00 00       	mov    $0x3,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <pipe>:
SYSCALL(pipe)
 40c:	b8 04 00 00 00       	mov    $0x4,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <read>:
SYSCALL(read)
 414:	b8 05 00 00 00       	mov    $0x5,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <write>:
SYSCALL(write)
 41c:	b8 10 00 00 00       	mov    $0x10,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <close>:
SYSCALL(close)
 424:	b8 15 00 00 00       	mov    $0x15,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <kill>:
SYSCALL(kill)
 42c:	b8 06 00 00 00       	mov    $0x6,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <exec>:
SYSCALL(exec)
 434:	b8 07 00 00 00       	mov    $0x7,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <open>:
SYSCALL(open)
 43c:	b8 0f 00 00 00       	mov    $0xf,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <mknod>:
SYSCALL(mknod)
 444:	b8 11 00 00 00       	mov    $0x11,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <unlink>:
SYSCALL(unlink)
 44c:	b8 12 00 00 00       	mov    $0x12,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <fstat>:
SYSCALL(fstat)
 454:	b8 08 00 00 00       	mov    $0x8,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <link>:
SYSCALL(link)
 45c:	b8 13 00 00 00       	mov    $0x13,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <mkdir>:
SYSCALL(mkdir)
 464:	b8 14 00 00 00       	mov    $0x14,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <chdir>:
SYSCALL(chdir)
 46c:	b8 09 00 00 00       	mov    $0x9,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <dup>:
SYSCALL(dup)
 474:	b8 0a 00 00 00       	mov    $0xa,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <getpid>:
SYSCALL(getpid)
 47c:	b8 0b 00 00 00       	mov    $0xb,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <sbrk>:
SYSCALL(sbrk)
 484:	b8 0c 00 00 00       	mov    $0xc,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <sleep>:
SYSCALL(sleep)
 48c:	b8 0d 00 00 00       	mov    $0xd,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <uptime>:
SYSCALL(uptime)
 494:	b8 0e 00 00 00       	mov    $0xe,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <date>:
SYSCALL(date)
 49c:	b8 16 00 00 00       	mov    $0x16,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <ls_call01>:

SYSCALL1(ls_call01)
 4a4:	b8 c8 02 00 00       	mov    $0x2c8,%eax
 4a9:	cd 41                	int    $0x41
 4ab:	c3                   	ret    

000004ac <ls_call02>:
SYSCALL1(ls_call02)
 4ac:	b8 d2 02 00 00       	mov    $0x2d2,%eax
 4b1:	cd 41                	int    $0x41
 4b3:	c3                   	ret    

000004b4 <ls_call03>:
SYSCALL1(ls_call03)
 4b4:	b8 dc 02 00 00       	mov    $0x2dc,%eax
 4b9:	cd 41                	int    $0x41
 4bb:	c3                   	ret    

000004bc <ls_call04>:
SYSCALL1(ls_call04)
 4bc:	b8 e6 02 00 00       	mov    $0x2e6,%eax
 4c1:	cd 41                	int    $0x41
 4c3:	c3                   	ret    

000004c4 <ls_call05>:
SYSCALL1(ls_call05)
 4c4:	b8 f0 02 00 00       	mov    $0x2f0,%eax
 4c9:	cd 41                	int    $0x41
 4cb:	c3                   	ret    

000004cc <ls_call06>:
SYSCALL1(ls_call06)
 4cc:	b8 fa 02 00 00       	mov    $0x2fa,%eax
 4d1:	cd 41                	int    $0x41
 4d3:	c3                   	ret    

000004d4 <ls_call07>:
SYSCALL1(ls_call07)
 4d4:	b8 04 03 00 00       	mov    $0x304,%eax
 4d9:	cd 41                	int    $0x41
 4db:	c3                   	ret    

000004dc <ls_call08>:
SYSCALL1(ls_call08)
 4dc:	b8 0e 03 00 00       	mov    $0x30e,%eax
 4e1:	cd 41                	int    $0x41
 4e3:	c3                   	ret    

000004e4 <ls_call09>:
SYSCALL1(ls_call09)
 4e4:	b8 18 03 00 00       	mov    $0x318,%eax
 4e9:	cd 41                	int    $0x41
 4eb:	c3                   	ret    

000004ec <ls_call10>:
SYSCALL1(ls_call10)
 4ec:	b8 22 03 00 00       	mov    $0x322,%eax
 4f1:	cd 41                	int    $0x41
 4f3:	c3                   	ret    

000004f4 <ls_call11>:
SYSCALL1(ls_call11)
 4f4:	b8 2c 03 00 00       	mov    $0x32c,%eax
 4f9:	cd 41                	int    $0x41
 4fb:	c3                   	ret    

000004fc <ls_call12>:
SYSCALL1(ls_call12)
 4fc:	b8 36 03 00 00       	mov    $0x336,%eax
 501:	cd 41                	int    $0x41
 503:	c3                   	ret    

00000504 <ls_call13>:
SYSCALL1(ls_call13)
 504:	b8 40 03 00 00       	mov    $0x340,%eax
 509:	cd 41                	int    $0x41
 50b:	c3                   	ret    

0000050c <ls_call14>:
SYSCALL1(ls_call14)
 50c:	b8 4a 03 00 00       	mov    $0x34a,%eax
 511:	cd 41                	int    $0x41
 513:	c3                   	ret    

00000514 <ls_call15>:
SYSCALL1(ls_call15)
 514:	b8 54 03 00 00       	mov    $0x354,%eax
 519:	cd 41                	int    $0x41
 51b:	c3                   	ret    

0000051c <ls_call16>:
SYSCALL1(ls_call16)
 51c:	b8 5e 03 00 00       	mov    $0x35e,%eax
 521:	cd 41                	int    $0x41
 523:	c3                   	ret    

00000524 <ls_call17>:
SYSCALL1(ls_call17)
 524:	b8 68 03 00 00       	mov    $0x368,%eax
 529:	cd 41                	int    $0x41
 52b:	c3                   	ret    

0000052c <ls_call18>:
SYSCALL1(ls_call18)
 52c:	b8 72 03 00 00       	mov    $0x372,%eax
 531:	cd 41                	int    $0x41
 533:	c3                   	ret    

00000534 <ls_call19>:
SYSCALL1(ls_call19)
 534:	b8 7c 03 00 00       	mov    $0x37c,%eax
 539:	cd 41                	int    $0x41
 53b:	c3                   	ret    

0000053c <ls_call20>:
SYSCALL1(ls_call20)
 53c:	b8 86 03 00 00       	mov    $0x386,%eax
 541:	cd 41                	int    $0x41
 543:	c3                   	ret    

00000544 <ls_call21>:
SYSCALL1(ls_call21)
 544:	b8 90 03 00 00       	mov    $0x390,%eax
 549:	cd 41                	int    $0x41
 54b:	c3                   	ret    

0000054c <ls_call22>:
SYSCALL1(ls_call22)
 54c:	b8 9a 03 00 00       	mov    $0x39a,%eax
 551:	cd 41                	int    $0x41
 553:	c3                   	ret    

00000554 <ls_call23>:
SYSCALL1(ls_call23)
 554:	b8 a4 03 00 00       	mov    $0x3a4,%eax
 559:	cd 41                	int    $0x41
 55b:	c3                   	ret    

0000055c <ls_call24>:
SYSCALL1(ls_call24)
 55c:	b8 ae 03 00 00       	mov    $0x3ae,%eax
 561:	cd 41                	int    $0x41
 563:	c3                   	ret    

00000564 <ls_call25>:
SYSCALL1(ls_call25)
 564:	b8 b8 03 00 00       	mov    $0x3b8,%eax
 569:	cd 41                	int    $0x41
 56b:	c3                   	ret    

0000056c <ls_call26>:
SYSCALL1(ls_call26)
 56c:	b8 c2 03 00 00       	mov    $0x3c2,%eax
 571:	cd 41                	int    $0x41
 573:	c3                   	ret    

00000574 <ls_call27>:
SYSCALL1(ls_call27)
 574:	b8 cc 03 00 00       	mov    $0x3cc,%eax
 579:	cd 41                	int    $0x41
 57b:	c3                   	ret    

0000057c <ls_call28>:
SYSCALL1(ls_call28)
 57c:	b8 d6 03 00 00       	mov    $0x3d6,%eax
 581:	cd 41                	int    $0x41
 583:	c3                   	ret    

00000584 <ls_call29>:
SYSCALL1(ls_call29)
 584:	b8 e0 03 00 00       	mov    $0x3e0,%eax
 589:	cd 41                	int    $0x41
 58b:	c3                   	ret    

0000058c <ls_call30>:
SYSCALL1(ls_call30)
 58c:	b8 ea 03 00 00       	mov    $0x3ea,%eax
 591:	cd 41                	int    $0x41
 593:	c3                   	ret    

00000594 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 594:	55                   	push   %ebp
 595:	89 e5                	mov    %esp,%ebp
 597:	83 ec 28             	sub    $0x28,%esp
 59a:	8b 45 0c             	mov    0xc(%ebp),%eax
 59d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a7:	00 
 5a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 5af:	8b 45 08             	mov    0x8(%ebp),%eax
 5b2:	89 04 24             	mov    %eax,(%esp)
 5b5:	e8 62 fe ff ff       	call   41c <write>
}
 5ba:	c9                   	leave  
 5bb:	c3                   	ret    

000005bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5bc:	55                   	push   %ebp
 5bd:	89 e5                	mov    %esp,%ebp
 5bf:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5c9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5cd:	74 17                	je     5e6 <printint+0x2a>
 5cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5d3:	79 11                	jns    5e6 <printint+0x2a>
    neg = 1;
 5d5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 5df:	f7 d8                	neg    %eax
 5e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5e4:	eb 06                	jmp    5ec <printint+0x30>
  } else {
    x = xx;
 5e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5f9:	ba 00 00 00 00       	mov    $0x0,%edx
 5fe:	f7 f1                	div    %ecx
 600:	89 d0                	mov    %edx,%eax
 602:	0f b6 80 98 0c 00 00 	movzbl 0xc98(%eax),%eax
 609:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 60c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 60f:	01 ca                	add    %ecx,%edx
 611:	88 02                	mov    %al,(%edx)
 613:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 617:	8b 55 10             	mov    0x10(%ebp),%edx
 61a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 61d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 620:	ba 00 00 00 00       	mov    $0x0,%edx
 625:	f7 75 d4             	divl   -0x2c(%ebp)
 628:	89 45 ec             	mov    %eax,-0x14(%ebp)
 62b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 62f:	75 c2                	jne    5f3 <printint+0x37>
  if(neg)
 631:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 635:	74 2e                	je     665 <printint+0xa9>
    buf[i++] = '-';
 637:	8d 55 dc             	lea    -0x24(%ebp),%edx
 63a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63d:	01 d0                	add    %edx,%eax
 63f:	c6 00 2d             	movb   $0x2d,(%eax)
 642:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 646:	eb 1d                	jmp    665 <printint+0xa9>
    putc(fd, buf[i]);
 648:	8d 55 dc             	lea    -0x24(%ebp),%edx
 64b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 64e:	01 d0                	add    %edx,%eax
 650:	0f b6 00             	movzbl (%eax),%eax
 653:	0f be c0             	movsbl %al,%eax
 656:	89 44 24 04          	mov    %eax,0x4(%esp)
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	89 04 24             	mov    %eax,(%esp)
 660:	e8 2f ff ff ff       	call   594 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 665:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 669:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 66d:	79 d9                	jns    648 <printint+0x8c>
    putc(fd, buf[i]);
}
 66f:	c9                   	leave  
 670:	c3                   	ret    

00000671 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 671:	55                   	push   %ebp
 672:	89 e5                	mov    %esp,%ebp
 674:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 677:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 67e:	8d 45 0c             	lea    0xc(%ebp),%eax
 681:	83 c0 04             	add    $0x4,%eax
 684:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 687:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 68e:	e9 7d 01 00 00       	jmp    810 <printf+0x19f>
    c = fmt[i] & 0xff;
 693:	8b 55 0c             	mov    0xc(%ebp),%edx
 696:	8b 45 f0             	mov    -0x10(%ebp),%eax
 699:	01 d0                	add    %edx,%eax
 69b:	0f b6 00             	movzbl (%eax),%eax
 69e:	0f be c0             	movsbl %al,%eax
 6a1:	25 ff 00 00 00       	and    $0xff,%eax
 6a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ad:	75 2c                	jne    6db <printf+0x6a>
      if(c == '%'){
 6af:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6b3:	75 0c                	jne    6c1 <printf+0x50>
        state = '%';
 6b5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6bc:	e9 4b 01 00 00       	jmp    80c <printf+0x19b>
      } else {
        putc(fd, c);
 6c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c4:	0f be c0             	movsbl %al,%eax
 6c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cb:	8b 45 08             	mov    0x8(%ebp),%eax
 6ce:	89 04 24             	mov    %eax,(%esp)
 6d1:	e8 be fe ff ff       	call   594 <putc>
 6d6:	e9 31 01 00 00       	jmp    80c <printf+0x19b>
      }
    } else if(state == '%'){
 6db:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6df:	0f 85 27 01 00 00    	jne    80c <printf+0x19b>
      if(c == 'd'){
 6e5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6e9:	75 2d                	jne    718 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 6eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ee:	8b 00                	mov    (%eax),%eax
 6f0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 6f7:	00 
 6f8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 6ff:	00 
 700:	89 44 24 04          	mov    %eax,0x4(%esp)
 704:	8b 45 08             	mov    0x8(%ebp),%eax
 707:	89 04 24             	mov    %eax,(%esp)
 70a:	e8 ad fe ff ff       	call   5bc <printint>
        ap++;
 70f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 713:	e9 ed 00 00 00       	jmp    805 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 718:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 71c:	74 06                	je     724 <printf+0xb3>
 71e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 722:	75 2d                	jne    751 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 724:	8b 45 e8             	mov    -0x18(%ebp),%eax
 727:	8b 00                	mov    (%eax),%eax
 729:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 730:	00 
 731:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 738:	00 
 739:	89 44 24 04          	mov    %eax,0x4(%esp)
 73d:	8b 45 08             	mov    0x8(%ebp),%eax
 740:	89 04 24             	mov    %eax,(%esp)
 743:	e8 74 fe ff ff       	call   5bc <printint>
        ap++;
 748:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 74c:	e9 b4 00 00 00       	jmp    805 <printf+0x194>
      } else if(c == 's'){
 751:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 755:	75 46                	jne    79d <printf+0x12c>
        s = (char*)*ap;
 757:	8b 45 e8             	mov    -0x18(%ebp),%eax
 75a:	8b 00                	mov    (%eax),%eax
 75c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 75f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 763:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 767:	75 27                	jne    790 <printf+0x11f>
          s = "(null)";
 769:	c7 45 f4 55 0a 00 00 	movl   $0xa55,-0xc(%ebp)
        while(*s != 0){
 770:	eb 1e                	jmp    790 <printf+0x11f>
          putc(fd, *s);
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	0f b6 00             	movzbl (%eax),%eax
 778:	0f be c0             	movsbl %al,%eax
 77b:	89 44 24 04          	mov    %eax,0x4(%esp)
 77f:	8b 45 08             	mov    0x8(%ebp),%eax
 782:	89 04 24             	mov    %eax,(%esp)
 785:	e8 0a fe ff ff       	call   594 <putc>
          s++;
 78a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 78e:	eb 01                	jmp    791 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 790:	90                   	nop
 791:	8b 45 f4             	mov    -0xc(%ebp),%eax
 794:	0f b6 00             	movzbl (%eax),%eax
 797:	84 c0                	test   %al,%al
 799:	75 d7                	jne    772 <printf+0x101>
 79b:	eb 68                	jmp    805 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 79d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7a1:	75 1d                	jne    7c0 <printf+0x14f>
        putc(fd, *ap);
 7a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7a6:	8b 00                	mov    (%eax),%eax
 7a8:	0f be c0             	movsbl %al,%eax
 7ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 7af:	8b 45 08             	mov    0x8(%ebp),%eax
 7b2:	89 04 24             	mov    %eax,(%esp)
 7b5:	e8 da fd ff ff       	call   594 <putc>
        ap++;
 7ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7be:	eb 45                	jmp    805 <printf+0x194>
      } else if(c == '%'){
 7c0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7c4:	75 17                	jne    7dd <printf+0x16c>
        putc(fd, c);
 7c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7c9:	0f be c0             	movsbl %al,%eax
 7cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 7d0:	8b 45 08             	mov    0x8(%ebp),%eax
 7d3:	89 04 24             	mov    %eax,(%esp)
 7d6:	e8 b9 fd ff ff       	call   594 <putc>
 7db:	eb 28                	jmp    805 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7dd:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 7e4:	00 
 7e5:	8b 45 08             	mov    0x8(%ebp),%eax
 7e8:	89 04 24             	mov    %eax,(%esp)
 7eb:	e8 a4 fd ff ff       	call   594 <putc>
        putc(fd, c);
 7f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7f3:	0f be c0             	movsbl %al,%eax
 7f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 7fa:	8b 45 08             	mov    0x8(%ebp),%eax
 7fd:	89 04 24             	mov    %eax,(%esp)
 800:	e8 8f fd ff ff       	call   594 <putc>
      }
      state = 0;
 805:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 80c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 810:	8b 55 0c             	mov    0xc(%ebp),%edx
 813:	8b 45 f0             	mov    -0x10(%ebp),%eax
 816:	01 d0                	add    %edx,%eax
 818:	0f b6 00             	movzbl (%eax),%eax
 81b:	84 c0                	test   %al,%al
 81d:	0f 85 70 fe ff ff    	jne    693 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 823:	c9                   	leave  
 824:	c3                   	ret    
 825:	90                   	nop
 826:	90                   	nop
 827:	90                   	nop

00000828 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 828:	55                   	push   %ebp
 829:	89 e5                	mov    %esp,%ebp
 82b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 82e:	8b 45 08             	mov    0x8(%ebp),%eax
 831:	83 e8 08             	sub    $0x8,%eax
 834:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 837:	a1 b4 0c 00 00       	mov    0xcb4,%eax
 83c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 83f:	eb 24                	jmp    865 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 841:	8b 45 fc             	mov    -0x4(%ebp),%eax
 844:	8b 00                	mov    (%eax),%eax
 846:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 849:	77 12                	ja     85d <free+0x35>
 84b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 851:	77 24                	ja     877 <free+0x4f>
 853:	8b 45 fc             	mov    -0x4(%ebp),%eax
 856:	8b 00                	mov    (%eax),%eax
 858:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 85b:	77 1a                	ja     877 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	8b 00                	mov    (%eax),%eax
 862:	89 45 fc             	mov    %eax,-0x4(%ebp)
 865:	8b 45 f8             	mov    -0x8(%ebp),%eax
 868:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 86b:	76 d4                	jbe    841 <free+0x19>
 86d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 870:	8b 00                	mov    (%eax),%eax
 872:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 875:	76 ca                	jbe    841 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 877:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87a:	8b 40 04             	mov    0x4(%eax),%eax
 87d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 884:	8b 45 f8             	mov    -0x8(%ebp),%eax
 887:	01 c2                	add    %eax,%edx
 889:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88c:	8b 00                	mov    (%eax),%eax
 88e:	39 c2                	cmp    %eax,%edx
 890:	75 24                	jne    8b6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 892:	8b 45 f8             	mov    -0x8(%ebp),%eax
 895:	8b 50 04             	mov    0x4(%eax),%edx
 898:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	8b 40 04             	mov    0x4(%eax),%eax
 8a0:	01 c2                	add    %eax,%edx
 8a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ab:	8b 00                	mov    (%eax),%eax
 8ad:	8b 10                	mov    (%eax),%edx
 8af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b2:	89 10                	mov    %edx,(%eax)
 8b4:	eb 0a                	jmp    8c0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b9:	8b 10                	mov    (%eax),%edx
 8bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8be:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c3:	8b 40 04             	mov    0x4(%eax),%eax
 8c6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d0:	01 d0                	add    %edx,%eax
 8d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8d5:	75 20                	jne    8f7 <free+0xcf>
    p->s.size += bp->s.size;
 8d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8da:	8b 50 04             	mov    0x4(%eax),%edx
 8dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e0:	8b 40 04             	mov    0x4(%eax),%eax
 8e3:	01 c2                	add    %eax,%edx
 8e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ee:	8b 10                	mov    (%eax),%edx
 8f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f3:	89 10                	mov    %edx,(%eax)
 8f5:	eb 08                	jmp    8ff <free+0xd7>
  } else
    p->s.ptr = bp;
 8f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fa:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8fd:	89 10                	mov    %edx,(%eax)
  freep = p;
 8ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 902:	a3 b4 0c 00 00       	mov    %eax,0xcb4
}
 907:	c9                   	leave  
 908:	c3                   	ret    

00000909 <morecore>:

static Header*
morecore(uint nu)
{
 909:	55                   	push   %ebp
 90a:	89 e5                	mov    %esp,%ebp
 90c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 90f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 916:	77 07                	ja     91f <morecore+0x16>
    nu = 4096;
 918:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 91f:	8b 45 08             	mov    0x8(%ebp),%eax
 922:	c1 e0 03             	shl    $0x3,%eax
 925:	89 04 24             	mov    %eax,(%esp)
 928:	e8 57 fb ff ff       	call   484 <sbrk>
 92d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 930:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 934:	75 07                	jne    93d <morecore+0x34>
    return 0;
 936:	b8 00 00 00 00       	mov    $0x0,%eax
 93b:	eb 22                	jmp    95f <morecore+0x56>
  hp = (Header*)p;
 93d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 940:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 943:	8b 45 f0             	mov    -0x10(%ebp),%eax
 946:	8b 55 08             	mov    0x8(%ebp),%edx
 949:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 94c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94f:	83 c0 08             	add    $0x8,%eax
 952:	89 04 24             	mov    %eax,(%esp)
 955:	e8 ce fe ff ff       	call   828 <free>
  return freep;
 95a:	a1 b4 0c 00 00       	mov    0xcb4,%eax
}
 95f:	c9                   	leave  
 960:	c3                   	ret    

00000961 <malloc>:

void*
malloc(uint nbytes)
{
 961:	55                   	push   %ebp
 962:	89 e5                	mov    %esp,%ebp
 964:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 967:	8b 45 08             	mov    0x8(%ebp),%eax
 96a:	83 c0 07             	add    $0x7,%eax
 96d:	c1 e8 03             	shr    $0x3,%eax
 970:	83 c0 01             	add    $0x1,%eax
 973:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 976:	a1 b4 0c 00 00       	mov    0xcb4,%eax
 97b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 97e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 982:	75 23                	jne    9a7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 984:	c7 45 f0 ac 0c 00 00 	movl   $0xcac,-0x10(%ebp)
 98b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 98e:	a3 b4 0c 00 00       	mov    %eax,0xcb4
 993:	a1 b4 0c 00 00       	mov    0xcb4,%eax
 998:	a3 ac 0c 00 00       	mov    %eax,0xcac
    base.s.size = 0;
 99d:	c7 05 b0 0c 00 00 00 	movl   $0x0,0xcb0
 9a4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9aa:	8b 00                	mov    (%eax),%eax
 9ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b2:	8b 40 04             	mov    0x4(%eax),%eax
 9b5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9b8:	72 4d                	jb     a07 <malloc+0xa6>
      if(p->s.size == nunits)
 9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bd:	8b 40 04             	mov    0x4(%eax),%eax
 9c0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9c3:	75 0c                	jne    9d1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c8:	8b 10                	mov    (%eax),%edx
 9ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9cd:	89 10                	mov    %edx,(%eax)
 9cf:	eb 26                	jmp    9f7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 9d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d4:	8b 40 04             	mov    0x4(%eax),%eax
 9d7:	89 c2                	mov    %eax,%edx
 9d9:	2b 55 ec             	sub    -0x14(%ebp),%edx
 9dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9df:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e5:	8b 40 04             	mov    0x4(%eax),%eax
 9e8:	c1 e0 03             	shl    $0x3,%eax
 9eb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9f4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9fa:	a3 b4 0c 00 00       	mov    %eax,0xcb4
      return (void*)(p + 1);
 9ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a02:	83 c0 08             	add    $0x8,%eax
 a05:	eb 38                	jmp    a3f <malloc+0xde>
    }
    if(p == freep)
 a07:	a1 b4 0c 00 00       	mov    0xcb4,%eax
 a0c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a0f:	75 1b                	jne    a2c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a11:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a14:	89 04 24             	mov    %eax,(%esp)
 a17:	e8 ed fe ff ff       	call   909 <morecore>
 a1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a23:	75 07                	jne    a2c <malloc+0xcb>
        return 0;
 a25:	b8 00 00 00 00       	mov    $0x0,%eax
 a2a:	eb 13                	jmp    a3f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a35:	8b 00                	mov    (%eax),%eax
 a37:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a3a:	e9 70 ff ff ff       	jmp    9af <malloc+0x4e>
}
 a3f:	c9                   	leave  
 a40:	c3                   	ret    
