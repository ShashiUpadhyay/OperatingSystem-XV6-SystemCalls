
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
  1b:	05 80 10 00 00       	add    $0x1080,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 80 10 00 00 	movl   $0x1080,-0x10(%ebp)
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
  71:	e8 aa 06 00 00       	call   720 <write>
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
  9b:	81 7d f0 80 10 00 00 	cmpl   $0x1080,-0x10(%ebp)
  a2:	75 07                	jne    ab <grep+0xab>
      m = 0;
  a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  af:	7e 2b                	jle    dc <grep+0xdc>
      m -= p - buf;
  b1:	ba 80 10 00 00       	mov    $0x1080,%edx
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
  d0:	c7 04 24 80 10 00 00 	movl   $0x1080,(%esp)
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
  ed:	81 c2 80 10 00 00    	add    $0x1080,%edx
  f3:	89 44 24 08          	mov    %eax,0x8(%esp)
  f7:	89 54 24 04          	mov    %edx,0x4(%esp)
  fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 12 06 00 00       	call   718 <read>
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
 124:	c7 44 24 04 48 0d 00 	movl   $0xd48,0x4(%esp)
 12b:	00 
 12c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 133:	e8 3d 08 00 00       	call   975 <printf>
    exit();
 138:	e8 c3 05 00 00       	call   700 <exit>
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
 161:	e8 9a 05 00 00       	call   700 <exit>
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
 190:	e8 ab 05 00 00       	call   740 <open>
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
 1b6:	c7 44 24 04 68 0d 00 	movl   $0xd68,0x4(%esp)
 1bd:	00 
 1be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c5:	e8 ab 07 00 00       	call   975 <printf>
      exit();
 1ca:	e8 31 05 00 00       	call   700 <exit>
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
 1ea:	e8 39 05 00 00       	call   728 <close>
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
 201:	e8 fa 04 00 00       	call   700 <exit>

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
 4a9:	e8 6a 02 00 00       	call   718 <read>
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
 50b:	e8 30 02 00 00       	call   740 <open>
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
 52d:	e8 26 02 00 00       	call   758 <fstat>
 532:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 535:	8b 45 f4             	mov    -0xc(%ebp),%eax
 538:	89 04 24             	mov    %eax,(%esp)
 53b:	e8 e8 01 00 00       	call   728 <close>
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

000005cc <SYS_ls_call01>:
 5cc:	6c                   	insb   (%dx),%es:(%edi)
 5cd:	73 5f                	jae    62e <SYS_ls_call10+0x8>
 5cf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5d2:	6c                   	insb   (%dx),%es:(%edi)
 5d3:	30 31                	xor    %dh,(%ecx)
	...

000005d6 <SYS_ls_call02>:
 5d6:	6c                   	insb   (%dx),%es:(%edi)
 5d7:	73 5f                	jae    638 <SYS_ls_call11+0x8>
 5d9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5dc:	6c                   	insb   (%dx),%es:(%edi)
 5dd:	30 32                	xor    %dh,(%edx)
	...

000005e0 <SYS_ls_call03>:
 5e0:	6c                   	insb   (%dx),%es:(%edi)
 5e1:	73 5f                	jae    642 <SYS_ls_call12+0x8>
 5e3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5e6:	6c                   	insb   (%dx),%es:(%edi)
 5e7:	30 33                	xor    %dh,(%ebx)
	...

000005ea <SYS_ls_call04>:
 5ea:	6c                   	insb   (%dx),%es:(%edi)
 5eb:	73 5f                	jae    64c <SYS_ls_call13+0x8>
 5ed:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5f0:	6c                   	insb   (%dx),%es:(%edi)
 5f1:	30 34 00             	xor    %dh,(%eax,%eax,1)

000005f4 <SYS_ls_call05>:
 5f4:	6c                   	insb   (%dx),%es:(%edi)
 5f5:	73 5f                	jae    656 <SYS_ls_call14+0x8>
 5f7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5fa:	6c                   	insb   (%dx),%es:(%edi)
 5fb:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

000005fe <SYS_ls_call06>:
 5fe:	6c                   	insb   (%dx),%es:(%edi)
 5ff:	73 5f                	jae    660 <SYS_ls_call15+0x8>
 601:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 604:	6c                   	insb   (%dx),%es:(%edi)
 605:	30 36                	xor    %dh,(%esi)
	...

00000608 <SYS_ls_call07>:
 608:	6c                   	insb   (%dx),%es:(%edi)
 609:	73 5f                	jae    66a <SYS_ls_call16+0x8>
 60b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 60e:	6c                   	insb   (%dx),%es:(%edi)
 60f:	30 37                	xor    %dh,(%edi)
	...

00000612 <SYS_ls_call08>:
 612:	6c                   	insb   (%dx),%es:(%edi)
 613:	73 5f                	jae    674 <SYS_ls_call17+0x8>
 615:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 618:	6c                   	insb   (%dx),%es:(%edi)
 619:	30 38                	xor    %bh,(%eax)
	...

0000061c <SYS_ls_call09>:
 61c:	6c                   	insb   (%dx),%es:(%edi)
 61d:	73 5f                	jae    67e <SYS_ls_call18+0x8>
 61f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 622:	6c                   	insb   (%dx),%es:(%edi)
 623:	30 39                	xor    %bh,(%ecx)
	...

00000626 <SYS_ls_call10>:
 626:	6c                   	insb   (%dx),%es:(%edi)
 627:	73 5f                	jae    688 <SYS_ls_call19+0x8>
 629:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 62c:	6c                   	insb   (%dx),%es:(%edi)
 62d:	31 30                	xor    %esi,(%eax)
	...

00000630 <SYS_ls_call11>:
 630:	6c                   	insb   (%dx),%es:(%edi)
 631:	73 5f                	jae    692 <SYS_ls_call20+0x8>
 633:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 636:	6c                   	insb   (%dx),%es:(%edi)
 637:	31 31                	xor    %esi,(%ecx)
	...

0000063a <SYS_ls_call12>:
 63a:	6c                   	insb   (%dx),%es:(%edi)
 63b:	73 5f                	jae    69c <SYS_ls_call21+0x8>
 63d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 640:	6c                   	insb   (%dx),%es:(%edi)
 641:	31 32                	xor    %esi,(%edx)
	...

00000644 <SYS_ls_call13>:
 644:	6c                   	insb   (%dx),%es:(%edi)
 645:	73 5f                	jae    6a6 <SYS_ls_call22+0x8>
 647:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 64a:	6c                   	insb   (%dx),%es:(%edi)
 64b:	31 33                	xor    %esi,(%ebx)
	...

0000064e <SYS_ls_call14>:
 64e:	6c                   	insb   (%dx),%es:(%edi)
 64f:	73 5f                	jae    6b0 <SYS_ls_call23+0x8>
 651:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 654:	6c                   	insb   (%dx),%es:(%edi)
 655:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000658 <SYS_ls_call15>:
 658:	6c                   	insb   (%dx),%es:(%edi)
 659:	73 5f                	jae    6ba <SYS_ls_call24+0x8>
 65b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 65e:	6c                   	insb   (%dx),%es:(%edi)
 65f:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000662 <SYS_ls_call16>:
 662:	6c                   	insb   (%dx),%es:(%edi)
 663:	73 5f                	jae    6c4 <SYS_ls_call25+0x8>
 665:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 668:	6c                   	insb   (%dx),%es:(%edi)
 669:	31 36                	xor    %esi,(%esi)
	...

0000066c <SYS_ls_call17>:
 66c:	6c                   	insb   (%dx),%es:(%edi)
 66d:	73 5f                	jae    6ce <SYS_ls_call26+0x8>
 66f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 672:	6c                   	insb   (%dx),%es:(%edi)
 673:	31 37                	xor    %esi,(%edi)
	...

00000676 <SYS_ls_call18>:
 676:	6c                   	insb   (%dx),%es:(%edi)
 677:	73 5f                	jae    6d8 <SYS_ls_call27+0x8>
 679:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 67c:	6c                   	insb   (%dx),%es:(%edi)
 67d:	31 38                	xor    %edi,(%eax)
	...

00000680 <SYS_ls_call19>:
 680:	6c                   	insb   (%dx),%es:(%edi)
 681:	73 5f                	jae    6e2 <SYS_ls_call28+0x8>
 683:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 686:	6c                   	insb   (%dx),%es:(%edi)
 687:	31 39                	xor    %edi,(%ecx)
	...

0000068a <SYS_ls_call20>:
 68a:	6c                   	insb   (%dx),%es:(%edi)
 68b:	73 5f                	jae    6ec <SYS_ls_call29+0x8>
 68d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 690:	6c                   	insb   (%dx),%es:(%edi)
 691:	32 30                	xor    (%eax),%dh
	...

00000694 <SYS_ls_call21>:
 694:	6c                   	insb   (%dx),%es:(%edi)
 695:	73 5f                	jae    6f6 <SYS_ls_call30+0x8>
 697:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 69a:	6c                   	insb   (%dx),%es:(%edi)
 69b:	32 31                	xor    (%ecx),%dh
	...

0000069e <SYS_ls_call22>:
 69e:	6c                   	insb   (%dx),%es:(%edi)
 69f:	73 5f                	jae    700 <exit>
 6a1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6a4:	6c                   	insb   (%dx),%es:(%edi)
 6a5:	32 32                	xor    (%edx),%dh
	...

000006a8 <SYS_ls_call23>:
 6a8:	6c                   	insb   (%dx),%es:(%edi)
 6a9:	73 5f                	jae    70a <wait+0x2>
 6ab:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6ae:	6c                   	insb   (%dx),%es:(%edi)
 6af:	32 33                	xor    (%ebx),%dh
	...

000006b2 <SYS_ls_call24>:
 6b2:	6c                   	insb   (%dx),%es:(%edi)
 6b3:	73 5f                	jae    714 <pipe+0x4>
 6b5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6b8:	6c                   	insb   (%dx),%es:(%edi)
 6b9:	32 34 00             	xor    (%eax,%eax,1),%dh

000006bc <SYS_ls_call25>:
 6bc:	6c                   	insb   (%dx),%es:(%edi)
 6bd:	73 5f                	jae    71e <read+0x6>
 6bf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6c2:	6c                   	insb   (%dx),%es:(%edi)
 6c3:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000006c6 <SYS_ls_call26>:
 6c6:	6c                   	insb   (%dx),%es:(%edi)
 6c7:	73 5f                	jae    728 <close>
 6c9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6cc:	6c                   	insb   (%dx),%es:(%edi)
 6cd:	32 36                	xor    (%esi),%dh
	...

000006d0 <SYS_ls_call27>:
 6d0:	6c                   	insb   (%dx),%es:(%edi)
 6d1:	73 5f                	jae    732 <kill+0x2>
 6d3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6d6:	6c                   	insb   (%dx),%es:(%edi)
 6d7:	32 37                	xor    (%edi),%dh
	...

000006da <SYS_ls_call28>:
 6da:	6c                   	insb   (%dx),%es:(%edi)
 6db:	73 5f                	jae    73c <exec+0x4>
 6dd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6e0:	6c                   	insb   (%dx),%es:(%edi)
 6e1:	32 38                	xor    (%eax),%bh
	...

000006e4 <SYS_ls_call29>:
 6e4:	6c                   	insb   (%dx),%es:(%edi)
 6e5:	73 5f                	jae    746 <open+0x6>
 6e7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6ea:	6c                   	insb   (%dx),%es:(%edi)
 6eb:	32 39                	xor    (%ecx),%bh
	...

000006ee <SYS_ls_call30>:
 6ee:	6c                   	insb   (%dx),%es:(%edi)
 6ef:	73 5f                	jae    750 <unlink>
 6f1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6f4:	6c                   	insb   (%dx),%es:(%edi)
 6f5:	33 30                	xor    (%eax),%esi
	...

000006f8 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 6f8:	b8 01 00 00 00       	mov    $0x1,%eax
 6fd:	cd 40                	int    $0x40
 6ff:	c3                   	ret    

00000700 <exit>:
SYSCALL(exit)
 700:	b8 02 00 00 00       	mov    $0x2,%eax
 705:	cd 40                	int    $0x40
 707:	c3                   	ret    

00000708 <wait>:
SYSCALL(wait)
 708:	b8 03 00 00 00       	mov    $0x3,%eax
 70d:	cd 40                	int    $0x40
 70f:	c3                   	ret    

00000710 <pipe>:
SYSCALL(pipe)
 710:	b8 04 00 00 00       	mov    $0x4,%eax
 715:	cd 40                	int    $0x40
 717:	c3                   	ret    

00000718 <read>:
SYSCALL(read)
 718:	b8 05 00 00 00       	mov    $0x5,%eax
 71d:	cd 40                	int    $0x40
 71f:	c3                   	ret    

00000720 <write>:
SYSCALL(write)
 720:	b8 10 00 00 00       	mov    $0x10,%eax
 725:	cd 40                	int    $0x40
 727:	c3                   	ret    

00000728 <close>:
SYSCALL(close)
 728:	b8 15 00 00 00       	mov    $0x15,%eax
 72d:	cd 40                	int    $0x40
 72f:	c3                   	ret    

00000730 <kill>:
SYSCALL(kill)
 730:	b8 06 00 00 00       	mov    $0x6,%eax
 735:	cd 40                	int    $0x40
 737:	c3                   	ret    

00000738 <exec>:
SYSCALL(exec)
 738:	b8 07 00 00 00       	mov    $0x7,%eax
 73d:	cd 40                	int    $0x40
 73f:	c3                   	ret    

00000740 <open>:
SYSCALL(open)
 740:	b8 0f 00 00 00       	mov    $0xf,%eax
 745:	cd 40                	int    $0x40
 747:	c3                   	ret    

00000748 <mknod>:
SYSCALL(mknod)
 748:	b8 11 00 00 00       	mov    $0x11,%eax
 74d:	cd 40                	int    $0x40
 74f:	c3                   	ret    

00000750 <unlink>:
SYSCALL(unlink)
 750:	b8 12 00 00 00       	mov    $0x12,%eax
 755:	cd 40                	int    $0x40
 757:	c3                   	ret    

00000758 <fstat>:
SYSCALL(fstat)
 758:	b8 08 00 00 00       	mov    $0x8,%eax
 75d:	cd 40                	int    $0x40
 75f:	c3                   	ret    

00000760 <link>:
SYSCALL(link)
 760:	b8 13 00 00 00       	mov    $0x13,%eax
 765:	cd 40                	int    $0x40
 767:	c3                   	ret    

00000768 <mkdir>:
SYSCALL(mkdir)
 768:	b8 14 00 00 00       	mov    $0x14,%eax
 76d:	cd 40                	int    $0x40
 76f:	c3                   	ret    

00000770 <chdir>:
SYSCALL(chdir)
 770:	b8 09 00 00 00       	mov    $0x9,%eax
 775:	cd 40                	int    $0x40
 777:	c3                   	ret    

00000778 <dup>:
SYSCALL(dup)
 778:	b8 0a 00 00 00       	mov    $0xa,%eax
 77d:	cd 40                	int    $0x40
 77f:	c3                   	ret    

00000780 <getpid>:
SYSCALL(getpid)
 780:	b8 0b 00 00 00       	mov    $0xb,%eax
 785:	cd 40                	int    $0x40
 787:	c3                   	ret    

00000788 <sbrk>:
SYSCALL(sbrk)
 788:	b8 0c 00 00 00       	mov    $0xc,%eax
 78d:	cd 40                	int    $0x40
 78f:	c3                   	ret    

00000790 <sleep>:
SYSCALL(sleep)
 790:	b8 0d 00 00 00       	mov    $0xd,%eax
 795:	cd 40                	int    $0x40
 797:	c3                   	ret    

00000798 <uptime>:
SYSCALL(uptime)
 798:	b8 0e 00 00 00       	mov    $0xe,%eax
 79d:	cd 40                	int    $0x40
 79f:	c3                   	ret    

000007a0 <date>:
SYSCALL(date)
 7a0:	b8 16 00 00 00       	mov    $0x16,%eax
 7a5:	cd 40                	int    $0x40
 7a7:	c3                   	ret    

000007a8 <ls_call01>:

SYSCALL1(ls_call01)
 7a8:	b8 cc 05 00 00       	mov    $0x5cc,%eax
 7ad:	cd 41                	int    $0x41
 7af:	c3                   	ret    

000007b0 <ls_call02>:
SYSCALL1(ls_call02)
 7b0:	b8 d6 05 00 00       	mov    $0x5d6,%eax
 7b5:	cd 41                	int    $0x41
 7b7:	c3                   	ret    

000007b8 <ls_call03>:
SYSCALL1(ls_call03)
 7b8:	b8 e0 05 00 00       	mov    $0x5e0,%eax
 7bd:	cd 41                	int    $0x41
 7bf:	c3                   	ret    

000007c0 <ls_call04>:
SYSCALL1(ls_call04)
 7c0:	b8 ea 05 00 00       	mov    $0x5ea,%eax
 7c5:	cd 41                	int    $0x41
 7c7:	c3                   	ret    

000007c8 <ls_call05>:
SYSCALL1(ls_call05)
 7c8:	b8 f4 05 00 00       	mov    $0x5f4,%eax
 7cd:	cd 41                	int    $0x41
 7cf:	c3                   	ret    

000007d0 <ls_call06>:
SYSCALL1(ls_call06)
 7d0:	b8 fe 05 00 00       	mov    $0x5fe,%eax
 7d5:	cd 41                	int    $0x41
 7d7:	c3                   	ret    

000007d8 <ls_call07>:
SYSCALL1(ls_call07)
 7d8:	b8 08 06 00 00       	mov    $0x608,%eax
 7dd:	cd 41                	int    $0x41
 7df:	c3                   	ret    

000007e0 <ls_call08>:
SYSCALL1(ls_call08)
 7e0:	b8 12 06 00 00       	mov    $0x612,%eax
 7e5:	cd 41                	int    $0x41
 7e7:	c3                   	ret    

000007e8 <ls_call09>:
SYSCALL1(ls_call09)
 7e8:	b8 1c 06 00 00       	mov    $0x61c,%eax
 7ed:	cd 41                	int    $0x41
 7ef:	c3                   	ret    

000007f0 <ls_call10>:
SYSCALL1(ls_call10)
 7f0:	b8 26 06 00 00       	mov    $0x626,%eax
 7f5:	cd 41                	int    $0x41
 7f7:	c3                   	ret    

000007f8 <ls_call11>:
SYSCALL1(ls_call11)
 7f8:	b8 30 06 00 00       	mov    $0x630,%eax
 7fd:	cd 41                	int    $0x41
 7ff:	c3                   	ret    

00000800 <ls_call12>:
SYSCALL1(ls_call12)
 800:	b8 3a 06 00 00       	mov    $0x63a,%eax
 805:	cd 41                	int    $0x41
 807:	c3                   	ret    

00000808 <ls_call13>:
SYSCALL1(ls_call13)
 808:	b8 44 06 00 00       	mov    $0x644,%eax
 80d:	cd 41                	int    $0x41
 80f:	c3                   	ret    

00000810 <ls_call14>:
SYSCALL1(ls_call14)
 810:	b8 4e 06 00 00       	mov    $0x64e,%eax
 815:	cd 41                	int    $0x41
 817:	c3                   	ret    

00000818 <ls_call15>:
SYSCALL1(ls_call15)
 818:	b8 58 06 00 00       	mov    $0x658,%eax
 81d:	cd 41                	int    $0x41
 81f:	c3                   	ret    

00000820 <ls_call16>:
SYSCALL1(ls_call16)
 820:	b8 62 06 00 00       	mov    $0x662,%eax
 825:	cd 41                	int    $0x41
 827:	c3                   	ret    

00000828 <ls_call17>:
SYSCALL1(ls_call17)
 828:	b8 6c 06 00 00       	mov    $0x66c,%eax
 82d:	cd 41                	int    $0x41
 82f:	c3                   	ret    

00000830 <ls_call18>:
SYSCALL1(ls_call18)
 830:	b8 76 06 00 00       	mov    $0x676,%eax
 835:	cd 41                	int    $0x41
 837:	c3                   	ret    

00000838 <ls_call19>:
SYSCALL1(ls_call19)
 838:	b8 80 06 00 00       	mov    $0x680,%eax
 83d:	cd 41                	int    $0x41
 83f:	c3                   	ret    

00000840 <ls_call20>:
SYSCALL1(ls_call20)
 840:	b8 8a 06 00 00       	mov    $0x68a,%eax
 845:	cd 41                	int    $0x41
 847:	c3                   	ret    

00000848 <ls_call21>:
SYSCALL1(ls_call21)
 848:	b8 94 06 00 00       	mov    $0x694,%eax
 84d:	cd 41                	int    $0x41
 84f:	c3                   	ret    

00000850 <ls_call22>:
SYSCALL1(ls_call22)
 850:	b8 9e 06 00 00       	mov    $0x69e,%eax
 855:	cd 41                	int    $0x41
 857:	c3                   	ret    

00000858 <ls_call23>:
SYSCALL1(ls_call23)
 858:	b8 a8 06 00 00       	mov    $0x6a8,%eax
 85d:	cd 41                	int    $0x41
 85f:	c3                   	ret    

00000860 <ls_call24>:
SYSCALL1(ls_call24)
 860:	b8 b2 06 00 00       	mov    $0x6b2,%eax
 865:	cd 41                	int    $0x41
 867:	c3                   	ret    

00000868 <ls_call25>:
SYSCALL1(ls_call25)
 868:	b8 bc 06 00 00       	mov    $0x6bc,%eax
 86d:	cd 41                	int    $0x41
 86f:	c3                   	ret    

00000870 <ls_call26>:
SYSCALL1(ls_call26)
 870:	b8 c6 06 00 00       	mov    $0x6c6,%eax
 875:	cd 41                	int    $0x41
 877:	c3                   	ret    

00000878 <ls_call27>:
SYSCALL1(ls_call27)
 878:	b8 d0 06 00 00       	mov    $0x6d0,%eax
 87d:	cd 41                	int    $0x41
 87f:	c3                   	ret    

00000880 <ls_call28>:
SYSCALL1(ls_call28)
 880:	b8 da 06 00 00       	mov    $0x6da,%eax
 885:	cd 41                	int    $0x41
 887:	c3                   	ret    

00000888 <ls_call29>:
SYSCALL1(ls_call29)
 888:	b8 e4 06 00 00       	mov    $0x6e4,%eax
 88d:	cd 41                	int    $0x41
 88f:	c3                   	ret    

00000890 <ls_call30>:
SYSCALL1(ls_call30)
 890:	b8 ee 06 00 00       	mov    $0x6ee,%eax
 895:	cd 41                	int    $0x41
 897:	c3                   	ret    

00000898 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 898:	55                   	push   %ebp
 899:	89 e5                	mov    %esp,%ebp
 89b:	83 ec 28             	sub    $0x28,%esp
 89e:	8b 45 0c             	mov    0xc(%ebp),%eax
 8a1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 8a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8ab:	00 
 8ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
 8af:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b3:	8b 45 08             	mov    0x8(%ebp),%eax
 8b6:	89 04 24             	mov    %eax,(%esp)
 8b9:	e8 62 fe ff ff       	call   720 <write>
}
 8be:	c9                   	leave  
 8bf:	c3                   	ret    

000008c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 8c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 8cd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 8d1:	74 17                	je     8ea <printint+0x2a>
 8d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 8d7:	79 11                	jns    8ea <printint+0x2a>
    neg = 1;
 8d9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 8e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 8e3:	f7 d8                	neg    %eax
 8e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 8e8:	eb 06                	jmp    8f0 <printint+0x30>
  } else {
    x = xx;
 8ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 8ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 8f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 8f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 8fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8fd:	ba 00 00 00 00       	mov    $0x0,%edx
 902:	f7 f1                	div    %ecx
 904:	89 d0                	mov    %edx,%eax
 906:	0f b6 80 44 10 00 00 	movzbl 0x1044(%eax),%eax
 90d:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 910:	8b 55 f4             	mov    -0xc(%ebp),%edx
 913:	01 ca                	add    %ecx,%edx
 915:	88 02                	mov    %al,(%edx)
 917:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 91b:	8b 55 10             	mov    0x10(%ebp),%edx
 91e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 921:	8b 45 ec             	mov    -0x14(%ebp),%eax
 924:	ba 00 00 00 00       	mov    $0x0,%edx
 929:	f7 75 d4             	divl   -0x2c(%ebp)
 92c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 92f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 933:	75 c2                	jne    8f7 <printint+0x37>
  if(neg)
 935:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 939:	74 2e                	je     969 <printint+0xa9>
    buf[i++] = '-';
 93b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	01 d0                	add    %edx,%eax
 943:	c6 00 2d             	movb   $0x2d,(%eax)
 946:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 94a:	eb 1d                	jmp    969 <printint+0xa9>
    putc(fd, buf[i]);
 94c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 94f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 952:	01 d0                	add    %edx,%eax
 954:	0f b6 00             	movzbl (%eax),%eax
 957:	0f be c0             	movsbl %al,%eax
 95a:	89 44 24 04          	mov    %eax,0x4(%esp)
 95e:	8b 45 08             	mov    0x8(%ebp),%eax
 961:	89 04 24             	mov    %eax,(%esp)
 964:	e8 2f ff ff ff       	call   898 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 969:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 96d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 971:	79 d9                	jns    94c <printint+0x8c>
    putc(fd, buf[i]);
}
 973:	c9                   	leave  
 974:	c3                   	ret    

00000975 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 975:	55                   	push   %ebp
 976:	89 e5                	mov    %esp,%ebp
 978:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 97b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 982:	8d 45 0c             	lea    0xc(%ebp),%eax
 985:	83 c0 04             	add    $0x4,%eax
 988:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 98b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 992:	e9 7d 01 00 00       	jmp    b14 <printf+0x19f>
    c = fmt[i] & 0xff;
 997:	8b 55 0c             	mov    0xc(%ebp),%edx
 99a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99d:	01 d0                	add    %edx,%eax
 99f:	0f b6 00             	movzbl (%eax),%eax
 9a2:	0f be c0             	movsbl %al,%eax
 9a5:	25 ff 00 00 00       	and    $0xff,%eax
 9aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 9ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 9b1:	75 2c                	jne    9df <printf+0x6a>
      if(c == '%'){
 9b3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 9b7:	75 0c                	jne    9c5 <printf+0x50>
        state = '%';
 9b9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 9c0:	e9 4b 01 00 00       	jmp    b10 <printf+0x19b>
      } else {
        putc(fd, c);
 9c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9c8:	0f be c0             	movsbl %al,%eax
 9cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 9cf:	8b 45 08             	mov    0x8(%ebp),%eax
 9d2:	89 04 24             	mov    %eax,(%esp)
 9d5:	e8 be fe ff ff       	call   898 <putc>
 9da:	e9 31 01 00 00       	jmp    b10 <printf+0x19b>
      }
    } else if(state == '%'){
 9df:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 9e3:	0f 85 27 01 00 00    	jne    b10 <printf+0x19b>
      if(c == 'd'){
 9e9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 9ed:	75 2d                	jne    a1c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 9ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9f2:	8b 00                	mov    (%eax),%eax
 9f4:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 9fb:	00 
 9fc:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 a03:	00 
 a04:	89 44 24 04          	mov    %eax,0x4(%esp)
 a08:	8b 45 08             	mov    0x8(%ebp),%eax
 a0b:	89 04 24             	mov    %eax,(%esp)
 a0e:	e8 ad fe ff ff       	call   8c0 <printint>
        ap++;
 a13:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 a17:	e9 ed 00 00 00       	jmp    b09 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 a1c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 a20:	74 06                	je     a28 <printf+0xb3>
 a22:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 a26:	75 2d                	jne    a55 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 a28:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a2b:	8b 00                	mov    (%eax),%eax
 a2d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 a34:	00 
 a35:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 a3c:	00 
 a3d:	89 44 24 04          	mov    %eax,0x4(%esp)
 a41:	8b 45 08             	mov    0x8(%ebp),%eax
 a44:	89 04 24             	mov    %eax,(%esp)
 a47:	e8 74 fe ff ff       	call   8c0 <printint>
        ap++;
 a4c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 a50:	e9 b4 00 00 00       	jmp    b09 <printf+0x194>
      } else if(c == 's'){
 a55:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 a59:	75 46                	jne    aa1 <printf+0x12c>
        s = (char*)*ap;
 a5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a5e:	8b 00                	mov    (%eax),%eax
 a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 a63:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 a67:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a6b:	75 27                	jne    a94 <printf+0x11f>
          s = "(null)";
 a6d:	c7 45 f4 7e 0d 00 00 	movl   $0xd7e,-0xc(%ebp)
        while(*s != 0){
 a74:	eb 1e                	jmp    a94 <printf+0x11f>
          putc(fd, *s);
 a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a79:	0f b6 00             	movzbl (%eax),%eax
 a7c:	0f be c0             	movsbl %al,%eax
 a7f:	89 44 24 04          	mov    %eax,0x4(%esp)
 a83:	8b 45 08             	mov    0x8(%ebp),%eax
 a86:	89 04 24             	mov    %eax,(%esp)
 a89:	e8 0a fe ff ff       	call   898 <putc>
          s++;
 a8e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a92:	eb 01                	jmp    a95 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a94:	90                   	nop
 a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a98:	0f b6 00             	movzbl (%eax),%eax
 a9b:	84 c0                	test   %al,%al
 a9d:	75 d7                	jne    a76 <printf+0x101>
 a9f:	eb 68                	jmp    b09 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 aa1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 aa5:	75 1d                	jne    ac4 <printf+0x14f>
        putc(fd, *ap);
 aa7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 aaa:	8b 00                	mov    (%eax),%eax
 aac:	0f be c0             	movsbl %al,%eax
 aaf:	89 44 24 04          	mov    %eax,0x4(%esp)
 ab3:	8b 45 08             	mov    0x8(%ebp),%eax
 ab6:	89 04 24             	mov    %eax,(%esp)
 ab9:	e8 da fd ff ff       	call   898 <putc>
        ap++;
 abe:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 ac2:	eb 45                	jmp    b09 <printf+0x194>
      } else if(c == '%'){
 ac4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 ac8:	75 17                	jne    ae1 <printf+0x16c>
        putc(fd, c);
 aca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 acd:	0f be c0             	movsbl %al,%eax
 ad0:	89 44 24 04          	mov    %eax,0x4(%esp)
 ad4:	8b 45 08             	mov    0x8(%ebp),%eax
 ad7:	89 04 24             	mov    %eax,(%esp)
 ada:	e8 b9 fd ff ff       	call   898 <putc>
 adf:	eb 28                	jmp    b09 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 ae1:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 ae8:	00 
 ae9:	8b 45 08             	mov    0x8(%ebp),%eax
 aec:	89 04 24             	mov    %eax,(%esp)
 aef:	e8 a4 fd ff ff       	call   898 <putc>
        putc(fd, c);
 af4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 af7:	0f be c0             	movsbl %al,%eax
 afa:	89 44 24 04          	mov    %eax,0x4(%esp)
 afe:	8b 45 08             	mov    0x8(%ebp),%eax
 b01:	89 04 24             	mov    %eax,(%esp)
 b04:	e8 8f fd ff ff       	call   898 <putc>
      }
      state = 0;
 b09:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b10:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 b14:	8b 55 0c             	mov    0xc(%ebp),%edx
 b17:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b1a:	01 d0                	add    %edx,%eax
 b1c:	0f b6 00             	movzbl (%eax),%eax
 b1f:	84 c0                	test   %al,%al
 b21:	0f 85 70 fe ff ff    	jne    997 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 b27:	c9                   	leave  
 b28:	c3                   	ret    
 b29:	90                   	nop
 b2a:	90                   	nop
 b2b:	90                   	nop

00000b2c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b2c:	55                   	push   %ebp
 b2d:	89 e5                	mov    %esp,%ebp
 b2f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b32:	8b 45 08             	mov    0x8(%ebp),%eax
 b35:	83 e8 08             	sub    $0x8,%eax
 b38:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b3b:	a1 68 10 00 00       	mov    0x1068,%eax
 b40:	89 45 fc             	mov    %eax,-0x4(%ebp)
 b43:	eb 24                	jmp    b69 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b45:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b48:	8b 00                	mov    (%eax),%eax
 b4a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 b4d:	77 12                	ja     b61 <free+0x35>
 b4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b52:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 b55:	77 24                	ja     b7b <free+0x4f>
 b57:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b5a:	8b 00                	mov    (%eax),%eax
 b5c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 b5f:	77 1a                	ja     b7b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b61:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b64:	8b 00                	mov    (%eax),%eax
 b66:	89 45 fc             	mov    %eax,-0x4(%ebp)
 b69:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b6c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 b6f:	76 d4                	jbe    b45 <free+0x19>
 b71:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b74:	8b 00                	mov    (%eax),%eax
 b76:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 b79:	76 ca                	jbe    b45 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 b7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b7e:	8b 40 04             	mov    0x4(%eax),%eax
 b81:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 b88:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b8b:	01 c2                	add    %eax,%edx
 b8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b90:	8b 00                	mov    (%eax),%eax
 b92:	39 c2                	cmp    %eax,%edx
 b94:	75 24                	jne    bba <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 b96:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b99:	8b 50 04             	mov    0x4(%eax),%edx
 b9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b9f:	8b 00                	mov    (%eax),%eax
 ba1:	8b 40 04             	mov    0x4(%eax),%eax
 ba4:	01 c2                	add    %eax,%edx
 ba6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ba9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 bac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 baf:	8b 00                	mov    (%eax),%eax
 bb1:	8b 10                	mov    (%eax),%edx
 bb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 bb6:	89 10                	mov    %edx,(%eax)
 bb8:	eb 0a                	jmp    bc4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 bba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bbd:	8b 10                	mov    (%eax),%edx
 bbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 bc2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 bc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bc7:	8b 40 04             	mov    0x4(%eax),%eax
 bca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 bd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bd4:	01 d0                	add    %edx,%eax
 bd6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 bd9:	75 20                	jne    bfb <free+0xcf>
    p->s.size += bp->s.size;
 bdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bde:	8b 50 04             	mov    0x4(%eax),%edx
 be1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 be4:	8b 40 04             	mov    0x4(%eax),%eax
 be7:	01 c2                	add    %eax,%edx
 be9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bec:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 bef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 bf2:	8b 10                	mov    (%eax),%edx
 bf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bf7:	89 10                	mov    %edx,(%eax)
 bf9:	eb 08                	jmp    c03 <free+0xd7>
  } else
    p->s.ptr = bp;
 bfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bfe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 c01:	89 10                	mov    %edx,(%eax)
  freep = p;
 c03:	8b 45 fc             	mov    -0x4(%ebp),%eax
 c06:	a3 68 10 00 00       	mov    %eax,0x1068
}
 c0b:	c9                   	leave  
 c0c:	c3                   	ret    

00000c0d <morecore>:

static Header*
morecore(uint nu)
{
 c0d:	55                   	push   %ebp
 c0e:	89 e5                	mov    %esp,%ebp
 c10:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 c13:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 c1a:	77 07                	ja     c23 <morecore+0x16>
    nu = 4096;
 c1c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 c23:	8b 45 08             	mov    0x8(%ebp),%eax
 c26:	c1 e0 03             	shl    $0x3,%eax
 c29:	89 04 24             	mov    %eax,(%esp)
 c2c:	e8 57 fb ff ff       	call   788 <sbrk>
 c31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 c34:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 c38:	75 07                	jne    c41 <morecore+0x34>
    return 0;
 c3a:	b8 00 00 00 00       	mov    $0x0,%eax
 c3f:	eb 22                	jmp    c63 <morecore+0x56>
  hp = (Header*)p;
 c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 c47:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c4a:	8b 55 08             	mov    0x8(%ebp),%edx
 c4d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c53:	83 c0 08             	add    $0x8,%eax
 c56:	89 04 24             	mov    %eax,(%esp)
 c59:	e8 ce fe ff ff       	call   b2c <free>
  return freep;
 c5e:	a1 68 10 00 00       	mov    0x1068,%eax
}
 c63:	c9                   	leave  
 c64:	c3                   	ret    

00000c65 <malloc>:

void*
malloc(uint nbytes)
{
 c65:	55                   	push   %ebp
 c66:	89 e5                	mov    %esp,%ebp
 c68:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c6b:	8b 45 08             	mov    0x8(%ebp),%eax
 c6e:	83 c0 07             	add    $0x7,%eax
 c71:	c1 e8 03             	shr    $0x3,%eax
 c74:	83 c0 01             	add    $0x1,%eax
 c77:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 c7a:	a1 68 10 00 00       	mov    0x1068,%eax
 c7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 c82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c86:	75 23                	jne    cab <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 c88:	c7 45 f0 60 10 00 00 	movl   $0x1060,-0x10(%ebp)
 c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c92:	a3 68 10 00 00       	mov    %eax,0x1068
 c97:	a1 68 10 00 00       	mov    0x1068,%eax
 c9c:	a3 60 10 00 00       	mov    %eax,0x1060
    base.s.size = 0;
 ca1:	c7 05 64 10 00 00 00 	movl   $0x0,0x1064
 ca8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cae:	8b 00                	mov    (%eax),%eax
 cb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cb6:	8b 40 04             	mov    0x4(%eax),%eax
 cb9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 cbc:	72 4d                	jb     d0b <malloc+0xa6>
      if(p->s.size == nunits)
 cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cc1:	8b 40 04             	mov    0x4(%eax),%eax
 cc4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 cc7:	75 0c                	jne    cd5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 cc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ccc:	8b 10                	mov    (%eax),%edx
 cce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cd1:	89 10                	mov    %edx,(%eax)
 cd3:	eb 26                	jmp    cfb <malloc+0x96>
      else {
        p->s.size -= nunits;
 cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cd8:	8b 40 04             	mov    0x4(%eax),%eax
 cdb:	89 c2                	mov    %eax,%edx
 cdd:	2b 55 ec             	sub    -0x14(%ebp),%edx
 ce0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ce3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ce9:	8b 40 04             	mov    0x4(%eax),%eax
 cec:	c1 e0 03             	shl    $0x3,%eax
 cef:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 cf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cf5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 cf8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 cfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cfe:	a3 68 10 00 00       	mov    %eax,0x1068
      return (void*)(p + 1);
 d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d06:	83 c0 08             	add    $0x8,%eax
 d09:	eb 38                	jmp    d43 <malloc+0xde>
    }
    if(p == freep)
 d0b:	a1 68 10 00 00       	mov    0x1068,%eax
 d10:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 d13:	75 1b                	jne    d30 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 d15:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d18:	89 04 24             	mov    %eax,(%esp)
 d1b:	e8 ed fe ff ff       	call   c0d <morecore>
 d20:	89 45 f4             	mov    %eax,-0xc(%ebp)
 d23:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d27:	75 07                	jne    d30 <malloc+0xcb>
        return 0;
 d29:	b8 00 00 00 00       	mov    $0x0,%eax
 d2e:	eb 13                	jmp    d43 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d30:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d33:	89 45 f0             	mov    %eax,-0x10(%ebp)
 d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d39:	8b 00                	mov    (%eax),%eax
 d3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 d3e:	e9 70 ff ff ff       	jmp    cb3 <malloc+0x4e>
}
 d43:	c9                   	leave  
 d44:	c3                   	ret    
