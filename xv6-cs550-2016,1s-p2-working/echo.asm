
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "date.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 30             	sub    $0x30,%esp
  int i;
  struct rtcdate r;
  date(&r);
   9:	8d 44 24 14          	lea    0x14(%esp),%eax
   d:	89 04 24             	mov    %eax,(%esp)
  10:	e8 bb 04 00 00       	call   4d0 <date>
  printf(1,"%d, %d", r.year,r.month);
  15:	8b 54 24 24          	mov    0x24(%esp),%edx
  19:	8b 44 24 28          	mov    0x28(%esp),%eax
  1d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  21:	89 44 24 08          	mov    %eax,0x8(%esp)
  25:	c7 44 24 04 75 0a 00 	movl   $0xa75,0x4(%esp)
  2c:	00 
  2d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  34:	e8 6c 06 00 00       	call   6a5 <printf>


  for(i = 1; i < argc; i++)
  39:	c7 44 24 2c 01 00 00 	movl   $0x1,0x2c(%esp)
  40:	00 
  41:	eb 4b                	jmp    8e <main+0x8e>
  printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  43:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  47:	83 c0 01             	add    $0x1,%eax
  4a:	3b 45 08             	cmp    0x8(%ebp),%eax
  4d:	7d 07                	jge    56 <main+0x56>
  4f:	b8 7c 0a 00 00       	mov    $0xa7c,%eax
  54:	eb 05                	jmp    5b <main+0x5b>
  56:	b8 7e 0a 00 00       	mov    $0xa7e,%eax
  5b:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  5f:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  66:	8b 55 0c             	mov    0xc(%ebp),%edx
  69:	01 ca                	add    %ecx,%edx
  6b:	8b 12                	mov    (%edx),%edx
  6d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  71:	89 54 24 08          	mov    %edx,0x8(%esp)
  75:	c7 44 24 04 80 0a 00 	movl   $0xa80,0x4(%esp)
  7c:	00 
  7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  84:	e8 1c 06 00 00       	call   6a5 <printf>
  struct rtcdate r;
  date(&r);
  printf(1,"%d, %d", r.year,r.month);


  for(i = 1; i < argc; i++)
  89:	83 44 24 2c 01       	addl   $0x1,0x2c(%esp)
  8e:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  92:	3b 45 08             	cmp    0x8(%ebp),%eax
  95:	7c ac                	jl     43 <main+0x43>
  printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  97:	e8 94 03 00 00       	call   430 <exit>

0000009c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  9c:	55                   	push   %ebp
  9d:	89 e5                	mov    %esp,%ebp
  9f:	57                   	push   %edi
  a0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a4:	8b 55 10             	mov    0x10(%ebp),%edx
  a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  aa:	89 cb                	mov    %ecx,%ebx
  ac:	89 df                	mov    %ebx,%edi
  ae:	89 d1                	mov    %edx,%ecx
  b0:	fc                   	cld    
  b1:	f3 aa                	rep stos %al,%es:(%edi)
  b3:	89 ca                	mov    %ecx,%edx
  b5:	89 fb                	mov    %edi,%ebx
  b7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ba:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  bd:	5b                   	pop    %ebx
  be:	5f                   	pop    %edi
  bf:	5d                   	pop    %ebp
  c0:	c3                   	ret    

000000c1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  c4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  c7:	8b 45 08             	mov    0x8(%ebp),%eax
  ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  cd:	90                   	nop
  ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  d1:	0f b6 10             	movzbl (%eax),%edx
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	88 10                	mov    %dl,(%eax)
  d9:	8b 45 08             	mov    0x8(%ebp),%eax
  dc:	0f b6 00             	movzbl (%eax),%eax
  df:	84 c0                	test   %al,%al
  e1:	0f 95 c0             	setne  %al
  e4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  ec:	84 c0                	test   %al,%al
  ee:	75 de                	jne    ce <strcpy+0xd>
    ;
  return os;
  f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f3:	c9                   	leave  
  f4:	c3                   	ret    

000000f5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f5:	55                   	push   %ebp
  f6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  f8:	eb 08                	jmp    102 <strcmp+0xd>
    p++, q++;
  fa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  fe:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 102:	8b 45 08             	mov    0x8(%ebp),%eax
 105:	0f b6 00             	movzbl (%eax),%eax
 108:	84 c0                	test   %al,%al
 10a:	74 10                	je     11c <strcmp+0x27>
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	0f b6 10             	movzbl (%eax),%edx
 112:	8b 45 0c             	mov    0xc(%ebp),%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	38 c2                	cmp    %al,%dl
 11a:	74 de                	je     fa <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 11c:	8b 45 08             	mov    0x8(%ebp),%eax
 11f:	0f b6 00             	movzbl (%eax),%eax
 122:	0f b6 d0             	movzbl %al,%edx
 125:	8b 45 0c             	mov    0xc(%ebp),%eax
 128:	0f b6 00             	movzbl (%eax),%eax
 12b:	0f b6 c0             	movzbl %al,%eax
 12e:	89 d1                	mov    %edx,%ecx
 130:	29 c1                	sub    %eax,%ecx
 132:	89 c8                	mov    %ecx,%eax
}
 134:	5d                   	pop    %ebp
 135:	c3                   	ret    

00000136 <strlen>:

uint
strlen(char *s)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
 139:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 13c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 143:	eb 04                	jmp    149 <strlen+0x13>
 145:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 149:	8b 55 fc             	mov    -0x4(%ebp),%edx
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	01 d0                	add    %edx,%eax
 151:	0f b6 00             	movzbl (%eax),%eax
 154:	84 c0                	test   %al,%al
 156:	75 ed                	jne    145 <strlen+0xf>
    ;
  return n;
 158:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15b:	c9                   	leave  
 15c:	c3                   	ret    

0000015d <memset>:

void*
memset(void *dst, int c, uint n)
{
 15d:	55                   	push   %ebp
 15e:	89 e5                	mov    %esp,%ebp
 160:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 163:	8b 45 10             	mov    0x10(%ebp),%eax
 166:	89 44 24 08          	mov    %eax,0x8(%esp)
 16a:	8b 45 0c             	mov    0xc(%ebp),%eax
 16d:	89 44 24 04          	mov    %eax,0x4(%esp)
 171:	8b 45 08             	mov    0x8(%ebp),%eax
 174:	89 04 24             	mov    %eax,(%esp)
 177:	e8 20 ff ff ff       	call   9c <stosb>
  return dst;
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 17f:	c9                   	leave  
 180:	c3                   	ret    

00000181 <strchr>:

char*
strchr(const char *s, char c)
{
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	83 ec 04             	sub    $0x4,%esp
 187:	8b 45 0c             	mov    0xc(%ebp),%eax
 18a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 18d:	eb 14                	jmp    1a3 <strchr+0x22>
    if(*s == c)
 18f:	8b 45 08             	mov    0x8(%ebp),%eax
 192:	0f b6 00             	movzbl (%eax),%eax
 195:	3a 45 fc             	cmp    -0x4(%ebp),%al
 198:	75 05                	jne    19f <strchr+0x1e>
      return (char*)s;
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	eb 13                	jmp    1b2 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 19f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	0f b6 00             	movzbl (%eax),%eax
 1a9:	84 c0                	test   %al,%al
 1ab:	75 e2                	jne    18f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b2:	c9                   	leave  
 1b3:	c3                   	ret    

000001b4 <gets>:

char*
gets(char *buf, int max)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1c1:	eb 46                	jmp    209 <gets+0x55>
    cc = read(0, &c, 1);
 1c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1ca:	00 
 1cb:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1d9:	e8 6a 02 00 00       	call   448 <read>
 1de:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1e5:	7e 2f                	jle    216 <gets+0x62>
      break;
    buf[i++] = c;
 1e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
 1ed:	01 c2                	add    %eax,%edx
 1ef:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f3:	88 02                	mov    %al,(%edx)
 1f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1fd:	3c 0a                	cmp    $0xa,%al
 1ff:	74 16                	je     217 <gets+0x63>
 201:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 205:	3c 0d                	cmp    $0xd,%al
 207:	74 0e                	je     217 <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 209:	8b 45 f4             	mov    -0xc(%ebp),%eax
 20c:	83 c0 01             	add    $0x1,%eax
 20f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 212:	7c af                	jl     1c3 <gets+0xf>
 214:	eb 01                	jmp    217 <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 216:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 217:	8b 55 f4             	mov    -0xc(%ebp),%edx
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	01 d0                	add    %edx,%eax
 21f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 222:	8b 45 08             	mov    0x8(%ebp),%eax
}
 225:	c9                   	leave  
 226:	c3                   	ret    

00000227 <stat>:

int
stat(char *n, struct stat *st)
{
 227:	55                   	push   %ebp
 228:	89 e5                	mov    %esp,%ebp
 22a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 234:	00 
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	89 04 24             	mov    %eax,(%esp)
 23b:	e8 30 02 00 00       	call   470 <open>
 240:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 243:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 247:	79 07                	jns    250 <stat+0x29>
    return -1;
 249:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 24e:	eb 23                	jmp    273 <stat+0x4c>
  r = fstat(fd, st);
 250:	8b 45 0c             	mov    0xc(%ebp),%eax
 253:	89 44 24 04          	mov    %eax,0x4(%esp)
 257:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25a:	89 04 24             	mov    %eax,(%esp)
 25d:	e8 26 02 00 00       	call   488 <fstat>
 262:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 265:	8b 45 f4             	mov    -0xc(%ebp),%eax
 268:	89 04 24             	mov    %eax,(%esp)
 26b:	e8 e8 01 00 00       	call   458 <close>
  return r;
 270:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 273:	c9                   	leave  
 274:	c3                   	ret    

00000275 <atoi>:

int
atoi(const char *s)
{
 275:	55                   	push   %ebp
 276:	89 e5                	mov    %esp,%ebp
 278:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 27b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 282:	eb 23                	jmp    2a7 <atoi+0x32>
    n = n*10 + *s++ - '0';
 284:	8b 55 fc             	mov    -0x4(%ebp),%edx
 287:	89 d0                	mov    %edx,%eax
 289:	c1 e0 02             	shl    $0x2,%eax
 28c:	01 d0                	add    %edx,%eax
 28e:	01 c0                	add    %eax,%eax
 290:	89 c2                	mov    %eax,%edx
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	0f b6 00             	movzbl (%eax),%eax
 298:	0f be c0             	movsbl %al,%eax
 29b:	01 d0                	add    %edx,%eax
 29d:	83 e8 30             	sub    $0x30,%eax
 2a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2a3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	0f b6 00             	movzbl (%eax),%eax
 2ad:	3c 2f                	cmp    $0x2f,%al
 2af:	7e 0a                	jle    2bb <atoi+0x46>
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	0f b6 00             	movzbl (%eax),%eax
 2b7:	3c 39                	cmp    $0x39,%al
 2b9:	7e c9                	jle    284 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2be:	c9                   	leave  
 2bf:	c3                   	ret    

000002c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
 2c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2d2:	eb 13                	jmp    2e7 <memmove+0x27>
    *dst++ = *src++;
 2d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2d7:	0f b6 10             	movzbl (%eax),%edx
 2da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2dd:	88 10                	mov    %dl,(%eax)
 2df:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2e3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2eb:	0f 9f c0             	setg   %al
 2ee:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2f2:	84 c0                	test   %al,%al
 2f4:	75 de                	jne    2d4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2f9:	c9                   	leave  
 2fa:	c3                   	ret    
 2fb:	90                   	nop

000002fc <SYS_ls_call01>:
 2fc:	6c                   	insb   (%dx),%es:(%edi)
 2fd:	73 5f                	jae    35e <SYS_ls_call10+0x8>
 2ff:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 302:	6c                   	insb   (%dx),%es:(%edi)
 303:	30 31                	xor    %dh,(%ecx)
	...

00000306 <SYS_ls_call02>:
 306:	6c                   	insb   (%dx),%es:(%edi)
 307:	73 5f                	jae    368 <SYS_ls_call11+0x8>
 309:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 30c:	6c                   	insb   (%dx),%es:(%edi)
 30d:	30 32                	xor    %dh,(%edx)
	...

00000310 <SYS_ls_call03>:
 310:	6c                   	insb   (%dx),%es:(%edi)
 311:	73 5f                	jae    372 <SYS_ls_call12+0x8>
 313:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 316:	6c                   	insb   (%dx),%es:(%edi)
 317:	30 33                	xor    %dh,(%ebx)
	...

0000031a <SYS_ls_call04>:
 31a:	6c                   	insb   (%dx),%es:(%edi)
 31b:	73 5f                	jae    37c <SYS_ls_call13+0x8>
 31d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 320:	6c                   	insb   (%dx),%es:(%edi)
 321:	30 34 00             	xor    %dh,(%eax,%eax,1)

00000324 <SYS_ls_call05>:
 324:	6c                   	insb   (%dx),%es:(%edi)
 325:	73 5f                	jae    386 <SYS_ls_call14+0x8>
 327:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 32a:	6c                   	insb   (%dx),%es:(%edi)
 32b:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

0000032e <SYS_ls_call06>:
 32e:	6c                   	insb   (%dx),%es:(%edi)
 32f:	73 5f                	jae    390 <SYS_ls_call15+0x8>
 331:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 334:	6c                   	insb   (%dx),%es:(%edi)
 335:	30 36                	xor    %dh,(%esi)
	...

00000338 <SYS_ls_call07>:
 338:	6c                   	insb   (%dx),%es:(%edi)
 339:	73 5f                	jae    39a <SYS_ls_call16+0x8>
 33b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 33e:	6c                   	insb   (%dx),%es:(%edi)
 33f:	30 37                	xor    %dh,(%edi)
	...

00000342 <SYS_ls_call08>:
 342:	6c                   	insb   (%dx),%es:(%edi)
 343:	73 5f                	jae    3a4 <SYS_ls_call17+0x8>
 345:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 348:	6c                   	insb   (%dx),%es:(%edi)
 349:	30 38                	xor    %bh,(%eax)
	...

0000034c <SYS_ls_call09>:
 34c:	6c                   	insb   (%dx),%es:(%edi)
 34d:	73 5f                	jae    3ae <SYS_ls_call18+0x8>
 34f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 352:	6c                   	insb   (%dx),%es:(%edi)
 353:	30 39                	xor    %bh,(%ecx)
	...

00000356 <SYS_ls_call10>:
 356:	6c                   	insb   (%dx),%es:(%edi)
 357:	73 5f                	jae    3b8 <SYS_ls_call19+0x8>
 359:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 35c:	6c                   	insb   (%dx),%es:(%edi)
 35d:	31 30                	xor    %esi,(%eax)
	...

00000360 <SYS_ls_call11>:
 360:	6c                   	insb   (%dx),%es:(%edi)
 361:	73 5f                	jae    3c2 <SYS_ls_call20+0x8>
 363:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 366:	6c                   	insb   (%dx),%es:(%edi)
 367:	31 31                	xor    %esi,(%ecx)
	...

0000036a <SYS_ls_call12>:
 36a:	6c                   	insb   (%dx),%es:(%edi)
 36b:	73 5f                	jae    3cc <SYS_ls_call21+0x8>
 36d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 370:	6c                   	insb   (%dx),%es:(%edi)
 371:	31 32                	xor    %esi,(%edx)
	...

00000374 <SYS_ls_call13>:
 374:	6c                   	insb   (%dx),%es:(%edi)
 375:	73 5f                	jae    3d6 <SYS_ls_call22+0x8>
 377:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 37a:	6c                   	insb   (%dx),%es:(%edi)
 37b:	31 33                	xor    %esi,(%ebx)
	...

0000037e <SYS_ls_call14>:
 37e:	6c                   	insb   (%dx),%es:(%edi)
 37f:	73 5f                	jae    3e0 <SYS_ls_call23+0x8>
 381:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 384:	6c                   	insb   (%dx),%es:(%edi)
 385:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000388 <SYS_ls_call15>:
 388:	6c                   	insb   (%dx),%es:(%edi)
 389:	73 5f                	jae    3ea <SYS_ls_call24+0x8>
 38b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 38e:	6c                   	insb   (%dx),%es:(%edi)
 38f:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000392 <SYS_ls_call16>:
 392:	6c                   	insb   (%dx),%es:(%edi)
 393:	73 5f                	jae    3f4 <SYS_ls_call25+0x8>
 395:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 398:	6c                   	insb   (%dx),%es:(%edi)
 399:	31 36                	xor    %esi,(%esi)
	...

0000039c <SYS_ls_call17>:
 39c:	6c                   	insb   (%dx),%es:(%edi)
 39d:	73 5f                	jae    3fe <SYS_ls_call26+0x8>
 39f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a2:	6c                   	insb   (%dx),%es:(%edi)
 3a3:	31 37                	xor    %esi,(%edi)
	...

000003a6 <SYS_ls_call18>:
 3a6:	6c                   	insb   (%dx),%es:(%edi)
 3a7:	73 5f                	jae    408 <SYS_ls_call27+0x8>
 3a9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ac:	6c                   	insb   (%dx),%es:(%edi)
 3ad:	31 38                	xor    %edi,(%eax)
	...

000003b0 <SYS_ls_call19>:
 3b0:	6c                   	insb   (%dx),%es:(%edi)
 3b1:	73 5f                	jae    412 <SYS_ls_call28+0x8>
 3b3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b6:	6c                   	insb   (%dx),%es:(%edi)
 3b7:	31 39                	xor    %edi,(%ecx)
	...

000003ba <SYS_ls_call20>:
 3ba:	6c                   	insb   (%dx),%es:(%edi)
 3bb:	73 5f                	jae    41c <SYS_ls_call29+0x8>
 3bd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c0:	6c                   	insb   (%dx),%es:(%edi)
 3c1:	32 30                	xor    (%eax),%dh
	...

000003c4 <SYS_ls_call21>:
 3c4:	6c                   	insb   (%dx),%es:(%edi)
 3c5:	73 5f                	jae    426 <SYS_ls_call30+0x8>
 3c7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ca:	6c                   	insb   (%dx),%es:(%edi)
 3cb:	32 31                	xor    (%ecx),%dh
	...

000003ce <SYS_ls_call22>:
 3ce:	6c                   	insb   (%dx),%es:(%edi)
 3cf:	73 5f                	jae    430 <exit>
 3d1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d4:	6c                   	insb   (%dx),%es:(%edi)
 3d5:	32 32                	xor    (%edx),%dh
	...

000003d8 <SYS_ls_call23>:
 3d8:	6c                   	insb   (%dx),%es:(%edi)
 3d9:	73 5f                	jae    43a <wait+0x2>
 3db:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3de:	6c                   	insb   (%dx),%es:(%edi)
 3df:	32 33                	xor    (%ebx),%dh
	...

000003e2 <SYS_ls_call24>:
 3e2:	6c                   	insb   (%dx),%es:(%edi)
 3e3:	73 5f                	jae    444 <pipe+0x4>
 3e5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e8:	6c                   	insb   (%dx),%es:(%edi)
 3e9:	32 34 00             	xor    (%eax,%eax,1),%dh

000003ec <SYS_ls_call25>:
 3ec:	6c                   	insb   (%dx),%es:(%edi)
 3ed:	73 5f                	jae    44e <read+0x6>
 3ef:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f2:	6c                   	insb   (%dx),%es:(%edi)
 3f3:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000003f6 <SYS_ls_call26>:
 3f6:	6c                   	insb   (%dx),%es:(%edi)
 3f7:	73 5f                	jae    458 <close>
 3f9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3fc:	6c                   	insb   (%dx),%es:(%edi)
 3fd:	32 36                	xor    (%esi),%dh
	...

00000400 <SYS_ls_call27>:
 400:	6c                   	insb   (%dx),%es:(%edi)
 401:	73 5f                	jae    462 <kill+0x2>
 403:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 406:	6c                   	insb   (%dx),%es:(%edi)
 407:	32 37                	xor    (%edi),%dh
	...

0000040a <SYS_ls_call28>:
 40a:	6c                   	insb   (%dx),%es:(%edi)
 40b:	73 5f                	jae    46c <exec+0x4>
 40d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 410:	6c                   	insb   (%dx),%es:(%edi)
 411:	32 38                	xor    (%eax),%bh
	...

00000414 <SYS_ls_call29>:
 414:	6c                   	insb   (%dx),%es:(%edi)
 415:	73 5f                	jae    476 <open+0x6>
 417:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 41a:	6c                   	insb   (%dx),%es:(%edi)
 41b:	32 39                	xor    (%ecx),%bh
	...

0000041e <SYS_ls_call30>:
 41e:	6c                   	insb   (%dx),%es:(%edi)
 41f:	73 5f                	jae    480 <unlink>
 421:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 424:	6c                   	insb   (%dx),%es:(%edi)
 425:	33 30                	xor    (%eax),%esi
	...

00000428 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 428:	b8 01 00 00 00       	mov    $0x1,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <exit>:
SYSCALL(exit)
 430:	b8 02 00 00 00       	mov    $0x2,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <wait>:
SYSCALL(wait)
 438:	b8 03 00 00 00       	mov    $0x3,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <pipe>:
SYSCALL(pipe)
 440:	b8 04 00 00 00       	mov    $0x4,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <read>:
SYSCALL(read)
 448:	b8 05 00 00 00       	mov    $0x5,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <write>:
SYSCALL(write)
 450:	b8 10 00 00 00       	mov    $0x10,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <close>:
SYSCALL(close)
 458:	b8 15 00 00 00       	mov    $0x15,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <kill>:
SYSCALL(kill)
 460:	b8 06 00 00 00       	mov    $0x6,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <exec>:
SYSCALL(exec)
 468:	b8 07 00 00 00       	mov    $0x7,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <open>:
SYSCALL(open)
 470:	b8 0f 00 00 00       	mov    $0xf,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <mknod>:
SYSCALL(mknod)
 478:	b8 11 00 00 00       	mov    $0x11,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <unlink>:
SYSCALL(unlink)
 480:	b8 12 00 00 00       	mov    $0x12,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <fstat>:
SYSCALL(fstat)
 488:	b8 08 00 00 00       	mov    $0x8,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <link>:
SYSCALL(link)
 490:	b8 13 00 00 00       	mov    $0x13,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <mkdir>:
SYSCALL(mkdir)
 498:	b8 14 00 00 00       	mov    $0x14,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <chdir>:
SYSCALL(chdir)
 4a0:	b8 09 00 00 00       	mov    $0x9,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <dup>:
SYSCALL(dup)
 4a8:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <getpid>:
SYSCALL(getpid)
 4b0:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <sbrk>:
SYSCALL(sbrk)
 4b8:	b8 0c 00 00 00       	mov    $0xc,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <sleep>:
SYSCALL(sleep)
 4c0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <uptime>:
SYSCALL(uptime)
 4c8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <date>:
SYSCALL(date)
 4d0:	b8 16 00 00 00       	mov    $0x16,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <ls_call01>:

SYSCALL1(ls_call01)
 4d8:	b8 fc 02 00 00       	mov    $0x2fc,%eax
 4dd:	cd 41                	int    $0x41
 4df:	c3                   	ret    

000004e0 <ls_call02>:
SYSCALL1(ls_call02)
 4e0:	b8 06 03 00 00       	mov    $0x306,%eax
 4e5:	cd 41                	int    $0x41
 4e7:	c3                   	ret    

000004e8 <ls_call03>:
SYSCALL1(ls_call03)
 4e8:	b8 10 03 00 00       	mov    $0x310,%eax
 4ed:	cd 41                	int    $0x41
 4ef:	c3                   	ret    

000004f0 <ls_call04>:
SYSCALL1(ls_call04)
 4f0:	b8 1a 03 00 00       	mov    $0x31a,%eax
 4f5:	cd 41                	int    $0x41
 4f7:	c3                   	ret    

000004f8 <ls_call05>:
SYSCALL1(ls_call05)
 4f8:	b8 24 03 00 00       	mov    $0x324,%eax
 4fd:	cd 41                	int    $0x41
 4ff:	c3                   	ret    

00000500 <ls_call06>:
SYSCALL1(ls_call06)
 500:	b8 2e 03 00 00       	mov    $0x32e,%eax
 505:	cd 41                	int    $0x41
 507:	c3                   	ret    

00000508 <ls_call07>:
SYSCALL1(ls_call07)
 508:	b8 38 03 00 00       	mov    $0x338,%eax
 50d:	cd 41                	int    $0x41
 50f:	c3                   	ret    

00000510 <ls_call08>:
SYSCALL1(ls_call08)
 510:	b8 42 03 00 00       	mov    $0x342,%eax
 515:	cd 41                	int    $0x41
 517:	c3                   	ret    

00000518 <ls_call09>:
SYSCALL1(ls_call09)
 518:	b8 4c 03 00 00       	mov    $0x34c,%eax
 51d:	cd 41                	int    $0x41
 51f:	c3                   	ret    

00000520 <ls_call10>:
SYSCALL1(ls_call10)
 520:	b8 56 03 00 00       	mov    $0x356,%eax
 525:	cd 41                	int    $0x41
 527:	c3                   	ret    

00000528 <ls_call11>:
SYSCALL1(ls_call11)
 528:	b8 60 03 00 00       	mov    $0x360,%eax
 52d:	cd 41                	int    $0x41
 52f:	c3                   	ret    

00000530 <ls_call12>:
SYSCALL1(ls_call12)
 530:	b8 6a 03 00 00       	mov    $0x36a,%eax
 535:	cd 41                	int    $0x41
 537:	c3                   	ret    

00000538 <ls_call13>:
SYSCALL1(ls_call13)
 538:	b8 74 03 00 00       	mov    $0x374,%eax
 53d:	cd 41                	int    $0x41
 53f:	c3                   	ret    

00000540 <ls_call14>:
SYSCALL1(ls_call14)
 540:	b8 7e 03 00 00       	mov    $0x37e,%eax
 545:	cd 41                	int    $0x41
 547:	c3                   	ret    

00000548 <ls_call15>:
SYSCALL1(ls_call15)
 548:	b8 88 03 00 00       	mov    $0x388,%eax
 54d:	cd 41                	int    $0x41
 54f:	c3                   	ret    

00000550 <ls_call16>:
SYSCALL1(ls_call16)
 550:	b8 92 03 00 00       	mov    $0x392,%eax
 555:	cd 41                	int    $0x41
 557:	c3                   	ret    

00000558 <ls_call17>:
SYSCALL1(ls_call17)
 558:	b8 9c 03 00 00       	mov    $0x39c,%eax
 55d:	cd 41                	int    $0x41
 55f:	c3                   	ret    

00000560 <ls_call18>:
SYSCALL1(ls_call18)
 560:	b8 a6 03 00 00       	mov    $0x3a6,%eax
 565:	cd 41                	int    $0x41
 567:	c3                   	ret    

00000568 <ls_call19>:
SYSCALL1(ls_call19)
 568:	b8 b0 03 00 00       	mov    $0x3b0,%eax
 56d:	cd 41                	int    $0x41
 56f:	c3                   	ret    

00000570 <ls_call20>:
SYSCALL1(ls_call20)
 570:	b8 ba 03 00 00       	mov    $0x3ba,%eax
 575:	cd 41                	int    $0x41
 577:	c3                   	ret    

00000578 <ls_call21>:
SYSCALL1(ls_call21)
 578:	b8 c4 03 00 00       	mov    $0x3c4,%eax
 57d:	cd 41                	int    $0x41
 57f:	c3                   	ret    

00000580 <ls_call22>:
SYSCALL1(ls_call22)
 580:	b8 ce 03 00 00       	mov    $0x3ce,%eax
 585:	cd 41                	int    $0x41
 587:	c3                   	ret    

00000588 <ls_call23>:
SYSCALL1(ls_call23)
 588:	b8 d8 03 00 00       	mov    $0x3d8,%eax
 58d:	cd 41                	int    $0x41
 58f:	c3                   	ret    

00000590 <ls_call24>:
SYSCALL1(ls_call24)
 590:	b8 e2 03 00 00       	mov    $0x3e2,%eax
 595:	cd 41                	int    $0x41
 597:	c3                   	ret    

00000598 <ls_call25>:
SYSCALL1(ls_call25)
 598:	b8 ec 03 00 00       	mov    $0x3ec,%eax
 59d:	cd 41                	int    $0x41
 59f:	c3                   	ret    

000005a0 <ls_call26>:
SYSCALL1(ls_call26)
 5a0:	b8 f6 03 00 00       	mov    $0x3f6,%eax
 5a5:	cd 41                	int    $0x41
 5a7:	c3                   	ret    

000005a8 <ls_call27>:
SYSCALL1(ls_call27)
 5a8:	b8 00 04 00 00       	mov    $0x400,%eax
 5ad:	cd 41                	int    $0x41
 5af:	c3                   	ret    

000005b0 <ls_call28>:
SYSCALL1(ls_call28)
 5b0:	b8 0a 04 00 00       	mov    $0x40a,%eax
 5b5:	cd 41                	int    $0x41
 5b7:	c3                   	ret    

000005b8 <ls_call29>:
SYSCALL1(ls_call29)
 5b8:	b8 14 04 00 00       	mov    $0x414,%eax
 5bd:	cd 41                	int    $0x41
 5bf:	c3                   	ret    

000005c0 <ls_call30>:
SYSCALL1(ls_call30)
 5c0:	b8 1e 04 00 00       	mov    $0x41e,%eax
 5c5:	cd 41                	int    $0x41
 5c7:	c3                   	ret    

000005c8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5c8:	55                   	push   %ebp
 5c9:	89 e5                	mov    %esp,%ebp
 5cb:	83 ec 28             	sub    $0x28,%esp
 5ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 5d1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5db:	00 
 5dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5df:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	89 04 24             	mov    %eax,(%esp)
 5e9:	e8 62 fe ff ff       	call   450 <write>
}
 5ee:	c9                   	leave  
 5ef:	c3                   	ret    

000005f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5fd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 601:	74 17                	je     61a <printint+0x2a>
 603:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 607:	79 11                	jns    61a <printint+0x2a>
    neg = 1;
 609:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 610:	8b 45 0c             	mov    0xc(%ebp),%eax
 613:	f7 d8                	neg    %eax
 615:	89 45 ec             	mov    %eax,-0x14(%ebp)
 618:	eb 06                	jmp    620 <printint+0x30>
  } else {
    x = xx;
 61a:	8b 45 0c             	mov    0xc(%ebp),%eax
 61d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 620:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 627:	8b 4d 10             	mov    0x10(%ebp),%ecx
 62a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 62d:	ba 00 00 00 00       	mov    $0x0,%edx
 632:	f7 f1                	div    %ecx
 634:	89 d0                	mov    %edx,%eax
 636:	0f b6 80 c8 0c 00 00 	movzbl 0xcc8(%eax),%eax
 63d:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 640:	8b 55 f4             	mov    -0xc(%ebp),%edx
 643:	01 ca                	add    %ecx,%edx
 645:	88 02                	mov    %al,(%edx)
 647:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 64b:	8b 55 10             	mov    0x10(%ebp),%edx
 64e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 651:	8b 45 ec             	mov    -0x14(%ebp),%eax
 654:	ba 00 00 00 00       	mov    $0x0,%edx
 659:	f7 75 d4             	divl   -0x2c(%ebp)
 65c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 65f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 663:	75 c2                	jne    627 <printint+0x37>
  if(neg)
 665:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 669:	74 2e                	je     699 <printint+0xa9>
    buf[i++] = '-';
 66b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 66e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 671:	01 d0                	add    %edx,%eax
 673:	c6 00 2d             	movb   $0x2d,(%eax)
 676:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 67a:	eb 1d                	jmp    699 <printint+0xa9>
    putc(fd, buf[i]);
 67c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 67f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 682:	01 d0                	add    %edx,%eax
 684:	0f b6 00             	movzbl (%eax),%eax
 687:	0f be c0             	movsbl %al,%eax
 68a:	89 44 24 04          	mov    %eax,0x4(%esp)
 68e:	8b 45 08             	mov    0x8(%ebp),%eax
 691:	89 04 24             	mov    %eax,(%esp)
 694:	e8 2f ff ff ff       	call   5c8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 699:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 69d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a1:	79 d9                	jns    67c <printint+0x8c>
    putc(fd, buf[i]);
}
 6a3:	c9                   	leave  
 6a4:	c3                   	ret    

000006a5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6a5:	55                   	push   %ebp
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6b2:	8d 45 0c             	lea    0xc(%ebp),%eax
 6b5:	83 c0 04             	add    $0x4,%eax
 6b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6c2:	e9 7d 01 00 00       	jmp    844 <printf+0x19f>
    c = fmt[i] & 0xff;
 6c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cd:	01 d0                	add    %edx,%eax
 6cf:	0f b6 00             	movzbl (%eax),%eax
 6d2:	0f be c0             	movsbl %al,%eax
 6d5:	25 ff 00 00 00       	and    $0xff,%eax
 6da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6e1:	75 2c                	jne    70f <printf+0x6a>
      if(c == '%'){
 6e3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6e7:	75 0c                	jne    6f5 <printf+0x50>
        state = '%';
 6e9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6f0:	e9 4b 01 00 00       	jmp    840 <printf+0x19b>
      } else {
        putc(fd, c);
 6f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6f8:	0f be c0             	movsbl %al,%eax
 6fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ff:	8b 45 08             	mov    0x8(%ebp),%eax
 702:	89 04 24             	mov    %eax,(%esp)
 705:	e8 be fe ff ff       	call   5c8 <putc>
 70a:	e9 31 01 00 00       	jmp    840 <printf+0x19b>
      }
    } else if(state == '%'){
 70f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 713:	0f 85 27 01 00 00    	jne    840 <printf+0x19b>
      if(c == 'd'){
 719:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 71d:	75 2d                	jne    74c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 71f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 722:	8b 00                	mov    (%eax),%eax
 724:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 72b:	00 
 72c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 733:	00 
 734:	89 44 24 04          	mov    %eax,0x4(%esp)
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	89 04 24             	mov    %eax,(%esp)
 73e:	e8 ad fe ff ff       	call   5f0 <printint>
        ap++;
 743:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 747:	e9 ed 00 00 00       	jmp    839 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 74c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 750:	74 06                	je     758 <printf+0xb3>
 752:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 756:	75 2d                	jne    785 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 758:	8b 45 e8             	mov    -0x18(%ebp),%eax
 75b:	8b 00                	mov    (%eax),%eax
 75d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 764:	00 
 765:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 76c:	00 
 76d:	89 44 24 04          	mov    %eax,0x4(%esp)
 771:	8b 45 08             	mov    0x8(%ebp),%eax
 774:	89 04 24             	mov    %eax,(%esp)
 777:	e8 74 fe ff ff       	call   5f0 <printint>
        ap++;
 77c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 780:	e9 b4 00 00 00       	jmp    839 <printf+0x194>
      } else if(c == 's'){
 785:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 789:	75 46                	jne    7d1 <printf+0x12c>
        s = (char*)*ap;
 78b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 78e:	8b 00                	mov    (%eax),%eax
 790:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 793:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 797:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 79b:	75 27                	jne    7c4 <printf+0x11f>
          s = "(null)";
 79d:	c7 45 f4 85 0a 00 00 	movl   $0xa85,-0xc(%ebp)
        while(*s != 0){
 7a4:	eb 1e                	jmp    7c4 <printf+0x11f>
          putc(fd, *s);
 7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a9:	0f b6 00             	movzbl (%eax),%eax
 7ac:	0f be c0             	movsbl %al,%eax
 7af:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b3:	8b 45 08             	mov    0x8(%ebp),%eax
 7b6:	89 04 24             	mov    %eax,(%esp)
 7b9:	e8 0a fe ff ff       	call   5c8 <putc>
          s++;
 7be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 7c2:	eb 01                	jmp    7c5 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7c4:	90                   	nop
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	0f b6 00             	movzbl (%eax),%eax
 7cb:	84 c0                	test   %al,%al
 7cd:	75 d7                	jne    7a6 <printf+0x101>
 7cf:	eb 68                	jmp    839 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7d1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7d5:	75 1d                	jne    7f4 <printf+0x14f>
        putc(fd, *ap);
 7d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	0f be c0             	movsbl %al,%eax
 7df:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e3:	8b 45 08             	mov    0x8(%ebp),%eax
 7e6:	89 04 24             	mov    %eax,(%esp)
 7e9:	e8 da fd ff ff       	call   5c8 <putc>
        ap++;
 7ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f2:	eb 45                	jmp    839 <printf+0x194>
      } else if(c == '%'){
 7f4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7f8:	75 17                	jne    811 <printf+0x16c>
        putc(fd, c);
 7fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7fd:	0f be c0             	movsbl %al,%eax
 800:	89 44 24 04          	mov    %eax,0x4(%esp)
 804:	8b 45 08             	mov    0x8(%ebp),%eax
 807:	89 04 24             	mov    %eax,(%esp)
 80a:	e8 b9 fd ff ff       	call   5c8 <putc>
 80f:	eb 28                	jmp    839 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 811:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 818:	00 
 819:	8b 45 08             	mov    0x8(%ebp),%eax
 81c:	89 04 24             	mov    %eax,(%esp)
 81f:	e8 a4 fd ff ff       	call   5c8 <putc>
        putc(fd, c);
 824:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 827:	0f be c0             	movsbl %al,%eax
 82a:	89 44 24 04          	mov    %eax,0x4(%esp)
 82e:	8b 45 08             	mov    0x8(%ebp),%eax
 831:	89 04 24             	mov    %eax,(%esp)
 834:	e8 8f fd ff ff       	call   5c8 <putc>
      }
      state = 0;
 839:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 840:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 844:	8b 55 0c             	mov    0xc(%ebp),%edx
 847:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84a:	01 d0                	add    %edx,%eax
 84c:	0f b6 00             	movzbl (%eax),%eax
 84f:	84 c0                	test   %al,%al
 851:	0f 85 70 fe ff ff    	jne    6c7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 857:	c9                   	leave  
 858:	c3                   	ret    
 859:	90                   	nop
 85a:	90                   	nop
 85b:	90                   	nop

0000085c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85c:	55                   	push   %ebp
 85d:	89 e5                	mov    %esp,%ebp
 85f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 862:	8b 45 08             	mov    0x8(%ebp),%eax
 865:	83 e8 08             	sub    $0x8,%eax
 868:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86b:	a1 e4 0c 00 00       	mov    0xce4,%eax
 870:	89 45 fc             	mov    %eax,-0x4(%ebp)
 873:	eb 24                	jmp    899 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 875:	8b 45 fc             	mov    -0x4(%ebp),%eax
 878:	8b 00                	mov    (%eax),%eax
 87a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 87d:	77 12                	ja     891 <free+0x35>
 87f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 882:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 885:	77 24                	ja     8ab <free+0x4f>
 887:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88a:	8b 00                	mov    (%eax),%eax
 88c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 88f:	77 1a                	ja     8ab <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	8b 45 fc             	mov    -0x4(%ebp),%eax
 894:	8b 00                	mov    (%eax),%eax
 896:	89 45 fc             	mov    %eax,-0x4(%ebp)
 899:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 89f:	76 d4                	jbe    875 <free+0x19>
 8a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a4:	8b 00                	mov    (%eax),%eax
 8a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8a9:	76 ca                	jbe    875 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ae:	8b 40 04             	mov    0x4(%eax),%eax
 8b1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bb:	01 c2                	add    %eax,%edx
 8bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c0:	8b 00                	mov    (%eax),%eax
 8c2:	39 c2                	cmp    %eax,%edx
 8c4:	75 24                	jne    8ea <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c9:	8b 50 04             	mov    0x4(%eax),%edx
 8cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cf:	8b 00                	mov    (%eax),%eax
 8d1:	8b 40 04             	mov    0x4(%eax),%eax
 8d4:	01 c2                	add    %eax,%edx
 8d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8df:	8b 00                	mov    (%eax),%eax
 8e1:	8b 10                	mov    (%eax),%edx
 8e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e6:	89 10                	mov    %edx,(%eax)
 8e8:	eb 0a                	jmp    8f4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ed:	8b 10                	mov    (%eax),%edx
 8ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f7:	8b 40 04             	mov    0x4(%eax),%eax
 8fa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 901:	8b 45 fc             	mov    -0x4(%ebp),%eax
 904:	01 d0                	add    %edx,%eax
 906:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 909:	75 20                	jne    92b <free+0xcf>
    p->s.size += bp->s.size;
 90b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90e:	8b 50 04             	mov    0x4(%eax),%edx
 911:	8b 45 f8             	mov    -0x8(%ebp),%eax
 914:	8b 40 04             	mov    0x4(%eax),%eax
 917:	01 c2                	add    %eax,%edx
 919:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 91f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 922:	8b 10                	mov    (%eax),%edx
 924:	8b 45 fc             	mov    -0x4(%ebp),%eax
 927:	89 10                	mov    %edx,(%eax)
 929:	eb 08                	jmp    933 <free+0xd7>
  } else
    p->s.ptr = bp;
 92b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 931:	89 10                	mov    %edx,(%eax)
  freep = p;
 933:	8b 45 fc             	mov    -0x4(%ebp),%eax
 936:	a3 e4 0c 00 00       	mov    %eax,0xce4
}
 93b:	c9                   	leave  
 93c:	c3                   	ret    

0000093d <morecore>:

static Header*
morecore(uint nu)
{
 93d:	55                   	push   %ebp
 93e:	89 e5                	mov    %esp,%ebp
 940:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 943:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 94a:	77 07                	ja     953 <morecore+0x16>
    nu = 4096;
 94c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 953:	8b 45 08             	mov    0x8(%ebp),%eax
 956:	c1 e0 03             	shl    $0x3,%eax
 959:	89 04 24             	mov    %eax,(%esp)
 95c:	e8 57 fb ff ff       	call   4b8 <sbrk>
 961:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 964:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 968:	75 07                	jne    971 <morecore+0x34>
    return 0;
 96a:	b8 00 00 00 00       	mov    $0x0,%eax
 96f:	eb 22                	jmp    993 <morecore+0x56>
  hp = (Header*)p;
 971:	8b 45 f4             	mov    -0xc(%ebp),%eax
 974:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 977:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97a:	8b 55 08             	mov    0x8(%ebp),%edx
 97d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 980:	8b 45 f0             	mov    -0x10(%ebp),%eax
 983:	83 c0 08             	add    $0x8,%eax
 986:	89 04 24             	mov    %eax,(%esp)
 989:	e8 ce fe ff ff       	call   85c <free>
  return freep;
 98e:	a1 e4 0c 00 00       	mov    0xce4,%eax
}
 993:	c9                   	leave  
 994:	c3                   	ret    

00000995 <malloc>:

void*
malloc(uint nbytes)
{
 995:	55                   	push   %ebp
 996:	89 e5                	mov    %esp,%ebp
 998:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99b:	8b 45 08             	mov    0x8(%ebp),%eax
 99e:	83 c0 07             	add    $0x7,%eax
 9a1:	c1 e8 03             	shr    $0x3,%eax
 9a4:	83 c0 01             	add    $0x1,%eax
 9a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9aa:	a1 e4 0c 00 00       	mov    0xce4,%eax
 9af:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9b6:	75 23                	jne    9db <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9b8:	c7 45 f0 dc 0c 00 00 	movl   $0xcdc,-0x10(%ebp)
 9bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c2:	a3 e4 0c 00 00       	mov    %eax,0xce4
 9c7:	a1 e4 0c 00 00       	mov    0xce4,%eax
 9cc:	a3 dc 0c 00 00       	mov    %eax,0xcdc
    base.s.size = 0;
 9d1:	c7 05 e0 0c 00 00 00 	movl   $0x0,0xce0
 9d8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9de:	8b 00                	mov    (%eax),%eax
 9e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e6:	8b 40 04             	mov    0x4(%eax),%eax
 9e9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9ec:	72 4d                	jb     a3b <malloc+0xa6>
      if(p->s.size == nunits)
 9ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f1:	8b 40 04             	mov    0x4(%eax),%eax
 9f4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9f7:	75 0c                	jne    a05 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fc:	8b 10                	mov    (%eax),%edx
 9fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a01:	89 10                	mov    %edx,(%eax)
 a03:	eb 26                	jmp    a2b <malloc+0x96>
      else {
        p->s.size -= nunits;
 a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a08:	8b 40 04             	mov    0x4(%eax),%eax
 a0b:	89 c2                	mov    %eax,%edx
 a0d:	2b 55 ec             	sub    -0x14(%ebp),%edx
 a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a13:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a19:	8b 40 04             	mov    0x4(%eax),%eax
 a1c:	c1 e0 03             	shl    $0x3,%eax
 a1f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a25:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a28:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2e:	a3 e4 0c 00 00       	mov    %eax,0xce4
      return (void*)(p + 1);
 a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a36:	83 c0 08             	add    $0x8,%eax
 a39:	eb 38                	jmp    a73 <malloc+0xde>
    }
    if(p == freep)
 a3b:	a1 e4 0c 00 00       	mov    0xce4,%eax
 a40:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a43:	75 1b                	jne    a60 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a45:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a48:	89 04 24             	mov    %eax,(%esp)
 a4b:	e8 ed fe ff ff       	call   93d <morecore>
 a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a57:	75 07                	jne    a60 <malloc+0xcb>
        return 0;
 a59:	b8 00 00 00 00       	mov    $0x0,%eax
 a5e:	eb 13                	jmp    a73 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a63:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a69:	8b 00                	mov    (%eax),%eax
 a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a6e:	e9 70 ff ff ff       	jmp    9e3 <malloc+0x4e>
}
 a73:	c9                   	leave  
 a74:	c3                   	ret    
