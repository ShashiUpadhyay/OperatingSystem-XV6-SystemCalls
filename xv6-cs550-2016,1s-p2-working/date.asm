
_date:     file format elf32-i386


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
   9:	83 ec 40             	sub    $0x40,%esp

  struct rtcdate r;
  if (argc > 1)
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  10:	7e 16                	jle    28 <main+0x28>
  	printf(1,"Too many arguments!\n");
  12:	c7 44 24 04 5c 0a 00 	movl   $0xa5c,0x4(%esp)
  19:	00 
  1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  21:	e8 63 06 00 00       	call   689 <printf>
  26:	eb 50                	jmp    78 <main+0x78>
  else
  {
  date(&r);
  28:	8d 44 24 28          	lea    0x28(%esp),%eax
  2c:	89 04 24             	mov    %eax,(%esp)
  2f:	e8 80 04 00 00       	call   4b4 <date>
  printf(1,"Year:%d, Month:%d,Day:%d Time %d-%d-%d\n", r.year,r.month,r.day, r.hour,r.minute, r.second);
  34:	8b 7c 24 28          	mov    0x28(%esp),%edi
  38:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  3c:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  40:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  44:	8b 54 24 38          	mov    0x38(%esp),%edx
  48:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  4c:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
  50:	89 74 24 18          	mov    %esi,0x18(%esp)
  54:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  58:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  5c:	89 54 24 0c          	mov    %edx,0xc(%esp)
  60:	89 44 24 08          	mov    %eax,0x8(%esp)
  64:	c7 44 24 04 74 0a 00 	movl   $0xa74,0x4(%esp)
  6b:	00 
  6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  73:	e8 11 06 00 00       	call   689 <printf>
  }
  exit(); 
  78:	e8 97 03 00 00       	call   414 <exit>
  7d:	90                   	nop
  7e:	90                   	nop
  7f:	90                   	nop

00000080 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	57                   	push   %edi
  84:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  85:	8b 4d 08             	mov    0x8(%ebp),%ecx
  88:	8b 55 10             	mov    0x10(%ebp),%edx
  8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  8e:	89 cb                	mov    %ecx,%ebx
  90:	89 df                	mov    %ebx,%edi
  92:	89 d1                	mov    %edx,%ecx
  94:	fc                   	cld    
  95:	f3 aa                	rep stos %al,%es:(%edi)
  97:	89 ca                	mov    %ecx,%edx
  99:	89 fb                	mov    %edi,%ebx
  9b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a1:	5b                   	pop    %ebx
  a2:	5f                   	pop    %edi
  a3:	5d                   	pop    %ebp
  a4:	c3                   	ret    

000000a5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a5:	55                   	push   %ebp
  a6:	89 e5                	mov    %esp,%ebp
  a8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  ab:	8b 45 08             	mov    0x8(%ebp),%eax
  ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  b1:	90                   	nop
  b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  b5:	0f b6 10             	movzbl (%eax),%edx
  b8:	8b 45 08             	mov    0x8(%ebp),%eax
  bb:	88 10                	mov    %dl,(%eax)
  bd:	8b 45 08             	mov    0x8(%ebp),%eax
  c0:	0f b6 00             	movzbl (%eax),%eax
  c3:	84 c0                	test   %al,%al
  c5:	0f 95 c0             	setne  %al
  c8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  cc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  d0:	84 c0                	test   %al,%al
  d2:	75 de                	jne    b2 <strcpy+0xd>
    ;
  return os;
  d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d7:	c9                   	leave  
  d8:	c3                   	ret    

000000d9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d9:	55                   	push   %ebp
  da:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  dc:	eb 08                	jmp    e6 <strcmp+0xd>
    p++, q++;
  de:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	0f b6 00             	movzbl (%eax),%eax
  ec:	84 c0                	test   %al,%al
  ee:	74 10                	je     100 <strcmp+0x27>
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	0f b6 10             	movzbl (%eax),%edx
  f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  f9:	0f b6 00             	movzbl (%eax),%eax
  fc:	38 c2                	cmp    %al,%dl
  fe:	74 de                	je     de <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 100:	8b 45 08             	mov    0x8(%ebp),%eax
 103:	0f b6 00             	movzbl (%eax),%eax
 106:	0f b6 d0             	movzbl %al,%edx
 109:	8b 45 0c             	mov    0xc(%ebp),%eax
 10c:	0f b6 00             	movzbl (%eax),%eax
 10f:	0f b6 c0             	movzbl %al,%eax
 112:	89 d1                	mov    %edx,%ecx
 114:	29 c1                	sub    %eax,%ecx
 116:	89 c8                	mov    %ecx,%eax
}
 118:	5d                   	pop    %ebp
 119:	c3                   	ret    

0000011a <strlen>:

uint
strlen(char *s)
{
 11a:	55                   	push   %ebp
 11b:	89 e5                	mov    %esp,%ebp
 11d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 127:	eb 04                	jmp    12d <strlen+0x13>
 129:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 12d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	01 d0                	add    %edx,%eax
 135:	0f b6 00             	movzbl (%eax),%eax
 138:	84 c0                	test   %al,%al
 13a:	75 ed                	jne    129 <strlen+0xf>
    ;
  return n;
 13c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13f:	c9                   	leave  
 140:	c3                   	ret    

00000141 <memset>:

void*
memset(void *dst, int c, uint n)
{
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 147:	8b 45 10             	mov    0x10(%ebp),%eax
 14a:	89 44 24 08          	mov    %eax,0x8(%esp)
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	89 44 24 04          	mov    %eax,0x4(%esp)
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	89 04 24             	mov    %eax,(%esp)
 15b:	e8 20 ff ff ff       	call   80 <stosb>
  return dst;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
}
 163:	c9                   	leave  
 164:	c3                   	ret    

00000165 <strchr>:

char*
strchr(const char *s, char c)
{
 165:	55                   	push   %ebp
 166:	89 e5                	mov    %esp,%ebp
 168:	83 ec 04             	sub    $0x4,%esp
 16b:	8b 45 0c             	mov    0xc(%ebp),%eax
 16e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 171:	eb 14                	jmp    187 <strchr+0x22>
    if(*s == c)
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 00             	movzbl (%eax),%eax
 179:	3a 45 fc             	cmp    -0x4(%ebp),%al
 17c:	75 05                	jne    183 <strchr+0x1e>
      return (char*)s;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	eb 13                	jmp    196 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 183:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 e2                	jne    173 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 191:	b8 00 00 00 00       	mov    $0x0,%eax
}
 196:	c9                   	leave  
 197:	c3                   	ret    

00000198 <gets>:

char*
gets(char *buf, int max)
{
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a5:	eb 46                	jmp    1ed <gets+0x55>
    cc = read(0, &c, 1);
 1a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1ae:	00 
 1af:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1bd:	e8 6a 02 00 00       	call   42c <read>
 1c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c9:	7e 2f                	jle    1fa <gets+0x62>
      break;
    buf[i++] = c;
 1cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ce:	8b 45 08             	mov    0x8(%ebp),%eax
 1d1:	01 c2                	add    %eax,%edx
 1d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d7:	88 02                	mov    %al,(%edx)
 1d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e1:	3c 0a                	cmp    $0xa,%al
 1e3:	74 16                	je     1fb <gets+0x63>
 1e5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e9:	3c 0d                	cmp    $0xd,%al
 1eb:	74 0e                	je     1fb <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f6:	7c af                	jl     1a7 <gets+0xf>
 1f8:	eb 01                	jmp    1fb <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1fa:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1fe:	8b 45 08             	mov    0x8(%ebp),%eax
 201:	01 d0                	add    %edx,%eax
 203:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 206:	8b 45 08             	mov    0x8(%ebp),%eax
}
 209:	c9                   	leave  
 20a:	c3                   	ret    

0000020b <stat>:

int
stat(char *n, struct stat *st)
{
 20b:	55                   	push   %ebp
 20c:	89 e5                	mov    %esp,%ebp
 20e:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 211:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 218:	00 
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	89 04 24             	mov    %eax,(%esp)
 21f:	e8 30 02 00 00       	call   454 <open>
 224:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 227:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 22b:	79 07                	jns    234 <stat+0x29>
    return -1;
 22d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 232:	eb 23                	jmp    257 <stat+0x4c>
  r = fstat(fd, st);
 234:	8b 45 0c             	mov    0xc(%ebp),%eax
 237:	89 44 24 04          	mov    %eax,0x4(%esp)
 23b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23e:	89 04 24             	mov    %eax,(%esp)
 241:	e8 26 02 00 00       	call   46c <fstat>
 246:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 249:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24c:	89 04 24             	mov    %eax,(%esp)
 24f:	e8 e8 01 00 00       	call   43c <close>
  return r;
 254:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 257:	c9                   	leave  
 258:	c3                   	ret    

00000259 <atoi>:

int
atoi(const char *s)
{
 259:	55                   	push   %ebp
 25a:	89 e5                	mov    %esp,%ebp
 25c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 266:	eb 23                	jmp    28b <atoi+0x32>
    n = n*10 + *s++ - '0';
 268:	8b 55 fc             	mov    -0x4(%ebp),%edx
 26b:	89 d0                	mov    %edx,%eax
 26d:	c1 e0 02             	shl    $0x2,%eax
 270:	01 d0                	add    %edx,%eax
 272:	01 c0                	add    %eax,%eax
 274:	89 c2                	mov    %eax,%edx
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	0f b6 00             	movzbl (%eax),%eax
 27c:	0f be c0             	movsbl %al,%eax
 27f:	01 d0                	add    %edx,%eax
 281:	83 e8 30             	sub    $0x30,%eax
 284:	89 45 fc             	mov    %eax,-0x4(%ebp)
 287:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	0f b6 00             	movzbl (%eax),%eax
 291:	3c 2f                	cmp    $0x2f,%al
 293:	7e 0a                	jle    29f <atoi+0x46>
 295:	8b 45 08             	mov    0x8(%ebp),%eax
 298:	0f b6 00             	movzbl (%eax),%eax
 29b:	3c 39                	cmp    $0x39,%al
 29d:	7e c9                	jle    268 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a2:	c9                   	leave  
 2a3:	c3                   	ret    

000002a4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2aa:	8b 45 08             	mov    0x8(%ebp),%eax
 2ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b6:	eb 13                	jmp    2cb <memmove+0x27>
    *dst++ = *src++;
 2b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2bb:	0f b6 10             	movzbl (%eax),%edx
 2be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c1:	88 10                	mov    %dl,(%eax)
 2c3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2c7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2cf:	0f 9f c0             	setg   %al
 2d2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2d6:	84 c0                	test   %al,%al
 2d8:	75 de                	jne    2b8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2dd:	c9                   	leave  
 2de:	c3                   	ret    
 2df:	90                   	nop

000002e0 <SYS_ls_call01>:
 2e0:	6c                   	insb   (%dx),%es:(%edi)
 2e1:	73 5f                	jae    342 <SYS_ls_call10+0x8>
 2e3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2e6:	6c                   	insb   (%dx),%es:(%edi)
 2e7:	30 31                	xor    %dh,(%ecx)
	...

000002ea <SYS_ls_call02>:
 2ea:	6c                   	insb   (%dx),%es:(%edi)
 2eb:	73 5f                	jae    34c <SYS_ls_call11+0x8>
 2ed:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2f0:	6c                   	insb   (%dx),%es:(%edi)
 2f1:	30 32                	xor    %dh,(%edx)
	...

000002f4 <SYS_ls_call03>:
 2f4:	6c                   	insb   (%dx),%es:(%edi)
 2f5:	73 5f                	jae    356 <SYS_ls_call12+0x8>
 2f7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2fa:	6c                   	insb   (%dx),%es:(%edi)
 2fb:	30 33                	xor    %dh,(%ebx)
	...

000002fe <SYS_ls_call04>:
 2fe:	6c                   	insb   (%dx),%es:(%edi)
 2ff:	73 5f                	jae    360 <SYS_ls_call13+0x8>
 301:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 304:	6c                   	insb   (%dx),%es:(%edi)
 305:	30 34 00             	xor    %dh,(%eax,%eax,1)

00000308 <SYS_ls_call05>:
 308:	6c                   	insb   (%dx),%es:(%edi)
 309:	73 5f                	jae    36a <SYS_ls_call14+0x8>
 30b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 30e:	6c                   	insb   (%dx),%es:(%edi)
 30f:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

00000312 <SYS_ls_call06>:
 312:	6c                   	insb   (%dx),%es:(%edi)
 313:	73 5f                	jae    374 <SYS_ls_call15+0x8>
 315:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 318:	6c                   	insb   (%dx),%es:(%edi)
 319:	30 36                	xor    %dh,(%esi)
	...

0000031c <SYS_ls_call07>:
 31c:	6c                   	insb   (%dx),%es:(%edi)
 31d:	73 5f                	jae    37e <SYS_ls_call16+0x8>
 31f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 322:	6c                   	insb   (%dx),%es:(%edi)
 323:	30 37                	xor    %dh,(%edi)
	...

00000326 <SYS_ls_call08>:
 326:	6c                   	insb   (%dx),%es:(%edi)
 327:	73 5f                	jae    388 <SYS_ls_call17+0x8>
 329:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 32c:	6c                   	insb   (%dx),%es:(%edi)
 32d:	30 38                	xor    %bh,(%eax)
	...

00000330 <SYS_ls_call09>:
 330:	6c                   	insb   (%dx),%es:(%edi)
 331:	73 5f                	jae    392 <SYS_ls_call18+0x8>
 333:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 336:	6c                   	insb   (%dx),%es:(%edi)
 337:	30 39                	xor    %bh,(%ecx)
	...

0000033a <SYS_ls_call10>:
 33a:	6c                   	insb   (%dx),%es:(%edi)
 33b:	73 5f                	jae    39c <SYS_ls_call19+0x8>
 33d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 340:	6c                   	insb   (%dx),%es:(%edi)
 341:	31 30                	xor    %esi,(%eax)
	...

00000344 <SYS_ls_call11>:
 344:	6c                   	insb   (%dx),%es:(%edi)
 345:	73 5f                	jae    3a6 <SYS_ls_call20+0x8>
 347:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 34a:	6c                   	insb   (%dx),%es:(%edi)
 34b:	31 31                	xor    %esi,(%ecx)
	...

0000034e <SYS_ls_call12>:
 34e:	6c                   	insb   (%dx),%es:(%edi)
 34f:	73 5f                	jae    3b0 <SYS_ls_call21+0x8>
 351:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 354:	6c                   	insb   (%dx),%es:(%edi)
 355:	31 32                	xor    %esi,(%edx)
	...

00000358 <SYS_ls_call13>:
 358:	6c                   	insb   (%dx),%es:(%edi)
 359:	73 5f                	jae    3ba <SYS_ls_call22+0x8>
 35b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 35e:	6c                   	insb   (%dx),%es:(%edi)
 35f:	31 33                	xor    %esi,(%ebx)
	...

00000362 <SYS_ls_call14>:
 362:	6c                   	insb   (%dx),%es:(%edi)
 363:	73 5f                	jae    3c4 <SYS_ls_call23+0x8>
 365:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 368:	6c                   	insb   (%dx),%es:(%edi)
 369:	31 34 00             	xor    %esi,(%eax,%eax,1)

0000036c <SYS_ls_call15>:
 36c:	6c                   	insb   (%dx),%es:(%edi)
 36d:	73 5f                	jae    3ce <SYS_ls_call24+0x8>
 36f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 372:	6c                   	insb   (%dx),%es:(%edi)
 373:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000376 <SYS_ls_call16>:
 376:	6c                   	insb   (%dx),%es:(%edi)
 377:	73 5f                	jae    3d8 <SYS_ls_call25+0x8>
 379:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 37c:	6c                   	insb   (%dx),%es:(%edi)
 37d:	31 36                	xor    %esi,(%esi)
	...

00000380 <SYS_ls_call17>:
 380:	6c                   	insb   (%dx),%es:(%edi)
 381:	73 5f                	jae    3e2 <SYS_ls_call26+0x8>
 383:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 386:	6c                   	insb   (%dx),%es:(%edi)
 387:	31 37                	xor    %esi,(%edi)
	...

0000038a <SYS_ls_call18>:
 38a:	6c                   	insb   (%dx),%es:(%edi)
 38b:	73 5f                	jae    3ec <SYS_ls_call27+0x8>
 38d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 390:	6c                   	insb   (%dx),%es:(%edi)
 391:	31 38                	xor    %edi,(%eax)
	...

00000394 <SYS_ls_call19>:
 394:	6c                   	insb   (%dx),%es:(%edi)
 395:	73 5f                	jae    3f6 <SYS_ls_call28+0x8>
 397:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 39a:	6c                   	insb   (%dx),%es:(%edi)
 39b:	31 39                	xor    %edi,(%ecx)
	...

0000039e <SYS_ls_call20>:
 39e:	6c                   	insb   (%dx),%es:(%edi)
 39f:	73 5f                	jae    400 <SYS_ls_call29+0x8>
 3a1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a4:	6c                   	insb   (%dx),%es:(%edi)
 3a5:	32 30                	xor    (%eax),%dh
	...

000003a8 <SYS_ls_call21>:
 3a8:	6c                   	insb   (%dx),%es:(%edi)
 3a9:	73 5f                	jae    40a <SYS_ls_call30+0x8>
 3ab:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ae:	6c                   	insb   (%dx),%es:(%edi)
 3af:	32 31                	xor    (%ecx),%dh
	...

000003b2 <SYS_ls_call22>:
 3b2:	6c                   	insb   (%dx),%es:(%edi)
 3b3:	73 5f                	jae    414 <exit>
 3b5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b8:	6c                   	insb   (%dx),%es:(%edi)
 3b9:	32 32                	xor    (%edx),%dh
	...

000003bc <SYS_ls_call23>:
 3bc:	6c                   	insb   (%dx),%es:(%edi)
 3bd:	73 5f                	jae    41e <wait+0x2>
 3bf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c2:	6c                   	insb   (%dx),%es:(%edi)
 3c3:	32 33                	xor    (%ebx),%dh
	...

000003c6 <SYS_ls_call24>:
 3c6:	6c                   	insb   (%dx),%es:(%edi)
 3c7:	73 5f                	jae    428 <pipe+0x4>
 3c9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3cc:	6c                   	insb   (%dx),%es:(%edi)
 3cd:	32 34 00             	xor    (%eax,%eax,1),%dh

000003d0 <SYS_ls_call25>:
 3d0:	6c                   	insb   (%dx),%es:(%edi)
 3d1:	73 5f                	jae    432 <read+0x6>
 3d3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d6:	6c                   	insb   (%dx),%es:(%edi)
 3d7:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000003da <SYS_ls_call26>:
 3da:	6c                   	insb   (%dx),%es:(%edi)
 3db:	73 5f                	jae    43c <close>
 3dd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e0:	6c                   	insb   (%dx),%es:(%edi)
 3e1:	32 36                	xor    (%esi),%dh
	...

000003e4 <SYS_ls_call27>:
 3e4:	6c                   	insb   (%dx),%es:(%edi)
 3e5:	73 5f                	jae    446 <kill+0x2>
 3e7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ea:	6c                   	insb   (%dx),%es:(%edi)
 3eb:	32 37                	xor    (%edi),%dh
	...

000003ee <SYS_ls_call28>:
 3ee:	6c                   	insb   (%dx),%es:(%edi)
 3ef:	73 5f                	jae    450 <exec+0x4>
 3f1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f4:	6c                   	insb   (%dx),%es:(%edi)
 3f5:	32 38                	xor    (%eax),%bh
	...

000003f8 <SYS_ls_call29>:
 3f8:	6c                   	insb   (%dx),%es:(%edi)
 3f9:	73 5f                	jae    45a <open+0x6>
 3fb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3fe:	6c                   	insb   (%dx),%es:(%edi)
 3ff:	32 39                	xor    (%ecx),%bh
	...

00000402 <SYS_ls_call30>:
 402:	6c                   	insb   (%dx),%es:(%edi)
 403:	73 5f                	jae    464 <unlink>
 405:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 408:	6c                   	insb   (%dx),%es:(%edi)
 409:	33 30                	xor    (%eax),%esi
	...

0000040c <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 40c:	b8 01 00 00 00       	mov    $0x1,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <exit>:
SYSCALL(exit)
 414:	b8 02 00 00 00       	mov    $0x2,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <wait>:
SYSCALL(wait)
 41c:	b8 03 00 00 00       	mov    $0x3,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <pipe>:
SYSCALL(pipe)
 424:	b8 04 00 00 00       	mov    $0x4,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <read>:
SYSCALL(read)
 42c:	b8 05 00 00 00       	mov    $0x5,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <write>:
SYSCALL(write)
 434:	b8 10 00 00 00       	mov    $0x10,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <close>:
SYSCALL(close)
 43c:	b8 15 00 00 00       	mov    $0x15,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <kill>:
SYSCALL(kill)
 444:	b8 06 00 00 00       	mov    $0x6,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <exec>:
SYSCALL(exec)
 44c:	b8 07 00 00 00       	mov    $0x7,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <open>:
SYSCALL(open)
 454:	b8 0f 00 00 00       	mov    $0xf,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <mknod>:
SYSCALL(mknod)
 45c:	b8 11 00 00 00       	mov    $0x11,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <unlink>:
SYSCALL(unlink)
 464:	b8 12 00 00 00       	mov    $0x12,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <fstat>:
SYSCALL(fstat)
 46c:	b8 08 00 00 00       	mov    $0x8,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <link>:
SYSCALL(link)
 474:	b8 13 00 00 00       	mov    $0x13,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <mkdir>:
SYSCALL(mkdir)
 47c:	b8 14 00 00 00       	mov    $0x14,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <chdir>:
SYSCALL(chdir)
 484:	b8 09 00 00 00       	mov    $0x9,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <dup>:
SYSCALL(dup)
 48c:	b8 0a 00 00 00       	mov    $0xa,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <getpid>:
SYSCALL(getpid)
 494:	b8 0b 00 00 00       	mov    $0xb,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <sbrk>:
SYSCALL(sbrk)
 49c:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <sleep>:
SYSCALL(sleep)
 4a4:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <uptime>:
SYSCALL(uptime)
 4ac:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <date>:
SYSCALL(date)
 4b4:	b8 16 00 00 00       	mov    $0x16,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <ls_call01>:

SYSCALL1(ls_call01)
 4bc:	b8 e0 02 00 00       	mov    $0x2e0,%eax
 4c1:	cd 41                	int    $0x41
 4c3:	c3                   	ret    

000004c4 <ls_call02>:
SYSCALL1(ls_call02)
 4c4:	b8 ea 02 00 00       	mov    $0x2ea,%eax
 4c9:	cd 41                	int    $0x41
 4cb:	c3                   	ret    

000004cc <ls_call03>:
SYSCALL1(ls_call03)
 4cc:	b8 f4 02 00 00       	mov    $0x2f4,%eax
 4d1:	cd 41                	int    $0x41
 4d3:	c3                   	ret    

000004d4 <ls_call04>:
SYSCALL1(ls_call04)
 4d4:	b8 fe 02 00 00       	mov    $0x2fe,%eax
 4d9:	cd 41                	int    $0x41
 4db:	c3                   	ret    

000004dc <ls_call05>:
SYSCALL1(ls_call05)
 4dc:	b8 08 03 00 00       	mov    $0x308,%eax
 4e1:	cd 41                	int    $0x41
 4e3:	c3                   	ret    

000004e4 <ls_call06>:
SYSCALL1(ls_call06)
 4e4:	b8 12 03 00 00       	mov    $0x312,%eax
 4e9:	cd 41                	int    $0x41
 4eb:	c3                   	ret    

000004ec <ls_call07>:
SYSCALL1(ls_call07)
 4ec:	b8 1c 03 00 00       	mov    $0x31c,%eax
 4f1:	cd 41                	int    $0x41
 4f3:	c3                   	ret    

000004f4 <ls_call08>:
SYSCALL1(ls_call08)
 4f4:	b8 26 03 00 00       	mov    $0x326,%eax
 4f9:	cd 41                	int    $0x41
 4fb:	c3                   	ret    

000004fc <ls_call09>:
SYSCALL1(ls_call09)
 4fc:	b8 30 03 00 00       	mov    $0x330,%eax
 501:	cd 41                	int    $0x41
 503:	c3                   	ret    

00000504 <ls_call10>:
SYSCALL1(ls_call10)
 504:	b8 3a 03 00 00       	mov    $0x33a,%eax
 509:	cd 41                	int    $0x41
 50b:	c3                   	ret    

0000050c <ls_call11>:
SYSCALL1(ls_call11)
 50c:	b8 44 03 00 00       	mov    $0x344,%eax
 511:	cd 41                	int    $0x41
 513:	c3                   	ret    

00000514 <ls_call12>:
SYSCALL1(ls_call12)
 514:	b8 4e 03 00 00       	mov    $0x34e,%eax
 519:	cd 41                	int    $0x41
 51b:	c3                   	ret    

0000051c <ls_call13>:
SYSCALL1(ls_call13)
 51c:	b8 58 03 00 00       	mov    $0x358,%eax
 521:	cd 41                	int    $0x41
 523:	c3                   	ret    

00000524 <ls_call14>:
SYSCALL1(ls_call14)
 524:	b8 62 03 00 00       	mov    $0x362,%eax
 529:	cd 41                	int    $0x41
 52b:	c3                   	ret    

0000052c <ls_call15>:
SYSCALL1(ls_call15)
 52c:	b8 6c 03 00 00       	mov    $0x36c,%eax
 531:	cd 41                	int    $0x41
 533:	c3                   	ret    

00000534 <ls_call16>:
SYSCALL1(ls_call16)
 534:	b8 76 03 00 00       	mov    $0x376,%eax
 539:	cd 41                	int    $0x41
 53b:	c3                   	ret    

0000053c <ls_call17>:
SYSCALL1(ls_call17)
 53c:	b8 80 03 00 00       	mov    $0x380,%eax
 541:	cd 41                	int    $0x41
 543:	c3                   	ret    

00000544 <ls_call18>:
SYSCALL1(ls_call18)
 544:	b8 8a 03 00 00       	mov    $0x38a,%eax
 549:	cd 41                	int    $0x41
 54b:	c3                   	ret    

0000054c <ls_call19>:
SYSCALL1(ls_call19)
 54c:	b8 94 03 00 00       	mov    $0x394,%eax
 551:	cd 41                	int    $0x41
 553:	c3                   	ret    

00000554 <ls_call20>:
SYSCALL1(ls_call20)
 554:	b8 9e 03 00 00       	mov    $0x39e,%eax
 559:	cd 41                	int    $0x41
 55b:	c3                   	ret    

0000055c <ls_call21>:
SYSCALL1(ls_call21)
 55c:	b8 a8 03 00 00       	mov    $0x3a8,%eax
 561:	cd 41                	int    $0x41
 563:	c3                   	ret    

00000564 <ls_call22>:
SYSCALL1(ls_call22)
 564:	b8 b2 03 00 00       	mov    $0x3b2,%eax
 569:	cd 41                	int    $0x41
 56b:	c3                   	ret    

0000056c <ls_call23>:
SYSCALL1(ls_call23)
 56c:	b8 bc 03 00 00       	mov    $0x3bc,%eax
 571:	cd 41                	int    $0x41
 573:	c3                   	ret    

00000574 <ls_call24>:
SYSCALL1(ls_call24)
 574:	b8 c6 03 00 00       	mov    $0x3c6,%eax
 579:	cd 41                	int    $0x41
 57b:	c3                   	ret    

0000057c <ls_call25>:
SYSCALL1(ls_call25)
 57c:	b8 d0 03 00 00       	mov    $0x3d0,%eax
 581:	cd 41                	int    $0x41
 583:	c3                   	ret    

00000584 <ls_call26>:
SYSCALL1(ls_call26)
 584:	b8 da 03 00 00       	mov    $0x3da,%eax
 589:	cd 41                	int    $0x41
 58b:	c3                   	ret    

0000058c <ls_call27>:
SYSCALL1(ls_call27)
 58c:	b8 e4 03 00 00       	mov    $0x3e4,%eax
 591:	cd 41                	int    $0x41
 593:	c3                   	ret    

00000594 <ls_call28>:
SYSCALL1(ls_call28)
 594:	b8 ee 03 00 00       	mov    $0x3ee,%eax
 599:	cd 41                	int    $0x41
 59b:	c3                   	ret    

0000059c <ls_call29>:
SYSCALL1(ls_call29)
 59c:	b8 f8 03 00 00       	mov    $0x3f8,%eax
 5a1:	cd 41                	int    $0x41
 5a3:	c3                   	ret    

000005a4 <ls_call30>:
SYSCALL1(ls_call30)
 5a4:	b8 02 04 00 00       	mov    $0x402,%eax
 5a9:	cd 41                	int    $0x41
 5ab:	c3                   	ret    

000005ac <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	83 ec 28             	sub    $0x28,%esp
 5b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 5b5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5bf:	00 
 5c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ca:	89 04 24             	mov    %eax,(%esp)
 5cd:	e8 62 fe ff ff       	call   434 <write>
}
 5d2:	c9                   	leave  
 5d3:	c3                   	ret    

000005d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5e1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5e5:	74 17                	je     5fe <printint+0x2a>
 5e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5eb:	79 11                	jns    5fe <printint+0x2a>
    neg = 1;
 5ed:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5f4:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f7:	f7 d8                	neg    %eax
 5f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5fc:	eb 06                	jmp    604 <printint+0x30>
  } else {
    x = xx;
 5fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 601:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 604:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 60b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 60e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 611:	ba 00 00 00 00       	mov    $0x0,%edx
 616:	f7 f1                	div    %ecx
 618:	89 d0                	mov    %edx,%eax
 61a:	0f b6 80 e4 0c 00 00 	movzbl 0xce4(%eax),%eax
 621:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 624:	8b 55 f4             	mov    -0xc(%ebp),%edx
 627:	01 ca                	add    %ecx,%edx
 629:	88 02                	mov    %al,(%edx)
 62b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 62f:	8b 55 10             	mov    0x10(%ebp),%edx
 632:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 635:	8b 45 ec             	mov    -0x14(%ebp),%eax
 638:	ba 00 00 00 00       	mov    $0x0,%edx
 63d:	f7 75 d4             	divl   -0x2c(%ebp)
 640:	89 45 ec             	mov    %eax,-0x14(%ebp)
 643:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 647:	75 c2                	jne    60b <printint+0x37>
  if(neg)
 649:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 64d:	74 2e                	je     67d <printint+0xa9>
    buf[i++] = '-';
 64f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 652:	8b 45 f4             	mov    -0xc(%ebp),%eax
 655:	01 d0                	add    %edx,%eax
 657:	c6 00 2d             	movb   $0x2d,(%eax)
 65a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 65e:	eb 1d                	jmp    67d <printint+0xa9>
    putc(fd, buf[i]);
 660:	8d 55 dc             	lea    -0x24(%ebp),%edx
 663:	8b 45 f4             	mov    -0xc(%ebp),%eax
 666:	01 d0                	add    %edx,%eax
 668:	0f b6 00             	movzbl (%eax),%eax
 66b:	0f be c0             	movsbl %al,%eax
 66e:	89 44 24 04          	mov    %eax,0x4(%esp)
 672:	8b 45 08             	mov    0x8(%ebp),%eax
 675:	89 04 24             	mov    %eax,(%esp)
 678:	e8 2f ff ff ff       	call   5ac <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 67d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 681:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 685:	79 d9                	jns    660 <printint+0x8c>
    putc(fd, buf[i]);
}
 687:	c9                   	leave  
 688:	c3                   	ret    

00000689 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 689:	55                   	push   %ebp
 68a:	89 e5                	mov    %esp,%ebp
 68c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 68f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 696:	8d 45 0c             	lea    0xc(%ebp),%eax
 699:	83 c0 04             	add    $0x4,%eax
 69c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 69f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6a6:	e9 7d 01 00 00       	jmp    828 <printf+0x19f>
    c = fmt[i] & 0xff;
 6ab:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b1:	01 d0                	add    %edx,%eax
 6b3:	0f b6 00             	movzbl (%eax),%eax
 6b6:	0f be c0             	movsbl %al,%eax
 6b9:	25 ff 00 00 00       	and    $0xff,%eax
 6be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6c5:	75 2c                	jne    6f3 <printf+0x6a>
      if(c == '%'){
 6c7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6cb:	75 0c                	jne    6d9 <printf+0x50>
        state = '%';
 6cd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6d4:	e9 4b 01 00 00       	jmp    824 <printf+0x19b>
      } else {
        putc(fd, c);
 6d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6dc:	0f be c0             	movsbl %al,%eax
 6df:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e3:	8b 45 08             	mov    0x8(%ebp),%eax
 6e6:	89 04 24             	mov    %eax,(%esp)
 6e9:	e8 be fe ff ff       	call   5ac <putc>
 6ee:	e9 31 01 00 00       	jmp    824 <printf+0x19b>
      }
    } else if(state == '%'){
 6f3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6f7:	0f 85 27 01 00 00    	jne    824 <printf+0x19b>
      if(c == 'd'){
 6fd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 701:	75 2d                	jne    730 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 703:	8b 45 e8             	mov    -0x18(%ebp),%eax
 706:	8b 00                	mov    (%eax),%eax
 708:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 70f:	00 
 710:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 717:	00 
 718:	89 44 24 04          	mov    %eax,0x4(%esp)
 71c:	8b 45 08             	mov    0x8(%ebp),%eax
 71f:	89 04 24             	mov    %eax,(%esp)
 722:	e8 ad fe ff ff       	call   5d4 <printint>
        ap++;
 727:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 72b:	e9 ed 00 00 00       	jmp    81d <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 730:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 734:	74 06                	je     73c <printf+0xb3>
 736:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 73a:	75 2d                	jne    769 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 73c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 73f:	8b 00                	mov    (%eax),%eax
 741:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 748:	00 
 749:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 750:	00 
 751:	89 44 24 04          	mov    %eax,0x4(%esp)
 755:	8b 45 08             	mov    0x8(%ebp),%eax
 758:	89 04 24             	mov    %eax,(%esp)
 75b:	e8 74 fe ff ff       	call   5d4 <printint>
        ap++;
 760:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 764:	e9 b4 00 00 00       	jmp    81d <printf+0x194>
      } else if(c == 's'){
 769:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 76d:	75 46                	jne    7b5 <printf+0x12c>
        s = (char*)*ap;
 76f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 772:	8b 00                	mov    (%eax),%eax
 774:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 777:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 77b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 77f:	75 27                	jne    7a8 <printf+0x11f>
          s = "(null)";
 781:	c7 45 f4 9c 0a 00 00 	movl   $0xa9c,-0xc(%ebp)
        while(*s != 0){
 788:	eb 1e                	jmp    7a8 <printf+0x11f>
          putc(fd, *s);
 78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78d:	0f b6 00             	movzbl (%eax),%eax
 790:	0f be c0             	movsbl %al,%eax
 793:	89 44 24 04          	mov    %eax,0x4(%esp)
 797:	8b 45 08             	mov    0x8(%ebp),%eax
 79a:	89 04 24             	mov    %eax,(%esp)
 79d:	e8 0a fe ff ff       	call   5ac <putc>
          s++;
 7a2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 7a6:	eb 01                	jmp    7a9 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7a8:	90                   	nop
 7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ac:	0f b6 00             	movzbl (%eax),%eax
 7af:	84 c0                	test   %al,%al
 7b1:	75 d7                	jne    78a <printf+0x101>
 7b3:	eb 68                	jmp    81d <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7b5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7b9:	75 1d                	jne    7d8 <printf+0x14f>
        putc(fd, *ap);
 7bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7be:	8b 00                	mov    (%eax),%eax
 7c0:	0f be c0             	movsbl %al,%eax
 7c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c7:	8b 45 08             	mov    0x8(%ebp),%eax
 7ca:	89 04 24             	mov    %eax,(%esp)
 7cd:	e8 da fd ff ff       	call   5ac <putc>
        ap++;
 7d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7d6:	eb 45                	jmp    81d <printf+0x194>
      } else if(c == '%'){
 7d8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7dc:	75 17                	jne    7f5 <printf+0x16c>
        putc(fd, c);
 7de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e1:	0f be c0             	movsbl %al,%eax
 7e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e8:	8b 45 08             	mov    0x8(%ebp),%eax
 7eb:	89 04 24             	mov    %eax,(%esp)
 7ee:	e8 b9 fd ff ff       	call   5ac <putc>
 7f3:	eb 28                	jmp    81d <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f5:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 7fc:	00 
 7fd:	8b 45 08             	mov    0x8(%ebp),%eax
 800:	89 04 24             	mov    %eax,(%esp)
 803:	e8 a4 fd ff ff       	call   5ac <putc>
        putc(fd, c);
 808:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 80b:	0f be c0             	movsbl %al,%eax
 80e:	89 44 24 04          	mov    %eax,0x4(%esp)
 812:	8b 45 08             	mov    0x8(%ebp),%eax
 815:	89 04 24             	mov    %eax,(%esp)
 818:	e8 8f fd ff ff       	call   5ac <putc>
      }
      state = 0;
 81d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 824:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 828:	8b 55 0c             	mov    0xc(%ebp),%edx
 82b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82e:	01 d0                	add    %edx,%eax
 830:	0f b6 00             	movzbl (%eax),%eax
 833:	84 c0                	test   %al,%al
 835:	0f 85 70 fe ff ff    	jne    6ab <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 83b:	c9                   	leave  
 83c:	c3                   	ret    
 83d:	90                   	nop
 83e:	90                   	nop
 83f:	90                   	nop

00000840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 846:	8b 45 08             	mov    0x8(%ebp),%eax
 849:	83 e8 08             	sub    $0x8,%eax
 84c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84f:	a1 00 0d 00 00       	mov    0xd00,%eax
 854:	89 45 fc             	mov    %eax,-0x4(%ebp)
 857:	eb 24                	jmp    87d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 859:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85c:	8b 00                	mov    (%eax),%eax
 85e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 861:	77 12                	ja     875 <free+0x35>
 863:	8b 45 f8             	mov    -0x8(%ebp),%eax
 866:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 869:	77 24                	ja     88f <free+0x4f>
 86b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86e:	8b 00                	mov    (%eax),%eax
 870:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 873:	77 1a                	ja     88f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 875:	8b 45 fc             	mov    -0x4(%ebp),%eax
 878:	8b 00                	mov    (%eax),%eax
 87a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 87d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 880:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 883:	76 d4                	jbe    859 <free+0x19>
 885:	8b 45 fc             	mov    -0x4(%ebp),%eax
 888:	8b 00                	mov    (%eax),%eax
 88a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 88d:	76 ca                	jbe    859 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 88f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 892:	8b 40 04             	mov    0x4(%eax),%eax
 895:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 89c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89f:	01 c2                	add    %eax,%edx
 8a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a4:	8b 00                	mov    (%eax),%eax
 8a6:	39 c2                	cmp    %eax,%edx
 8a8:	75 24                	jne    8ce <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ad:	8b 50 04             	mov    0x4(%eax),%edx
 8b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b3:	8b 00                	mov    (%eax),%eax
 8b5:	8b 40 04             	mov    0x4(%eax),%eax
 8b8:	01 c2                	add    %eax,%edx
 8ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c3:	8b 00                	mov    (%eax),%eax
 8c5:	8b 10                	mov    (%eax),%edx
 8c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ca:	89 10                	mov    %edx,(%eax)
 8cc:	eb 0a                	jmp    8d8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d1:	8b 10                	mov    (%eax),%edx
 8d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8db:	8b 40 04             	mov    0x4(%eax),%eax
 8de:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e8:	01 d0                	add    %edx,%eax
 8ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ed:	75 20                	jne    90f <free+0xcf>
    p->s.size += bp->s.size;
 8ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f2:	8b 50 04             	mov    0x4(%eax),%edx
 8f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f8:	8b 40 04             	mov    0x4(%eax),%eax
 8fb:	01 c2                	add    %eax,%edx
 8fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 900:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 903:	8b 45 f8             	mov    -0x8(%ebp),%eax
 906:	8b 10                	mov    (%eax),%edx
 908:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90b:	89 10                	mov    %edx,(%eax)
 90d:	eb 08                	jmp    917 <free+0xd7>
  } else
    p->s.ptr = bp;
 90f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 912:	8b 55 f8             	mov    -0x8(%ebp),%edx
 915:	89 10                	mov    %edx,(%eax)
  freep = p;
 917:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91a:	a3 00 0d 00 00       	mov    %eax,0xd00
}
 91f:	c9                   	leave  
 920:	c3                   	ret    

00000921 <morecore>:

static Header*
morecore(uint nu)
{
 921:	55                   	push   %ebp
 922:	89 e5                	mov    %esp,%ebp
 924:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 927:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 92e:	77 07                	ja     937 <morecore+0x16>
    nu = 4096;
 930:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 937:	8b 45 08             	mov    0x8(%ebp),%eax
 93a:	c1 e0 03             	shl    $0x3,%eax
 93d:	89 04 24             	mov    %eax,(%esp)
 940:	e8 57 fb ff ff       	call   49c <sbrk>
 945:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 948:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 94c:	75 07                	jne    955 <morecore+0x34>
    return 0;
 94e:	b8 00 00 00 00       	mov    $0x0,%eax
 953:	eb 22                	jmp    977 <morecore+0x56>
  hp = (Header*)p;
 955:	8b 45 f4             	mov    -0xc(%ebp),%eax
 958:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 95b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 95e:	8b 55 08             	mov    0x8(%ebp),%edx
 961:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 964:	8b 45 f0             	mov    -0x10(%ebp),%eax
 967:	83 c0 08             	add    $0x8,%eax
 96a:	89 04 24             	mov    %eax,(%esp)
 96d:	e8 ce fe ff ff       	call   840 <free>
  return freep;
 972:	a1 00 0d 00 00       	mov    0xd00,%eax
}
 977:	c9                   	leave  
 978:	c3                   	ret    

00000979 <malloc>:

void*
malloc(uint nbytes)
{
 979:	55                   	push   %ebp
 97a:	89 e5                	mov    %esp,%ebp
 97c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 97f:	8b 45 08             	mov    0x8(%ebp),%eax
 982:	83 c0 07             	add    $0x7,%eax
 985:	c1 e8 03             	shr    $0x3,%eax
 988:	83 c0 01             	add    $0x1,%eax
 98b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 98e:	a1 00 0d 00 00       	mov    0xd00,%eax
 993:	89 45 f0             	mov    %eax,-0x10(%ebp)
 996:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 99a:	75 23                	jne    9bf <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 99c:	c7 45 f0 f8 0c 00 00 	movl   $0xcf8,-0x10(%ebp)
 9a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a6:	a3 00 0d 00 00       	mov    %eax,0xd00
 9ab:	a1 00 0d 00 00       	mov    0xd00,%eax
 9b0:	a3 f8 0c 00 00       	mov    %eax,0xcf8
    base.s.size = 0;
 9b5:	c7 05 fc 0c 00 00 00 	movl   $0x0,0xcfc
 9bc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c2:	8b 00                	mov    (%eax),%eax
 9c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ca:	8b 40 04             	mov    0x4(%eax),%eax
 9cd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9d0:	72 4d                	jb     a1f <malloc+0xa6>
      if(p->s.size == nunits)
 9d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d5:	8b 40 04             	mov    0x4(%eax),%eax
 9d8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9db:	75 0c                	jne    9e9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e0:	8b 10                	mov    (%eax),%edx
 9e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e5:	89 10                	mov    %edx,(%eax)
 9e7:	eb 26                	jmp    a0f <malloc+0x96>
      else {
        p->s.size -= nunits;
 9e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ec:	8b 40 04             	mov    0x4(%eax),%eax
 9ef:	89 c2                	mov    %eax,%edx
 9f1:	2b 55 ec             	sub    -0x14(%ebp),%edx
 9f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fd:	8b 40 04             	mov    0x4(%eax),%eax
 a00:	c1 e0 03             	shl    $0x3,%eax
 a03:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a09:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a0c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a12:	a3 00 0d 00 00       	mov    %eax,0xd00
      return (void*)(p + 1);
 a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1a:	83 c0 08             	add    $0x8,%eax
 a1d:	eb 38                	jmp    a57 <malloc+0xde>
    }
    if(p == freep)
 a1f:	a1 00 0d 00 00       	mov    0xd00,%eax
 a24:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a27:	75 1b                	jne    a44 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a29:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a2c:	89 04 24             	mov    %eax,(%esp)
 a2f:	e8 ed fe ff ff       	call   921 <morecore>
 a34:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a37:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a3b:	75 07                	jne    a44 <malloc+0xcb>
        return 0;
 a3d:	b8 00 00 00 00       	mov    $0x0,%eax
 a42:	eb 13                	jmp    a57 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4d:	8b 00                	mov    (%eax),%eax
 a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a52:	e9 70 ff ff ff       	jmp    9c7 <malloc+0x4e>
}
 a57:	c9                   	leave  
 a58:	c3                   	ret    
