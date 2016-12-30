
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 1b                	jmp    23 <cat+0x23>
    write(1, buf, n);
   8:	8b 45 f4             	mov    -0xc(%ebp),%eax
   b:	89 44 24 08          	mov    %eax,0x8(%esp)
   f:	c7 44 24 04 c0 0d 00 	movl   $0xdc0,0x4(%esp)
  16:	00 
  17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1e:	e8 b1 04 00 00       	call   4d4 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 c0 0d 00 	movl   $0xdc0,0x4(%esp)
  32:	00 
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 8e 04 00 00       	call   4cc <read>
  3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  45:	7f c1                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
  4d:	c7 44 24 04 f9 0a 00 	movl   $0xaf9,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 c8 06 00 00       	call   729 <printf>
    exit();
  61:	e8 4e 04 00 00       	call   4b4 <exit>
  }
}
  66:	c9                   	leave  
  67:	c3                   	ret    

00000068 <main>:

int
main(int argc, char *argv[])
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	83 e4 f0             	and    $0xfffffff0,%esp
  6e:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
  71:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  75:	7f 11                	jg     88 <main+0x20>
    cat(0);
  77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7e:	e8 7d ff ff ff       	call   0 <cat>
    exit();
  83:	e8 2c 04 00 00       	call   4b4 <exit>
  }

  for(i = 1; i < argc; i++){
  88:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  8f:	00 
  90:	eb 79                	jmp    10b <main+0xa3>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  96:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  a0:	01 d0                	add    %edx,%eax
  a2:	8b 00                	mov    (%eax),%eax
  a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  ab:	00 
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 40 04 00 00       	call   4f4 <open>
  b4:	89 44 24 18          	mov    %eax,0x18(%esp)
  b8:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  bd:	79 2f                	jns    ee <main+0x86>
      printf(1, "cat: cannot open %s\n", argv[i]);
  bf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	01 d0                	add    %edx,%eax
  cf:	8b 00                	mov    (%eax),%eax
  d1:	89 44 24 08          	mov    %eax,0x8(%esp)
  d5:	c7 44 24 04 0a 0b 00 	movl   $0xb0a,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e4:	e8 40 06 00 00       	call   729 <printf>
      exit();
  e9:	e8 c6 03 00 00       	call   4b4 <exit>
    }
    cat(fd);
  ee:	8b 44 24 18          	mov    0x18(%esp),%eax
  f2:	89 04 24             	mov    %eax,(%esp)
  f5:	e8 06 ff ff ff       	call   0 <cat>
    close(fd);
  fa:	8b 44 24 18          	mov    0x18(%esp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 d6 03 00 00       	call   4dc <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
 106:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 10b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 10f:	3b 45 08             	cmp    0x8(%ebp),%eax
 112:	0f 8c 7a ff ff ff    	jl     92 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 118:	e8 97 03 00 00       	call   4b4 <exit>
 11d:	90                   	nop
 11e:	90                   	nop
 11f:	90                   	nop

00000120 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 125:	8b 4d 08             	mov    0x8(%ebp),%ecx
 128:	8b 55 10             	mov    0x10(%ebp),%edx
 12b:	8b 45 0c             	mov    0xc(%ebp),%eax
 12e:	89 cb                	mov    %ecx,%ebx
 130:	89 df                	mov    %ebx,%edi
 132:	89 d1                	mov    %edx,%ecx
 134:	fc                   	cld    
 135:	f3 aa                	rep stos %al,%es:(%edi)
 137:	89 ca                	mov    %ecx,%edx
 139:	89 fb                	mov    %edi,%ebx
 13b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 141:	5b                   	pop    %ebx
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    

00000145 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
 148:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14b:	8b 45 08             	mov    0x8(%ebp),%eax
 14e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 151:	90                   	nop
 152:	8b 45 0c             	mov    0xc(%ebp),%eax
 155:	0f b6 10             	movzbl (%eax),%edx
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	88 10                	mov    %dl,(%eax)
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	0f b6 00             	movzbl (%eax),%eax
 163:	84 c0                	test   %al,%al
 165:	0f 95 c0             	setne  %al
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 170:	84 c0                	test   %al,%al
 172:	75 de                	jne    152 <strcpy+0xd>
    ;
  return os;
 174:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 177:	c9                   	leave  
 178:	c3                   	ret    

00000179 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 179:	55                   	push   %ebp
 17a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 17c:	eb 08                	jmp    186 <strcmp+0xd>
    p++, q++;
 17e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 182:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	84 c0                	test   %al,%al
 18e:	74 10                	je     1a0 <strcmp+0x27>
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 10             	movzbl (%eax),%edx
 196:	8b 45 0c             	mov    0xc(%ebp),%eax
 199:	0f b6 00             	movzbl (%eax),%eax
 19c:	38 c2                	cmp    %al,%dl
 19e:	74 de                	je     17e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	0f b6 00             	movzbl (%eax),%eax
 1a6:	0f b6 d0             	movzbl %al,%edx
 1a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ac:	0f b6 00             	movzbl (%eax),%eax
 1af:	0f b6 c0             	movzbl %al,%eax
 1b2:	89 d1                	mov    %edx,%ecx
 1b4:	29 c1                	sub    %eax,%ecx
 1b6:	89 c8                	mov    %ecx,%eax
}
 1b8:	5d                   	pop    %ebp
 1b9:	c3                   	ret    

000001ba <strlen>:

uint
strlen(char *s)
{
 1ba:	55                   	push   %ebp
 1bb:	89 e5                	mov    %esp,%ebp
 1bd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c7:	eb 04                	jmp    1cd <strlen+0x13>
 1c9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	01 d0                	add    %edx,%eax
 1d5:	0f b6 00             	movzbl (%eax),%eax
 1d8:	84 c0                	test   %al,%al
 1da:	75 ed                	jne    1c9 <strlen+0xf>
    ;
  return n;
 1dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1df:	c9                   	leave  
 1e0:	c3                   	ret    

000001e1 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e1:	55                   	push   %ebp
 1e2:	89 e5                	mov    %esp,%ebp
 1e4:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1e7:	8b 45 10             	mov    0x10(%ebp),%eax
 1ea:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
 1f8:	89 04 24             	mov    %eax,(%esp)
 1fb:	e8 20 ff ff ff       	call   120 <stosb>
  return dst;
 200:	8b 45 08             	mov    0x8(%ebp),%eax
}
 203:	c9                   	leave  
 204:	c3                   	ret    

00000205 <strchr>:

char*
strchr(const char *s, char c)
{
 205:	55                   	push   %ebp
 206:	89 e5                	mov    %esp,%ebp
 208:	83 ec 04             	sub    $0x4,%esp
 20b:	8b 45 0c             	mov    0xc(%ebp),%eax
 20e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 211:	eb 14                	jmp    227 <strchr+0x22>
    if(*s == c)
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 00             	movzbl (%eax),%eax
 219:	3a 45 fc             	cmp    -0x4(%ebp),%al
 21c:	75 05                	jne    223 <strchr+0x1e>
      return (char*)s;
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	eb 13                	jmp    236 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 223:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	0f b6 00             	movzbl (%eax),%eax
 22d:	84 c0                	test   %al,%al
 22f:	75 e2                	jne    213 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 231:	b8 00 00 00 00       	mov    $0x0,%eax
}
 236:	c9                   	leave  
 237:	c3                   	ret    

00000238 <gets>:

char*
gets(char *buf, int max)
{
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 245:	eb 46                	jmp    28d <gets+0x55>
    cc = read(0, &c, 1);
 247:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 24e:	00 
 24f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 252:	89 44 24 04          	mov    %eax,0x4(%esp)
 256:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 25d:	e8 6a 02 00 00       	call   4cc <read>
 262:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 265:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 269:	7e 2f                	jle    29a <gets+0x62>
      break;
    buf[i++] = c;
 26b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	01 c2                	add    %eax,%edx
 273:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 277:	88 02                	mov    %al,(%edx)
 279:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 27d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 281:	3c 0a                	cmp    $0xa,%al
 283:	74 16                	je     29b <gets+0x63>
 285:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 289:	3c 0d                	cmp    $0xd,%al
 28b:	74 0e                	je     29b <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 290:	83 c0 01             	add    $0x1,%eax
 293:	3b 45 0c             	cmp    0xc(%ebp),%eax
 296:	7c af                	jl     247 <gets+0xf>
 298:	eb 01                	jmp    29b <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 29a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 29b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
 2a1:	01 d0                	add    %edx,%eax
 2a3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a9:	c9                   	leave  
 2aa:	c3                   	ret    

000002ab <stat>:

int
stat(char *n, struct stat *st)
{
 2ab:	55                   	push   %ebp
 2ac:	89 e5                	mov    %esp,%ebp
 2ae:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b8:	00 
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	89 04 24             	mov    %eax,(%esp)
 2bf:	e8 30 02 00 00       	call   4f4 <open>
 2c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2cb:	79 07                	jns    2d4 <stat+0x29>
    return -1;
 2cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2d2:	eb 23                	jmp    2f7 <stat+0x4c>
  r = fstat(fd, st);
 2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2de:	89 04 24             	mov    %eax,(%esp)
 2e1:	e8 26 02 00 00       	call   50c <fstat>
 2e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ec:	89 04 24             	mov    %eax,(%esp)
 2ef:	e8 e8 01 00 00       	call   4dc <close>
  return r;
 2f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2f7:	c9                   	leave  
 2f8:	c3                   	ret    

000002f9 <atoi>:

int
atoi(const char *s)
{
 2f9:	55                   	push   %ebp
 2fa:	89 e5                	mov    %esp,%ebp
 2fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 306:	eb 23                	jmp    32b <atoi+0x32>
    n = n*10 + *s++ - '0';
 308:	8b 55 fc             	mov    -0x4(%ebp),%edx
 30b:	89 d0                	mov    %edx,%eax
 30d:	c1 e0 02             	shl    $0x2,%eax
 310:	01 d0                	add    %edx,%eax
 312:	01 c0                	add    %eax,%eax
 314:	89 c2                	mov    %eax,%edx
 316:	8b 45 08             	mov    0x8(%ebp),%eax
 319:	0f b6 00             	movzbl (%eax),%eax
 31c:	0f be c0             	movsbl %al,%eax
 31f:	01 d0                	add    %edx,%eax
 321:	83 e8 30             	sub    $0x30,%eax
 324:	89 45 fc             	mov    %eax,-0x4(%ebp)
 327:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	0f b6 00             	movzbl (%eax),%eax
 331:	3c 2f                	cmp    $0x2f,%al
 333:	7e 0a                	jle    33f <atoi+0x46>
 335:	8b 45 08             	mov    0x8(%ebp),%eax
 338:	0f b6 00             	movzbl (%eax),%eax
 33b:	3c 39                	cmp    $0x39,%al
 33d:	7e c9                	jle    308 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 33f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 342:	c9                   	leave  
 343:	c3                   	ret    

00000344 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 34a:	8b 45 08             	mov    0x8(%ebp),%eax
 34d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 350:	8b 45 0c             	mov    0xc(%ebp),%eax
 353:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 356:	eb 13                	jmp    36b <memmove+0x27>
    *dst++ = *src++;
 358:	8b 45 f8             	mov    -0x8(%ebp),%eax
 35b:	0f b6 10             	movzbl (%eax),%edx
 35e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 361:	88 10                	mov    %dl,(%eax)
 363:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 367:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 36f:	0f 9f c0             	setg   %al
 372:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 376:	84 c0                	test   %al,%al
 378:	75 de                	jne    358 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 37a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 37d:	c9                   	leave  
 37e:	c3                   	ret    
 37f:	90                   	nop

00000380 <SYS_ls_call01>:
 380:	6c                   	insb   (%dx),%es:(%edi)
 381:	73 5f                	jae    3e2 <SYS_ls_call10+0x8>
 383:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 386:	6c                   	insb   (%dx),%es:(%edi)
 387:	30 31                	xor    %dh,(%ecx)
	...

0000038a <SYS_ls_call02>:
 38a:	6c                   	insb   (%dx),%es:(%edi)
 38b:	73 5f                	jae    3ec <SYS_ls_call11+0x8>
 38d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 390:	6c                   	insb   (%dx),%es:(%edi)
 391:	30 32                	xor    %dh,(%edx)
	...

00000394 <SYS_ls_call03>:
 394:	6c                   	insb   (%dx),%es:(%edi)
 395:	73 5f                	jae    3f6 <SYS_ls_call12+0x8>
 397:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 39a:	6c                   	insb   (%dx),%es:(%edi)
 39b:	30 33                	xor    %dh,(%ebx)
	...

0000039e <SYS_ls_call04>:
 39e:	6c                   	insb   (%dx),%es:(%edi)
 39f:	73 5f                	jae    400 <SYS_ls_call13+0x8>
 3a1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3a4:	6c                   	insb   (%dx),%es:(%edi)
 3a5:	30 34 00             	xor    %dh,(%eax,%eax,1)

000003a8 <SYS_ls_call05>:
 3a8:	6c                   	insb   (%dx),%es:(%edi)
 3a9:	73 5f                	jae    40a <SYS_ls_call14+0x8>
 3ab:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ae:	6c                   	insb   (%dx),%es:(%edi)
 3af:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

000003b2 <SYS_ls_call06>:
 3b2:	6c                   	insb   (%dx),%es:(%edi)
 3b3:	73 5f                	jae    414 <SYS_ls_call15+0x8>
 3b5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3b8:	6c                   	insb   (%dx),%es:(%edi)
 3b9:	30 36                	xor    %dh,(%esi)
	...

000003bc <SYS_ls_call07>:
 3bc:	6c                   	insb   (%dx),%es:(%edi)
 3bd:	73 5f                	jae    41e <SYS_ls_call16+0x8>
 3bf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3c2:	6c                   	insb   (%dx),%es:(%edi)
 3c3:	30 37                	xor    %dh,(%edi)
	...

000003c6 <SYS_ls_call08>:
 3c6:	6c                   	insb   (%dx),%es:(%edi)
 3c7:	73 5f                	jae    428 <SYS_ls_call17+0x8>
 3c9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3cc:	6c                   	insb   (%dx),%es:(%edi)
 3cd:	30 38                	xor    %bh,(%eax)
	...

000003d0 <SYS_ls_call09>:
 3d0:	6c                   	insb   (%dx),%es:(%edi)
 3d1:	73 5f                	jae    432 <SYS_ls_call18+0x8>
 3d3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3d6:	6c                   	insb   (%dx),%es:(%edi)
 3d7:	30 39                	xor    %bh,(%ecx)
	...

000003da <SYS_ls_call10>:
 3da:	6c                   	insb   (%dx),%es:(%edi)
 3db:	73 5f                	jae    43c <SYS_ls_call19+0x8>
 3dd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3e0:	6c                   	insb   (%dx),%es:(%edi)
 3e1:	31 30                	xor    %esi,(%eax)
	...

000003e4 <SYS_ls_call11>:
 3e4:	6c                   	insb   (%dx),%es:(%edi)
 3e5:	73 5f                	jae    446 <SYS_ls_call20+0x8>
 3e7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3ea:	6c                   	insb   (%dx),%es:(%edi)
 3eb:	31 31                	xor    %esi,(%ecx)
	...

000003ee <SYS_ls_call12>:
 3ee:	6c                   	insb   (%dx),%es:(%edi)
 3ef:	73 5f                	jae    450 <SYS_ls_call21+0x8>
 3f1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3f4:	6c                   	insb   (%dx),%es:(%edi)
 3f5:	31 32                	xor    %esi,(%edx)
	...

000003f8 <SYS_ls_call13>:
 3f8:	6c                   	insb   (%dx),%es:(%edi)
 3f9:	73 5f                	jae    45a <SYS_ls_call22+0x8>
 3fb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 3fe:	6c                   	insb   (%dx),%es:(%edi)
 3ff:	31 33                	xor    %esi,(%ebx)
	...

00000402 <SYS_ls_call14>:
 402:	6c                   	insb   (%dx),%es:(%edi)
 403:	73 5f                	jae    464 <SYS_ls_call23+0x8>
 405:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 408:	6c                   	insb   (%dx),%es:(%edi)
 409:	31 34 00             	xor    %esi,(%eax,%eax,1)

0000040c <SYS_ls_call15>:
 40c:	6c                   	insb   (%dx),%es:(%edi)
 40d:	73 5f                	jae    46e <SYS_ls_call24+0x8>
 40f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 412:	6c                   	insb   (%dx),%es:(%edi)
 413:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000416 <SYS_ls_call16>:
 416:	6c                   	insb   (%dx),%es:(%edi)
 417:	73 5f                	jae    478 <SYS_ls_call25+0x8>
 419:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 41c:	6c                   	insb   (%dx),%es:(%edi)
 41d:	31 36                	xor    %esi,(%esi)
	...

00000420 <SYS_ls_call17>:
 420:	6c                   	insb   (%dx),%es:(%edi)
 421:	73 5f                	jae    482 <SYS_ls_call26+0x8>
 423:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 426:	6c                   	insb   (%dx),%es:(%edi)
 427:	31 37                	xor    %esi,(%edi)
	...

0000042a <SYS_ls_call18>:
 42a:	6c                   	insb   (%dx),%es:(%edi)
 42b:	73 5f                	jae    48c <SYS_ls_call27+0x8>
 42d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 430:	6c                   	insb   (%dx),%es:(%edi)
 431:	31 38                	xor    %edi,(%eax)
	...

00000434 <SYS_ls_call19>:
 434:	6c                   	insb   (%dx),%es:(%edi)
 435:	73 5f                	jae    496 <SYS_ls_call28+0x8>
 437:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 43a:	6c                   	insb   (%dx),%es:(%edi)
 43b:	31 39                	xor    %edi,(%ecx)
	...

0000043e <SYS_ls_call20>:
 43e:	6c                   	insb   (%dx),%es:(%edi)
 43f:	73 5f                	jae    4a0 <SYS_ls_call29+0x8>
 441:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 444:	6c                   	insb   (%dx),%es:(%edi)
 445:	32 30                	xor    (%eax),%dh
	...

00000448 <SYS_ls_call21>:
 448:	6c                   	insb   (%dx),%es:(%edi)
 449:	73 5f                	jae    4aa <SYS_ls_call30+0x8>
 44b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 44e:	6c                   	insb   (%dx),%es:(%edi)
 44f:	32 31                	xor    (%ecx),%dh
	...

00000452 <SYS_ls_call22>:
 452:	6c                   	insb   (%dx),%es:(%edi)
 453:	73 5f                	jae    4b4 <exit>
 455:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 458:	6c                   	insb   (%dx),%es:(%edi)
 459:	32 32                	xor    (%edx),%dh
	...

0000045c <SYS_ls_call23>:
 45c:	6c                   	insb   (%dx),%es:(%edi)
 45d:	73 5f                	jae    4be <wait+0x2>
 45f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 462:	6c                   	insb   (%dx),%es:(%edi)
 463:	32 33                	xor    (%ebx),%dh
	...

00000466 <SYS_ls_call24>:
 466:	6c                   	insb   (%dx),%es:(%edi)
 467:	73 5f                	jae    4c8 <pipe+0x4>
 469:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 46c:	6c                   	insb   (%dx),%es:(%edi)
 46d:	32 34 00             	xor    (%eax,%eax,1),%dh

00000470 <SYS_ls_call25>:
 470:	6c                   	insb   (%dx),%es:(%edi)
 471:	73 5f                	jae    4d2 <read+0x6>
 473:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 476:	6c                   	insb   (%dx),%es:(%edi)
 477:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

0000047a <SYS_ls_call26>:
 47a:	6c                   	insb   (%dx),%es:(%edi)
 47b:	73 5f                	jae    4dc <close>
 47d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 480:	6c                   	insb   (%dx),%es:(%edi)
 481:	32 36                	xor    (%esi),%dh
	...

00000484 <SYS_ls_call27>:
 484:	6c                   	insb   (%dx),%es:(%edi)
 485:	73 5f                	jae    4e6 <kill+0x2>
 487:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 48a:	6c                   	insb   (%dx),%es:(%edi)
 48b:	32 37                	xor    (%edi),%dh
	...

0000048e <SYS_ls_call28>:
 48e:	6c                   	insb   (%dx),%es:(%edi)
 48f:	73 5f                	jae    4f0 <exec+0x4>
 491:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 494:	6c                   	insb   (%dx),%es:(%edi)
 495:	32 38                	xor    (%eax),%bh
	...

00000498 <SYS_ls_call29>:
 498:	6c                   	insb   (%dx),%es:(%edi)
 499:	73 5f                	jae    4fa <open+0x6>
 49b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 49e:	6c                   	insb   (%dx),%es:(%edi)
 49f:	32 39                	xor    (%ecx),%bh
	...

000004a2 <SYS_ls_call30>:
 4a2:	6c                   	insb   (%dx),%es:(%edi)
 4a3:	73 5f                	jae    504 <unlink>
 4a5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4a8:	6c                   	insb   (%dx),%es:(%edi)
 4a9:	33 30                	xor    (%eax),%esi
	...

000004ac <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 4ac:	b8 01 00 00 00       	mov    $0x1,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <exit>:
SYSCALL(exit)
 4b4:	b8 02 00 00 00       	mov    $0x2,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <wait>:
SYSCALL(wait)
 4bc:	b8 03 00 00 00       	mov    $0x3,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <pipe>:
SYSCALL(pipe)
 4c4:	b8 04 00 00 00       	mov    $0x4,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <read>:
SYSCALL(read)
 4cc:	b8 05 00 00 00       	mov    $0x5,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <write>:
SYSCALL(write)
 4d4:	b8 10 00 00 00       	mov    $0x10,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <close>:
SYSCALL(close)
 4dc:	b8 15 00 00 00       	mov    $0x15,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <kill>:
SYSCALL(kill)
 4e4:	b8 06 00 00 00       	mov    $0x6,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <exec>:
SYSCALL(exec)
 4ec:	b8 07 00 00 00       	mov    $0x7,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <open>:
SYSCALL(open)
 4f4:	b8 0f 00 00 00       	mov    $0xf,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <mknod>:
SYSCALL(mknod)
 4fc:	b8 11 00 00 00       	mov    $0x11,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <unlink>:
SYSCALL(unlink)
 504:	b8 12 00 00 00       	mov    $0x12,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <fstat>:
SYSCALL(fstat)
 50c:	b8 08 00 00 00       	mov    $0x8,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <link>:
SYSCALL(link)
 514:	b8 13 00 00 00       	mov    $0x13,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <mkdir>:
SYSCALL(mkdir)
 51c:	b8 14 00 00 00       	mov    $0x14,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <chdir>:
SYSCALL(chdir)
 524:	b8 09 00 00 00       	mov    $0x9,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <dup>:
SYSCALL(dup)
 52c:	b8 0a 00 00 00       	mov    $0xa,%eax
 531:	cd 40                	int    $0x40
 533:	c3                   	ret    

00000534 <getpid>:
SYSCALL(getpid)
 534:	b8 0b 00 00 00       	mov    $0xb,%eax
 539:	cd 40                	int    $0x40
 53b:	c3                   	ret    

0000053c <sbrk>:
SYSCALL(sbrk)
 53c:	b8 0c 00 00 00       	mov    $0xc,%eax
 541:	cd 40                	int    $0x40
 543:	c3                   	ret    

00000544 <sleep>:
SYSCALL(sleep)
 544:	b8 0d 00 00 00       	mov    $0xd,%eax
 549:	cd 40                	int    $0x40
 54b:	c3                   	ret    

0000054c <uptime>:
SYSCALL(uptime)
 54c:	b8 0e 00 00 00       	mov    $0xe,%eax
 551:	cd 40                	int    $0x40
 553:	c3                   	ret    

00000554 <date>:
SYSCALL(date)
 554:	b8 16 00 00 00       	mov    $0x16,%eax
 559:	cd 40                	int    $0x40
 55b:	c3                   	ret    

0000055c <ls_call01>:

SYSCALL1(ls_call01)
 55c:	b8 80 03 00 00       	mov    $0x380,%eax
 561:	cd 41                	int    $0x41
 563:	c3                   	ret    

00000564 <ls_call02>:
SYSCALL1(ls_call02)
 564:	b8 8a 03 00 00       	mov    $0x38a,%eax
 569:	cd 41                	int    $0x41
 56b:	c3                   	ret    

0000056c <ls_call03>:
SYSCALL1(ls_call03)
 56c:	b8 94 03 00 00       	mov    $0x394,%eax
 571:	cd 41                	int    $0x41
 573:	c3                   	ret    

00000574 <ls_call04>:
SYSCALL1(ls_call04)
 574:	b8 9e 03 00 00       	mov    $0x39e,%eax
 579:	cd 41                	int    $0x41
 57b:	c3                   	ret    

0000057c <ls_call05>:
SYSCALL1(ls_call05)
 57c:	b8 a8 03 00 00       	mov    $0x3a8,%eax
 581:	cd 41                	int    $0x41
 583:	c3                   	ret    

00000584 <ls_call06>:
SYSCALL1(ls_call06)
 584:	b8 b2 03 00 00       	mov    $0x3b2,%eax
 589:	cd 41                	int    $0x41
 58b:	c3                   	ret    

0000058c <ls_call07>:
SYSCALL1(ls_call07)
 58c:	b8 bc 03 00 00       	mov    $0x3bc,%eax
 591:	cd 41                	int    $0x41
 593:	c3                   	ret    

00000594 <ls_call08>:
SYSCALL1(ls_call08)
 594:	b8 c6 03 00 00       	mov    $0x3c6,%eax
 599:	cd 41                	int    $0x41
 59b:	c3                   	ret    

0000059c <ls_call09>:
SYSCALL1(ls_call09)
 59c:	b8 d0 03 00 00       	mov    $0x3d0,%eax
 5a1:	cd 41                	int    $0x41
 5a3:	c3                   	ret    

000005a4 <ls_call10>:
SYSCALL1(ls_call10)
 5a4:	b8 da 03 00 00       	mov    $0x3da,%eax
 5a9:	cd 41                	int    $0x41
 5ab:	c3                   	ret    

000005ac <ls_call11>:
SYSCALL1(ls_call11)
 5ac:	b8 e4 03 00 00       	mov    $0x3e4,%eax
 5b1:	cd 41                	int    $0x41
 5b3:	c3                   	ret    

000005b4 <ls_call12>:
SYSCALL1(ls_call12)
 5b4:	b8 ee 03 00 00       	mov    $0x3ee,%eax
 5b9:	cd 41                	int    $0x41
 5bb:	c3                   	ret    

000005bc <ls_call13>:
SYSCALL1(ls_call13)
 5bc:	b8 f8 03 00 00       	mov    $0x3f8,%eax
 5c1:	cd 41                	int    $0x41
 5c3:	c3                   	ret    

000005c4 <ls_call14>:
SYSCALL1(ls_call14)
 5c4:	b8 02 04 00 00       	mov    $0x402,%eax
 5c9:	cd 41                	int    $0x41
 5cb:	c3                   	ret    

000005cc <ls_call15>:
SYSCALL1(ls_call15)
 5cc:	b8 0c 04 00 00       	mov    $0x40c,%eax
 5d1:	cd 41                	int    $0x41
 5d3:	c3                   	ret    

000005d4 <ls_call16>:
SYSCALL1(ls_call16)
 5d4:	b8 16 04 00 00       	mov    $0x416,%eax
 5d9:	cd 41                	int    $0x41
 5db:	c3                   	ret    

000005dc <ls_call17>:
SYSCALL1(ls_call17)
 5dc:	b8 20 04 00 00       	mov    $0x420,%eax
 5e1:	cd 41                	int    $0x41
 5e3:	c3                   	ret    

000005e4 <ls_call18>:
SYSCALL1(ls_call18)
 5e4:	b8 2a 04 00 00       	mov    $0x42a,%eax
 5e9:	cd 41                	int    $0x41
 5eb:	c3                   	ret    

000005ec <ls_call19>:
SYSCALL1(ls_call19)
 5ec:	b8 34 04 00 00       	mov    $0x434,%eax
 5f1:	cd 41                	int    $0x41
 5f3:	c3                   	ret    

000005f4 <ls_call20>:
SYSCALL1(ls_call20)
 5f4:	b8 3e 04 00 00       	mov    $0x43e,%eax
 5f9:	cd 41                	int    $0x41
 5fb:	c3                   	ret    

000005fc <ls_call21>:
SYSCALL1(ls_call21)
 5fc:	b8 48 04 00 00       	mov    $0x448,%eax
 601:	cd 41                	int    $0x41
 603:	c3                   	ret    

00000604 <ls_call22>:
SYSCALL1(ls_call22)
 604:	b8 52 04 00 00       	mov    $0x452,%eax
 609:	cd 41                	int    $0x41
 60b:	c3                   	ret    

0000060c <ls_call23>:
SYSCALL1(ls_call23)
 60c:	b8 5c 04 00 00       	mov    $0x45c,%eax
 611:	cd 41                	int    $0x41
 613:	c3                   	ret    

00000614 <ls_call24>:
SYSCALL1(ls_call24)
 614:	b8 66 04 00 00       	mov    $0x466,%eax
 619:	cd 41                	int    $0x41
 61b:	c3                   	ret    

0000061c <ls_call25>:
SYSCALL1(ls_call25)
 61c:	b8 70 04 00 00       	mov    $0x470,%eax
 621:	cd 41                	int    $0x41
 623:	c3                   	ret    

00000624 <ls_call26>:
SYSCALL1(ls_call26)
 624:	b8 7a 04 00 00       	mov    $0x47a,%eax
 629:	cd 41                	int    $0x41
 62b:	c3                   	ret    

0000062c <ls_call27>:
SYSCALL1(ls_call27)
 62c:	b8 84 04 00 00       	mov    $0x484,%eax
 631:	cd 41                	int    $0x41
 633:	c3                   	ret    

00000634 <ls_call28>:
SYSCALL1(ls_call28)
 634:	b8 8e 04 00 00       	mov    $0x48e,%eax
 639:	cd 41                	int    $0x41
 63b:	c3                   	ret    

0000063c <ls_call29>:
SYSCALL1(ls_call29)
 63c:	b8 98 04 00 00       	mov    $0x498,%eax
 641:	cd 41                	int    $0x41
 643:	c3                   	ret    

00000644 <ls_call30>:
SYSCALL1(ls_call30)
 644:	b8 a2 04 00 00       	mov    $0x4a2,%eax
 649:	cd 41                	int    $0x41
 64b:	c3                   	ret    

0000064c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 64c:	55                   	push   %ebp
 64d:	89 e5                	mov    %esp,%ebp
 64f:	83 ec 28             	sub    $0x28,%esp
 652:	8b 45 0c             	mov    0xc(%ebp),%eax
 655:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 658:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 65f:	00 
 660:	8d 45 f4             	lea    -0xc(%ebp),%eax
 663:	89 44 24 04          	mov    %eax,0x4(%esp)
 667:	8b 45 08             	mov    0x8(%ebp),%eax
 66a:	89 04 24             	mov    %eax,(%esp)
 66d:	e8 62 fe ff ff       	call   4d4 <write>
}
 672:	c9                   	leave  
 673:	c3                   	ret    

00000674 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 67a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 681:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 685:	74 17                	je     69e <printint+0x2a>
 687:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 68b:	79 11                	jns    69e <printint+0x2a>
    neg = 1;
 68d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 694:	8b 45 0c             	mov    0xc(%ebp),%eax
 697:	f7 d8                	neg    %eax
 699:	89 45 ec             	mov    %eax,-0x14(%ebp)
 69c:	eb 06                	jmp    6a4 <printint+0x30>
  } else {
    x = xx;
 69e:	8b 45 0c             	mov    0xc(%ebp),%eax
 6a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6b1:	ba 00 00 00 00       	mov    $0x0,%edx
 6b6:	f7 f1                	div    %ecx
 6b8:	89 d0                	mov    %edx,%eax
 6ba:	0f b6 80 84 0d 00 00 	movzbl 0xd84(%eax),%eax
 6c1:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 6c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6c7:	01 ca                	add    %ecx,%edx
 6c9:	88 02                	mov    %al,(%edx)
 6cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 6cf:	8b 55 10             	mov    0x10(%ebp),%edx
 6d2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 6d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6d8:	ba 00 00 00 00       	mov    $0x0,%edx
 6dd:	f7 75 d4             	divl   -0x2c(%ebp)
 6e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6e7:	75 c2                	jne    6ab <printint+0x37>
  if(neg)
 6e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6ed:	74 2e                	je     71d <printint+0xa9>
    buf[i++] = '-';
 6ef:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f5:	01 d0                	add    %edx,%eax
 6f7:	c6 00 2d             	movb   $0x2d,(%eax)
 6fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 6fe:	eb 1d                	jmp    71d <printint+0xa9>
    putc(fd, buf[i]);
 700:	8d 55 dc             	lea    -0x24(%ebp),%edx
 703:	8b 45 f4             	mov    -0xc(%ebp),%eax
 706:	01 d0                	add    %edx,%eax
 708:	0f b6 00             	movzbl (%eax),%eax
 70b:	0f be c0             	movsbl %al,%eax
 70e:	89 44 24 04          	mov    %eax,0x4(%esp)
 712:	8b 45 08             	mov    0x8(%ebp),%eax
 715:	89 04 24             	mov    %eax,(%esp)
 718:	e8 2f ff ff ff       	call   64c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 71d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 721:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 725:	79 d9                	jns    700 <printint+0x8c>
    putc(fd, buf[i]);
}
 727:	c9                   	leave  
 728:	c3                   	ret    

00000729 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 729:	55                   	push   %ebp
 72a:	89 e5                	mov    %esp,%ebp
 72c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 72f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 736:	8d 45 0c             	lea    0xc(%ebp),%eax
 739:	83 c0 04             	add    $0x4,%eax
 73c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 73f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 746:	e9 7d 01 00 00       	jmp    8c8 <printf+0x19f>
    c = fmt[i] & 0xff;
 74b:	8b 55 0c             	mov    0xc(%ebp),%edx
 74e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 751:	01 d0                	add    %edx,%eax
 753:	0f b6 00             	movzbl (%eax),%eax
 756:	0f be c0             	movsbl %al,%eax
 759:	25 ff 00 00 00       	and    $0xff,%eax
 75e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 761:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 765:	75 2c                	jne    793 <printf+0x6a>
      if(c == '%'){
 767:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 76b:	75 0c                	jne    779 <printf+0x50>
        state = '%';
 76d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 774:	e9 4b 01 00 00       	jmp    8c4 <printf+0x19b>
      } else {
        putc(fd, c);
 779:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 77c:	0f be c0             	movsbl %al,%eax
 77f:	89 44 24 04          	mov    %eax,0x4(%esp)
 783:	8b 45 08             	mov    0x8(%ebp),%eax
 786:	89 04 24             	mov    %eax,(%esp)
 789:	e8 be fe ff ff       	call   64c <putc>
 78e:	e9 31 01 00 00       	jmp    8c4 <printf+0x19b>
      }
    } else if(state == '%'){
 793:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 797:	0f 85 27 01 00 00    	jne    8c4 <printf+0x19b>
      if(c == 'd'){
 79d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7a1:	75 2d                	jne    7d0 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 7a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7a6:	8b 00                	mov    (%eax),%eax
 7a8:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7af:	00 
 7b0:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7b7:	00 
 7b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bc:	8b 45 08             	mov    0x8(%ebp),%eax
 7bf:	89 04 24             	mov    %eax,(%esp)
 7c2:	e8 ad fe ff ff       	call   674 <printint>
        ap++;
 7c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7cb:	e9 ed 00 00 00       	jmp    8bd <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 7d0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7d4:	74 06                	je     7dc <printf+0xb3>
 7d6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7da:	75 2d                	jne    809 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 7dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7df:	8b 00                	mov    (%eax),%eax
 7e1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 7e8:	00 
 7e9:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 7f0:	00 
 7f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f5:	8b 45 08             	mov    0x8(%ebp),%eax
 7f8:	89 04 24             	mov    %eax,(%esp)
 7fb:	e8 74 fe ff ff       	call   674 <printint>
        ap++;
 800:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 804:	e9 b4 00 00 00       	jmp    8bd <printf+0x194>
      } else if(c == 's'){
 809:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 80d:	75 46                	jne    855 <printf+0x12c>
        s = (char*)*ap;
 80f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 817:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 81b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 81f:	75 27                	jne    848 <printf+0x11f>
          s = "(null)";
 821:	c7 45 f4 1f 0b 00 00 	movl   $0xb1f,-0xc(%ebp)
        while(*s != 0){
 828:	eb 1e                	jmp    848 <printf+0x11f>
          putc(fd, *s);
 82a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82d:	0f b6 00             	movzbl (%eax),%eax
 830:	0f be c0             	movsbl %al,%eax
 833:	89 44 24 04          	mov    %eax,0x4(%esp)
 837:	8b 45 08             	mov    0x8(%ebp),%eax
 83a:	89 04 24             	mov    %eax,(%esp)
 83d:	e8 0a fe ff ff       	call   64c <putc>
          s++;
 842:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 846:	eb 01                	jmp    849 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 848:	90                   	nop
 849:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84c:	0f b6 00             	movzbl (%eax),%eax
 84f:	84 c0                	test   %al,%al
 851:	75 d7                	jne    82a <printf+0x101>
 853:	eb 68                	jmp    8bd <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 855:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 859:	75 1d                	jne    878 <printf+0x14f>
        putc(fd, *ap);
 85b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 85e:	8b 00                	mov    (%eax),%eax
 860:	0f be c0             	movsbl %al,%eax
 863:	89 44 24 04          	mov    %eax,0x4(%esp)
 867:	8b 45 08             	mov    0x8(%ebp),%eax
 86a:	89 04 24             	mov    %eax,(%esp)
 86d:	e8 da fd ff ff       	call   64c <putc>
        ap++;
 872:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 876:	eb 45                	jmp    8bd <printf+0x194>
      } else if(c == '%'){
 878:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 87c:	75 17                	jne    895 <printf+0x16c>
        putc(fd, c);
 87e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 881:	0f be c0             	movsbl %al,%eax
 884:	89 44 24 04          	mov    %eax,0x4(%esp)
 888:	8b 45 08             	mov    0x8(%ebp),%eax
 88b:	89 04 24             	mov    %eax,(%esp)
 88e:	e8 b9 fd ff ff       	call   64c <putc>
 893:	eb 28                	jmp    8bd <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 895:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 89c:	00 
 89d:	8b 45 08             	mov    0x8(%ebp),%eax
 8a0:	89 04 24             	mov    %eax,(%esp)
 8a3:	e8 a4 fd ff ff       	call   64c <putc>
        putc(fd, c);
 8a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8ab:	0f be c0             	movsbl %al,%eax
 8ae:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b2:	8b 45 08             	mov    0x8(%ebp),%eax
 8b5:	89 04 24             	mov    %eax,(%esp)
 8b8:	e8 8f fd ff ff       	call   64c <putc>
      }
      state = 0;
 8bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8c4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8c8:	8b 55 0c             	mov    0xc(%ebp),%edx
 8cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ce:	01 d0                	add    %edx,%eax
 8d0:	0f b6 00             	movzbl (%eax),%eax
 8d3:	84 c0                	test   %al,%al
 8d5:	0f 85 70 fe ff ff    	jne    74b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8db:	c9                   	leave  
 8dc:	c3                   	ret    
 8dd:	90                   	nop
 8de:	90                   	nop
 8df:	90                   	nop

000008e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e6:	8b 45 08             	mov    0x8(%ebp),%eax
 8e9:	83 e8 08             	sub    $0x8,%eax
 8ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ef:	a1 a8 0d 00 00       	mov    0xda8,%eax
 8f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8f7:	eb 24                	jmp    91d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	8b 00                	mov    (%eax),%eax
 8fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 901:	77 12                	ja     915 <free+0x35>
 903:	8b 45 f8             	mov    -0x8(%ebp),%eax
 906:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 909:	77 24                	ja     92f <free+0x4f>
 90b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90e:	8b 00                	mov    (%eax),%eax
 910:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 913:	77 1a                	ja     92f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 915:	8b 45 fc             	mov    -0x4(%ebp),%eax
 918:	8b 00                	mov    (%eax),%eax
 91a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 91d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 920:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 923:	76 d4                	jbe    8f9 <free+0x19>
 925:	8b 45 fc             	mov    -0x4(%ebp),%eax
 928:	8b 00                	mov    (%eax),%eax
 92a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 92d:	76 ca                	jbe    8f9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 92f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 932:	8b 40 04             	mov    0x4(%eax),%eax
 935:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 93c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93f:	01 c2                	add    %eax,%edx
 941:	8b 45 fc             	mov    -0x4(%ebp),%eax
 944:	8b 00                	mov    (%eax),%eax
 946:	39 c2                	cmp    %eax,%edx
 948:	75 24                	jne    96e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 94a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 94d:	8b 50 04             	mov    0x4(%eax),%edx
 950:	8b 45 fc             	mov    -0x4(%ebp),%eax
 953:	8b 00                	mov    (%eax),%eax
 955:	8b 40 04             	mov    0x4(%eax),%eax
 958:	01 c2                	add    %eax,%edx
 95a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 960:	8b 45 fc             	mov    -0x4(%ebp),%eax
 963:	8b 00                	mov    (%eax),%eax
 965:	8b 10                	mov    (%eax),%edx
 967:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96a:	89 10                	mov    %edx,(%eax)
 96c:	eb 0a                	jmp    978 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 96e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 971:	8b 10                	mov    (%eax),%edx
 973:	8b 45 f8             	mov    -0x8(%ebp),%eax
 976:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 978:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97b:	8b 40 04             	mov    0x4(%eax),%eax
 97e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 985:	8b 45 fc             	mov    -0x4(%ebp),%eax
 988:	01 d0                	add    %edx,%eax
 98a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 98d:	75 20                	jne    9af <free+0xcf>
    p->s.size += bp->s.size;
 98f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 992:	8b 50 04             	mov    0x4(%eax),%edx
 995:	8b 45 f8             	mov    -0x8(%ebp),%eax
 998:	8b 40 04             	mov    0x4(%eax),%eax
 99b:	01 c2                	add    %eax,%edx
 99d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a6:	8b 10                	mov    (%eax),%edx
 9a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ab:	89 10                	mov    %edx,(%eax)
 9ad:	eb 08                	jmp    9b7 <free+0xd7>
  } else
    p->s.ptr = bp;
 9af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9b5:	89 10                	mov    %edx,(%eax)
  freep = p;
 9b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ba:	a3 a8 0d 00 00       	mov    %eax,0xda8
}
 9bf:	c9                   	leave  
 9c0:	c3                   	ret    

000009c1 <morecore>:

static Header*
morecore(uint nu)
{
 9c1:	55                   	push   %ebp
 9c2:	89 e5                	mov    %esp,%ebp
 9c4:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9c7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9ce:	77 07                	ja     9d7 <morecore+0x16>
    nu = 4096;
 9d0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9d7:	8b 45 08             	mov    0x8(%ebp),%eax
 9da:	c1 e0 03             	shl    $0x3,%eax
 9dd:	89 04 24             	mov    %eax,(%esp)
 9e0:	e8 57 fb ff ff       	call   53c <sbrk>
 9e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9e8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9ec:	75 07                	jne    9f5 <morecore+0x34>
    return 0;
 9ee:	b8 00 00 00 00       	mov    $0x0,%eax
 9f3:	eb 22                	jmp    a17 <morecore+0x56>
  hp = (Header*)p;
 9f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9fe:	8b 55 08             	mov    0x8(%ebp),%edx
 a01:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a04:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a07:	83 c0 08             	add    $0x8,%eax
 a0a:	89 04 24             	mov    %eax,(%esp)
 a0d:	e8 ce fe ff ff       	call   8e0 <free>
  return freep;
 a12:	a1 a8 0d 00 00       	mov    0xda8,%eax
}
 a17:	c9                   	leave  
 a18:	c3                   	ret    

00000a19 <malloc>:

void*
malloc(uint nbytes)
{
 a19:	55                   	push   %ebp
 a1a:	89 e5                	mov    %esp,%ebp
 a1c:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a1f:	8b 45 08             	mov    0x8(%ebp),%eax
 a22:	83 c0 07             	add    $0x7,%eax
 a25:	c1 e8 03             	shr    $0x3,%eax
 a28:	83 c0 01             	add    $0x1,%eax
 a2b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a2e:	a1 a8 0d 00 00       	mov    0xda8,%eax
 a33:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a36:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a3a:	75 23                	jne    a5f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a3c:	c7 45 f0 a0 0d 00 00 	movl   $0xda0,-0x10(%ebp)
 a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a46:	a3 a8 0d 00 00       	mov    %eax,0xda8
 a4b:	a1 a8 0d 00 00       	mov    0xda8,%eax
 a50:	a3 a0 0d 00 00       	mov    %eax,0xda0
    base.s.size = 0;
 a55:	c7 05 a4 0d 00 00 00 	movl   $0x0,0xda4
 a5c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a62:	8b 00                	mov    (%eax),%eax
 a64:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6a:	8b 40 04             	mov    0x4(%eax),%eax
 a6d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a70:	72 4d                	jb     abf <malloc+0xa6>
      if(p->s.size == nunits)
 a72:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a75:	8b 40 04             	mov    0x4(%eax),%eax
 a78:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a7b:	75 0c                	jne    a89 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a80:	8b 10                	mov    (%eax),%edx
 a82:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a85:	89 10                	mov    %edx,(%eax)
 a87:	eb 26                	jmp    aaf <malloc+0x96>
      else {
        p->s.size -= nunits;
 a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8c:	8b 40 04             	mov    0x4(%eax),%eax
 a8f:	89 c2                	mov    %eax,%edx
 a91:	2b 55 ec             	sub    -0x14(%ebp),%edx
 a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a97:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a9d:	8b 40 04             	mov    0x4(%eax),%eax
 aa0:	c1 e0 03             	shl    $0x3,%eax
 aa3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa9:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aac:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ab2:	a3 a8 0d 00 00       	mov    %eax,0xda8
      return (void*)(p + 1);
 ab7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aba:	83 c0 08             	add    $0x8,%eax
 abd:	eb 38                	jmp    af7 <malloc+0xde>
    }
    if(p == freep)
 abf:	a1 a8 0d 00 00       	mov    0xda8,%eax
 ac4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 ac7:	75 1b                	jne    ae4 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 ac9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 acc:	89 04 24             	mov    %eax,(%esp)
 acf:	e8 ed fe ff ff       	call   9c1 <morecore>
 ad4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 ad7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 adb:	75 07                	jne    ae4 <malloc+0xcb>
        return 0;
 add:	b8 00 00 00 00       	mov    $0x0,%eax
 ae2:	eb 13                	jmp    af7 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aed:	8b 00                	mov    (%eax),%eax
 aef:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 af2:	e9 70 ff ff ff       	jmp    a67 <malloc+0x4e>
}
 af7:	c9                   	leave  
 af8:	c3                   	ret    
