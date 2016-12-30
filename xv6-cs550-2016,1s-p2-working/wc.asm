
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 48             	sub    $0x48,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 68                	jmp    8a <wc+0x8a>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 57                	jmp    82 <wc+0x82>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 a0 0e 00 00       	add    $0xea0,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 a0 0e 00 00       	add    $0xea0,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	89 44 24 04          	mov    %eax,0x4(%esp)
  54:	c7 04 24 b5 0b 00 00 	movl   $0xbb5,(%esp)
  5b:	e8 61 02 00 00       	call   2c1 <strchr>
  60:	85 c0                	test   %eax,%eax
  62:	74 09                	je     6d <wc+0x6d>
        inword = 0;
  64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6b:	eb 11                	jmp    7e <wc+0x7e>
      else if(!inword){
  6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  71:	75 0b                	jne    7e <wc+0x7e>
        w++;
  73:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  77:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  82:	8b 45 f4             	mov    -0xc(%ebp),%eax
  85:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  88:	7c a1                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  91:	00 
  92:	c7 44 24 04 a0 0e 00 	movl   $0xea0,0x4(%esp)
  99:	00 
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 e3 04 00 00       	call   588 <read>
  a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  ac:	0f 8f 70 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b6:	79 19                	jns    d1 <wc+0xd1>
    printf(1, "wc: read error\n");
  b8:	c7 44 24 04 bb 0b 00 	movl   $0xbbb,0x4(%esp)
  bf:	00 
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 19 07 00 00       	call   7e5 <printf>
    exit();
  cc:	e8 9f 04 00 00       	call   570 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  d4:	89 44 24 14          	mov    %eax,0x14(%esp)
  d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  db:	89 44 24 10          	mov    %eax,0x10(%esp)
  df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ed:	c7 44 24 04 cb 0b 00 	movl   $0xbcb,0x4(%esp)
  f4:	00 
  f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fc:	e8 e4 06 00 00       	call   7e5 <printf>
}
 101:	c9                   	leave  
 102:	c3                   	ret    

00000103 <main>:

int
main(int argc, char *argv[])
{
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	83 e4 f0             	and    $0xfffffff0,%esp
 109:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
 10c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 110:	7f 19                	jg     12b <main+0x28>
    wc(0, "");
 112:	c7 44 24 04 d8 0b 00 	movl   $0xbd8,0x4(%esp)
 119:	00 
 11a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 121:	e8 da fe ff ff       	call   0 <wc>
    exit();
 126:	e8 45 04 00 00       	call   570 <exit>
  }

  for(i = 1; i < argc; i++){
 12b:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 132:	00 
 133:	e9 8f 00 00 00       	jmp    1c7 <main+0xc4>
    if((fd = open(argv[i], 0)) < 0){
 138:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 13c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 143:	8b 45 0c             	mov    0xc(%ebp),%eax
 146:	01 d0                	add    %edx,%eax
 148:	8b 00                	mov    (%eax),%eax
 14a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 151:	00 
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 56 04 00 00       	call   5b0 <open>
 15a:	89 44 24 18          	mov    %eax,0x18(%esp)
 15e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
 163:	79 2f                	jns    194 <main+0x91>
      printf(1, "wc: cannot open %s\n", argv[i]);
 165:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 169:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 170:	8b 45 0c             	mov    0xc(%ebp),%eax
 173:	01 d0                	add    %edx,%eax
 175:	8b 00                	mov    (%eax),%eax
 177:	89 44 24 08          	mov    %eax,0x8(%esp)
 17b:	c7 44 24 04 d9 0b 00 	movl   $0xbd9,0x4(%esp)
 182:	00 
 183:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18a:	e8 56 06 00 00       	call   7e5 <printf>
      exit();
 18f:	e8 dc 03 00 00       	call   570 <exit>
    }
    wc(fd, argv[i]);
 194:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 19f:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a2:	01 d0                	add    %edx,%eax
 1a4:	8b 00                	mov    (%eax),%eax
 1a6:	89 44 24 04          	mov    %eax,0x4(%esp)
 1aa:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ae:	89 04 24             	mov    %eax,(%esp)
 1b1:	e8 4a fe ff ff       	call   0 <wc>
    close(fd);
 1b6:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ba:	89 04 24             	mov    %eax,(%esp)
 1bd:	e8 d6 03 00 00       	call   598 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1c2:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1c7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1cb:	3b 45 08             	cmp    0x8(%ebp),%eax
 1ce:	0f 8c 64 ff ff ff    	jl     138 <main+0x35>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1d4:	e8 97 03 00 00       	call   570 <exit>
 1d9:	90                   	nop
 1da:	90                   	nop
 1db:	90                   	nop

000001dc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	57                   	push   %edi
 1e0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e4:	8b 55 10             	mov    0x10(%ebp),%edx
 1e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ea:	89 cb                	mov    %ecx,%ebx
 1ec:	89 df                	mov    %ebx,%edi
 1ee:	89 d1                	mov    %edx,%ecx
 1f0:	fc                   	cld    
 1f1:	f3 aa                	rep stos %al,%es:(%edi)
 1f3:	89 ca                	mov    %ecx,%edx
 1f5:	89 fb                	mov    %edi,%ebx
 1f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1fa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1fd:	5b                   	pop    %ebx
 1fe:	5f                   	pop    %edi
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    

00000201 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 20d:	90                   	nop
 20e:	8b 45 0c             	mov    0xc(%ebp),%eax
 211:	0f b6 10             	movzbl (%eax),%edx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	88 10                	mov    %dl,(%eax)
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	0f b6 00             	movzbl (%eax),%eax
 21f:	84 c0                	test   %al,%al
 221:	0f 95 c0             	setne  %al
 224:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 228:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 22c:	84 c0                	test   %al,%al
 22e:	75 de                	jne    20e <strcpy+0xd>
    ;
  return os;
 230:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 233:	c9                   	leave  
 234:	c3                   	ret    

00000235 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 235:	55                   	push   %ebp
 236:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 238:	eb 08                	jmp    242 <strcmp+0xd>
    p++, q++;
 23a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 23e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 242:	8b 45 08             	mov    0x8(%ebp),%eax
 245:	0f b6 00             	movzbl (%eax),%eax
 248:	84 c0                	test   %al,%al
 24a:	74 10                	je     25c <strcmp+0x27>
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	0f b6 10             	movzbl (%eax),%edx
 252:	8b 45 0c             	mov    0xc(%ebp),%eax
 255:	0f b6 00             	movzbl (%eax),%eax
 258:	38 c2                	cmp    %al,%dl
 25a:	74 de                	je     23a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	0f b6 d0             	movzbl %al,%edx
 265:	8b 45 0c             	mov    0xc(%ebp),%eax
 268:	0f b6 00             	movzbl (%eax),%eax
 26b:	0f b6 c0             	movzbl %al,%eax
 26e:	89 d1                	mov    %edx,%ecx
 270:	29 c1                	sub    %eax,%ecx
 272:	89 c8                	mov    %ecx,%eax
}
 274:	5d                   	pop    %ebp
 275:	c3                   	ret    

00000276 <strlen>:

uint
strlen(char *s)
{
 276:	55                   	push   %ebp
 277:	89 e5                	mov    %esp,%ebp
 279:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 27c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 283:	eb 04                	jmp    289 <strlen+0x13>
 285:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 289:	8b 55 fc             	mov    -0x4(%ebp),%edx
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	01 d0                	add    %edx,%eax
 291:	0f b6 00             	movzbl (%eax),%eax
 294:	84 c0                	test   %al,%al
 296:	75 ed                	jne    285 <strlen+0xf>
    ;
  return n;
 298:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29b:	c9                   	leave  
 29c:	c3                   	ret    

0000029d <memset>:

void*
memset(void *dst, int c, uint n)
{
 29d:	55                   	push   %ebp
 29e:	89 e5                	mov    %esp,%ebp
 2a0:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 2a3:	8b 45 10             	mov    0x10(%ebp),%eax
 2a6:	89 44 24 08          	mov    %eax,0x8(%esp)
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	89 04 24             	mov    %eax,(%esp)
 2b7:	e8 20 ff ff ff       	call   1dc <stosb>
  return dst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bf:	c9                   	leave  
 2c0:	c3                   	ret    

000002c1 <strchr>:

char*
strchr(const char *s, char c)
{
 2c1:	55                   	push   %ebp
 2c2:	89 e5                	mov    %esp,%ebp
 2c4:	83 ec 04             	sub    $0x4,%esp
 2c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ca:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2cd:	eb 14                	jmp    2e3 <strchr+0x22>
    if(*s == c)
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	0f b6 00             	movzbl (%eax),%eax
 2d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2d8:	75 05                	jne    2df <strchr+0x1e>
      return (char*)s;
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	eb 13                	jmp    2f2 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	0f b6 00             	movzbl (%eax),%eax
 2e9:	84 c0                	test   %al,%al
 2eb:	75 e2                	jne    2cf <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2f2:	c9                   	leave  
 2f3:	c3                   	ret    

000002f4 <gets>:

char*
gets(char *buf, int max)
{
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 301:	eb 46                	jmp    349 <gets+0x55>
    cc = read(0, &c, 1);
 303:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 30a:	00 
 30b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 30e:	89 44 24 04          	mov    %eax,0x4(%esp)
 312:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 319:	e8 6a 02 00 00       	call   588 <read>
 31e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 321:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 325:	7e 2f                	jle    356 <gets+0x62>
      break;
    buf[i++] = c;
 327:	8b 55 f4             	mov    -0xc(%ebp),%edx
 32a:	8b 45 08             	mov    0x8(%ebp),%eax
 32d:	01 c2                	add    %eax,%edx
 32f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 333:	88 02                	mov    %al,(%edx)
 335:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 339:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 33d:	3c 0a                	cmp    $0xa,%al
 33f:	74 16                	je     357 <gets+0x63>
 341:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 345:	3c 0d                	cmp    $0xd,%al
 347:	74 0e                	je     357 <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 349:	8b 45 f4             	mov    -0xc(%ebp),%eax
 34c:	83 c0 01             	add    $0x1,%eax
 34f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 352:	7c af                	jl     303 <gets+0xf>
 354:	eb 01                	jmp    357 <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 356:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 357:	8b 55 f4             	mov    -0xc(%ebp),%edx
 35a:	8b 45 08             	mov    0x8(%ebp),%eax
 35d:	01 d0                	add    %edx,%eax
 35f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 362:	8b 45 08             	mov    0x8(%ebp),%eax
}
 365:	c9                   	leave  
 366:	c3                   	ret    

00000367 <stat>:

int
stat(char *n, struct stat *st)
{
 367:	55                   	push   %ebp
 368:	89 e5                	mov    %esp,%ebp
 36a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 36d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 374:	00 
 375:	8b 45 08             	mov    0x8(%ebp),%eax
 378:	89 04 24             	mov    %eax,(%esp)
 37b:	e8 30 02 00 00       	call   5b0 <open>
 380:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 383:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 387:	79 07                	jns    390 <stat+0x29>
    return -1;
 389:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 38e:	eb 23                	jmp    3b3 <stat+0x4c>
  r = fstat(fd, st);
 390:	8b 45 0c             	mov    0xc(%ebp),%eax
 393:	89 44 24 04          	mov    %eax,0x4(%esp)
 397:	8b 45 f4             	mov    -0xc(%ebp),%eax
 39a:	89 04 24             	mov    %eax,(%esp)
 39d:	e8 26 02 00 00       	call   5c8 <fstat>
 3a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 3a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a8:	89 04 24             	mov    %eax,(%esp)
 3ab:	e8 e8 01 00 00       	call   598 <close>
  return r;
 3b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <atoi>:

int
atoi(const char *s)
{
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
 3b8:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3c2:	eb 23                	jmp    3e7 <atoi+0x32>
    n = n*10 + *s++ - '0';
 3c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c7:	89 d0                	mov    %edx,%eax
 3c9:	c1 e0 02             	shl    $0x2,%eax
 3cc:	01 d0                	add    %edx,%eax
 3ce:	01 c0                	add    %eax,%eax
 3d0:	89 c2                	mov    %eax,%edx
 3d2:	8b 45 08             	mov    0x8(%ebp),%eax
 3d5:	0f b6 00             	movzbl (%eax),%eax
 3d8:	0f be c0             	movsbl %al,%eax
 3db:	01 d0                	add    %edx,%eax
 3dd:	83 e8 30             	sub    $0x30,%eax
 3e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3e3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ea:	0f b6 00             	movzbl (%eax),%eax
 3ed:	3c 2f                	cmp    $0x2f,%al
 3ef:	7e 0a                	jle    3fb <atoi+0x46>
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	0f b6 00             	movzbl (%eax),%eax
 3f7:	3c 39                	cmp    $0x39,%al
 3f9:	7e c9                	jle    3c4 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fe:	c9                   	leave  
 3ff:	c3                   	ret    

00000400 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 406:	8b 45 08             	mov    0x8(%ebp),%eax
 409:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 40c:	8b 45 0c             	mov    0xc(%ebp),%eax
 40f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 412:	eb 13                	jmp    427 <memmove+0x27>
    *dst++ = *src++;
 414:	8b 45 f8             	mov    -0x8(%ebp),%eax
 417:	0f b6 10             	movzbl (%eax),%edx
 41a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 41d:	88 10                	mov    %dl,(%eax)
 41f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 423:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 427:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 42b:	0f 9f c0             	setg   %al
 42e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 432:	84 c0                	test   %al,%al
 434:	75 de                	jne    414 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 436:	8b 45 08             	mov    0x8(%ebp),%eax
}
 439:	c9                   	leave  
 43a:	c3                   	ret    
 43b:	90                   	nop

0000043c <SYS_ls_call01>:
 43c:	6c                   	insb   (%dx),%es:(%edi)
 43d:	73 5f                	jae    49e <SYS_ls_call10+0x8>
 43f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 442:	6c                   	insb   (%dx),%es:(%edi)
 443:	30 31                	xor    %dh,(%ecx)
	...

00000446 <SYS_ls_call02>:
 446:	6c                   	insb   (%dx),%es:(%edi)
 447:	73 5f                	jae    4a8 <SYS_ls_call11+0x8>
 449:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 44c:	6c                   	insb   (%dx),%es:(%edi)
 44d:	30 32                	xor    %dh,(%edx)
	...

00000450 <SYS_ls_call03>:
 450:	6c                   	insb   (%dx),%es:(%edi)
 451:	73 5f                	jae    4b2 <SYS_ls_call12+0x8>
 453:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 456:	6c                   	insb   (%dx),%es:(%edi)
 457:	30 33                	xor    %dh,(%ebx)
	...

0000045a <SYS_ls_call04>:
 45a:	6c                   	insb   (%dx),%es:(%edi)
 45b:	73 5f                	jae    4bc <SYS_ls_call13+0x8>
 45d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 460:	6c                   	insb   (%dx),%es:(%edi)
 461:	30 34 00             	xor    %dh,(%eax,%eax,1)

00000464 <SYS_ls_call05>:
 464:	6c                   	insb   (%dx),%es:(%edi)
 465:	73 5f                	jae    4c6 <SYS_ls_call14+0x8>
 467:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 46a:	6c                   	insb   (%dx),%es:(%edi)
 46b:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

0000046e <SYS_ls_call06>:
 46e:	6c                   	insb   (%dx),%es:(%edi)
 46f:	73 5f                	jae    4d0 <SYS_ls_call15+0x8>
 471:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 474:	6c                   	insb   (%dx),%es:(%edi)
 475:	30 36                	xor    %dh,(%esi)
	...

00000478 <SYS_ls_call07>:
 478:	6c                   	insb   (%dx),%es:(%edi)
 479:	73 5f                	jae    4da <SYS_ls_call16+0x8>
 47b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 47e:	6c                   	insb   (%dx),%es:(%edi)
 47f:	30 37                	xor    %dh,(%edi)
	...

00000482 <SYS_ls_call08>:
 482:	6c                   	insb   (%dx),%es:(%edi)
 483:	73 5f                	jae    4e4 <SYS_ls_call17+0x8>
 485:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 488:	6c                   	insb   (%dx),%es:(%edi)
 489:	30 38                	xor    %bh,(%eax)
	...

0000048c <SYS_ls_call09>:
 48c:	6c                   	insb   (%dx),%es:(%edi)
 48d:	73 5f                	jae    4ee <SYS_ls_call18+0x8>
 48f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 492:	6c                   	insb   (%dx),%es:(%edi)
 493:	30 39                	xor    %bh,(%ecx)
	...

00000496 <SYS_ls_call10>:
 496:	6c                   	insb   (%dx),%es:(%edi)
 497:	73 5f                	jae    4f8 <SYS_ls_call19+0x8>
 499:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 49c:	6c                   	insb   (%dx),%es:(%edi)
 49d:	31 30                	xor    %esi,(%eax)
	...

000004a0 <SYS_ls_call11>:
 4a0:	6c                   	insb   (%dx),%es:(%edi)
 4a1:	73 5f                	jae    502 <SYS_ls_call20+0x8>
 4a3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4a6:	6c                   	insb   (%dx),%es:(%edi)
 4a7:	31 31                	xor    %esi,(%ecx)
	...

000004aa <SYS_ls_call12>:
 4aa:	6c                   	insb   (%dx),%es:(%edi)
 4ab:	73 5f                	jae    50c <SYS_ls_call21+0x8>
 4ad:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4b0:	6c                   	insb   (%dx),%es:(%edi)
 4b1:	31 32                	xor    %esi,(%edx)
	...

000004b4 <SYS_ls_call13>:
 4b4:	6c                   	insb   (%dx),%es:(%edi)
 4b5:	73 5f                	jae    516 <SYS_ls_call22+0x8>
 4b7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4ba:	6c                   	insb   (%dx),%es:(%edi)
 4bb:	31 33                	xor    %esi,(%ebx)
	...

000004be <SYS_ls_call14>:
 4be:	6c                   	insb   (%dx),%es:(%edi)
 4bf:	73 5f                	jae    520 <SYS_ls_call23+0x8>
 4c1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4c4:	6c                   	insb   (%dx),%es:(%edi)
 4c5:	31 34 00             	xor    %esi,(%eax,%eax,1)

000004c8 <SYS_ls_call15>:
 4c8:	6c                   	insb   (%dx),%es:(%edi)
 4c9:	73 5f                	jae    52a <SYS_ls_call24+0x8>
 4cb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4ce:	6c                   	insb   (%dx),%es:(%edi)
 4cf:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

000004d2 <SYS_ls_call16>:
 4d2:	6c                   	insb   (%dx),%es:(%edi)
 4d3:	73 5f                	jae    534 <SYS_ls_call25+0x8>
 4d5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4d8:	6c                   	insb   (%dx),%es:(%edi)
 4d9:	31 36                	xor    %esi,(%esi)
	...

000004dc <SYS_ls_call17>:
 4dc:	6c                   	insb   (%dx),%es:(%edi)
 4dd:	73 5f                	jae    53e <SYS_ls_call26+0x8>
 4df:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4e2:	6c                   	insb   (%dx),%es:(%edi)
 4e3:	31 37                	xor    %esi,(%edi)
	...

000004e6 <SYS_ls_call18>:
 4e6:	6c                   	insb   (%dx),%es:(%edi)
 4e7:	73 5f                	jae    548 <SYS_ls_call27+0x8>
 4e9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4ec:	6c                   	insb   (%dx),%es:(%edi)
 4ed:	31 38                	xor    %edi,(%eax)
	...

000004f0 <SYS_ls_call19>:
 4f0:	6c                   	insb   (%dx),%es:(%edi)
 4f1:	73 5f                	jae    552 <SYS_ls_call28+0x8>
 4f3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 4f6:	6c                   	insb   (%dx),%es:(%edi)
 4f7:	31 39                	xor    %edi,(%ecx)
	...

000004fa <SYS_ls_call20>:
 4fa:	6c                   	insb   (%dx),%es:(%edi)
 4fb:	73 5f                	jae    55c <SYS_ls_call29+0x8>
 4fd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 500:	6c                   	insb   (%dx),%es:(%edi)
 501:	32 30                	xor    (%eax),%dh
	...

00000504 <SYS_ls_call21>:
 504:	6c                   	insb   (%dx),%es:(%edi)
 505:	73 5f                	jae    566 <SYS_ls_call30+0x8>
 507:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 50a:	6c                   	insb   (%dx),%es:(%edi)
 50b:	32 31                	xor    (%ecx),%dh
	...

0000050e <SYS_ls_call22>:
 50e:	6c                   	insb   (%dx),%es:(%edi)
 50f:	73 5f                	jae    570 <exit>
 511:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 514:	6c                   	insb   (%dx),%es:(%edi)
 515:	32 32                	xor    (%edx),%dh
	...

00000518 <SYS_ls_call23>:
 518:	6c                   	insb   (%dx),%es:(%edi)
 519:	73 5f                	jae    57a <wait+0x2>
 51b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 51e:	6c                   	insb   (%dx),%es:(%edi)
 51f:	32 33                	xor    (%ebx),%dh
	...

00000522 <SYS_ls_call24>:
 522:	6c                   	insb   (%dx),%es:(%edi)
 523:	73 5f                	jae    584 <pipe+0x4>
 525:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 528:	6c                   	insb   (%dx),%es:(%edi)
 529:	32 34 00             	xor    (%eax,%eax,1),%dh

0000052c <SYS_ls_call25>:
 52c:	6c                   	insb   (%dx),%es:(%edi)
 52d:	73 5f                	jae    58e <read+0x6>
 52f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 532:	6c                   	insb   (%dx),%es:(%edi)
 533:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

00000536 <SYS_ls_call26>:
 536:	6c                   	insb   (%dx),%es:(%edi)
 537:	73 5f                	jae    598 <close>
 539:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 53c:	6c                   	insb   (%dx),%es:(%edi)
 53d:	32 36                	xor    (%esi),%dh
	...

00000540 <SYS_ls_call27>:
 540:	6c                   	insb   (%dx),%es:(%edi)
 541:	73 5f                	jae    5a2 <kill+0x2>
 543:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 546:	6c                   	insb   (%dx),%es:(%edi)
 547:	32 37                	xor    (%edi),%dh
	...

0000054a <SYS_ls_call28>:
 54a:	6c                   	insb   (%dx),%es:(%edi)
 54b:	73 5f                	jae    5ac <exec+0x4>
 54d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 550:	6c                   	insb   (%dx),%es:(%edi)
 551:	32 38                	xor    (%eax),%bh
	...

00000554 <SYS_ls_call29>:
 554:	6c                   	insb   (%dx),%es:(%edi)
 555:	73 5f                	jae    5b6 <open+0x6>
 557:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 55a:	6c                   	insb   (%dx),%es:(%edi)
 55b:	32 39                	xor    (%ecx),%bh
	...

0000055e <SYS_ls_call30>:
 55e:	6c                   	insb   (%dx),%es:(%edi)
 55f:	73 5f                	jae    5c0 <unlink>
 561:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 564:	6c                   	insb   (%dx),%es:(%edi)
 565:	33 30                	xor    (%eax),%esi
	...

00000568 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 568:	b8 01 00 00 00       	mov    $0x1,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <exit>:
SYSCALL(exit)
 570:	b8 02 00 00 00       	mov    $0x2,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <wait>:
SYSCALL(wait)
 578:	b8 03 00 00 00       	mov    $0x3,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <pipe>:
SYSCALL(pipe)
 580:	b8 04 00 00 00       	mov    $0x4,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <read>:
SYSCALL(read)
 588:	b8 05 00 00 00       	mov    $0x5,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <write>:
SYSCALL(write)
 590:	b8 10 00 00 00       	mov    $0x10,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <close>:
SYSCALL(close)
 598:	b8 15 00 00 00       	mov    $0x15,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <kill>:
SYSCALL(kill)
 5a0:	b8 06 00 00 00       	mov    $0x6,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <exec>:
SYSCALL(exec)
 5a8:	b8 07 00 00 00       	mov    $0x7,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <open>:
SYSCALL(open)
 5b0:	b8 0f 00 00 00       	mov    $0xf,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <mknod>:
SYSCALL(mknod)
 5b8:	b8 11 00 00 00       	mov    $0x11,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <unlink>:
SYSCALL(unlink)
 5c0:	b8 12 00 00 00       	mov    $0x12,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <fstat>:
SYSCALL(fstat)
 5c8:	b8 08 00 00 00       	mov    $0x8,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <link>:
SYSCALL(link)
 5d0:	b8 13 00 00 00       	mov    $0x13,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <mkdir>:
SYSCALL(mkdir)
 5d8:	b8 14 00 00 00       	mov    $0x14,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <chdir>:
SYSCALL(chdir)
 5e0:	b8 09 00 00 00       	mov    $0x9,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <dup>:
SYSCALL(dup)
 5e8:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <getpid>:
SYSCALL(getpid)
 5f0:	b8 0b 00 00 00       	mov    $0xb,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <sbrk>:
SYSCALL(sbrk)
 5f8:	b8 0c 00 00 00       	mov    $0xc,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <sleep>:
SYSCALL(sleep)
 600:	b8 0d 00 00 00       	mov    $0xd,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <uptime>:
SYSCALL(uptime)
 608:	b8 0e 00 00 00       	mov    $0xe,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <date>:
SYSCALL(date)
 610:	b8 16 00 00 00       	mov    $0x16,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <ls_call01>:

SYSCALL1(ls_call01)
 618:	b8 3c 04 00 00       	mov    $0x43c,%eax
 61d:	cd 41                	int    $0x41
 61f:	c3                   	ret    

00000620 <ls_call02>:
SYSCALL1(ls_call02)
 620:	b8 46 04 00 00       	mov    $0x446,%eax
 625:	cd 41                	int    $0x41
 627:	c3                   	ret    

00000628 <ls_call03>:
SYSCALL1(ls_call03)
 628:	b8 50 04 00 00       	mov    $0x450,%eax
 62d:	cd 41                	int    $0x41
 62f:	c3                   	ret    

00000630 <ls_call04>:
SYSCALL1(ls_call04)
 630:	b8 5a 04 00 00       	mov    $0x45a,%eax
 635:	cd 41                	int    $0x41
 637:	c3                   	ret    

00000638 <ls_call05>:
SYSCALL1(ls_call05)
 638:	b8 64 04 00 00       	mov    $0x464,%eax
 63d:	cd 41                	int    $0x41
 63f:	c3                   	ret    

00000640 <ls_call06>:
SYSCALL1(ls_call06)
 640:	b8 6e 04 00 00       	mov    $0x46e,%eax
 645:	cd 41                	int    $0x41
 647:	c3                   	ret    

00000648 <ls_call07>:
SYSCALL1(ls_call07)
 648:	b8 78 04 00 00       	mov    $0x478,%eax
 64d:	cd 41                	int    $0x41
 64f:	c3                   	ret    

00000650 <ls_call08>:
SYSCALL1(ls_call08)
 650:	b8 82 04 00 00       	mov    $0x482,%eax
 655:	cd 41                	int    $0x41
 657:	c3                   	ret    

00000658 <ls_call09>:
SYSCALL1(ls_call09)
 658:	b8 8c 04 00 00       	mov    $0x48c,%eax
 65d:	cd 41                	int    $0x41
 65f:	c3                   	ret    

00000660 <ls_call10>:
SYSCALL1(ls_call10)
 660:	b8 96 04 00 00       	mov    $0x496,%eax
 665:	cd 41                	int    $0x41
 667:	c3                   	ret    

00000668 <ls_call11>:
SYSCALL1(ls_call11)
 668:	b8 a0 04 00 00       	mov    $0x4a0,%eax
 66d:	cd 41                	int    $0x41
 66f:	c3                   	ret    

00000670 <ls_call12>:
SYSCALL1(ls_call12)
 670:	b8 aa 04 00 00       	mov    $0x4aa,%eax
 675:	cd 41                	int    $0x41
 677:	c3                   	ret    

00000678 <ls_call13>:
SYSCALL1(ls_call13)
 678:	b8 b4 04 00 00       	mov    $0x4b4,%eax
 67d:	cd 41                	int    $0x41
 67f:	c3                   	ret    

00000680 <ls_call14>:
SYSCALL1(ls_call14)
 680:	b8 be 04 00 00       	mov    $0x4be,%eax
 685:	cd 41                	int    $0x41
 687:	c3                   	ret    

00000688 <ls_call15>:
SYSCALL1(ls_call15)
 688:	b8 c8 04 00 00       	mov    $0x4c8,%eax
 68d:	cd 41                	int    $0x41
 68f:	c3                   	ret    

00000690 <ls_call16>:
SYSCALL1(ls_call16)
 690:	b8 d2 04 00 00       	mov    $0x4d2,%eax
 695:	cd 41                	int    $0x41
 697:	c3                   	ret    

00000698 <ls_call17>:
SYSCALL1(ls_call17)
 698:	b8 dc 04 00 00       	mov    $0x4dc,%eax
 69d:	cd 41                	int    $0x41
 69f:	c3                   	ret    

000006a0 <ls_call18>:
SYSCALL1(ls_call18)
 6a0:	b8 e6 04 00 00       	mov    $0x4e6,%eax
 6a5:	cd 41                	int    $0x41
 6a7:	c3                   	ret    

000006a8 <ls_call19>:
SYSCALL1(ls_call19)
 6a8:	b8 f0 04 00 00       	mov    $0x4f0,%eax
 6ad:	cd 41                	int    $0x41
 6af:	c3                   	ret    

000006b0 <ls_call20>:
SYSCALL1(ls_call20)
 6b0:	b8 fa 04 00 00       	mov    $0x4fa,%eax
 6b5:	cd 41                	int    $0x41
 6b7:	c3                   	ret    

000006b8 <ls_call21>:
SYSCALL1(ls_call21)
 6b8:	b8 04 05 00 00       	mov    $0x504,%eax
 6bd:	cd 41                	int    $0x41
 6bf:	c3                   	ret    

000006c0 <ls_call22>:
SYSCALL1(ls_call22)
 6c0:	b8 0e 05 00 00       	mov    $0x50e,%eax
 6c5:	cd 41                	int    $0x41
 6c7:	c3                   	ret    

000006c8 <ls_call23>:
SYSCALL1(ls_call23)
 6c8:	b8 18 05 00 00       	mov    $0x518,%eax
 6cd:	cd 41                	int    $0x41
 6cf:	c3                   	ret    

000006d0 <ls_call24>:
SYSCALL1(ls_call24)
 6d0:	b8 22 05 00 00       	mov    $0x522,%eax
 6d5:	cd 41                	int    $0x41
 6d7:	c3                   	ret    

000006d8 <ls_call25>:
SYSCALL1(ls_call25)
 6d8:	b8 2c 05 00 00       	mov    $0x52c,%eax
 6dd:	cd 41                	int    $0x41
 6df:	c3                   	ret    

000006e0 <ls_call26>:
SYSCALL1(ls_call26)
 6e0:	b8 36 05 00 00       	mov    $0x536,%eax
 6e5:	cd 41                	int    $0x41
 6e7:	c3                   	ret    

000006e8 <ls_call27>:
SYSCALL1(ls_call27)
 6e8:	b8 40 05 00 00       	mov    $0x540,%eax
 6ed:	cd 41                	int    $0x41
 6ef:	c3                   	ret    

000006f0 <ls_call28>:
SYSCALL1(ls_call28)
 6f0:	b8 4a 05 00 00       	mov    $0x54a,%eax
 6f5:	cd 41                	int    $0x41
 6f7:	c3                   	ret    

000006f8 <ls_call29>:
SYSCALL1(ls_call29)
 6f8:	b8 54 05 00 00       	mov    $0x554,%eax
 6fd:	cd 41                	int    $0x41
 6ff:	c3                   	ret    

00000700 <ls_call30>:
SYSCALL1(ls_call30)
 700:	b8 5e 05 00 00       	mov    $0x55e,%eax
 705:	cd 41                	int    $0x41
 707:	c3                   	ret    

00000708 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 708:	55                   	push   %ebp
 709:	89 e5                	mov    %esp,%ebp
 70b:	83 ec 28             	sub    $0x28,%esp
 70e:	8b 45 0c             	mov    0xc(%ebp),%eax
 711:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 714:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 71b:	00 
 71c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 71f:	89 44 24 04          	mov    %eax,0x4(%esp)
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 62 fe ff ff       	call   590 <write>
}
 72e:	c9                   	leave  
 72f:	c3                   	ret    

00000730 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 736:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 73d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 741:	74 17                	je     75a <printint+0x2a>
 743:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 747:	79 11                	jns    75a <printint+0x2a>
    neg = 1;
 749:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 750:	8b 45 0c             	mov    0xc(%ebp),%eax
 753:	f7 d8                	neg    %eax
 755:	89 45 ec             	mov    %eax,-0x14(%ebp)
 758:	eb 06                	jmp    760 <printint+0x30>
  } else {
    x = xx;
 75a:	8b 45 0c             	mov    0xc(%ebp),%eax
 75d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 760:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 767:	8b 4d 10             	mov    0x10(%ebp),%ecx
 76a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 76d:	ba 00 00 00 00       	mov    $0x0,%edx
 772:	f7 f1                	div    %ecx
 774:	89 d0                	mov    %edx,%eax
 776:	0f b6 80 50 0e 00 00 	movzbl 0xe50(%eax),%eax
 77d:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 780:	8b 55 f4             	mov    -0xc(%ebp),%edx
 783:	01 ca                	add    %ecx,%edx
 785:	88 02                	mov    %al,(%edx)
 787:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 78b:	8b 55 10             	mov    0x10(%ebp),%edx
 78e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 791:	8b 45 ec             	mov    -0x14(%ebp),%eax
 794:	ba 00 00 00 00       	mov    $0x0,%edx
 799:	f7 75 d4             	divl   -0x2c(%ebp)
 79c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 79f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7a3:	75 c2                	jne    767 <printint+0x37>
  if(neg)
 7a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a9:	74 2e                	je     7d9 <printint+0xa9>
    buf[i++] = '-';
 7ab:	8d 55 dc             	lea    -0x24(%ebp),%edx
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	01 d0                	add    %edx,%eax
 7b3:	c6 00 2d             	movb   $0x2d,(%eax)
 7b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 7ba:	eb 1d                	jmp    7d9 <printint+0xa9>
    putc(fd, buf[i]);
 7bc:	8d 55 dc             	lea    -0x24(%ebp),%edx
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	01 d0                	add    %edx,%eax
 7c4:	0f b6 00             	movzbl (%eax),%eax
 7c7:	0f be c0             	movsbl %al,%eax
 7ca:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ce:	8b 45 08             	mov    0x8(%ebp),%eax
 7d1:	89 04 24             	mov    %eax,(%esp)
 7d4:	e8 2f ff ff ff       	call   708 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7d9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 7dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e1:	79 d9                	jns    7bc <printint+0x8c>
    putc(fd, buf[i]);
}
 7e3:	c9                   	leave  
 7e4:	c3                   	ret    

000007e5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7e5:	55                   	push   %ebp
 7e6:	89 e5                	mov    %esp,%ebp
 7e8:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 7eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7f2:	8d 45 0c             	lea    0xc(%ebp),%eax
 7f5:	83 c0 04             	add    $0x4,%eax
 7f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 7fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 802:	e9 7d 01 00 00       	jmp    984 <printf+0x19f>
    c = fmt[i] & 0xff;
 807:	8b 55 0c             	mov    0xc(%ebp),%edx
 80a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80d:	01 d0                	add    %edx,%eax
 80f:	0f b6 00             	movzbl (%eax),%eax
 812:	0f be c0             	movsbl %al,%eax
 815:	25 ff 00 00 00       	and    $0xff,%eax
 81a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 81d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 821:	75 2c                	jne    84f <printf+0x6a>
      if(c == '%'){
 823:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 827:	75 0c                	jne    835 <printf+0x50>
        state = '%';
 829:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 830:	e9 4b 01 00 00       	jmp    980 <printf+0x19b>
      } else {
        putc(fd, c);
 835:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 838:	0f be c0             	movsbl %al,%eax
 83b:	89 44 24 04          	mov    %eax,0x4(%esp)
 83f:	8b 45 08             	mov    0x8(%ebp),%eax
 842:	89 04 24             	mov    %eax,(%esp)
 845:	e8 be fe ff ff       	call   708 <putc>
 84a:	e9 31 01 00 00       	jmp    980 <printf+0x19b>
      }
    } else if(state == '%'){
 84f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 853:	0f 85 27 01 00 00    	jne    980 <printf+0x19b>
      if(c == 'd'){
 859:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 85d:	75 2d                	jne    88c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 85f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 862:	8b 00                	mov    (%eax),%eax
 864:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 86b:	00 
 86c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 873:	00 
 874:	89 44 24 04          	mov    %eax,0x4(%esp)
 878:	8b 45 08             	mov    0x8(%ebp),%eax
 87b:	89 04 24             	mov    %eax,(%esp)
 87e:	e8 ad fe ff ff       	call   730 <printint>
        ap++;
 883:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 887:	e9 ed 00 00 00       	jmp    979 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 88c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 890:	74 06                	je     898 <printf+0xb3>
 892:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 896:	75 2d                	jne    8c5 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 898:	8b 45 e8             	mov    -0x18(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 8a4:	00 
 8a5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 8ac:	00 
 8ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b1:	8b 45 08             	mov    0x8(%ebp),%eax
 8b4:	89 04 24             	mov    %eax,(%esp)
 8b7:	e8 74 fe ff ff       	call   730 <printint>
        ap++;
 8bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8c0:	e9 b4 00 00 00       	jmp    979 <printf+0x194>
      } else if(c == 's'){
 8c5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 8c9:	75 46                	jne    911 <printf+0x12c>
        s = (char*)*ap;
 8cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 8d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 8d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8db:	75 27                	jne    904 <printf+0x11f>
          s = "(null)";
 8dd:	c7 45 f4 ed 0b 00 00 	movl   $0xbed,-0xc(%ebp)
        while(*s != 0){
 8e4:	eb 1e                	jmp    904 <printf+0x11f>
          putc(fd, *s);
 8e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e9:	0f b6 00             	movzbl (%eax),%eax
 8ec:	0f be c0             	movsbl %al,%eax
 8ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 8f3:	8b 45 08             	mov    0x8(%ebp),%eax
 8f6:	89 04 24             	mov    %eax,(%esp)
 8f9:	e8 0a fe ff ff       	call   708 <putc>
          s++;
 8fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 902:	eb 01                	jmp    905 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 904:	90                   	nop
 905:	8b 45 f4             	mov    -0xc(%ebp),%eax
 908:	0f b6 00             	movzbl (%eax),%eax
 90b:	84 c0                	test   %al,%al
 90d:	75 d7                	jne    8e6 <printf+0x101>
 90f:	eb 68                	jmp    979 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 911:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 915:	75 1d                	jne    934 <printf+0x14f>
        putc(fd, *ap);
 917:	8b 45 e8             	mov    -0x18(%ebp),%eax
 91a:	8b 00                	mov    (%eax),%eax
 91c:	0f be c0             	movsbl %al,%eax
 91f:	89 44 24 04          	mov    %eax,0x4(%esp)
 923:	8b 45 08             	mov    0x8(%ebp),%eax
 926:	89 04 24             	mov    %eax,(%esp)
 929:	e8 da fd ff ff       	call   708 <putc>
        ap++;
 92e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 932:	eb 45                	jmp    979 <printf+0x194>
      } else if(c == '%'){
 934:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 938:	75 17                	jne    951 <printf+0x16c>
        putc(fd, c);
 93a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 93d:	0f be c0             	movsbl %al,%eax
 940:	89 44 24 04          	mov    %eax,0x4(%esp)
 944:	8b 45 08             	mov    0x8(%ebp),%eax
 947:	89 04 24             	mov    %eax,(%esp)
 94a:	e8 b9 fd ff ff       	call   708 <putc>
 94f:	eb 28                	jmp    979 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 951:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 958:	00 
 959:	8b 45 08             	mov    0x8(%ebp),%eax
 95c:	89 04 24             	mov    %eax,(%esp)
 95f:	e8 a4 fd ff ff       	call   708 <putc>
        putc(fd, c);
 964:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 967:	0f be c0             	movsbl %al,%eax
 96a:	89 44 24 04          	mov    %eax,0x4(%esp)
 96e:	8b 45 08             	mov    0x8(%ebp),%eax
 971:	89 04 24             	mov    %eax,(%esp)
 974:	e8 8f fd ff ff       	call   708 <putc>
      }
      state = 0;
 979:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 980:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 984:	8b 55 0c             	mov    0xc(%ebp),%edx
 987:	8b 45 f0             	mov    -0x10(%ebp),%eax
 98a:	01 d0                	add    %edx,%eax
 98c:	0f b6 00             	movzbl (%eax),%eax
 98f:	84 c0                	test   %al,%al
 991:	0f 85 70 fe ff ff    	jne    807 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 997:	c9                   	leave  
 998:	c3                   	ret    
 999:	90                   	nop
 99a:	90                   	nop
 99b:	90                   	nop

0000099c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 99c:	55                   	push   %ebp
 99d:	89 e5                	mov    %esp,%ebp
 99f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a2:	8b 45 08             	mov    0x8(%ebp),%eax
 9a5:	83 e8 08             	sub    $0x8,%eax
 9a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ab:	a1 88 0e 00 00       	mov    0xe88,%eax
 9b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 9b3:	eb 24                	jmp    9d9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b8:	8b 00                	mov    (%eax),%eax
 9ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9bd:	77 12                	ja     9d1 <free+0x35>
 9bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9c5:	77 24                	ja     9eb <free+0x4f>
 9c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ca:	8b 00                	mov    (%eax),%eax
 9cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9cf:	77 1a                	ja     9eb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d4:	8b 00                	mov    (%eax),%eax
 9d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 9d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9df:	76 d4                	jbe    9b5 <free+0x19>
 9e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e4:	8b 00                	mov    (%eax),%eax
 9e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9e9:	76 ca                	jbe    9b5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ee:	8b 40 04             	mov    0x4(%eax),%eax
 9f1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9fb:	01 c2                	add    %eax,%edx
 9fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a00:	8b 00                	mov    (%eax),%eax
 a02:	39 c2                	cmp    %eax,%edx
 a04:	75 24                	jne    a2a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 a06:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a09:	8b 50 04             	mov    0x4(%eax),%edx
 a0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a0f:	8b 00                	mov    (%eax),%eax
 a11:	8b 40 04             	mov    0x4(%eax),%eax
 a14:	01 c2                	add    %eax,%edx
 a16:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a19:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a1f:	8b 00                	mov    (%eax),%eax
 a21:	8b 10                	mov    (%eax),%edx
 a23:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a26:	89 10                	mov    %edx,(%eax)
 a28:	eb 0a                	jmp    a34 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 a2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a2d:	8b 10                	mov    (%eax),%edx
 a2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a32:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 a34:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a37:	8b 40 04             	mov    0x4(%eax),%eax
 a3a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a41:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a44:	01 d0                	add    %edx,%eax
 a46:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a49:	75 20                	jne    a6b <free+0xcf>
    p->s.size += bp->s.size;
 a4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a4e:	8b 50 04             	mov    0x4(%eax),%edx
 a51:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a54:	8b 40 04             	mov    0x4(%eax),%eax
 a57:	01 c2                	add    %eax,%edx
 a59:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a5c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a62:	8b 10                	mov    (%eax),%edx
 a64:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a67:	89 10                	mov    %edx,(%eax)
 a69:	eb 08                	jmp    a73 <free+0xd7>
  } else
    p->s.ptr = bp;
 a6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a6e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a71:	89 10                	mov    %edx,(%eax)
  freep = p;
 a73:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a76:	a3 88 0e 00 00       	mov    %eax,0xe88
}
 a7b:	c9                   	leave  
 a7c:	c3                   	ret    

00000a7d <morecore>:

static Header*
morecore(uint nu)
{
 a7d:	55                   	push   %ebp
 a7e:	89 e5                	mov    %esp,%ebp
 a80:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a83:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a8a:	77 07                	ja     a93 <morecore+0x16>
    nu = 4096;
 a8c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a93:	8b 45 08             	mov    0x8(%ebp),%eax
 a96:	c1 e0 03             	shl    $0x3,%eax
 a99:	89 04 24             	mov    %eax,(%esp)
 a9c:	e8 57 fb ff ff       	call   5f8 <sbrk>
 aa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 aa4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 aa8:	75 07                	jne    ab1 <morecore+0x34>
    return 0;
 aaa:	b8 00 00 00 00       	mov    $0x0,%eax
 aaf:	eb 22                	jmp    ad3 <morecore+0x56>
  hp = (Header*)p;
 ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 ab7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aba:	8b 55 08             	mov    0x8(%ebp),%edx
 abd:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac3:	83 c0 08             	add    $0x8,%eax
 ac6:	89 04 24             	mov    %eax,(%esp)
 ac9:	e8 ce fe ff ff       	call   99c <free>
  return freep;
 ace:	a1 88 0e 00 00       	mov    0xe88,%eax
}
 ad3:	c9                   	leave  
 ad4:	c3                   	ret    

00000ad5 <malloc>:

void*
malloc(uint nbytes)
{
 ad5:	55                   	push   %ebp
 ad6:	89 e5                	mov    %esp,%ebp
 ad8:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 adb:	8b 45 08             	mov    0x8(%ebp),%eax
 ade:	83 c0 07             	add    $0x7,%eax
 ae1:	c1 e8 03             	shr    $0x3,%eax
 ae4:	83 c0 01             	add    $0x1,%eax
 ae7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 aea:	a1 88 0e 00 00       	mov    0xe88,%eax
 aef:	89 45 f0             	mov    %eax,-0x10(%ebp)
 af2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 af6:	75 23                	jne    b1b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 af8:	c7 45 f0 80 0e 00 00 	movl   $0xe80,-0x10(%ebp)
 aff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b02:	a3 88 0e 00 00       	mov    %eax,0xe88
 b07:	a1 88 0e 00 00       	mov    0xe88,%eax
 b0c:	a3 80 0e 00 00       	mov    %eax,0xe80
    base.s.size = 0;
 b11:	c7 05 84 0e 00 00 00 	movl   $0x0,0xe84
 b18:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b1e:	8b 00                	mov    (%eax),%eax
 b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b26:	8b 40 04             	mov    0x4(%eax),%eax
 b29:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b2c:	72 4d                	jb     b7b <malloc+0xa6>
      if(p->s.size == nunits)
 b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b31:	8b 40 04             	mov    0x4(%eax),%eax
 b34:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b37:	75 0c                	jne    b45 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b3c:	8b 10                	mov    (%eax),%edx
 b3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b41:	89 10                	mov    %edx,(%eax)
 b43:	eb 26                	jmp    b6b <malloc+0x96>
      else {
        p->s.size -= nunits;
 b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b48:	8b 40 04             	mov    0x4(%eax),%eax
 b4b:	89 c2                	mov    %eax,%edx
 b4d:	2b 55 ec             	sub    -0x14(%ebp),%edx
 b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b53:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b59:	8b 40 04             	mov    0x4(%eax),%eax
 b5c:	c1 e0 03             	shl    $0x3,%eax
 b5f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b65:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b68:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b6e:	a3 88 0e 00 00       	mov    %eax,0xe88
      return (void*)(p + 1);
 b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b76:	83 c0 08             	add    $0x8,%eax
 b79:	eb 38                	jmp    bb3 <malloc+0xde>
    }
    if(p == freep)
 b7b:	a1 88 0e 00 00       	mov    0xe88,%eax
 b80:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b83:	75 1b                	jne    ba0 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 b85:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b88:	89 04 24             	mov    %eax,(%esp)
 b8b:	e8 ed fe ff ff       	call   a7d <morecore>
 b90:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b97:	75 07                	jne    ba0 <malloc+0xcb>
        return 0;
 b99:	b8 00 00 00 00       	mov    $0x0,%eax
 b9e:	eb 13                	jmp    bb3 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba9:	8b 00                	mov    (%eax),%eax
 bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 bae:	e9 70 ff ff ff       	jmp    b23 <malloc+0x4e>
}
 bb3:	c9                   	leave  
 bb4:	c3                   	ret    
