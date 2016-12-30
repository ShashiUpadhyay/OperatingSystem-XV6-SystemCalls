
_rm:     file format elf32-i386


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
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "Usage: rm files...\n");
   f:	c7 44 24 04 69 0a 00 	movl   $0xa69,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 76 06 00 00       	call   699 <printf>
    exit();
  23:	e8 fc 03 00 00       	call   424 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 4f                	jmp    81 <main+0x81>
    if(unlink(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 28 04 00 00       	call   474 <unlink>
  4c:	85 c0                	test   %eax,%eax
  4e:	79 2c                	jns    7c <main+0x7c>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  50:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  5e:	01 d0                	add    %edx,%eax
  60:	8b 00                	mov    (%eax),%eax
  62:	89 44 24 08          	mov    %eax,0x8(%esp)
  66:	c7 44 24 04 7d 0a 00 	movl   $0xa7d,0x4(%esp)
  6d:	00 
  6e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  75:	e8 1f 06 00 00       	call   699 <printf>
      break;
  7a:	eb 0e                	jmp    8a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  7c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  81:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  85:	3b 45 08             	cmp    0x8(%ebp),%eax
  88:	7c a8                	jl     32 <main+0x32>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  8a:	e8 95 03 00 00       	call   424 <exit>
  8f:	90                   	nop

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  98:	8b 55 10             	mov    0x10(%ebp),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	89 cb                	mov    %ecx,%ebx
  a0:	89 df                	mov    %ebx,%edi
  a2:	89 d1                	mov    %edx,%ecx
  a4:	fc                   	cld    
  a5:	f3 aa                	rep stos %al,%es:(%edi)
  a7:	89 ca                	mov    %ecx,%edx
  a9:	89 fb                	mov    %edi,%ebx
  ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b1:	5b                   	pop    %ebx
  b2:	5f                   	pop    %edi
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    

000000b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c1:	90                   	nop
  c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  c5:	0f b6 10             	movzbl (%eax),%edx
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	88 10                	mov    %dl,(%eax)
  cd:	8b 45 08             	mov    0x8(%ebp),%eax
  d0:	0f b6 00             	movzbl (%eax),%eax
  d3:	84 c0                	test   %al,%al
  d5:	0f 95 c0             	setne  %al
  d8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  dc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  e0:	84 c0                	test   %al,%al
  e2:	75 de                	jne    c2 <strcpy+0xd>
    ;
  return os;
  e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e7:	c9                   	leave  
  e8:	c3                   	ret    

000000e9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e9:	55                   	push   %ebp
  ea:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  ec:	eb 08                	jmp    f6 <strcmp+0xd>
    p++, q++;
  ee:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  f2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f6:	8b 45 08             	mov    0x8(%ebp),%eax
  f9:	0f b6 00             	movzbl (%eax),%eax
  fc:	84 c0                	test   %al,%al
  fe:	74 10                	je     110 <strcmp+0x27>
 100:	8b 45 08             	mov    0x8(%ebp),%eax
 103:	0f b6 10             	movzbl (%eax),%edx
 106:	8b 45 0c             	mov    0xc(%ebp),%eax
 109:	0f b6 00             	movzbl (%eax),%eax
 10c:	38 c2                	cmp    %al,%dl
 10e:	74 de                	je     ee <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	0f b6 00             	movzbl (%eax),%eax
 116:	0f b6 d0             	movzbl %al,%edx
 119:	8b 45 0c             	mov    0xc(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	0f b6 c0             	movzbl %al,%eax
 122:	89 d1                	mov    %edx,%ecx
 124:	29 c1                	sub    %eax,%ecx
 126:	89 c8                	mov    %ecx,%eax
}
 128:	5d                   	pop    %ebp
 129:	c3                   	ret    

0000012a <strlen>:

uint
strlen(char *s)
{
 12a:	55                   	push   %ebp
 12b:	89 e5                	mov    %esp,%ebp
 12d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 130:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 137:	eb 04                	jmp    13d <strlen+0x13>
 139:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 13d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 140:	8b 45 08             	mov    0x8(%ebp),%eax
 143:	01 d0                	add    %edx,%eax
 145:	0f b6 00             	movzbl (%eax),%eax
 148:	84 c0                	test   %al,%al
 14a:	75 ed                	jne    139 <strlen+0xf>
    ;
  return n;
 14c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 14f:	c9                   	leave  
 150:	c3                   	ret    

00000151 <memset>:

void*
memset(void *dst, int c, uint n)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 157:	8b 45 10             	mov    0x10(%ebp),%eax
 15a:	89 44 24 08          	mov    %eax,0x8(%esp)
 15e:	8b 45 0c             	mov    0xc(%ebp),%eax
 161:	89 44 24 04          	mov    %eax,0x4(%esp)
 165:	8b 45 08             	mov    0x8(%ebp),%eax
 168:	89 04 24             	mov    %eax,(%esp)
 16b:	e8 20 ff ff ff       	call   90 <stosb>
  return dst;
 170:	8b 45 08             	mov    0x8(%ebp),%eax
}
 173:	c9                   	leave  
 174:	c3                   	ret    

00000175 <strchr>:

char*
strchr(const char *s, char c)
{
 175:	55                   	push   %ebp
 176:	89 e5                	mov    %esp,%ebp
 178:	83 ec 04             	sub    $0x4,%esp
 17b:	8b 45 0c             	mov    0xc(%ebp),%eax
 17e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 181:	eb 14                	jmp    197 <strchr+0x22>
    if(*s == c)
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	0f b6 00             	movzbl (%eax),%eax
 189:	3a 45 fc             	cmp    -0x4(%ebp),%al
 18c:	75 05                	jne    193 <strchr+0x1e>
      return (char*)s;
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	eb 13                	jmp    1a6 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 193:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	0f b6 00             	movzbl (%eax),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 e2                	jne    183 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1a6:	c9                   	leave  
 1a7:	c3                   	ret    

000001a8 <gets>:

char*
gets(char *buf, int max)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1b5:	eb 46                	jmp    1fd <gets+0x55>
    cc = read(0, &c, 1);
 1b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1be:	00 
 1bf:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1c2:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1cd:	e8 6a 02 00 00       	call   43c <read>
 1d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1d9:	7e 2f                	jle    20a <gets+0x62>
      break;
    buf[i++] = c;
 1db:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
 1e1:	01 c2                	add    %eax,%edx
 1e3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e7:	88 02                	mov    %al,(%edx)
 1e9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f1:	3c 0a                	cmp    $0xa,%al
 1f3:	74 16                	je     20b <gets+0x63>
 1f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f9:	3c 0d                	cmp    $0xd,%al
 1fb:	74 0e                	je     20b <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 200:	83 c0 01             	add    $0x1,%eax
 203:	3b 45 0c             	cmp    0xc(%ebp),%eax
 206:	7c af                	jl     1b7 <gets+0xf>
 208:	eb 01                	jmp    20b <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 20a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 20b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	01 d0                	add    %edx,%eax
 213:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 216:	8b 45 08             	mov    0x8(%ebp),%eax
}
 219:	c9                   	leave  
 21a:	c3                   	ret    

0000021b <stat>:

int
stat(char *n, struct stat *st)
{
 21b:	55                   	push   %ebp
 21c:	89 e5                	mov    %esp,%ebp
 21e:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 221:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 228:	00 
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	89 04 24             	mov    %eax,(%esp)
 22f:	e8 30 02 00 00       	call   464 <open>
 234:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 237:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 23b:	79 07                	jns    244 <stat+0x29>
    return -1;
 23d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 242:	eb 23                	jmp    267 <stat+0x4c>
  r = fstat(fd, st);
 244:	8b 45 0c             	mov    0xc(%ebp),%eax
 247:	89 44 24 04          	mov    %eax,0x4(%esp)
 24b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24e:	89 04 24             	mov    %eax,(%esp)
 251:	e8 26 02 00 00       	call   47c <fstat>
 256:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 259:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25c:	89 04 24             	mov    %eax,(%esp)
 25f:	e8 e8 01 00 00       	call   44c <close>
  return r;
 264:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 267:	c9                   	leave  
 268:	c3                   	ret    

00000269 <atoi>:

int
atoi(const char *s)
{
 269:	55                   	push   %ebp
 26a:	89 e5                	mov    %esp,%ebp
 26c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 26f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 276:	eb 23                	jmp    29b <atoi+0x32>
    n = n*10 + *s++ - '0';
 278:	8b 55 fc             	mov    -0x4(%ebp),%edx
 27b:	89 d0                	mov    %edx,%eax
 27d:	c1 e0 02             	shl    $0x2,%eax
 280:	01 d0                	add    %edx,%eax
 282:	01 c0                	add    %eax,%eax
 284:	89 c2                	mov    %eax,%edx
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	0f b6 00             	movzbl (%eax),%eax
 28c:	0f be c0             	movsbl %al,%eax
 28f:	01 d0                	add    %edx,%eax
 291:	83 e8 30             	sub    $0x30,%eax
 294:	89 45 fc             	mov    %eax,-0x4(%ebp)
 297:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	0f b6 00             	movzbl (%eax),%eax
 2a1:	3c 2f                	cmp    $0x2f,%al
 2a3:	7e 0a                	jle    2af <atoi+0x46>
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	3c 39                	cmp    $0x39,%al
 2ad:	7e c9                	jle    278 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2af:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b2:	c9                   	leave  
 2b3:	c3                   	ret    

000002b4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2ba:	8b 45 08             	mov    0x8(%ebp),%eax
 2bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2c6:	eb 13                	jmp    2db <memmove+0x27>
    *dst++ = *src++;
 2c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2cb:	0f b6 10             	movzbl (%eax),%edx
 2ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2d1:	88 10                	mov    %dl,(%eax)
 2d3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2d7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2df:	0f 9f c0             	setg   %al
 2e2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2e6:	84 c0                	test   %al,%al
 2e8:	75 de                	jne    2c8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ed:	c9                   	leave  
 2ee:	c3                   	ret    
 2ef:	90                   	nop

000002f0 <SYS_ls_call01>:
 2f0:	6c                   	insb   (%dx),%es:(%edi)
 2f1:	73 5f                	jae    352 <SYS_ls_call10+0x8>
 2f3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 2f6:	6c                   	insb   (%dx),%es:(%edi)
 2f7:	30 31                	xor    %dh,(%ecx)
	...

000002fa <SYS_ls_call02>:
 2fa:	6c                   	insb   (%dx),%es:(%edi)
 2fb:	73 5f                	jae    35c <SYS_ls_call11+0x8>
 2fd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 300:	6c                   	insb   (%dx),%es:(%edi)
 301:	30 32                	xor    %dh,(%edx)
	...

00000304 <SYS_ls_call03>:
 304:	6c                   	insb   (%dx),%es:(%edi)
 305:	73 5f                	jae    366 <SYS_ls_call12+0x8>
 307:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 30a:	6c                   	insb   (%dx),%es:(%edi)
 30b:	30 33                	xor    %dh,(%ebx)
	...

0000030e <SYS_ls_call04>:
 30e:	6c                   	insb   (%dx),%es:(%edi)
 30f:	73 5f                	jae    370 <SYS_ls_call13+0x8>
 311:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 314:	6c                   	insb   (%dx),%es:(%edi)
 315:	30 34 00             	xor    %dh,(%eax,%eax,1)

00000318 <SYS_ls_call05>:
 318:	6c                   	insb   (%dx),%es:(%edi)
 319:	73 5f                	jae    37a <SYS_ls_call14+0x8>
 31b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 31e:	6c                   	insb   (%dx),%es:(%edi)
 31f:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

00000322 <SYS_ls_call06>:
 322:	6c                   	insb   (%dx),%es:(%edi)
 323:	73 5f                	jae    384 <SYS_ls_call15+0x8>
 325:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 328:	6c                   	insb   (%dx),%es:(%edi)
 329:	30 36                	xor    %dh,(%esi)
	...

0000032c <SYS_ls_call07>:
 32c:	6c                   	insb   (%dx),%es:(%edi)
 32d:	73 5f                	jae    38e <SYS_ls_call16+0x8>
 32f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 332:	6c                   	insb   (%dx),%es:(%edi)
 333:	30 37                	xor    %dh,(%edi)
	...

00000336 <SYS_ls_call08>:
 336:	6c                   	insb   (%dx),%es:(%edi)
 337:	73 5f                	jae    398 <SYS_ls_call17+0x8>
 339:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 33c:	6c                   	insb   (%dx),%es:(%edi)
 33d:	30 38                	xor    %bh,(%eax)
	...

00000340 <SYS_ls_call09>:
 340:	6c                   	insb   (%dx),%es:(%edi)
 341:	73 5f                	jae    3a2 <SYS_ls_call18+0x8>
 343:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 346:	6c                   	insb   (%dx),%es:(%edi)
 347:	30 39                	xor    %bh,(%ecx)
	...

0000034a <SYS_ls_call10>:
 34a:	6c                   	insb   (%dx),%es:(%edi)
 34b:	73 5f                	jae    3ac <SYS_ls_call19+0x8>
 34d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 350:	6c                   	insb   (%dx),%es:(%edi)
 351:	31 30                	xor    %esi,(%eax)
	...

00000354 <SYS_ls_call11>:
 354:	6c                   	insb   (%dx),%es:(%edi)
 355:	73 5f                	jae    3b6 <SYS_ls_call20+0x8>
 357:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 35a:	6c                   	insb   (%dx),%es:(%edi)
 35b:	31 31                	xor    %esi,(%ecx)
	...

0000035e <SYS_ls_call12>:
 35e:	6c                   	insb   (%dx),%es:(%edi)
 35f:	73 5f                	jae    3c0 <SYS_ls_call21+0x8>
 361:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 364:	6c                   	insb   (%dx),%es:(%edi)
 365:	31 32                	xor    %esi,(%edx)
	...

00000368 <SYS_ls_call13>:
 368:	6c                   	insb   (%dx),%es:(%edi)
 369:	73 5f                	jae    3ca <SYS_ls_call22+0x8>
 36b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 36e:	6c                   	insb   (%dx),%es:(%edi)
 36f:	31 33                	xor    %esi,(%ebx)
	...

00000372 <SYS_ls_call14>:
 372:	6c                   	insb   (%dx),%es:(%edi)
 373:	73 5f                	jae    3d4 <SYS_ls_call23+0x8>
 375:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 378:	6c                   	insb   (%dx),%es:(%edi)
 379:	31 34 00             	xor    %esi,(%eax,%eax,1)

0000037c <SYS_ls_call15>:
 37c:	6c                   	insb   (%dx),%es:(%edi)
 37d:	73 5f                	jae    3de <SYS_ls_call24+0x8>
 37f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 382:	6c                   	insb   (%dx),%es:(%edi)
 383:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000386 <SYS_ls_call16>:
 386:	6c                   	insb   (%dx),%es:(%edi)
 387:	73 5f                	jae    3e8 <SYS_ls_call25+0x8>
 389:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 38c:	6c                   	insb   (%dx),%es:(%edi)
 38d:	31 36                	xor    %esi,(%esi)
	...

00000390 <SYS_ls_call17>:
 390:	6c                   	insb   (%dx),%es:(%edi)
 391:	73 5f                	jae    3f2 <SYS_ls_call26+0x8>
 393:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 396:	6c                   	insb   (%dx),%es:(%edi)
 397:	31 37                	xor    %esi,(%edi)
	...

0000039a <SYS_ls_call18>:
 39a:	6c                   	insb   (%dx),%es:(%edi)
 39b:	73 5f                	jae    3fc <SYS_ls_call27+0x8>
 39d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a0:	6c                   	insb   (%dx),%es:(%edi)
 3a1:	31 38                	xor    %edi,(%eax)
	...

000003a4 <SYS_ls_call19>:
 3a4:	6c                   	insb   (%dx),%es:(%edi)
 3a5:	73 5f                	jae    406 <SYS_ls_call28+0x8>
 3a7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3aa:	6c                   	insb   (%dx),%es:(%edi)
 3ab:	31 39                	xor    %edi,(%ecx)
	...

000003ae <SYS_ls_call20>:
 3ae:	6c                   	insb   (%dx),%es:(%edi)
 3af:	73 5f                	jae    410 <SYS_ls_call29+0x8>
 3b1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b4:	6c                   	insb   (%dx),%es:(%edi)
 3b5:	32 30                	xor    (%eax),%dh
	...

000003b8 <SYS_ls_call21>:
 3b8:	6c                   	insb   (%dx),%es:(%edi)
 3b9:	73 5f                	jae    41a <SYS_ls_call30+0x8>
 3bb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3be:	6c                   	insb   (%dx),%es:(%edi)
 3bf:	32 31                	xor    (%ecx),%dh
	...

000003c2 <SYS_ls_call22>:
 3c2:	6c                   	insb   (%dx),%es:(%edi)
 3c3:	73 5f                	jae    424 <exit>
 3c5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c8:	6c                   	insb   (%dx),%es:(%edi)
 3c9:	32 32                	xor    (%edx),%dh
	...

000003cc <SYS_ls_call23>:
 3cc:	6c                   	insb   (%dx),%es:(%edi)
 3cd:	73 5f                	jae    42e <wait+0x2>
 3cf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d2:	6c                   	insb   (%dx),%es:(%edi)
 3d3:	32 33                	xor    (%ebx),%dh
	...

000003d6 <SYS_ls_call24>:
 3d6:	6c                   	insb   (%dx),%es:(%edi)
 3d7:	73 5f                	jae    438 <pipe+0x4>
 3d9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3dc:	6c                   	insb   (%dx),%es:(%edi)
 3dd:	32 34 00             	xor    (%eax,%eax,1),%dh

000003e0 <SYS_ls_call25>:
 3e0:	6c                   	insb   (%dx),%es:(%edi)
 3e1:	73 5f                	jae    442 <read+0x6>
 3e3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e6:	6c                   	insb   (%dx),%es:(%edi)
 3e7:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000003ea <SYS_ls_call26>:
 3ea:	6c                   	insb   (%dx),%es:(%edi)
 3eb:	73 5f                	jae    44c <close>
 3ed:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f0:	6c                   	insb   (%dx),%es:(%edi)
 3f1:	32 36                	xor    (%esi),%dh
	...

000003f4 <SYS_ls_call27>:
 3f4:	6c                   	insb   (%dx),%es:(%edi)
 3f5:	73 5f                	jae    456 <kill+0x2>
 3f7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3fa:	6c                   	insb   (%dx),%es:(%edi)
 3fb:	32 37                	xor    (%edi),%dh
	...

000003fe <SYS_ls_call28>:
 3fe:	6c                   	insb   (%dx),%es:(%edi)
 3ff:	73 5f                	jae    460 <exec+0x4>
 401:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 404:	6c                   	insb   (%dx),%es:(%edi)
 405:	32 38                	xor    (%eax),%bh
	...

00000408 <SYS_ls_call29>:
 408:	6c                   	insb   (%dx),%es:(%edi)
 409:	73 5f                	jae    46a <open+0x6>
 40b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 40e:	6c                   	insb   (%dx),%es:(%edi)
 40f:	32 39                	xor    (%ecx),%bh
	...

00000412 <SYS_ls_call30>:
 412:	6c                   	insb   (%dx),%es:(%edi)
 413:	73 5f                	jae    474 <unlink>
 415:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 418:	6c                   	insb   (%dx),%es:(%edi)
 419:	33 30                	xor    (%eax),%esi
	...

0000041c <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 41c:	b8 01 00 00 00       	mov    $0x1,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <exit>:
SYSCALL(exit)
 424:	b8 02 00 00 00       	mov    $0x2,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <wait>:
SYSCALL(wait)
 42c:	b8 03 00 00 00       	mov    $0x3,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <pipe>:
SYSCALL(pipe)
 434:	b8 04 00 00 00       	mov    $0x4,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <read>:
SYSCALL(read)
 43c:	b8 05 00 00 00       	mov    $0x5,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <write>:
SYSCALL(write)
 444:	b8 10 00 00 00       	mov    $0x10,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <close>:
SYSCALL(close)
 44c:	b8 15 00 00 00       	mov    $0x15,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <kill>:
SYSCALL(kill)
 454:	b8 06 00 00 00       	mov    $0x6,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <exec>:
SYSCALL(exec)
 45c:	b8 07 00 00 00       	mov    $0x7,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <open>:
SYSCALL(open)
 464:	b8 0f 00 00 00       	mov    $0xf,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <mknod>:
SYSCALL(mknod)
 46c:	b8 11 00 00 00       	mov    $0x11,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <unlink>:
SYSCALL(unlink)
 474:	b8 12 00 00 00       	mov    $0x12,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <fstat>:
SYSCALL(fstat)
 47c:	b8 08 00 00 00       	mov    $0x8,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <link>:
SYSCALL(link)
 484:	b8 13 00 00 00       	mov    $0x13,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <mkdir>:
SYSCALL(mkdir)
 48c:	b8 14 00 00 00       	mov    $0x14,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <chdir>:
SYSCALL(chdir)
 494:	b8 09 00 00 00       	mov    $0x9,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <dup>:
SYSCALL(dup)
 49c:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <getpid>:
SYSCALL(getpid)
 4a4:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <sbrk>:
SYSCALL(sbrk)
 4ac:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <sleep>:
SYSCALL(sleep)
 4b4:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <uptime>:
SYSCALL(uptime)
 4bc:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <date>:
SYSCALL(date)
 4c4:	b8 16 00 00 00       	mov    $0x16,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <ls_call01>:

SYSCALL1(ls_call01)
 4cc:	b8 f0 02 00 00       	mov    $0x2f0,%eax
 4d1:	cd 41                	int    $0x41
 4d3:	c3                   	ret    

000004d4 <ls_call02>:
SYSCALL1(ls_call02)
 4d4:	b8 fa 02 00 00       	mov    $0x2fa,%eax
 4d9:	cd 41                	int    $0x41
 4db:	c3                   	ret    

000004dc <ls_call03>:
SYSCALL1(ls_call03)
 4dc:	b8 04 03 00 00       	mov    $0x304,%eax
 4e1:	cd 41                	int    $0x41
 4e3:	c3                   	ret    

000004e4 <ls_call04>:
SYSCALL1(ls_call04)
 4e4:	b8 0e 03 00 00       	mov    $0x30e,%eax
 4e9:	cd 41                	int    $0x41
 4eb:	c3                   	ret    

000004ec <ls_call05>:
SYSCALL1(ls_call05)
 4ec:	b8 18 03 00 00       	mov    $0x318,%eax
 4f1:	cd 41                	int    $0x41
 4f3:	c3                   	ret    

000004f4 <ls_call06>:
SYSCALL1(ls_call06)
 4f4:	b8 22 03 00 00       	mov    $0x322,%eax
 4f9:	cd 41                	int    $0x41
 4fb:	c3                   	ret    

000004fc <ls_call07>:
SYSCALL1(ls_call07)
 4fc:	b8 2c 03 00 00       	mov    $0x32c,%eax
 501:	cd 41                	int    $0x41
 503:	c3                   	ret    

00000504 <ls_call08>:
SYSCALL1(ls_call08)
 504:	b8 36 03 00 00       	mov    $0x336,%eax
 509:	cd 41                	int    $0x41
 50b:	c3                   	ret    

0000050c <ls_call09>:
SYSCALL1(ls_call09)
 50c:	b8 40 03 00 00       	mov    $0x340,%eax
 511:	cd 41                	int    $0x41
 513:	c3                   	ret    

00000514 <ls_call10>:
SYSCALL1(ls_call10)
 514:	b8 4a 03 00 00       	mov    $0x34a,%eax
 519:	cd 41                	int    $0x41
 51b:	c3                   	ret    

0000051c <ls_call11>:
SYSCALL1(ls_call11)
 51c:	b8 54 03 00 00       	mov    $0x354,%eax
 521:	cd 41                	int    $0x41
 523:	c3                   	ret    

00000524 <ls_call12>:
SYSCALL1(ls_call12)
 524:	b8 5e 03 00 00       	mov    $0x35e,%eax
 529:	cd 41                	int    $0x41
 52b:	c3                   	ret    

0000052c <ls_call13>:
SYSCALL1(ls_call13)
 52c:	b8 68 03 00 00       	mov    $0x368,%eax
 531:	cd 41                	int    $0x41
 533:	c3                   	ret    

00000534 <ls_call14>:
SYSCALL1(ls_call14)
 534:	b8 72 03 00 00       	mov    $0x372,%eax
 539:	cd 41                	int    $0x41
 53b:	c3                   	ret    

0000053c <ls_call15>:
SYSCALL1(ls_call15)
 53c:	b8 7c 03 00 00       	mov    $0x37c,%eax
 541:	cd 41                	int    $0x41
 543:	c3                   	ret    

00000544 <ls_call16>:
SYSCALL1(ls_call16)
 544:	b8 86 03 00 00       	mov    $0x386,%eax
 549:	cd 41                	int    $0x41
 54b:	c3                   	ret    

0000054c <ls_call17>:
SYSCALL1(ls_call17)
 54c:	b8 90 03 00 00       	mov    $0x390,%eax
 551:	cd 41                	int    $0x41
 553:	c3                   	ret    

00000554 <ls_call18>:
SYSCALL1(ls_call18)
 554:	b8 9a 03 00 00       	mov    $0x39a,%eax
 559:	cd 41                	int    $0x41
 55b:	c3                   	ret    

0000055c <ls_call19>:
SYSCALL1(ls_call19)
 55c:	b8 a4 03 00 00       	mov    $0x3a4,%eax
 561:	cd 41                	int    $0x41
 563:	c3                   	ret    

00000564 <ls_call20>:
SYSCALL1(ls_call20)
 564:	b8 ae 03 00 00       	mov    $0x3ae,%eax
 569:	cd 41                	int    $0x41
 56b:	c3                   	ret    

0000056c <ls_call21>:
SYSCALL1(ls_call21)
 56c:	b8 b8 03 00 00       	mov    $0x3b8,%eax
 571:	cd 41                	int    $0x41
 573:	c3                   	ret    

00000574 <ls_call22>:
SYSCALL1(ls_call22)
 574:	b8 c2 03 00 00       	mov    $0x3c2,%eax
 579:	cd 41                	int    $0x41
 57b:	c3                   	ret    

0000057c <ls_call23>:
SYSCALL1(ls_call23)
 57c:	b8 cc 03 00 00       	mov    $0x3cc,%eax
 581:	cd 41                	int    $0x41
 583:	c3                   	ret    

00000584 <ls_call24>:
SYSCALL1(ls_call24)
 584:	b8 d6 03 00 00       	mov    $0x3d6,%eax
 589:	cd 41                	int    $0x41
 58b:	c3                   	ret    

0000058c <ls_call25>:
SYSCALL1(ls_call25)
 58c:	b8 e0 03 00 00       	mov    $0x3e0,%eax
 591:	cd 41                	int    $0x41
 593:	c3                   	ret    

00000594 <ls_call26>:
SYSCALL1(ls_call26)
 594:	b8 ea 03 00 00       	mov    $0x3ea,%eax
 599:	cd 41                	int    $0x41
 59b:	c3                   	ret    

0000059c <ls_call27>:
SYSCALL1(ls_call27)
 59c:	b8 f4 03 00 00       	mov    $0x3f4,%eax
 5a1:	cd 41                	int    $0x41
 5a3:	c3                   	ret    

000005a4 <ls_call28>:
SYSCALL1(ls_call28)
 5a4:	b8 fe 03 00 00       	mov    $0x3fe,%eax
 5a9:	cd 41                	int    $0x41
 5ab:	c3                   	ret    

000005ac <ls_call29>:
SYSCALL1(ls_call29)
 5ac:	b8 08 04 00 00       	mov    $0x408,%eax
 5b1:	cd 41                	int    $0x41
 5b3:	c3                   	ret    

000005b4 <ls_call30>:
SYSCALL1(ls_call30)
 5b4:	b8 12 04 00 00       	mov    $0x412,%eax
 5b9:	cd 41                	int    $0x41
 5bb:	c3                   	ret    

000005bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5bc:	55                   	push   %ebp
 5bd:	89 e5                	mov    %esp,%ebp
 5bf:	83 ec 28             	sub    $0x28,%esp
 5c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5cf:	00 
 5d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d7:	8b 45 08             	mov    0x8(%ebp),%eax
 5da:	89 04 24             	mov    %eax,(%esp)
 5dd:	e8 62 fe ff ff       	call   444 <write>
}
 5e2:	c9                   	leave  
 5e3:	c3                   	ret    

000005e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e4:	55                   	push   %ebp
 5e5:	89 e5                	mov    %esp,%ebp
 5e7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5f1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5f5:	74 17                	je     60e <printint+0x2a>
 5f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5fb:	79 11                	jns    60e <printint+0x2a>
    neg = 1;
 5fd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 604:	8b 45 0c             	mov    0xc(%ebp),%eax
 607:	f7 d8                	neg    %eax
 609:	89 45 ec             	mov    %eax,-0x14(%ebp)
 60c:	eb 06                	jmp    614 <printint+0x30>
  } else {
    x = xx;
 60e:	8b 45 0c             	mov    0xc(%ebp),%eax
 611:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 614:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 61b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 61e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 621:	ba 00 00 00 00       	mov    $0x0,%edx
 626:	f7 f1                	div    %ecx
 628:	89 d0                	mov    %edx,%eax
 62a:	0f b6 80 dc 0c 00 00 	movzbl 0xcdc(%eax),%eax
 631:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 634:	8b 55 f4             	mov    -0xc(%ebp),%edx
 637:	01 ca                	add    %ecx,%edx
 639:	88 02                	mov    %al,(%edx)
 63b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 63f:	8b 55 10             	mov    0x10(%ebp),%edx
 642:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 645:	8b 45 ec             	mov    -0x14(%ebp),%eax
 648:	ba 00 00 00 00       	mov    $0x0,%edx
 64d:	f7 75 d4             	divl   -0x2c(%ebp)
 650:	89 45 ec             	mov    %eax,-0x14(%ebp)
 653:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 657:	75 c2                	jne    61b <printint+0x37>
  if(neg)
 659:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 65d:	74 2e                	je     68d <printint+0xa9>
    buf[i++] = '-';
 65f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 662:	8b 45 f4             	mov    -0xc(%ebp),%eax
 665:	01 d0                	add    %edx,%eax
 667:	c6 00 2d             	movb   $0x2d,(%eax)
 66a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 66e:	eb 1d                	jmp    68d <printint+0xa9>
    putc(fd, buf[i]);
 670:	8d 55 dc             	lea    -0x24(%ebp),%edx
 673:	8b 45 f4             	mov    -0xc(%ebp),%eax
 676:	01 d0                	add    %edx,%eax
 678:	0f b6 00             	movzbl (%eax),%eax
 67b:	0f be c0             	movsbl %al,%eax
 67e:	89 44 24 04          	mov    %eax,0x4(%esp)
 682:	8b 45 08             	mov    0x8(%ebp),%eax
 685:	89 04 24             	mov    %eax,(%esp)
 688:	e8 2f ff ff ff       	call   5bc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 68d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 691:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 695:	79 d9                	jns    670 <printint+0x8c>
    putc(fd, buf[i]);
}
 697:	c9                   	leave  
 698:	c3                   	ret    

00000699 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 699:	55                   	push   %ebp
 69a:	89 e5                	mov    %esp,%ebp
 69c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 69f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6a6:	8d 45 0c             	lea    0xc(%ebp),%eax
 6a9:	83 c0 04             	add    $0x4,%eax
 6ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6b6:	e9 7d 01 00 00       	jmp    838 <printf+0x19f>
    c = fmt[i] & 0xff;
 6bb:	8b 55 0c             	mov    0xc(%ebp),%edx
 6be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c1:	01 d0                	add    %edx,%eax
 6c3:	0f b6 00             	movzbl (%eax),%eax
 6c6:	0f be c0             	movsbl %al,%eax
 6c9:	25 ff 00 00 00       	and    $0xff,%eax
 6ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6d5:	75 2c                	jne    703 <printf+0x6a>
      if(c == '%'){
 6d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6db:	75 0c                	jne    6e9 <printf+0x50>
        state = '%';
 6dd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6e4:	e9 4b 01 00 00       	jmp    834 <printf+0x19b>
      } else {
        putc(fd, c);
 6e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ec:	0f be c0             	movsbl %al,%eax
 6ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	89 04 24             	mov    %eax,(%esp)
 6f9:	e8 be fe ff ff       	call   5bc <putc>
 6fe:	e9 31 01 00 00       	jmp    834 <printf+0x19b>
      }
    } else if(state == '%'){
 703:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 707:	0f 85 27 01 00 00    	jne    834 <printf+0x19b>
      if(c == 'd'){
 70d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 711:	75 2d                	jne    740 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 713:	8b 45 e8             	mov    -0x18(%ebp),%eax
 716:	8b 00                	mov    (%eax),%eax
 718:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 71f:	00 
 720:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 727:	00 
 728:	89 44 24 04          	mov    %eax,0x4(%esp)
 72c:	8b 45 08             	mov    0x8(%ebp),%eax
 72f:	89 04 24             	mov    %eax,(%esp)
 732:	e8 ad fe ff ff       	call   5e4 <printint>
        ap++;
 737:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73b:	e9 ed 00 00 00       	jmp    82d <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 740:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 744:	74 06                	je     74c <printf+0xb3>
 746:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 74a:	75 2d                	jne    779 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 74c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 74f:	8b 00                	mov    (%eax),%eax
 751:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 758:	00 
 759:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 760:	00 
 761:	89 44 24 04          	mov    %eax,0x4(%esp)
 765:	8b 45 08             	mov    0x8(%ebp),%eax
 768:	89 04 24             	mov    %eax,(%esp)
 76b:	e8 74 fe ff ff       	call   5e4 <printint>
        ap++;
 770:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 774:	e9 b4 00 00 00       	jmp    82d <printf+0x194>
      } else if(c == 's'){
 779:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 77d:	75 46                	jne    7c5 <printf+0x12c>
        s = (char*)*ap;
 77f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 782:	8b 00                	mov    (%eax),%eax
 784:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 787:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 78b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 78f:	75 27                	jne    7b8 <printf+0x11f>
          s = "(null)";
 791:	c7 45 f4 96 0a 00 00 	movl   $0xa96,-0xc(%ebp)
        while(*s != 0){
 798:	eb 1e                	jmp    7b8 <printf+0x11f>
          putc(fd, *s);
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	0f b6 00             	movzbl (%eax),%eax
 7a0:	0f be c0             	movsbl %al,%eax
 7a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7a7:	8b 45 08             	mov    0x8(%ebp),%eax
 7aa:	89 04 24             	mov    %eax,(%esp)
 7ad:	e8 0a fe ff ff       	call   5bc <putc>
          s++;
 7b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 7b6:	eb 01                	jmp    7b9 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7b8:	90                   	nop
 7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bc:	0f b6 00             	movzbl (%eax),%eax
 7bf:	84 c0                	test   %al,%al
 7c1:	75 d7                	jne    79a <printf+0x101>
 7c3:	eb 68                	jmp    82d <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7c5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7c9:	75 1d                	jne    7e8 <printf+0x14f>
        putc(fd, *ap);
 7cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ce:	8b 00                	mov    (%eax),%eax
 7d0:	0f be c0             	movsbl %al,%eax
 7d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7d7:	8b 45 08             	mov    0x8(%ebp),%eax
 7da:	89 04 24             	mov    %eax,(%esp)
 7dd:	e8 da fd ff ff       	call   5bc <putc>
        ap++;
 7e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7e6:	eb 45                	jmp    82d <printf+0x194>
      } else if(c == '%'){
 7e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ec:	75 17                	jne    805 <printf+0x16c>
        putc(fd, c);
 7ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7f1:	0f be c0             	movsbl %al,%eax
 7f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f8:	8b 45 08             	mov    0x8(%ebp),%eax
 7fb:	89 04 24             	mov    %eax,(%esp)
 7fe:	e8 b9 fd ff ff       	call   5bc <putc>
 803:	eb 28                	jmp    82d <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 805:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 80c:	00 
 80d:	8b 45 08             	mov    0x8(%ebp),%eax
 810:	89 04 24             	mov    %eax,(%esp)
 813:	e8 a4 fd ff ff       	call   5bc <putc>
        putc(fd, c);
 818:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 81b:	0f be c0             	movsbl %al,%eax
 81e:	89 44 24 04          	mov    %eax,0x4(%esp)
 822:	8b 45 08             	mov    0x8(%ebp),%eax
 825:	89 04 24             	mov    %eax,(%esp)
 828:	e8 8f fd ff ff       	call   5bc <putc>
      }
      state = 0;
 82d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 834:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 838:	8b 55 0c             	mov    0xc(%ebp),%edx
 83b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83e:	01 d0                	add    %edx,%eax
 840:	0f b6 00             	movzbl (%eax),%eax
 843:	84 c0                	test   %al,%al
 845:	0f 85 70 fe ff ff    	jne    6bb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 84b:	c9                   	leave  
 84c:	c3                   	ret    
 84d:	90                   	nop
 84e:	90                   	nop
 84f:	90                   	nop

00000850 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 856:	8b 45 08             	mov    0x8(%ebp),%eax
 859:	83 e8 08             	sub    $0x8,%eax
 85c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85f:	a1 f8 0c 00 00       	mov    0xcf8,%eax
 864:	89 45 fc             	mov    %eax,-0x4(%ebp)
 867:	eb 24                	jmp    88d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 869:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86c:	8b 00                	mov    (%eax),%eax
 86e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 871:	77 12                	ja     885 <free+0x35>
 873:	8b 45 f8             	mov    -0x8(%ebp),%eax
 876:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 879:	77 24                	ja     89f <free+0x4f>
 87b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87e:	8b 00                	mov    (%eax),%eax
 880:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 883:	77 1a                	ja     89f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 885:	8b 45 fc             	mov    -0x4(%ebp),%eax
 888:	8b 00                	mov    (%eax),%eax
 88a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 88d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 890:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 893:	76 d4                	jbe    869 <free+0x19>
 895:	8b 45 fc             	mov    -0x4(%ebp),%eax
 898:	8b 00                	mov    (%eax),%eax
 89a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 89d:	76 ca                	jbe    869 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 89f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a2:	8b 40 04             	mov    0x4(%eax),%eax
 8a5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8af:	01 c2                	add    %eax,%edx
 8b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b4:	8b 00                	mov    (%eax),%eax
 8b6:	39 c2                	cmp    %eax,%edx
 8b8:	75 24                	jne    8de <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bd:	8b 50 04             	mov    0x4(%eax),%edx
 8c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c3:	8b 00                	mov    (%eax),%eax
 8c5:	8b 40 04             	mov    0x4(%eax),%eax
 8c8:	01 c2                	add    %eax,%edx
 8ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8cd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d3:	8b 00                	mov    (%eax),%eax
 8d5:	8b 10                	mov    (%eax),%edx
 8d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8da:	89 10                	mov    %edx,(%eax)
 8dc:	eb 0a                	jmp    8e8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e1:	8b 10                	mov    (%eax),%edx
 8e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8eb:	8b 40 04             	mov    0x4(%eax),%eax
 8ee:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f8:	01 d0                	add    %edx,%eax
 8fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8fd:	75 20                	jne    91f <free+0xcf>
    p->s.size += bp->s.size;
 8ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 902:	8b 50 04             	mov    0x4(%eax),%edx
 905:	8b 45 f8             	mov    -0x8(%ebp),%eax
 908:	8b 40 04             	mov    0x4(%eax),%eax
 90b:	01 c2                	add    %eax,%edx
 90d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 910:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 913:	8b 45 f8             	mov    -0x8(%ebp),%eax
 916:	8b 10                	mov    (%eax),%edx
 918:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91b:	89 10                	mov    %edx,(%eax)
 91d:	eb 08                	jmp    927 <free+0xd7>
  } else
    p->s.ptr = bp;
 91f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 922:	8b 55 f8             	mov    -0x8(%ebp),%edx
 925:	89 10                	mov    %edx,(%eax)
  freep = p;
 927:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92a:	a3 f8 0c 00 00       	mov    %eax,0xcf8
}
 92f:	c9                   	leave  
 930:	c3                   	ret    

00000931 <morecore>:

static Header*
morecore(uint nu)
{
 931:	55                   	push   %ebp
 932:	89 e5                	mov    %esp,%ebp
 934:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 937:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 93e:	77 07                	ja     947 <morecore+0x16>
    nu = 4096;
 940:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 947:	8b 45 08             	mov    0x8(%ebp),%eax
 94a:	c1 e0 03             	shl    $0x3,%eax
 94d:	89 04 24             	mov    %eax,(%esp)
 950:	e8 57 fb ff ff       	call   4ac <sbrk>
 955:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 958:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 95c:	75 07                	jne    965 <morecore+0x34>
    return 0;
 95e:	b8 00 00 00 00       	mov    $0x0,%eax
 963:	eb 22                	jmp    987 <morecore+0x56>
  hp = (Header*)p;
 965:	8b 45 f4             	mov    -0xc(%ebp),%eax
 968:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 96b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96e:	8b 55 08             	mov    0x8(%ebp),%edx
 971:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 974:	8b 45 f0             	mov    -0x10(%ebp),%eax
 977:	83 c0 08             	add    $0x8,%eax
 97a:	89 04 24             	mov    %eax,(%esp)
 97d:	e8 ce fe ff ff       	call   850 <free>
  return freep;
 982:	a1 f8 0c 00 00       	mov    0xcf8,%eax
}
 987:	c9                   	leave  
 988:	c3                   	ret    

00000989 <malloc>:

void*
malloc(uint nbytes)
{
 989:	55                   	push   %ebp
 98a:	89 e5                	mov    %esp,%ebp
 98c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 98f:	8b 45 08             	mov    0x8(%ebp),%eax
 992:	83 c0 07             	add    $0x7,%eax
 995:	c1 e8 03             	shr    $0x3,%eax
 998:	83 c0 01             	add    $0x1,%eax
 99b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 99e:	a1 f8 0c 00 00       	mov    0xcf8,%eax
 9a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9aa:	75 23                	jne    9cf <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9ac:	c7 45 f0 f0 0c 00 00 	movl   $0xcf0,-0x10(%ebp)
 9b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b6:	a3 f8 0c 00 00       	mov    %eax,0xcf8
 9bb:	a1 f8 0c 00 00       	mov    0xcf8,%eax
 9c0:	a3 f0 0c 00 00       	mov    %eax,0xcf0
    base.s.size = 0;
 9c5:	c7 05 f4 0c 00 00 00 	movl   $0x0,0xcf4
 9cc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d2:	8b 00                	mov    (%eax),%eax
 9d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9da:	8b 40 04             	mov    0x4(%eax),%eax
 9dd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9e0:	72 4d                	jb     a2f <malloc+0xa6>
      if(p->s.size == nunits)
 9e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e5:	8b 40 04             	mov    0x4(%eax),%eax
 9e8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9eb:	75 0c                	jne    9f9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f0:	8b 10                	mov    (%eax),%edx
 9f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f5:	89 10                	mov    %edx,(%eax)
 9f7:	eb 26                	jmp    a1f <malloc+0x96>
      else {
        p->s.size -= nunits;
 9f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fc:	8b 40 04             	mov    0x4(%eax),%eax
 9ff:	89 c2                	mov    %eax,%edx
 a01:	2b 55 ec             	sub    -0x14(%ebp),%edx
 a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a07:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0d:	8b 40 04             	mov    0x4(%eax),%eax
 a10:	c1 e0 03             	shl    $0x3,%eax
 a13:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a19:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a1c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a22:	a3 f8 0c 00 00       	mov    %eax,0xcf8
      return (void*)(p + 1);
 a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2a:	83 c0 08             	add    $0x8,%eax
 a2d:	eb 38                	jmp    a67 <malloc+0xde>
    }
    if(p == freep)
 a2f:	a1 f8 0c 00 00       	mov    0xcf8,%eax
 a34:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a37:	75 1b                	jne    a54 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 a39:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a3c:	89 04 24             	mov    %eax,(%esp)
 a3f:	e8 ed fe ff ff       	call   931 <morecore>
 a44:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a4b:	75 07                	jne    a54 <malloc+0xcb>
        return 0;
 a4d:	b8 00 00 00 00       	mov    $0x0,%eax
 a52:	eb 13                	jmp    a67 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a57:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5d:	8b 00                	mov    (%eax),%eax
 a5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a62:	e9 70 ff ff ff       	jmp    9d7 <malloc+0x4e>
}
 a67:	c9                   	leave  
 a68:	c3                   	ret    
