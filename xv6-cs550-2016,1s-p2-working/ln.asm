
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   9:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
   d:	74 19                	je     28 <main+0x28>
    printf(2, "Usage: ln old new\n");
   f:	c7 44 24 04 55 0a 00 	movl   $0xa55,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 62 06 00 00       	call   685 <printf>
    exit();
  23:	e8 e8 03 00 00       	call   410 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  28:	8b 45 0c             	mov    0xc(%ebp),%eax
  2b:	83 c0 08             	add    $0x8,%eax
  2e:	8b 10                	mov    (%eax),%edx
  30:	8b 45 0c             	mov    0xc(%ebp),%eax
  33:	83 c0 04             	add    $0x4,%eax
  36:	8b 00                	mov    (%eax),%eax
  38:	89 54 24 04          	mov    %edx,0x4(%esp)
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 2c 04 00 00       	call   470 <link>
  44:	85 c0                	test   %eax,%eax
  46:	79 2c                	jns    74 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	8b 45 0c             	mov    0xc(%ebp),%eax
  4b:	83 c0 08             	add    $0x8,%eax
  4e:	8b 10                	mov    (%eax),%edx
  50:	8b 45 0c             	mov    0xc(%ebp),%eax
  53:	83 c0 04             	add    $0x4,%eax
  56:	8b 00                	mov    (%eax),%eax
  58:	89 54 24 0c          	mov    %edx,0xc(%esp)
  5c:	89 44 24 08          	mov    %eax,0x8(%esp)
  60:	c7 44 24 04 68 0a 00 	movl   $0xa68,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	e8 11 06 00 00       	call   685 <printf>
  exit();
  74:	e8 97 03 00 00       	call   410 <exit>
  79:	90                   	nop
  7a:	90                   	nop
  7b:	90                   	nop

0000007c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	57                   	push   %edi
  80:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  81:	8b 4d 08             	mov    0x8(%ebp),%ecx
  84:	8b 55 10             	mov    0x10(%ebp),%edx
  87:	8b 45 0c             	mov    0xc(%ebp),%eax
  8a:	89 cb                	mov    %ecx,%ebx
  8c:	89 df                	mov    %ebx,%edi
  8e:	89 d1                	mov    %edx,%ecx
  90:	fc                   	cld    
  91:	f3 aa                	rep stos %al,%es:(%edi)
  93:	89 ca                	mov    %ecx,%edx
  95:	89 fb                	mov    %edi,%ebx
  97:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9d:	5b                   	pop    %ebx
  9e:	5f                   	pop    %edi
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    

000000a1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a1:	55                   	push   %ebp
  a2:	89 e5                	mov    %esp,%ebp
  a4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a7:	8b 45 08             	mov    0x8(%ebp),%eax
  aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ad:	90                   	nop
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	0f b6 10             	movzbl (%eax),%edx
  b4:	8b 45 08             	mov    0x8(%ebp),%eax
  b7:	88 10                	mov    %dl,(%eax)
  b9:	8b 45 08             	mov    0x8(%ebp),%eax
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	0f 95 c0             	setne  %al
  c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  cc:	84 c0                	test   %al,%al
  ce:	75 de                	jne    ae <strcpy+0xd>
    ;
  return os;
  d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d3:	c9                   	leave  
  d4:	c3                   	ret    

000000d5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d5:	55                   	push   %ebp
  d6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d8:	eb 08                	jmp    e2 <strcmp+0xd>
    p++, q++;
  da:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  de:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 00             	movzbl (%eax),%eax
  e8:	84 c0                	test   %al,%al
  ea:	74 10                	je     fc <strcmp+0x27>
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	0f b6 10             	movzbl (%eax),%edx
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	38 c2                	cmp    %al,%dl
  fa:	74 de                	je     da <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 00             	movzbl (%eax),%eax
 102:	0f b6 d0             	movzbl %al,%edx
 105:	8b 45 0c             	mov    0xc(%ebp),%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	0f b6 c0             	movzbl %al,%eax
 10e:	89 d1                	mov    %edx,%ecx
 110:	29 c1                	sub    %eax,%ecx
 112:	89 c8                	mov    %ecx,%eax
}
 114:	5d                   	pop    %ebp
 115:	c3                   	ret    

00000116 <strlen>:

uint
strlen(char *s)
{
 116:	55                   	push   %ebp
 117:	89 e5                	mov    %esp,%ebp
 119:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 11c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 123:	eb 04                	jmp    129 <strlen+0x13>
 125:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 129:	8b 55 fc             	mov    -0x4(%ebp),%edx
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	01 d0                	add    %edx,%eax
 131:	0f b6 00             	movzbl (%eax),%eax
 134:	84 c0                	test   %al,%al
 136:	75 ed                	jne    125 <strlen+0xf>
    ;
  return n;
 138:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13b:	c9                   	leave  
 13c:	c3                   	ret    

0000013d <memset>:

void*
memset(void *dst, int c, uint n)
{
 13d:	55                   	push   %ebp
 13e:	89 e5                	mov    %esp,%ebp
 140:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 143:	8b 45 10             	mov    0x10(%ebp),%eax
 146:	89 44 24 08          	mov    %eax,0x8(%esp)
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 44 24 04          	mov    %eax,0x4(%esp)
 151:	8b 45 08             	mov    0x8(%ebp),%eax
 154:	89 04 24             	mov    %eax,(%esp)
 157:	e8 20 ff ff ff       	call   7c <stosb>
  return dst;
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15f:	c9                   	leave  
 160:	c3                   	ret    

00000161 <strchr>:

char*
strchr(const char *s, char c)
{
 161:	55                   	push   %ebp
 162:	89 e5                	mov    %esp,%ebp
 164:	83 ec 04             	sub    $0x4,%esp
 167:	8b 45 0c             	mov    0xc(%ebp),%eax
 16a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16d:	eb 14                	jmp    183 <strchr+0x22>
    if(*s == c)
 16f:	8b 45 08             	mov    0x8(%ebp),%eax
 172:	0f b6 00             	movzbl (%eax),%eax
 175:	3a 45 fc             	cmp    -0x4(%ebp),%al
 178:	75 05                	jne    17f <strchr+0x1e>
      return (char*)s;
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	eb 13                	jmp    192 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 17f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	0f b6 00             	movzbl (%eax),%eax
 189:	84 c0                	test   %al,%al
 18b:	75 e2                	jne    16f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 18d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 192:	c9                   	leave  
 193:	c3                   	ret    

00000194 <gets>:

char*
gets(char *buf, int max)
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a1:	eb 46                	jmp    1e9 <gets+0x55>
    cc = read(0, &c, 1);
 1a3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1aa:	00 
 1ab:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ae:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b9:	e8 6a 02 00 00       	call   428 <read>
 1be:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1c1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c5:	7e 2f                	jle    1f6 <gets+0x62>
      break;
    buf[i++] = c;
 1c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	01 c2                	add    %eax,%edx
 1cf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d3:	88 02                	mov    %al,(%edx)
 1d5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1d9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1dd:	3c 0a                	cmp    $0xa,%al
 1df:	74 16                	je     1f7 <gets+0x63>
 1e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e5:	3c 0d                	cmp    $0xd,%al
 1e7:	74 0e                	je     1f7 <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ec:	83 c0 01             	add    $0x1,%eax
 1ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f2:	7c af                	jl     1a3 <gets+0xf>
 1f4:	eb 01                	jmp    1f7 <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1f6:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
 1fd:	01 d0                	add    %edx,%eax
 1ff:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 202:	8b 45 08             	mov    0x8(%ebp),%eax
}
 205:	c9                   	leave  
 206:	c3                   	ret    

00000207 <stat>:

int
stat(char *n, struct stat *st)
{
 207:	55                   	push   %ebp
 208:	89 e5                	mov    %esp,%ebp
 20a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 214:	00 
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	89 04 24             	mov    %eax,(%esp)
 21b:	e8 30 02 00 00       	call   450 <open>
 220:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 223:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 227:	79 07                	jns    230 <stat+0x29>
    return -1;
 229:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22e:	eb 23                	jmp    253 <stat+0x4c>
  r = fstat(fd, st);
 230:	8b 45 0c             	mov    0xc(%ebp),%eax
 233:	89 44 24 04          	mov    %eax,0x4(%esp)
 237:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23a:	89 04 24             	mov    %eax,(%esp)
 23d:	e8 26 02 00 00       	call   468 <fstat>
 242:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 245:	8b 45 f4             	mov    -0xc(%ebp),%eax
 248:	89 04 24             	mov    %eax,(%esp)
 24b:	e8 e8 01 00 00       	call   438 <close>
  return r;
 250:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 253:	c9                   	leave  
 254:	c3                   	ret    

00000255 <atoi>:

int
atoi(const char *s)
{
 255:	55                   	push   %ebp
 256:	89 e5                	mov    %esp,%ebp
 258:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 262:	eb 23                	jmp    287 <atoi+0x32>
    n = n*10 + *s++ - '0';
 264:	8b 55 fc             	mov    -0x4(%ebp),%edx
 267:	89 d0                	mov    %edx,%eax
 269:	c1 e0 02             	shl    $0x2,%eax
 26c:	01 d0                	add    %edx,%eax
 26e:	01 c0                	add    %eax,%eax
 270:	89 c2                	mov    %eax,%edx
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	0f b6 00             	movzbl (%eax),%eax
 278:	0f be c0             	movsbl %al,%eax
 27b:	01 d0                	add    %edx,%eax
 27d:	83 e8 30             	sub    $0x30,%eax
 280:	89 45 fc             	mov    %eax,-0x4(%ebp)
 283:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	0f b6 00             	movzbl (%eax),%eax
 28d:	3c 2f                	cmp    $0x2f,%al
 28f:	7e 0a                	jle    29b <atoi+0x46>
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	3c 39                	cmp    $0x39,%al
 299:	7e c9                	jle    264 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29e:	c9                   	leave  
 29f:	c3                   	ret    

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ac:	8b 45 0c             	mov    0xc(%ebp),%eax
 2af:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b2:	eb 13                	jmp    2c7 <memmove+0x27>
    *dst++ = *src++;
 2b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2b7:	0f b6 10             	movzbl (%eax),%edx
 2ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2bd:	88 10                	mov    %dl,(%eax)
 2bf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2c3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2cb:	0f 9f c0             	setg   %al
 2ce:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2d2:	84 c0                	test   %al,%al
 2d4:	75 de                	jne    2b4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d9:	c9                   	leave  
 2da:	c3                   	ret    
 2db:	90                   	nop

000002dc <SYS_ls_call01>:
 2dc:	6c                   	insb   (%dx),%es:(%edi)
 2dd:	73 5f                	jae    33e <SYS_ls_call10+0x8>
 2df:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2e2:	6c                   	insb   (%dx),%es:(%edi)
 2e3:	30 31                	xor    %dh,(%ecx)
	...

000002e6 <SYS_ls_call02>:
 2e6:	6c                   	insb   (%dx),%es:(%edi)
 2e7:	73 5f                	jae    348 <SYS_ls_call11+0x8>
 2e9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2ec:	6c                   	insb   (%dx),%es:(%edi)
 2ed:	30 32                	xor    %dh,(%edx)
	...

000002f0 <SYS_ls_call03>:
 2f0:	6c                   	insb   (%dx),%es:(%edi)
 2f1:	73 5f                	jae    352 <SYS_ls_call12+0x8>
 2f3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2f6:	6c                   	insb   (%dx),%es:(%edi)
 2f7:	30 33                	xor    %dh,(%ebx)
	...

000002fa <SYS_ls_call04>:
 2fa:	6c                   	insb   (%dx),%es:(%edi)
 2fb:	73 5f                	jae    35c <SYS_ls_call13+0x8>
 2fd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 300:	6c                   	insb   (%dx),%es:(%edi)
 301:	30 34 00             	xor    %dh,(%eax,%eax,1)

00000304 <SYS_ls_call05>:
 304:	6c                   	insb   (%dx),%es:(%edi)
 305:	73 5f                	jae    366 <SYS_ls_call14+0x8>
 307:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 30a:	6c                   	insb   (%dx),%es:(%edi)
 30b:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

0000030e <SYS_ls_call06>:
 30e:	6c                   	insb   (%dx),%es:(%edi)
 30f:	73 5f                	jae    370 <SYS_ls_call15+0x8>
 311:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 314:	6c                   	insb   (%dx),%es:(%edi)
 315:	30 36                	xor    %dh,(%esi)
	...

00000318 <SYS_ls_call07>:
 318:	6c                   	insb   (%dx),%es:(%edi)
 319:	73 5f                	jae    37a <SYS_ls_call16+0x8>
 31b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 31e:	6c                   	insb   (%dx),%es:(%edi)
 31f:	30 37                	xor    %dh,(%edi)
	...

00000322 <SYS_ls_call08>:
 322:	6c                   	insb   (%dx),%es:(%edi)
 323:	73 5f                	jae    384 <SYS_ls_call17+0x8>
 325:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 328:	6c                   	insb   (%dx),%es:(%edi)
 329:	30 38                	xor    %bh,(%eax)
	...

0000032c <SYS_ls_call09>:
 32c:	6c                   	insb   (%dx),%es:(%edi)
 32d:	73 5f                	jae    38e <SYS_ls_call18+0x8>
 32f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 332:	6c                   	insb   (%dx),%es:(%edi)
 333:	30 39                	xor    %bh,(%ecx)
	...

00000336 <SYS_ls_call10>:
 336:	6c                   	insb   (%dx),%es:(%edi)
 337:	73 5f                	jae    398 <SYS_ls_call19+0x8>
 339:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 33c:	6c                   	insb   (%dx),%es:(%edi)
 33d:	31 30                	xor    %esi,(%eax)
	...

00000340 <SYS_ls_call11>:
 340:	6c                   	insb   (%dx),%es:(%edi)
 341:	73 5f                	jae    3a2 <SYS_ls_call20+0x8>
 343:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 346:	6c                   	insb   (%dx),%es:(%edi)
 347:	31 31                	xor    %esi,(%ecx)
	...

0000034a <SYS_ls_call12>:
 34a:	6c                   	insb   (%dx),%es:(%edi)
 34b:	73 5f                	jae    3ac <SYS_ls_call21+0x8>
 34d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 350:	6c                   	insb   (%dx),%es:(%edi)
 351:	31 32                	xor    %esi,(%edx)
	...

00000354 <SYS_ls_call13>:
 354:	6c                   	insb   (%dx),%es:(%edi)
 355:	73 5f                	jae    3b6 <SYS_ls_call22+0x8>
 357:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 35a:	6c                   	insb   (%dx),%es:(%edi)
 35b:	31 33                	xor    %esi,(%ebx)
	...

0000035e <SYS_ls_call14>:
 35e:	6c                   	insb   (%dx),%es:(%edi)
 35f:	73 5f                	jae    3c0 <SYS_ls_call23+0x8>
 361:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 364:	6c                   	insb   (%dx),%es:(%edi)
 365:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000368 <SYS_ls_call15>:
 368:	6c                   	insb   (%dx),%es:(%edi)
 369:	73 5f                	jae    3ca <SYS_ls_call24+0x8>
 36b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 36e:	6c                   	insb   (%dx),%es:(%edi)
 36f:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000372 <SYS_ls_call16>:
 372:	6c                   	insb   (%dx),%es:(%edi)
 373:	73 5f                	jae    3d4 <SYS_ls_call25+0x8>
 375:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 378:	6c                   	insb   (%dx),%es:(%edi)
 379:	31 36                	xor    %esi,(%esi)
	...

0000037c <SYS_ls_call17>:
 37c:	6c                   	insb   (%dx),%es:(%edi)
 37d:	73 5f                	jae    3de <SYS_ls_call26+0x8>
 37f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 382:	6c                   	insb   (%dx),%es:(%edi)
 383:	31 37                	xor    %esi,(%edi)
	...

00000386 <SYS_ls_call18>:
 386:	6c                   	insb   (%dx),%es:(%edi)
 387:	73 5f                	jae    3e8 <SYS_ls_call27+0x8>
 389:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 38c:	6c                   	insb   (%dx),%es:(%edi)
 38d:	31 38                	xor    %edi,(%eax)
	...

00000390 <SYS_ls_call19>:
 390:	6c                   	insb   (%dx),%es:(%edi)
 391:	73 5f                	jae    3f2 <SYS_ls_call28+0x8>
 393:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 396:	6c                   	insb   (%dx),%es:(%edi)
 397:	31 39                	xor    %edi,(%ecx)
	...

0000039a <SYS_ls_call20>:
 39a:	6c                   	insb   (%dx),%es:(%edi)
 39b:	73 5f                	jae    3fc <SYS_ls_call29+0x8>
 39d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a0:	6c                   	insb   (%dx),%es:(%edi)
 3a1:	32 30                	xor    (%eax),%dh
	...

000003a4 <SYS_ls_call21>:
 3a4:	6c                   	insb   (%dx),%es:(%edi)
 3a5:	73 5f                	jae    406 <SYS_ls_call30+0x8>
 3a7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3aa:	6c                   	insb   (%dx),%es:(%edi)
 3ab:	32 31                	xor    (%ecx),%dh
	...

000003ae <SYS_ls_call22>:
 3ae:	6c                   	insb   (%dx),%es:(%edi)
 3af:	73 5f                	jae    410 <exit>
 3b1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b4:	6c                   	insb   (%dx),%es:(%edi)
 3b5:	32 32                	xor    (%edx),%dh
	...

000003b8 <SYS_ls_call23>:
 3b8:	6c                   	insb   (%dx),%es:(%edi)
 3b9:	73 5f                	jae    41a <wait+0x2>
 3bb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3be:	6c                   	insb   (%dx),%es:(%edi)
 3bf:	32 33                	xor    (%ebx),%dh
	...

000003c2 <SYS_ls_call24>:
 3c2:	6c                   	insb   (%dx),%es:(%edi)
 3c3:	73 5f                	jae    424 <pipe+0x4>
 3c5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c8:	6c                   	insb   (%dx),%es:(%edi)
 3c9:	32 34 00             	xor    (%eax,%eax,1),%dh

000003cc <SYS_ls_call25>:
 3cc:	6c                   	insb   (%dx),%es:(%edi)
 3cd:	73 5f                	jae    42e <read+0x6>
 3cf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d2:	6c                   	insb   (%dx),%es:(%edi)
 3d3:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000003d6 <SYS_ls_call26>:
 3d6:	6c                   	insb   (%dx),%es:(%edi)
 3d7:	73 5f                	jae    438 <close>
 3d9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3dc:	6c                   	insb   (%dx),%es:(%edi)
 3dd:	32 36                	xor    (%esi),%dh
	...

000003e0 <SYS_ls_call27>:
 3e0:	6c                   	insb   (%dx),%es:(%edi)
 3e1:	73 5f                	jae    442 <kill+0x2>
 3e3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e6:	6c                   	insb   (%dx),%es:(%edi)
 3e7:	32 37                	xor    (%edi),%dh
	...

000003ea <SYS_ls_call28>:
 3ea:	6c                   	insb   (%dx),%es:(%edi)
 3eb:	73 5f                	jae    44c <exec+0x4>
 3ed:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f0:	6c                   	insb   (%dx),%es:(%edi)
 3f1:	32 38                	xor    (%eax),%bh
	...

000003f4 <SYS_ls_call29>:
 3f4:	6c                   	insb   (%dx),%es:(%edi)
 3f5:	73 5f                	jae    456 <open+0x6>
 3f7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3fa:	6c                   	insb   (%dx),%es:(%edi)
 3fb:	32 39                	xor    (%ecx),%bh
	...

000003fe <SYS_ls_call30>:
 3fe:	6c                   	insb   (%dx),%es:(%edi)
 3ff:	73 5f                	jae    460 <unlink>
 401:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 404:	6c                   	insb   (%dx),%es:(%edi)
 405:	33 30                	xor    (%eax),%esi
	...

00000408 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 408:	b8 01 00 00 00       	mov    $0x1,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <exit>:
SYSCALL(exit)
 410:	b8 02 00 00 00       	mov    $0x2,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <wait>:
SYSCALL(wait)
 418:	b8 03 00 00 00       	mov    $0x3,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <pipe>:
SYSCALL(pipe)
 420:	b8 04 00 00 00       	mov    $0x4,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <read>:
SYSCALL(read)
 428:	b8 05 00 00 00       	mov    $0x5,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <write>:
SYSCALL(write)
 430:	b8 10 00 00 00       	mov    $0x10,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <close>:
SYSCALL(close)
 438:	b8 15 00 00 00       	mov    $0x15,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <kill>:
SYSCALL(kill)
 440:	b8 06 00 00 00       	mov    $0x6,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <exec>:
SYSCALL(exec)
 448:	b8 07 00 00 00       	mov    $0x7,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <open>:
SYSCALL(open)
 450:	b8 0f 00 00 00       	mov    $0xf,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <mknod>:
SYSCALL(mknod)
 458:	b8 11 00 00 00       	mov    $0x11,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <unlink>:
SYSCALL(unlink)
 460:	b8 12 00 00 00       	mov    $0x12,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <fstat>:
SYSCALL(fstat)
 468:	b8 08 00 00 00       	mov    $0x8,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <link>:
SYSCALL(link)
 470:	b8 13 00 00 00       	mov    $0x13,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <mkdir>:
SYSCALL(mkdir)
 478:	b8 14 00 00 00       	mov    $0x14,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <chdir>:
SYSCALL(chdir)
 480:	b8 09 00 00 00       	mov    $0x9,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <dup>:
SYSCALL(dup)
 488:	b8 0a 00 00 00       	mov    $0xa,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <getpid>:
SYSCALL(getpid)
 490:	b8 0b 00 00 00       	mov    $0xb,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <sbrk>:
SYSCALL(sbrk)
 498:	b8 0c 00 00 00       	mov    $0xc,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <sleep>:
SYSCALL(sleep)
 4a0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <uptime>:
SYSCALL(uptime)
 4a8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <date>:
SYSCALL(date)
 4b0:	b8 16 00 00 00       	mov    $0x16,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <ls_call01>:

SYSCALL1(ls_call01)
 4b8:	b8 dc 02 00 00       	mov    $0x2dc,%eax
 4bd:	cd 41                	int    $0x41
 4bf:	c3                   	ret    

000004c0 <ls_call02>:
SYSCALL1(ls_call02)
 4c0:	b8 e6 02 00 00       	mov    $0x2e6,%eax
 4c5:	cd 41                	int    $0x41
 4c7:	c3                   	ret    

000004c8 <ls_call03>:
SYSCALL1(ls_call03)
 4c8:	b8 f0 02 00 00       	mov    $0x2f0,%eax
 4cd:	cd 41                	int    $0x41
 4cf:	c3                   	ret    

000004d0 <ls_call04>:
SYSCALL1(ls_call04)
 4d0:	b8 fa 02 00 00       	mov    $0x2fa,%eax
 4d5:	cd 41                	int    $0x41
 4d7:	c3                   	ret    

000004d8 <ls_call05>:
SYSCALL1(ls_call05)
 4d8:	b8 04 03 00 00       	mov    $0x304,%eax
 4dd:	cd 41                	int    $0x41
 4df:	c3                   	ret    

000004e0 <ls_call06>:
SYSCALL1(ls_call06)
 4e0:	b8 0e 03 00 00       	mov    $0x30e,%eax
 4e5:	cd 41                	int    $0x41
 4e7:	c3                   	ret    

000004e8 <ls_call07>:
SYSCALL1(ls_call07)
 4e8:	b8 18 03 00 00       	mov    $0x318,%eax
 4ed:	cd 41                	int    $0x41
 4ef:	c3                   	ret    

000004f0 <ls_call08>:
SYSCALL1(ls_call08)
 4f0:	b8 22 03 00 00       	mov    $0x322,%eax
 4f5:	cd 41                	int    $0x41
 4f7:	c3                   	ret    

000004f8 <ls_call09>:
SYSCALL1(ls_call09)
 4f8:	b8 2c 03 00 00       	mov    $0x32c,%eax
 4fd:	cd 41                	int    $0x41
 4ff:	c3                   	ret    

00000500 <ls_call10>:
SYSCALL1(ls_call10)
 500:	b8 36 03 00 00       	mov    $0x336,%eax
 505:	cd 41                	int    $0x41
 507:	c3                   	ret    

00000508 <ls_call11>:
SYSCALL1(ls_call11)
 508:	b8 40 03 00 00       	mov    $0x340,%eax
 50d:	cd 41                	int    $0x41
 50f:	c3                   	ret    

00000510 <ls_call12>:
SYSCALL1(ls_call12)
 510:	b8 4a 03 00 00       	mov    $0x34a,%eax
 515:	cd 41                	int    $0x41
 517:	c3                   	ret    

00000518 <ls_call13>:
SYSCALL1(ls_call13)
 518:	b8 54 03 00 00       	mov    $0x354,%eax
 51d:	cd 41                	int    $0x41
 51f:	c3                   	ret    

00000520 <ls_call14>:
SYSCALL1(ls_call14)
 520:	b8 5e 03 00 00       	mov    $0x35e,%eax
 525:	cd 41                	int    $0x41
 527:	c3                   	ret    

00000528 <ls_call15>:
SYSCALL1(ls_call15)
 528:	b8 68 03 00 00       	mov    $0x368,%eax
 52d:	cd 41                	int    $0x41
 52f:	c3                   	ret    

00000530 <ls_call16>:
SYSCALL1(ls_call16)
 530:	b8 72 03 00 00       	mov    $0x372,%eax
 535:	cd 41                	int    $0x41
 537:	c3                   	ret    

00000538 <ls_call17>:
SYSCALL1(ls_call17)
 538:	b8 7c 03 00 00       	mov    $0x37c,%eax
 53d:	cd 41                	int    $0x41
 53f:	c3                   	ret    

00000540 <ls_call18>:
SYSCALL1(ls_call18)
 540:	b8 86 03 00 00       	mov    $0x386,%eax
 545:	cd 41                	int    $0x41
 547:	c3                   	ret    

00000548 <ls_call19>:
SYSCALL1(ls_call19)
 548:	b8 90 03 00 00       	mov    $0x390,%eax
 54d:	cd 41                	int    $0x41
 54f:	c3                   	ret    

00000550 <ls_call20>:
SYSCALL1(ls_call20)
 550:	b8 9a 03 00 00       	mov    $0x39a,%eax
 555:	cd 41                	int    $0x41
 557:	c3                   	ret    

00000558 <ls_call21>:
SYSCALL1(ls_call21)
 558:	b8 a4 03 00 00       	mov    $0x3a4,%eax
 55d:	cd 41                	int    $0x41
 55f:	c3                   	ret    

00000560 <ls_call22>:
SYSCALL1(ls_call22)
 560:	b8 ae 03 00 00       	mov    $0x3ae,%eax
 565:	cd 41                	int    $0x41
 567:	c3                   	ret    

00000568 <ls_call23>:
SYSCALL1(ls_call23)
 568:	b8 b8 03 00 00       	mov    $0x3b8,%eax
 56d:	cd 41                	int    $0x41
 56f:	c3                   	ret    

00000570 <ls_call24>:
SYSCALL1(ls_call24)
 570:	b8 c2 03 00 00       	mov    $0x3c2,%eax
 575:	cd 41                	int    $0x41
 577:	c3                   	ret    

00000578 <ls_call25>:
SYSCALL1(ls_call25)
 578:	b8 cc 03 00 00       	mov    $0x3cc,%eax
 57d:	cd 41                	int    $0x41
 57f:	c3                   	ret    

00000580 <ls_call26>:
SYSCALL1(ls_call26)
 580:	b8 d6 03 00 00       	mov    $0x3d6,%eax
 585:	cd 41                	int    $0x41
 587:	c3                   	ret    

00000588 <ls_call27>:
SYSCALL1(ls_call27)
 588:	b8 e0 03 00 00       	mov    $0x3e0,%eax
 58d:	cd 41                	int    $0x41
 58f:	c3                   	ret    

00000590 <ls_call28>:
SYSCALL1(ls_call28)
 590:	b8 ea 03 00 00       	mov    $0x3ea,%eax
 595:	cd 41                	int    $0x41
 597:	c3                   	ret    

00000598 <ls_call29>:
SYSCALL1(ls_call29)
 598:	b8 f4 03 00 00       	mov    $0x3f4,%eax
 59d:	cd 41                	int    $0x41
 59f:	c3                   	ret    

000005a0 <ls_call30>:
SYSCALL1(ls_call30)
 5a0:	b8 fe 03 00 00       	mov    $0x3fe,%eax
 5a5:	cd 41                	int    $0x41
 5a7:	c3                   	ret    

000005a8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5a8:	55                   	push   %ebp
 5a9:	89 e5                	mov    %esp,%ebp
 5ab:	83 ec 28             	sub    $0x28,%esp
 5ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 5b1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5bb:	00 
 5bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c3:	8b 45 08             	mov    0x8(%ebp),%eax
 5c6:	89 04 24             	mov    %eax,(%esp)
 5c9:	e8 62 fe ff ff       	call   430 <write>
}
 5ce:	c9                   	leave  
 5cf:	c3                   	ret    

000005d0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5dd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5e1:	74 17                	je     5fa <printint+0x2a>
 5e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5e7:	79 11                	jns    5fa <printint+0x2a>
    neg = 1;
 5e9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f3:	f7 d8                	neg    %eax
 5f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5f8:	eb 06                	jmp    600 <printint+0x30>
  } else {
    x = xx;
 5fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 5fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 600:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 607:	8b 4d 10             	mov    0x10(%ebp),%ecx
 60a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 60d:	ba 00 00 00 00       	mov    $0x0,%edx
 612:	f7 f1                	div    %ecx
 614:	89 d0                	mov    %edx,%eax
 616:	0f b6 80 c0 0c 00 00 	movzbl 0xcc0(%eax),%eax
 61d:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 620:	8b 55 f4             	mov    -0xc(%ebp),%edx
 623:	01 ca                	add    %ecx,%edx
 625:	88 02                	mov    %al,(%edx)
 627:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 62b:	8b 55 10             	mov    0x10(%ebp),%edx
 62e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 631:	8b 45 ec             	mov    -0x14(%ebp),%eax
 634:	ba 00 00 00 00       	mov    $0x0,%edx
 639:	f7 75 d4             	divl   -0x2c(%ebp)
 63c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 63f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 643:	75 c2                	jne    607 <printint+0x37>
  if(neg)
 645:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 649:	74 2e                	je     679 <printint+0xa9>
    buf[i++] = '-';
 64b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 64e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 651:	01 d0                	add    %edx,%eax
 653:	c6 00 2d             	movb   $0x2d,(%eax)
 656:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 65a:	eb 1d                	jmp    679 <printint+0xa9>
    putc(fd, buf[i]);
 65c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 65f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 662:	01 d0                	add    %edx,%eax
 664:	0f b6 00             	movzbl (%eax),%eax
 667:	0f be c0             	movsbl %al,%eax
 66a:	89 44 24 04          	mov    %eax,0x4(%esp)
 66e:	8b 45 08             	mov    0x8(%ebp),%eax
 671:	89 04 24             	mov    %eax,(%esp)
 674:	e8 2f ff ff ff       	call   5a8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 679:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 67d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 681:	79 d9                	jns    65c <printint+0x8c>
    putc(fd, buf[i]);
}
 683:	c9                   	leave  
 684:	c3                   	ret    

00000685 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 685:	55                   	push   %ebp
 686:	89 e5                	mov    %esp,%ebp
 688:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 68b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 692:	8d 45 0c             	lea    0xc(%ebp),%eax
 695:	83 c0 04             	add    $0x4,%eax
 698:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 69b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6a2:	e9 7d 01 00 00       	jmp    824 <printf+0x19f>
    c = fmt[i] & 0xff;
 6a7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ad:	01 d0                	add    %edx,%eax
 6af:	0f b6 00             	movzbl (%eax),%eax
 6b2:	0f be c0             	movsbl %al,%eax
 6b5:	25 ff 00 00 00       	and    $0xff,%eax
 6ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6c1:	75 2c                	jne    6ef <printf+0x6a>
      if(c == '%'){
 6c3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6c7:	75 0c                	jne    6d5 <printf+0x50>
        state = '%';
 6c9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6d0:	e9 4b 01 00 00       	jmp    820 <printf+0x19b>
      } else {
        putc(fd, c);
 6d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d8:	0f be c0             	movsbl %al,%eax
 6db:	89 44 24 04          	mov    %eax,0x4(%esp)
 6df:	8b 45 08             	mov    0x8(%ebp),%eax
 6e2:	89 04 24             	mov    %eax,(%esp)
 6e5:	e8 be fe ff ff       	call   5a8 <putc>
 6ea:	e9 31 01 00 00       	jmp    820 <printf+0x19b>
      }
    } else if(state == '%'){
 6ef:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6f3:	0f 85 27 01 00 00    	jne    820 <printf+0x19b>
      if(c == 'd'){
 6f9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6fd:	75 2d                	jne    72c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 6ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
 702:	8b 00                	mov    (%eax),%eax
 704:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 70b:	00 
 70c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 713:	00 
 714:	89 44 24 04          	mov    %eax,0x4(%esp)
 718:	8b 45 08             	mov    0x8(%ebp),%eax
 71b:	89 04 24             	mov    %eax,(%esp)
 71e:	e8 ad fe ff ff       	call   5d0 <printint>
        ap++;
 723:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 727:	e9 ed 00 00 00       	jmp    819 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 72c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 730:	74 06                	je     738 <printf+0xb3>
 732:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 736:	75 2d                	jne    765 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 738:	8b 45 e8             	mov    -0x18(%ebp),%eax
 73b:	8b 00                	mov    (%eax),%eax
 73d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 744:	00 
 745:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 74c:	00 
 74d:	89 44 24 04          	mov    %eax,0x4(%esp)
 751:	8b 45 08             	mov    0x8(%ebp),%eax
 754:	89 04 24             	mov    %eax,(%esp)
 757:	e8 74 fe ff ff       	call   5d0 <printint>
        ap++;
 75c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 760:	e9 b4 00 00 00       	jmp    819 <printf+0x194>
      } else if(c == 's'){
 765:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 769:	75 46                	jne    7b1 <printf+0x12c>
        s = (char*)*ap;
 76b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 76e:	8b 00                	mov    (%eax),%eax
 770:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 773:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 777:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 77b:	75 27                	jne    7a4 <printf+0x11f>
          s = "(null)";
 77d:	c7 45 f4 7c 0a 00 00 	movl   $0xa7c,-0xc(%ebp)
        while(*s != 0){
 784:	eb 1e                	jmp    7a4 <printf+0x11f>
          putc(fd, *s);
 786:	8b 45 f4             	mov    -0xc(%ebp),%eax
 789:	0f b6 00             	movzbl (%eax),%eax
 78c:	0f be c0             	movsbl %al,%eax
 78f:	89 44 24 04          	mov    %eax,0x4(%esp)
 793:	8b 45 08             	mov    0x8(%ebp),%eax
 796:	89 04 24             	mov    %eax,(%esp)
 799:	e8 0a fe ff ff       	call   5a8 <putc>
          s++;
 79e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 7a2:	eb 01                	jmp    7a5 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7a4:	90                   	nop
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	0f b6 00             	movzbl (%eax),%eax
 7ab:	84 c0                	test   %al,%al
 7ad:	75 d7                	jne    786 <printf+0x101>
 7af:	eb 68                	jmp    819 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7b1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7b5:	75 1d                	jne    7d4 <printf+0x14f>
        putc(fd, *ap);
 7b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ba:	8b 00                	mov    (%eax),%eax
 7bc:	0f be c0             	movsbl %al,%eax
 7bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c3:	8b 45 08             	mov    0x8(%ebp),%eax
 7c6:	89 04 24             	mov    %eax,(%esp)
 7c9:	e8 da fd ff ff       	call   5a8 <putc>
        ap++;
 7ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7d2:	eb 45                	jmp    819 <printf+0x194>
      } else if(c == '%'){
 7d4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7d8:	75 17                	jne    7f1 <printf+0x16c>
        putc(fd, c);
 7da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7dd:	0f be c0             	movsbl %al,%eax
 7e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e4:	8b 45 08             	mov    0x8(%ebp),%eax
 7e7:	89 04 24             	mov    %eax,(%esp)
 7ea:	e8 b9 fd ff ff       	call   5a8 <putc>
 7ef:	eb 28                	jmp    819 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f1:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 7f8:	00 
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
 7fc:	89 04 24             	mov    %eax,(%esp)
 7ff:	e8 a4 fd ff ff       	call   5a8 <putc>
        putc(fd, c);
 804:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 807:	0f be c0             	movsbl %al,%eax
 80a:	89 44 24 04          	mov    %eax,0x4(%esp)
 80e:	8b 45 08             	mov    0x8(%ebp),%eax
 811:	89 04 24             	mov    %eax,(%esp)
 814:	e8 8f fd ff ff       	call   5a8 <putc>
      }
      state = 0;
 819:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 820:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 824:	8b 55 0c             	mov    0xc(%ebp),%edx
 827:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82a:	01 d0                	add    %edx,%eax
 82c:	0f b6 00             	movzbl (%eax),%eax
 82f:	84 c0                	test   %al,%al
 831:	0f 85 70 fe ff ff    	jne    6a7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 837:	c9                   	leave  
 838:	c3                   	ret    
 839:	90                   	nop
 83a:	90                   	nop
 83b:	90                   	nop

0000083c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83c:	55                   	push   %ebp
 83d:	89 e5                	mov    %esp,%ebp
 83f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 842:	8b 45 08             	mov    0x8(%ebp),%eax
 845:	83 e8 08             	sub    $0x8,%eax
 848:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84b:	a1 dc 0c 00 00       	mov    0xcdc,%eax
 850:	89 45 fc             	mov    %eax,-0x4(%ebp)
 853:	eb 24                	jmp    879 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 855:	8b 45 fc             	mov    -0x4(%ebp),%eax
 858:	8b 00                	mov    (%eax),%eax
 85a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 85d:	77 12                	ja     871 <free+0x35>
 85f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 862:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 865:	77 24                	ja     88b <free+0x4f>
 867:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86a:	8b 00                	mov    (%eax),%eax
 86c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 86f:	77 1a                	ja     88b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 871:	8b 45 fc             	mov    -0x4(%ebp),%eax
 874:	8b 00                	mov    (%eax),%eax
 876:	89 45 fc             	mov    %eax,-0x4(%ebp)
 879:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 87f:	76 d4                	jbe    855 <free+0x19>
 881:	8b 45 fc             	mov    -0x4(%ebp),%eax
 884:	8b 00                	mov    (%eax),%eax
 886:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 889:	76 ca                	jbe    855 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 88b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88e:	8b 40 04             	mov    0x4(%eax),%eax
 891:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 898:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89b:	01 c2                	add    %eax,%edx
 89d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a0:	8b 00                	mov    (%eax),%eax
 8a2:	39 c2                	cmp    %eax,%edx
 8a4:	75 24                	jne    8ca <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a9:	8b 50 04             	mov    0x4(%eax),%edx
 8ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8af:	8b 00                	mov    (%eax),%eax
 8b1:	8b 40 04             	mov    0x4(%eax),%eax
 8b4:	01 c2                	add    %eax,%edx
 8b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8bf:	8b 00                	mov    (%eax),%eax
 8c1:	8b 10                	mov    (%eax),%edx
 8c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c6:	89 10                	mov    %edx,(%eax)
 8c8:	eb 0a                	jmp    8d4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cd:	8b 10                	mov    (%eax),%edx
 8cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d7:	8b 40 04             	mov    0x4(%eax),%eax
 8da:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e4:	01 d0                	add    %edx,%eax
 8e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8e9:	75 20                	jne    90b <free+0xcf>
    p->s.size += bp->s.size;
 8eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ee:	8b 50 04             	mov    0x4(%eax),%edx
 8f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f4:	8b 40 04             	mov    0x4(%eax),%eax
 8f7:	01 c2                	add    %eax,%edx
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 902:	8b 10                	mov    (%eax),%edx
 904:	8b 45 fc             	mov    -0x4(%ebp),%eax
 907:	89 10                	mov    %edx,(%eax)
 909:	eb 08                	jmp    913 <free+0xd7>
  } else
    p->s.ptr = bp;
 90b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 911:	89 10                	mov    %edx,(%eax)
  freep = p;
 913:	8b 45 fc             	mov    -0x4(%ebp),%eax
 916:	a3 dc 0c 00 00       	mov    %eax,0xcdc
}
 91b:	c9                   	leave  
 91c:	c3                   	ret    

0000091d <morecore>:

static Header*
morecore(uint nu)
{
 91d:	55                   	push   %ebp
 91e:	89 e5                	mov    %esp,%ebp
 920:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 923:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 92a:	77 07                	ja     933 <morecore+0x16>
    nu = 4096;
 92c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 933:	8b 45 08             	mov    0x8(%ebp),%eax
 936:	c1 e0 03             	shl    $0x3,%eax
 939:	89 04 24             	mov    %eax,(%esp)
 93c:	e8 57 fb ff ff       	call   498 <sbrk>
 941:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 944:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 948:	75 07                	jne    951 <morecore+0x34>
    return 0;
 94a:	b8 00 00 00 00       	mov    $0x0,%eax
 94f:	eb 22                	jmp    973 <morecore+0x56>
  hp = (Header*)p;
 951:	8b 45 f4             	mov    -0xc(%ebp),%eax
 954:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 957:	8b 45 f0             	mov    -0x10(%ebp),%eax
 95a:	8b 55 08             	mov    0x8(%ebp),%edx
 95d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 960:	8b 45 f0             	mov    -0x10(%ebp),%eax
 963:	83 c0 08             	add    $0x8,%eax
 966:	89 04 24             	mov    %eax,(%esp)
 969:	e8 ce fe ff ff       	call   83c <free>
  return freep;
 96e:	a1 dc 0c 00 00       	mov    0xcdc,%eax
}
 973:	c9                   	leave  
 974:	c3                   	ret    

00000975 <malloc>:

void*
malloc(uint nbytes)
{
 975:	55                   	push   %ebp
 976:	89 e5                	mov    %esp,%ebp
 978:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 97b:	8b 45 08             	mov    0x8(%ebp),%eax
 97e:	83 c0 07             	add    $0x7,%eax
 981:	c1 e8 03             	shr    $0x3,%eax
 984:	83 c0 01             	add    $0x1,%eax
 987:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 98a:	a1 dc 0c 00 00       	mov    0xcdc,%eax
 98f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 992:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 996:	75 23                	jne    9bb <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 998:	c7 45 f0 d4 0c 00 00 	movl   $0xcd4,-0x10(%ebp)
 99f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a2:	a3 dc 0c 00 00       	mov    %eax,0xcdc
 9a7:	a1 dc 0c 00 00       	mov    0xcdc,%eax
 9ac:	a3 d4 0c 00 00       	mov    %eax,0xcd4
    base.s.size = 0;
 9b1:	c7 05 d8 0c 00 00 00 	movl   $0x0,0xcd8
 9b8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9be:	8b 00                	mov    (%eax),%eax
 9c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c6:	8b 40 04             	mov    0x4(%eax),%eax
 9c9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9cc:	72 4d                	jb     a1b <malloc+0xa6>
      if(p->s.size == nunits)
 9ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d1:	8b 40 04             	mov    0x4(%eax),%eax
 9d4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9d7:	75 0c                	jne    9e5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9dc:	8b 10                	mov    (%eax),%edx
 9de:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e1:	89 10                	mov    %edx,(%eax)
 9e3:	eb 26                	jmp    a0b <malloc+0x96>
      else {
        p->s.size -= nunits;
 9e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e8:	8b 40 04             	mov    0x4(%eax),%eax
 9eb:	89 c2                	mov    %eax,%edx
 9ed:	2b 55 ec             	sub    -0x14(%ebp),%edx
 9f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f9:	8b 40 04             	mov    0x4(%eax),%eax
 9fc:	c1 e0 03             	shl    $0x3,%eax
 9ff:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a05:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a08:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a0e:	a3 dc 0c 00 00       	mov    %eax,0xcdc
      return (void*)(p + 1);
 a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a16:	83 c0 08             	add    $0x8,%eax
 a19:	eb 38                	jmp    a53 <malloc+0xde>
    }
    if(p == freep)
 a1b:	a1 dc 0c 00 00       	mov    0xcdc,%eax
 a20:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a23:	75 1b                	jne    a40 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a25:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a28:	89 04 24             	mov    %eax,(%esp)
 a2b:	e8 ed fe ff ff       	call   91d <morecore>
 a30:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a33:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a37:	75 07                	jne    a40 <malloc+0xcb>
        return 0;
 a39:	b8 00 00 00 00       	mov    $0x0,%eax
 a3e:	eb 13                	jmp    a53 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a43:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a49:	8b 00                	mov    (%eax),%eax
 a4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a4e:	e9 70 ff ff ff       	jmp    9c3 <malloc+0x4e>
}
 a53:	c9                   	leave  
 a54:	c3                   	ret    
