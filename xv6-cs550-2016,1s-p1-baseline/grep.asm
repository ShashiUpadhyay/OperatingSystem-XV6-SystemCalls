
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 ca 00 00 00       	jmp    dc <grep+0xdc>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 60 0e 00 00       	add    $0xe60,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 60 0e 00 00 	movl   $0xe60,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 53                	jmp    7f <grep+0x7f>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  35:	89 44 24 04          	mov    %eax,0x4(%esp)
  39:	8b 45 08             	mov    0x8(%ebp),%eax
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 c2 01 00 00       	call   206 <match>
  44:	85 c0                	test   %eax,%eax
  46:	74 2e                	je     76 <grep+0x76>
        *q = '\n';
  48:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4b:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  51:	83 c0 01             	add    $0x1,%eax
  54:	89 c2                	mov    %eax,%edx
  56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  59:	89 d1                	mov    %edx,%ecx
  5b:	29 c1                	sub    %eax,%ecx
  5d:	89 c8                	mov    %ecx,%eax
  5f:	89 44 24 08          	mov    %eax,0x8(%esp)
  63:	8b 45 f0             	mov    -0x10(%ebp),%eax
  66:	89 44 24 04          	mov    %eax,0x4(%esp)
  6a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  71:	e8 7e 05 00 00       	call   5f4 <write>
      }
      p = q+1;
  76:	8b 45 e8             	mov    -0x18(%ebp),%eax
  79:	83 c0 01             	add    $0x1,%eax
  7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  7f:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  86:	00 
  87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8a:	89 04 24             	mov    %eax,(%esp)
  8d:	e8 bf 03 00 00       	call   451 <strchr>
  92:	89 45 e8             	mov    %eax,-0x18(%ebp)
  95:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  99:	75 91                	jne    2c <grep+0x2c>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  9b:	81 7d f0 60 0e 00 00 	cmpl   $0xe60,-0x10(%ebp)
  a2:	75 07                	jne    ab <grep+0xab>
      m = 0;
  a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  af:	7e 2b                	jle    dc <grep+0xdc>
      m -= p - buf;
  b1:	ba 60 0e 00 00       	mov    $0xe60,%edx
  b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  b9:	89 d1                	mov    %edx,%ecx
  bb:	29 c1                	sub    %eax,%ecx
  bd:	89 c8                	mov    %ecx,%eax
  bf:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  d0:	c7 04 24 60 0e 00 00 	movl   $0xe60,(%esp)
  d7:	e8 b4 04 00 00       	call   590 <memmove>
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  df:	ba ff 03 00 00       	mov    $0x3ff,%edx
  e4:	89 d1                	mov    %edx,%ecx
  e6:	29 c1                	sub    %eax,%ecx
  e8:	89 c8                	mov    %ecx,%eax
  ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ed:	81 c2 60 0e 00 00    	add    $0xe60,%edx
  f3:	89 44 24 08          	mov    %eax,0x8(%esp)
  f7:	89 54 24 04          	mov    %edx,0x4(%esp)
  fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 e6 04 00 00       	call   5ec <read>
 106:	89 45 ec             	mov    %eax,-0x14(%ebp)
 109:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 10d:	0f 8f ff fe ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 113:	c9                   	leave  
 114:	c3                   	ret    

00000115 <main>:

int
main(int argc, char *argv[])
{
 115:	55                   	push   %ebp
 116:	89 e5                	mov    %esp,%ebp
 118:	83 e4 f0             	and    $0xfffffff0,%esp
 11b:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 11e:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 122:	7f 19                	jg     13d <main+0x28>
    printf(2, "usage: grep pattern [file ...]\n");
 124:	c7 44 24 04 24 0b 00 	movl   $0xb24,0x4(%esp)
 12b:	00 
 12c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 133:	e8 19 06 00 00       	call   751 <printf>
    exit();
 138:	e8 97 04 00 00       	call   5d4 <exit>
  }
  pattern = argv[1];
 13d:	8b 45 0c             	mov    0xc(%ebp),%eax
 140:	8b 40 04             	mov    0x4(%eax),%eax
 143:	89 44 24 18          	mov    %eax,0x18(%esp)
  
  if(argc <= 2){
 147:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 14b:	7f 19                	jg     166 <main+0x51>
    grep(pattern, 0);
 14d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 154:	00 
 155:	8b 44 24 18          	mov    0x18(%esp),%eax
 159:	89 04 24             	mov    %eax,(%esp)
 15c:	e8 9f fe ff ff       	call   0 <grep>
    exit();
 161:	e8 6e 04 00 00       	call   5d4 <exit>
  }

  for(i = 2; i < argc; i++){
 166:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
 16d:	00 
 16e:	e9 81 00 00 00       	jmp    1f4 <main+0xdf>
    if((fd = open(argv[i], 0)) < 0){
 173:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 177:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 17e:	8b 45 0c             	mov    0xc(%ebp),%eax
 181:	01 d0                	add    %edx,%eax
 183:	8b 00                	mov    (%eax),%eax
 185:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 18c:	00 
 18d:	89 04 24             	mov    %eax,(%esp)
 190:	e8 7f 04 00 00       	call   614 <open>
 195:	89 44 24 14          	mov    %eax,0x14(%esp)
 199:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
 19e:	79 2f                	jns    1cf <main+0xba>
      printf(1, "grep: cannot open %s\n", argv[i]);
 1a0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ae:	01 d0                	add    %edx,%eax
 1b0:	8b 00                	mov    (%eax),%eax
 1b2:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b6:	c7 44 24 04 44 0b 00 	movl   $0xb44,0x4(%esp)
 1bd:	00 
 1be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c5:	e8 87 05 00 00       	call   751 <printf>
      exit();
 1ca:	e8 05 04 00 00       	call   5d4 <exit>
    }
    grep(pattern, fd);
 1cf:	8b 44 24 14          	mov    0x14(%esp),%eax
 1d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d7:	8b 44 24 18          	mov    0x18(%esp),%eax
 1db:	89 04 24             	mov    %eax,(%esp)
 1de:	e8 1d fe ff ff       	call   0 <grep>
    close(fd);
 1e3:	8b 44 24 14          	mov    0x14(%esp),%eax
 1e7:	89 04 24             	mov    %eax,(%esp)
 1ea:	e8 0d 04 00 00       	call   5fc <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1ef:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1f4:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1f8:	3b 45 08             	cmp    0x8(%ebp),%eax
 1fb:	0f 8c 72 ff ff ff    	jl     173 <main+0x5e>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 201:	e8 ce 03 00 00       	call   5d4 <exit>

00000206 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 206:	55                   	push   %ebp
 207:	89 e5                	mov    %esp,%ebp
 209:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	0f b6 00             	movzbl (%eax),%eax
 212:	3c 5e                	cmp    $0x5e,%al
 214:	75 17                	jne    22d <match+0x27>
    return matchhere(re+1, text);
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	8d 50 01             	lea    0x1(%eax),%edx
 21c:	8b 45 0c             	mov    0xc(%ebp),%eax
 21f:	89 44 24 04          	mov    %eax,0x4(%esp)
 223:	89 14 24             	mov    %edx,(%esp)
 226:	e8 39 00 00 00       	call   264 <matchhere>
 22b:	eb 35                	jmp    262 <match+0x5c>
  do{  // must look at empty string
    if(matchhere(re, text))
 22d:	8b 45 0c             	mov    0xc(%ebp),%eax
 230:	89 44 24 04          	mov    %eax,0x4(%esp)
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	89 04 24             	mov    %eax,(%esp)
 23a:	e8 25 00 00 00       	call   264 <matchhere>
 23f:	85 c0                	test   %eax,%eax
 241:	74 07                	je     24a <match+0x44>
      return 1;
 243:	b8 01 00 00 00       	mov    $0x1,%eax
 248:	eb 18                	jmp    262 <match+0x5c>
  }while(*text++ != '\0');
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	0f 95 c0             	setne  %al
 255:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 259:	84 c0                	test   %al,%al
 25b:	75 d0                	jne    22d <match+0x27>
  return 0;
 25d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 262:	c9                   	leave  
 263:	c3                   	ret    

00000264 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	0f b6 00             	movzbl (%eax),%eax
 270:	84 c0                	test   %al,%al
 272:	75 0a                	jne    27e <matchhere+0x1a>
    return 1;
 274:	b8 01 00 00 00       	mov    $0x1,%eax
 279:	e9 9b 00 00 00       	jmp    319 <matchhere+0xb5>
  if(re[1] == '*')
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	83 c0 01             	add    $0x1,%eax
 284:	0f b6 00             	movzbl (%eax),%eax
 287:	3c 2a                	cmp    $0x2a,%al
 289:	75 24                	jne    2af <matchhere+0x4b>
    return matchstar(re[0], re+2, text);
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	8d 48 02             	lea    0x2(%eax),%ecx
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	0f be c0             	movsbl %al,%eax
 29a:	8b 55 0c             	mov    0xc(%ebp),%edx
 29d:	89 54 24 08          	mov    %edx,0x8(%esp)
 2a1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 2a5:	89 04 24             	mov    %eax,(%esp)
 2a8:	e8 6e 00 00 00       	call   31b <matchstar>
 2ad:	eb 6a                	jmp    319 <matchhere+0xb5>
  if(re[0] == '$' && re[1] == '\0')
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	0f b6 00             	movzbl (%eax),%eax
 2b5:	3c 24                	cmp    $0x24,%al
 2b7:	75 1d                	jne    2d6 <matchhere+0x72>
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	83 c0 01             	add    $0x1,%eax
 2bf:	0f b6 00             	movzbl (%eax),%eax
 2c2:	84 c0                	test   %al,%al
 2c4:	75 10                	jne    2d6 <matchhere+0x72>
    return *text == '\0';
 2c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c9:	0f b6 00             	movzbl (%eax),%eax
 2cc:	84 c0                	test   %al,%al
 2ce:	0f 94 c0             	sete   %al
 2d1:	0f b6 c0             	movzbl %al,%eax
 2d4:	eb 43                	jmp    319 <matchhere+0xb5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d9:	0f b6 00             	movzbl (%eax),%eax
 2dc:	84 c0                	test   %al,%al
 2de:	74 34                	je     314 <matchhere+0xb0>
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	0f b6 00             	movzbl (%eax),%eax
 2e6:	3c 2e                	cmp    $0x2e,%al
 2e8:	74 10                	je     2fa <matchhere+0x96>
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
 2ed:	0f b6 10             	movzbl (%eax),%edx
 2f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f3:	0f b6 00             	movzbl (%eax),%eax
 2f6:	38 c2                	cmp    %al,%dl
 2f8:	75 1a                	jne    314 <matchhere+0xb0>
    return matchhere(re+1, text+1);
 2fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fd:	8d 50 01             	lea    0x1(%eax),%edx
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	83 c0 01             	add    $0x1,%eax
 306:	89 54 24 04          	mov    %edx,0x4(%esp)
 30a:	89 04 24             	mov    %eax,(%esp)
 30d:	e8 52 ff ff ff       	call   264 <matchhere>
 312:	eb 05                	jmp    319 <matchhere+0xb5>
  return 0;
 314:	b8 00 00 00 00       	mov    $0x0,%eax
}
 319:	c9                   	leave  
 31a:	c3                   	ret    

0000031b <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 31b:	55                   	push   %ebp
 31c:	89 e5                	mov    %esp,%ebp
 31e:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 321:	8b 45 10             	mov    0x10(%ebp),%eax
 324:	89 44 24 04          	mov    %eax,0x4(%esp)
 328:	8b 45 0c             	mov    0xc(%ebp),%eax
 32b:	89 04 24             	mov    %eax,(%esp)
 32e:	e8 31 ff ff ff       	call   264 <matchhere>
 333:	85 c0                	test   %eax,%eax
 335:	74 07                	je     33e <matchstar+0x23>
      return 1;
 337:	b8 01 00 00 00       	mov    $0x1,%eax
 33c:	eb 2c                	jmp    36a <matchstar+0x4f>
  }while(*text!='\0' && (*text++==c || c=='.'));
 33e:	8b 45 10             	mov    0x10(%ebp),%eax
 341:	0f b6 00             	movzbl (%eax),%eax
 344:	84 c0                	test   %al,%al
 346:	74 1d                	je     365 <matchstar+0x4a>
 348:	8b 45 10             	mov    0x10(%ebp),%eax
 34b:	0f b6 00             	movzbl (%eax),%eax
 34e:	0f be c0             	movsbl %al,%eax
 351:	3b 45 08             	cmp    0x8(%ebp),%eax
 354:	0f 94 c0             	sete   %al
 357:	83 45 10 01          	addl   $0x1,0x10(%ebp)
 35b:	84 c0                	test   %al,%al
 35d:	75 c2                	jne    321 <matchstar+0x6>
 35f:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 363:	74 bc                	je     321 <matchstar+0x6>
  return 0;
 365:	b8 00 00 00 00       	mov    $0x0,%eax
}
 36a:	c9                   	leave  
 36b:	c3                   	ret    

0000036c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	57                   	push   %edi
 370:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 371:	8b 4d 08             	mov    0x8(%ebp),%ecx
 374:	8b 55 10             	mov    0x10(%ebp),%edx
 377:	8b 45 0c             	mov    0xc(%ebp),%eax
 37a:	89 cb                	mov    %ecx,%ebx
 37c:	89 df                	mov    %ebx,%edi
 37e:	89 d1                	mov    %edx,%ecx
 380:	fc                   	cld    
 381:	f3 aa                	rep stos %al,%es:(%edi)
 383:	89 ca                	mov    %ecx,%edx
 385:	89 fb                	mov    %edi,%ebx
 387:	89 5d 08             	mov    %ebx,0x8(%ebp)
 38a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 38d:	5b                   	pop    %ebx
 38e:	5f                   	pop    %edi
 38f:	5d                   	pop    %ebp
 390:	c3                   	ret    

00000391 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 391:	55                   	push   %ebp
 392:	89 e5                	mov    %esp,%ebp
 394:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 397:	8b 45 08             	mov    0x8(%ebp),%eax
 39a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 39d:	90                   	nop
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	0f b6 10             	movzbl (%eax),%edx
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	88 10                	mov    %dl,(%eax)
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ac:	0f b6 00             	movzbl (%eax),%eax
 3af:	84 c0                	test   %al,%al
 3b1:	0f 95 c0             	setne  %al
 3b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3b8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 3bc:	84 c0                	test   %al,%al
 3be:	75 de                	jne    39e <strcpy+0xd>
    ;
  return os;
 3c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3c3:	c9                   	leave  
 3c4:	c3                   	ret    

000003c5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3c5:	55                   	push   %ebp
 3c6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3c8:	eb 08                	jmp    3d2 <strcmp+0xd>
    p++, q++;
 3ca:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3ce:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3d2:	8b 45 08             	mov    0x8(%ebp),%eax
 3d5:	0f b6 00             	movzbl (%eax),%eax
 3d8:	84 c0                	test   %al,%al
 3da:	74 10                	je     3ec <strcmp+0x27>
 3dc:	8b 45 08             	mov    0x8(%ebp),%eax
 3df:	0f b6 10             	movzbl (%eax),%edx
 3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e5:	0f b6 00             	movzbl (%eax),%eax
 3e8:	38 c2                	cmp    %al,%dl
 3ea:	74 de                	je     3ca <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3ec:	8b 45 08             	mov    0x8(%ebp),%eax
 3ef:	0f b6 00             	movzbl (%eax),%eax
 3f2:	0f b6 d0             	movzbl %al,%edx
 3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f8:	0f b6 00             	movzbl (%eax),%eax
 3fb:	0f b6 c0             	movzbl %al,%eax
 3fe:	89 d1                	mov    %edx,%ecx
 400:	29 c1                	sub    %eax,%ecx
 402:	89 c8                	mov    %ecx,%eax
}
 404:	5d                   	pop    %ebp
 405:	c3                   	ret    

00000406 <strlen>:

uint
strlen(char *s)
{
 406:	55                   	push   %ebp
 407:	89 e5                	mov    %esp,%ebp
 409:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 40c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 413:	eb 04                	jmp    419 <strlen+0x13>
 415:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 419:	8b 55 fc             	mov    -0x4(%ebp),%edx
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	01 d0                	add    %edx,%eax
 421:	0f b6 00             	movzbl (%eax),%eax
 424:	84 c0                	test   %al,%al
 426:	75 ed                	jne    415 <strlen+0xf>
    ;
  return n;
 428:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 42b:	c9                   	leave  
 42c:	c3                   	ret    

0000042d <memset>:

void*
memset(void *dst, int c, uint n)
{
 42d:	55                   	push   %ebp
 42e:	89 e5                	mov    %esp,%ebp
 430:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 433:	8b 45 10             	mov    0x10(%ebp),%eax
 436:	89 44 24 08          	mov    %eax,0x8(%esp)
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	89 44 24 04          	mov    %eax,0x4(%esp)
 441:	8b 45 08             	mov    0x8(%ebp),%eax
 444:	89 04 24             	mov    %eax,(%esp)
 447:	e8 20 ff ff ff       	call   36c <stosb>
  return dst;
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 44f:	c9                   	leave  
 450:	c3                   	ret    

00000451 <strchr>:

char*
strchr(const char *s, char c)
{
 451:	55                   	push   %ebp
 452:	89 e5                	mov    %esp,%ebp
 454:	83 ec 04             	sub    $0x4,%esp
 457:	8b 45 0c             	mov    0xc(%ebp),%eax
 45a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 45d:	eb 14                	jmp    473 <strchr+0x22>
    if(*s == c)
 45f:	8b 45 08             	mov    0x8(%ebp),%eax
 462:	0f b6 00             	movzbl (%eax),%eax
 465:	3a 45 fc             	cmp    -0x4(%ebp),%al
 468:	75 05                	jne    46f <strchr+0x1e>
      return (char*)s;
 46a:	8b 45 08             	mov    0x8(%ebp),%eax
 46d:	eb 13                	jmp    482 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 46f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 473:	8b 45 08             	mov    0x8(%ebp),%eax
 476:	0f b6 00             	movzbl (%eax),%eax
 479:	84 c0                	test   %al,%al
 47b:	75 e2                	jne    45f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 47d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 482:	c9                   	leave  
 483:	c3                   	ret    

00000484 <gets>:

char*
gets(char *buf, int max)
{
 484:	55                   	push   %ebp
 485:	89 e5                	mov    %esp,%ebp
 487:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 48a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 491:	eb 46                	jmp    4d9 <gets+0x55>
    cc = read(0, &c, 1);
 493:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 49a:	00 
 49b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 49e:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4a9:	e8 3e 01 00 00       	call   5ec <read>
 4ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 4b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b5:	7e 2f                	jle    4e6 <gets+0x62>
      break;
    buf[i++] = c;
 4b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4ba:	8b 45 08             	mov    0x8(%ebp),%eax
 4bd:	01 c2                	add    %eax,%edx
 4bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4c3:	88 02                	mov    %al,(%edx)
 4c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 4c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4cd:	3c 0a                	cmp    $0xa,%al
 4cf:	74 16                	je     4e7 <gets+0x63>
 4d1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4d5:	3c 0d                	cmp    $0xd,%al
 4d7:	74 0e                	je     4e7 <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4dc:	83 c0 01             	add    $0x1,%eax
 4df:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4e2:	7c af                	jl     493 <gets+0xf>
 4e4:	eb 01                	jmp    4e7 <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 4e6:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4ea:	8b 45 08             	mov    0x8(%ebp),%eax
 4ed:	01 d0                	add    %edx,%eax
 4ef:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4f5:	c9                   	leave  
 4f6:	c3                   	ret    

000004f7 <stat>:

int
stat(char *n, struct stat *st)
{
 4f7:	55                   	push   %ebp
 4f8:	89 e5                	mov    %esp,%ebp
 4fa:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 504:	00 
 505:	8b 45 08             	mov    0x8(%ebp),%eax
 508:	89 04 24             	mov    %eax,(%esp)
 50b:	e8 04 01 00 00       	call   614 <open>
 510:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 517:	79 07                	jns    520 <stat+0x29>
    return -1;
 519:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 51e:	eb 23                	jmp    543 <stat+0x4c>
  r = fstat(fd, st);
 520:	8b 45 0c             	mov    0xc(%ebp),%eax
 523:	89 44 24 04          	mov    %eax,0x4(%esp)
 527:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52a:	89 04 24             	mov    %eax,(%esp)
 52d:	e8 fa 00 00 00       	call   62c <fstat>
 532:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 535:	8b 45 f4             	mov    -0xc(%ebp),%eax
 538:	89 04 24             	mov    %eax,(%esp)
 53b:	e8 bc 00 00 00       	call   5fc <close>
  return r;
 540:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 543:	c9                   	leave  
 544:	c3                   	ret    

00000545 <atoi>:

int
atoi(const char *s)
{
 545:	55                   	push   %ebp
 546:	89 e5                	mov    %esp,%ebp
 548:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 54b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 552:	eb 23                	jmp    577 <atoi+0x32>
    n = n*10 + *s++ - '0';
 554:	8b 55 fc             	mov    -0x4(%ebp),%edx
 557:	89 d0                	mov    %edx,%eax
 559:	c1 e0 02             	shl    $0x2,%eax
 55c:	01 d0                	add    %edx,%eax
 55e:	01 c0                	add    %eax,%eax
 560:	89 c2                	mov    %eax,%edx
 562:	8b 45 08             	mov    0x8(%ebp),%eax
 565:	0f b6 00             	movzbl (%eax),%eax
 568:	0f be c0             	movsbl %al,%eax
 56b:	01 d0                	add    %edx,%eax
 56d:	83 e8 30             	sub    $0x30,%eax
 570:	89 45 fc             	mov    %eax,-0x4(%ebp)
 573:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 577:	8b 45 08             	mov    0x8(%ebp),%eax
 57a:	0f b6 00             	movzbl (%eax),%eax
 57d:	3c 2f                	cmp    $0x2f,%al
 57f:	7e 0a                	jle    58b <atoi+0x46>
 581:	8b 45 08             	mov    0x8(%ebp),%eax
 584:	0f b6 00             	movzbl (%eax),%eax
 587:	3c 39                	cmp    $0x39,%al
 589:	7e c9                	jle    554 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 58b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 58e:	c9                   	leave  
 58f:	c3                   	ret    

00000590 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 596:	8b 45 08             	mov    0x8(%ebp),%eax
 599:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 59c:	8b 45 0c             	mov    0xc(%ebp),%eax
 59f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 5a2:	eb 13                	jmp    5b7 <memmove+0x27>
    *dst++ = *src++;
 5a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5a7:	0f b6 10             	movzbl (%eax),%edx
 5aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ad:	88 10                	mov    %dl,(%eax)
 5af:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 5b3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5b7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 5bb:	0f 9f c0             	setg   %al
 5be:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 5c2:	84 c0                	test   %al,%al
 5c4:	75 de                	jne    5a4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5c9:	c9                   	leave  
 5ca:	c3                   	ret    
 5cb:	90                   	nop

000005cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5cc:	b8 01 00 00 00       	mov    $0x1,%eax
 5d1:	cd 40                	int    $0x40
 5d3:	c3                   	ret    

000005d4 <exit>:
SYSCALL(exit)
 5d4:	b8 02 00 00 00       	mov    $0x2,%eax
 5d9:	cd 40                	int    $0x40
 5db:	c3                   	ret    

000005dc <wait>:
SYSCALL(wait)
 5dc:	b8 03 00 00 00       	mov    $0x3,%eax
 5e1:	cd 40                	int    $0x40
 5e3:	c3                   	ret    

000005e4 <pipe>:
SYSCALL(pipe)
 5e4:	b8 04 00 00 00       	mov    $0x4,%eax
 5e9:	cd 40                	int    $0x40
 5eb:	c3                   	ret    

000005ec <read>:
SYSCALL(read)
 5ec:	b8 05 00 00 00       	mov    $0x5,%eax
 5f1:	cd 40                	int    $0x40
 5f3:	c3                   	ret    

000005f4 <write>:
SYSCALL(write)
 5f4:	b8 10 00 00 00       	mov    $0x10,%eax
 5f9:	cd 40                	int    $0x40
 5fb:	c3                   	ret    

000005fc <close>:
SYSCALL(close)
 5fc:	b8 15 00 00 00       	mov    $0x15,%eax
 601:	cd 40                	int    $0x40
 603:	c3                   	ret    

00000604 <kill>:
SYSCALL(kill)
 604:	b8 06 00 00 00       	mov    $0x6,%eax
 609:	cd 40                	int    $0x40
 60b:	c3                   	ret    

0000060c <exec>:
SYSCALL(exec)
 60c:	b8 07 00 00 00       	mov    $0x7,%eax
 611:	cd 40                	int    $0x40
 613:	c3                   	ret    

00000614 <open>:
SYSCALL(open)
 614:	b8 0f 00 00 00       	mov    $0xf,%eax
 619:	cd 40                	int    $0x40
 61b:	c3                   	ret    

0000061c <mknod>:
SYSCALL(mknod)
 61c:	b8 11 00 00 00       	mov    $0x11,%eax
 621:	cd 40                	int    $0x40
 623:	c3                   	ret    

00000624 <unlink>:
SYSCALL(unlink)
 624:	b8 12 00 00 00       	mov    $0x12,%eax
 629:	cd 40                	int    $0x40
 62b:	c3                   	ret    

0000062c <fstat>:
SYSCALL(fstat)
 62c:	b8 08 00 00 00       	mov    $0x8,%eax
 631:	cd 40                	int    $0x40
 633:	c3                   	ret    

00000634 <link>:
SYSCALL(link)
 634:	b8 13 00 00 00       	mov    $0x13,%eax
 639:	cd 40                	int    $0x40
 63b:	c3                   	ret    

0000063c <mkdir>:
SYSCALL(mkdir)
 63c:	b8 14 00 00 00       	mov    $0x14,%eax
 641:	cd 40                	int    $0x40
 643:	c3                   	ret    

00000644 <chdir>:
SYSCALL(chdir)
 644:	b8 09 00 00 00       	mov    $0x9,%eax
 649:	cd 40                	int    $0x40
 64b:	c3                   	ret    

0000064c <dup>:
SYSCALL(dup)
 64c:	b8 0a 00 00 00       	mov    $0xa,%eax
 651:	cd 40                	int    $0x40
 653:	c3                   	ret    

00000654 <getpid>:
SYSCALL(getpid)
 654:	b8 0b 00 00 00       	mov    $0xb,%eax
 659:	cd 40                	int    $0x40
 65b:	c3                   	ret    

0000065c <sbrk>:
SYSCALL(sbrk)
 65c:	b8 0c 00 00 00       	mov    $0xc,%eax
 661:	cd 40                	int    $0x40
 663:	c3                   	ret    

00000664 <sleep>:
SYSCALL(sleep)
 664:	b8 0d 00 00 00       	mov    $0xd,%eax
 669:	cd 40                	int    $0x40
 66b:	c3                   	ret    

0000066c <uptime>:
SYSCALL(uptime)
 66c:	b8 0e 00 00 00       	mov    $0xe,%eax
 671:	cd 40                	int    $0x40
 673:	c3                   	ret    

00000674 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	83 ec 28             	sub    $0x28,%esp
 67a:	8b 45 0c             	mov    0xc(%ebp),%eax
 67d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 680:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 687:	00 
 688:	8d 45 f4             	lea    -0xc(%ebp),%eax
 68b:	89 44 24 04          	mov    %eax,0x4(%esp)
 68f:	8b 45 08             	mov    0x8(%ebp),%eax
 692:	89 04 24             	mov    %eax,(%esp)
 695:	e8 5a ff ff ff       	call   5f4 <write>
}
 69a:	c9                   	leave  
 69b:	c3                   	ret    

0000069c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 69c:	55                   	push   %ebp
 69d:	89 e5                	mov    %esp,%ebp
 69f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6a9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6ad:	74 17                	je     6c6 <printint+0x2a>
 6af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6b3:	79 11                	jns    6c6 <printint+0x2a>
    neg = 1;
 6b5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 6bf:	f7 d8                	neg    %eax
 6c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6c4:	eb 06                	jmp    6cc <printint+0x30>
  } else {
    x = xx;
 6c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6d9:	ba 00 00 00 00       	mov    $0x0,%edx
 6de:	f7 f1                	div    %ecx
 6e0:	89 d0                	mov    %edx,%eax
 6e2:	0f b6 80 20 0e 00 00 	movzbl 0xe20(%eax),%eax
 6e9:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 6ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6ef:	01 ca                	add    %ecx,%edx
 6f1:	88 02                	mov    %al,(%edx)
 6f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 6f7:	8b 55 10             	mov    0x10(%ebp),%edx
 6fa:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 6fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 700:	ba 00 00 00 00       	mov    $0x0,%edx
 705:	f7 75 d4             	divl   -0x2c(%ebp)
 708:	89 45 ec             	mov    %eax,-0x14(%ebp)
 70b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 70f:	75 c2                	jne    6d3 <printint+0x37>
  if(neg)
 711:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 715:	74 2e                	je     745 <printint+0xa9>
    buf[i++] = '-';
 717:	8d 55 dc             	lea    -0x24(%ebp),%edx
 71a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71d:	01 d0                	add    %edx,%eax
 71f:	c6 00 2d             	movb   $0x2d,(%eax)
 722:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 726:	eb 1d                	jmp    745 <printint+0xa9>
    putc(fd, buf[i]);
 728:	8d 55 dc             	lea    -0x24(%ebp),%edx
 72b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72e:	01 d0                	add    %edx,%eax
 730:	0f b6 00             	movzbl (%eax),%eax
 733:	0f be c0             	movsbl %al,%eax
 736:	89 44 24 04          	mov    %eax,0x4(%esp)
 73a:	8b 45 08             	mov    0x8(%ebp),%eax
 73d:	89 04 24             	mov    %eax,(%esp)
 740:	e8 2f ff ff ff       	call   674 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 745:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 749:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 74d:	79 d9                	jns    728 <printint+0x8c>
    putc(fd, buf[i]);
}
 74f:	c9                   	leave  
 750:	c3                   	ret    

00000751 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 751:	55                   	push   %ebp
 752:	89 e5                	mov    %esp,%ebp
 754:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 757:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 75e:	8d 45 0c             	lea    0xc(%ebp),%eax
 761:	83 c0 04             	add    $0x4,%eax
 764:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 767:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 76e:	e9 7d 01 00 00       	jmp    8f0 <printf+0x19f>
    c = fmt[i] & 0xff;
 773:	8b 55 0c             	mov    0xc(%ebp),%edx
 776:	8b 45 f0             	mov    -0x10(%ebp),%eax
 779:	01 d0                	add    %edx,%eax
 77b:	0f b6 00             	movzbl (%eax),%eax
 77e:	0f be c0             	movsbl %al,%eax
 781:	25 ff 00 00 00       	and    $0xff,%eax
 786:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 789:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 78d:	75 2c                	jne    7bb <printf+0x6a>
      if(c == '%'){
 78f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 793:	75 0c                	jne    7a1 <printf+0x50>
        state = '%';
 795:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 79c:	e9 4b 01 00 00       	jmp    8ec <printf+0x19b>
      } else {
        putc(fd, c);
 7a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7a4:	0f be c0             	movsbl %al,%eax
 7a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ab:	8b 45 08             	mov    0x8(%ebp),%eax
 7ae:	89 04 24             	mov    %eax,(%esp)
 7b1:	e8 be fe ff ff       	call   674 <putc>
 7b6:	e9 31 01 00 00       	jmp    8ec <printf+0x19b>
      }
    } else if(state == '%'){
 7bb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7bf:	0f 85 27 01 00 00    	jne    8ec <printf+0x19b>
      if(c == 'd'){
 7c5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7c9:	75 2d                	jne    7f8 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 7cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ce:	8b 00                	mov    (%eax),%eax
 7d0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7d7:	00 
 7d8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7df:	00 
 7e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e4:	8b 45 08             	mov    0x8(%ebp),%eax
 7e7:	89 04 24             	mov    %eax,(%esp)
 7ea:	e8 ad fe ff ff       	call   69c <printint>
        ap++;
 7ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f3:	e9 ed 00 00 00       	jmp    8e5 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 7f8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7fc:	74 06                	je     804 <printf+0xb3>
 7fe:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 802:	75 2d                	jne    831 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 804:	8b 45 e8             	mov    -0x18(%ebp),%eax
 807:	8b 00                	mov    (%eax),%eax
 809:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 810:	00 
 811:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 818:	00 
 819:	89 44 24 04          	mov    %eax,0x4(%esp)
 81d:	8b 45 08             	mov    0x8(%ebp),%eax
 820:	89 04 24             	mov    %eax,(%esp)
 823:	e8 74 fe ff ff       	call   69c <printint>
        ap++;
 828:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 82c:	e9 b4 00 00 00       	jmp    8e5 <printf+0x194>
      } else if(c == 's'){
 831:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 835:	75 46                	jne    87d <printf+0x12c>
        s = (char*)*ap;
 837:	8b 45 e8             	mov    -0x18(%ebp),%eax
 83a:	8b 00                	mov    (%eax),%eax
 83c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 83f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 843:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 847:	75 27                	jne    870 <printf+0x11f>
          s = "(null)";
 849:	c7 45 f4 5a 0b 00 00 	movl   $0xb5a,-0xc(%ebp)
        while(*s != 0){
 850:	eb 1e                	jmp    870 <printf+0x11f>
          putc(fd, *s);
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	0f b6 00             	movzbl (%eax),%eax
 858:	0f be c0             	movsbl %al,%eax
 85b:	89 44 24 04          	mov    %eax,0x4(%esp)
 85f:	8b 45 08             	mov    0x8(%ebp),%eax
 862:	89 04 24             	mov    %eax,(%esp)
 865:	e8 0a fe ff ff       	call   674 <putc>
          s++;
 86a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 86e:	eb 01                	jmp    871 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 870:	90                   	nop
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	0f b6 00             	movzbl (%eax),%eax
 877:	84 c0                	test   %al,%al
 879:	75 d7                	jne    852 <printf+0x101>
 87b:	eb 68                	jmp    8e5 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 87d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 881:	75 1d                	jne    8a0 <printf+0x14f>
        putc(fd, *ap);
 883:	8b 45 e8             	mov    -0x18(%ebp),%eax
 886:	8b 00                	mov    (%eax),%eax
 888:	0f be c0             	movsbl %al,%eax
 88b:	89 44 24 04          	mov    %eax,0x4(%esp)
 88f:	8b 45 08             	mov    0x8(%ebp),%eax
 892:	89 04 24             	mov    %eax,(%esp)
 895:	e8 da fd ff ff       	call   674 <putc>
        ap++;
 89a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 89e:	eb 45                	jmp    8e5 <printf+0x194>
      } else if(c == '%'){
 8a0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8a4:	75 17                	jne    8bd <printf+0x16c>
        putc(fd, c);
 8a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8a9:	0f be c0             	movsbl %al,%eax
 8ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b0:	8b 45 08             	mov    0x8(%ebp),%eax
 8b3:	89 04 24             	mov    %eax,(%esp)
 8b6:	e8 b9 fd ff ff       	call   674 <putc>
 8bb:	eb 28                	jmp    8e5 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8bd:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 8c4:	00 
 8c5:	8b 45 08             	mov    0x8(%ebp),%eax
 8c8:	89 04 24             	mov    %eax,(%esp)
 8cb:	e8 a4 fd ff ff       	call   674 <putc>
        putc(fd, c);
 8d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8d3:	0f be c0             	movsbl %al,%eax
 8d6:	89 44 24 04          	mov    %eax,0x4(%esp)
 8da:	8b 45 08             	mov    0x8(%ebp),%eax
 8dd:	89 04 24             	mov    %eax,(%esp)
 8e0:	e8 8f fd ff ff       	call   674 <putc>
      }
      state = 0;
 8e5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8ec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8f0:	8b 55 0c             	mov    0xc(%ebp),%edx
 8f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f6:	01 d0                	add    %edx,%eax
 8f8:	0f b6 00             	movzbl (%eax),%eax
 8fb:	84 c0                	test   %al,%al
 8fd:	0f 85 70 fe ff ff    	jne    773 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 903:	c9                   	leave  
 904:	c3                   	ret    
 905:	90                   	nop
 906:	90                   	nop
 907:	90                   	nop

00000908 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 908:	55                   	push   %ebp
 909:	89 e5                	mov    %esp,%ebp
 90b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 90e:	8b 45 08             	mov    0x8(%ebp),%eax
 911:	83 e8 08             	sub    $0x8,%eax
 914:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 917:	a1 48 0e 00 00       	mov    0xe48,%eax
 91c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 91f:	eb 24                	jmp    945 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 921:	8b 45 fc             	mov    -0x4(%ebp),%eax
 924:	8b 00                	mov    (%eax),%eax
 926:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 929:	77 12                	ja     93d <free+0x35>
 92b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 92e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 931:	77 24                	ja     957 <free+0x4f>
 933:	8b 45 fc             	mov    -0x4(%ebp),%eax
 936:	8b 00                	mov    (%eax),%eax
 938:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 93b:	77 1a                	ja     957 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 940:	8b 00                	mov    (%eax),%eax
 942:	89 45 fc             	mov    %eax,-0x4(%ebp)
 945:	8b 45 f8             	mov    -0x8(%ebp),%eax
 948:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 94b:	76 d4                	jbe    921 <free+0x19>
 94d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 950:	8b 00                	mov    (%eax),%eax
 952:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 955:	76 ca                	jbe    921 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 957:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95a:	8b 40 04             	mov    0x4(%eax),%eax
 95d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 964:	8b 45 f8             	mov    -0x8(%ebp),%eax
 967:	01 c2                	add    %eax,%edx
 969:	8b 45 fc             	mov    -0x4(%ebp),%eax
 96c:	8b 00                	mov    (%eax),%eax
 96e:	39 c2                	cmp    %eax,%edx
 970:	75 24                	jne    996 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 972:	8b 45 f8             	mov    -0x8(%ebp),%eax
 975:	8b 50 04             	mov    0x4(%eax),%edx
 978:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97b:	8b 00                	mov    (%eax),%eax
 97d:	8b 40 04             	mov    0x4(%eax),%eax
 980:	01 c2                	add    %eax,%edx
 982:	8b 45 f8             	mov    -0x8(%ebp),%eax
 985:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 988:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98b:	8b 00                	mov    (%eax),%eax
 98d:	8b 10                	mov    (%eax),%edx
 98f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 992:	89 10                	mov    %edx,(%eax)
 994:	eb 0a                	jmp    9a0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 996:	8b 45 fc             	mov    -0x4(%ebp),%eax
 999:	8b 10                	mov    (%eax),%edx
 99b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a3:	8b 40 04             	mov    0x4(%eax),%eax
 9a6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b0:	01 d0                	add    %edx,%eax
 9b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9b5:	75 20                	jne    9d7 <free+0xcf>
    p->s.size += bp->s.size;
 9b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ba:	8b 50 04             	mov    0x4(%eax),%edx
 9bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c0:	8b 40 04             	mov    0x4(%eax),%eax
 9c3:	01 c2                	add    %eax,%edx
 9c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ce:	8b 10                	mov    (%eax),%edx
 9d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d3:	89 10                	mov    %edx,(%eax)
 9d5:	eb 08                	jmp    9df <free+0xd7>
  } else
    p->s.ptr = bp;
 9d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9da:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9dd:	89 10                	mov    %edx,(%eax)
  freep = p;
 9df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e2:	a3 48 0e 00 00       	mov    %eax,0xe48
}
 9e7:	c9                   	leave  
 9e8:	c3                   	ret    

000009e9 <morecore>:

static Header*
morecore(uint nu)
{
 9e9:	55                   	push   %ebp
 9ea:	89 e5                	mov    %esp,%ebp
 9ec:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9ef:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9f6:	77 07                	ja     9ff <morecore+0x16>
    nu = 4096;
 9f8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9ff:	8b 45 08             	mov    0x8(%ebp),%eax
 a02:	c1 e0 03             	shl    $0x3,%eax
 a05:	89 04 24             	mov    %eax,(%esp)
 a08:	e8 4f fc ff ff       	call   65c <sbrk>
 a0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a10:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a14:	75 07                	jne    a1d <morecore+0x34>
    return 0;
 a16:	b8 00 00 00 00       	mov    $0x0,%eax
 a1b:	eb 22                	jmp    a3f <morecore+0x56>
  hp = (Header*)p;
 a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a26:	8b 55 08             	mov    0x8(%ebp),%edx
 a29:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2f:	83 c0 08             	add    $0x8,%eax
 a32:	89 04 24             	mov    %eax,(%esp)
 a35:	e8 ce fe ff ff       	call   908 <free>
  return freep;
 a3a:	a1 48 0e 00 00       	mov    0xe48,%eax
}
 a3f:	c9                   	leave  
 a40:	c3                   	ret    

00000a41 <malloc>:

void*
malloc(uint nbytes)
{
 a41:	55                   	push   %ebp
 a42:	89 e5                	mov    %esp,%ebp
 a44:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a47:	8b 45 08             	mov    0x8(%ebp),%eax
 a4a:	83 c0 07             	add    $0x7,%eax
 a4d:	c1 e8 03             	shr    $0x3,%eax
 a50:	83 c0 01             	add    $0x1,%eax
 a53:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a56:	a1 48 0e 00 00       	mov    0xe48,%eax
 a5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a5e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a62:	75 23                	jne    a87 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a64:	c7 45 f0 40 0e 00 00 	movl   $0xe40,-0x10(%ebp)
 a6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a6e:	a3 48 0e 00 00       	mov    %eax,0xe48
 a73:	a1 48 0e 00 00       	mov    0xe48,%eax
 a78:	a3 40 0e 00 00       	mov    %eax,0xe40
    base.s.size = 0;
 a7d:	c7 05 44 0e 00 00 00 	movl   $0x0,0xe44
 a84:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a8a:	8b 00                	mov    (%eax),%eax
 a8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a92:	8b 40 04             	mov    0x4(%eax),%eax
 a95:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a98:	72 4d                	jb     ae7 <malloc+0xa6>
      if(p->s.size == nunits)
 a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a9d:	8b 40 04             	mov    0x4(%eax),%eax
 aa0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aa3:	75 0c                	jne    ab1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa8:	8b 10                	mov    (%eax),%edx
 aaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aad:	89 10                	mov    %edx,(%eax)
 aaf:	eb 26                	jmp    ad7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab4:	8b 40 04             	mov    0x4(%eax),%eax
 ab7:	89 c2                	mov    %eax,%edx
 ab9:	2b 55 ec             	sub    -0x14(%ebp),%edx
 abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac5:	8b 40 04             	mov    0x4(%eax),%eax
 ac8:	c1 e0 03             	shl    $0x3,%eax
 acb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ad4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ada:	a3 48 0e 00 00       	mov    %eax,0xe48
      return (void*)(p + 1);
 adf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae2:	83 c0 08             	add    $0x8,%eax
 ae5:	eb 38                	jmp    b1f <malloc+0xde>
    }
    if(p == freep)
 ae7:	a1 48 0e 00 00       	mov    0xe48,%eax
 aec:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 aef:	75 1b                	jne    b0c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 af1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 af4:	89 04 24             	mov    %eax,(%esp)
 af7:	e8 ed fe ff ff       	call   9e9 <morecore>
 afc:	89 45 f4             	mov    %eax,-0xc(%ebp)
 aff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b03:	75 07                	jne    b0c <malloc+0xcb>
        return 0;
 b05:	b8 00 00 00 00       	mov    $0x0,%eax
 b0a:	eb 13                	jmp    b1f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b15:	8b 00                	mov    (%eax),%eax
 b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b1a:	e9 70 ff ff ff       	jmp    a8f <malloc+0x4e>
}
 b1f:	c9                   	leave  
 b20:	c3                   	ret    
