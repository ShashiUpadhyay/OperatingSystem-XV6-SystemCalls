
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 24             	sub    $0x24,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	8b 45 08             	mov    0x8(%ebp),%eax
   a:	89 04 24             	mov    %eax,(%esp)
   d:	e8 e4 03 00 00       	call   3f6 <strlen>
  12:	8b 55 08             	mov    0x8(%ebp),%edx
  15:	01 d0                	add    %edx,%eax
  17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1a:	eb 04                	jmp    20 <fmtname+0x20>
  1c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  23:	3b 45 08             	cmp    0x8(%ebp),%eax
  26:	72 0a                	jb     32 <fmtname+0x32>
  28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2b:	0f b6 00             	movzbl (%eax),%eax
  2e:	3c 2f                	cmp    $0x2f,%al
  30:	75 ea                	jne    1c <fmtname+0x1c>
    ;
  p++;
  32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  39:	89 04 24             	mov    %eax,(%esp)
  3c:	e8 b5 03 00 00       	call   3f6 <strlen>
  41:	83 f8 0d             	cmp    $0xd,%eax
  44:	76 05                	jbe    4b <fmtname+0x4b>
    return p;
  46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  49:	eb 5f                	jmp    aa <fmtname+0xaa>
  memmove(buf, p, strlen(p));
  4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 a0 03 00 00       	call   3f6 <strlen>
  56:	89 44 24 08          	mov    %eax,0x8(%esp)
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	89 44 24 04          	mov    %eax,0x4(%esp)
  61:	c7 04 24 2c 10 00 00 	movl   $0x102c,(%esp)
  68:	e8 13 05 00 00       	call   580 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  70:	89 04 24             	mov    %eax,(%esp)
  73:	e8 7e 03 00 00       	call   3f6 <strlen>
  78:	ba 0e 00 00 00       	mov    $0xe,%edx
  7d:	89 d3                	mov    %edx,%ebx
  7f:	29 c3                	sub    %eax,%ebx
  81:	8b 45 f4             	mov    -0xc(%ebp),%eax
  84:	89 04 24             	mov    %eax,(%esp)
  87:	e8 6a 03 00 00       	call   3f6 <strlen>
  8c:	05 2c 10 00 00       	add    $0x102c,%eax
  91:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  95:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  9c:	00 
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 78 03 00 00       	call   41d <memset>
  return buf;
  a5:	b8 2c 10 00 00       	mov    $0x102c,%eax
}
  aa:	83 c4 24             	add    $0x24,%esp
  ad:	5b                   	pop    %ebx
  ae:	5d                   	pop    %ebp
  af:	c3                   	ret    

000000b0 <ls>:

void
ls(char *path)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  bc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  c3:	00 
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	89 04 24             	mov    %eax,(%esp)
  ca:	e8 61 06 00 00       	call   730 <open>
  cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d6:	79 20                	jns    f8 <ls+0x48>
    printf(2, "ls: cannot open %s\n", path);
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	89 44 24 08          	mov    %eax,0x8(%esp)
  df:	c7 44 24 04 35 0d 00 	movl   $0xd35,0x4(%esp)
  e6:	00 
  e7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  ee:	e8 72 08 00 00       	call   965 <printf>
  f3:	e9 01 02 00 00       	jmp    2f9 <ls+0x249>
    return;
  }
  
  if(fstat(fd, &st) < 0){
  f8:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 102:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 105:	89 04 24             	mov    %eax,(%esp)
 108:	e8 3b 06 00 00       	call   748 <fstat>
 10d:	85 c0                	test   %eax,%eax
 10f:	79 2b                	jns    13c <ls+0x8c>
    printf(2, "ls: cannot stat %s\n", path);
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	89 44 24 08          	mov    %eax,0x8(%esp)
 118:	c7 44 24 04 49 0d 00 	movl   $0xd49,0x4(%esp)
 11f:	00 
 120:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 127:	e8 39 08 00 00       	call   965 <printf>
    close(fd);
 12c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12f:	89 04 24             	mov    %eax,(%esp)
 132:	e8 e1 05 00 00       	call   718 <close>
 137:	e9 bd 01 00 00       	jmp    2f9 <ls+0x249>
    return;
  }
  
  switch(st.type){
 13c:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 143:	98                   	cwtl   
 144:	83 f8 01             	cmp    $0x1,%eax
 147:	74 53                	je     19c <ls+0xec>
 149:	83 f8 02             	cmp    $0x2,%eax
 14c:	0f 85 9c 01 00 00    	jne    2ee <ls+0x23e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 158:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15e:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 165:	0f bf d8             	movswl %ax,%ebx
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	89 04 24             	mov    %eax,(%esp)
 16e:	e8 8d fe ff ff       	call   0 <fmtname>
 173:	89 7c 24 14          	mov    %edi,0x14(%esp)
 177:	89 74 24 10          	mov    %esi,0x10(%esp)
 17b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 17f:	89 44 24 08          	mov    %eax,0x8(%esp)
 183:	c7 44 24 04 5d 0d 00 	movl   $0xd5d,0x4(%esp)
 18a:	00 
 18b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 192:	e8 ce 07 00 00       	call   965 <printf>
    break;
 197:	e9 52 01 00 00       	jmp    2ee <ls+0x23e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	89 04 24             	mov    %eax,(%esp)
 1a2:	e8 4f 02 00 00       	call   3f6 <strlen>
 1a7:	83 c0 10             	add    $0x10,%eax
 1aa:	3d 00 02 00 00       	cmp    $0x200,%eax
 1af:	76 19                	jbe    1ca <ls+0x11a>
      printf(1, "ls: path too long\n");
 1b1:	c7 44 24 04 6a 0d 00 	movl   $0xd6a,0x4(%esp)
 1b8:	00 
 1b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c0:	e8 a0 07 00 00       	call   965 <printf>
      break;
 1c5:	e9 24 01 00 00       	jmp    2ee <ls+0x23e>
    }
    strcpy(buf, path);
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d1:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d7:	89 04 24             	mov    %eax,(%esp)
 1da:	e8 a2 01 00 00       	call   381 <strcpy>
    p = buf+strlen(buf);
 1df:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 09 02 00 00       	call   3f6 <strlen>
 1ed:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1f3:	01 d0                	add    %edx,%eax
 1f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1fb:	c6 00 2f             	movb   $0x2f,(%eax)
 1fe:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 202:	e9 c0 00 00 00       	jmp    2c7 <ls+0x217>
      if(de.inum == 0)
 207:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 20e:	66 85 c0             	test   %ax,%ax
 211:	0f 84 af 00 00 00    	je     2c6 <ls+0x216>
        continue;
      memmove(p, de.name, DIRSIZ);
 217:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 21e:	00 
 21f:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 225:	83 c0 02             	add    $0x2,%eax
 228:	89 44 24 04          	mov    %eax,0x4(%esp)
 22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 22f:	89 04 24             	mov    %eax,(%esp)
 232:	e8 49 03 00 00       	call   580 <memmove>
      p[DIRSIZ] = 0;
 237:	8b 45 e0             	mov    -0x20(%ebp),%eax
 23a:	83 c0 0e             	add    $0xe,%eax
 23d:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 240:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 246:	89 44 24 04          	mov    %eax,0x4(%esp)
 24a:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 250:	89 04 24             	mov    %eax,(%esp)
 253:	e8 8f 02 00 00       	call   4e7 <stat>
 258:	85 c0                	test   %eax,%eax
 25a:	79 20                	jns    27c <ls+0x1cc>
        printf(1, "ls: cannot stat %s\n", buf);
 25c:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 262:	89 44 24 08          	mov    %eax,0x8(%esp)
 266:	c7 44 24 04 49 0d 00 	movl   $0xd49,0x4(%esp)
 26d:	00 
 26e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 275:	e8 eb 06 00 00       	call   965 <printf>
        continue;
 27a:	eb 4b                	jmp    2c7 <ls+0x217>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 27c:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 282:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 288:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 28f:	0f bf d8             	movswl %ax,%ebx
 292:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 298:	89 04 24             	mov    %eax,(%esp)
 29b:	e8 60 fd ff ff       	call   0 <fmtname>
 2a0:	89 7c 24 14          	mov    %edi,0x14(%esp)
 2a4:	89 74 24 10          	mov    %esi,0x10(%esp)
 2a8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 2ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b0:	c7 44 24 04 5d 0d 00 	movl   $0xd5d,0x4(%esp)
 2b7:	00 
 2b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2bf:	e8 a1 06 00 00       	call   965 <printf>
 2c4:	eb 01                	jmp    2c7 <ls+0x217>
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
 2c6:	90                   	nop
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2c7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 2ce:	00 
 2cf:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2dc:	89 04 24             	mov    %eax,(%esp)
 2df:	e8 24 04 00 00       	call   708 <read>
 2e4:	83 f8 10             	cmp    $0x10,%eax
 2e7:	0f 84 1a ff ff ff    	je     207 <ls+0x157>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2ed:	90                   	nop
  }
  close(fd);
 2ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2f1:	89 04 24             	mov    %eax,(%esp)
 2f4:	e8 1f 04 00 00       	call   718 <close>
}
 2f9:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 2ff:	5b                   	pop    %ebx
 300:	5e                   	pop    %esi
 301:	5f                   	pop    %edi
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    

00000304 <main>:

int
main(int argc, char *argv[])
{
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	83 e4 f0             	and    $0xfffffff0,%esp
 30a:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
 30d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 311:	7f 11                	jg     324 <main+0x20>
    ls(".");
 313:	c7 04 24 7d 0d 00 00 	movl   $0xd7d,(%esp)
 31a:	e8 91 fd ff ff       	call   b0 <ls>
    exit();
 31f:	e8 cc 03 00 00       	call   6f0 <exit>
  }
  for(i=1; i<argc; i++)
 324:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 32b:	00 
 32c:	eb 1f                	jmp    34d <main+0x49>
    ls(argv[i]);
 32e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 339:	8b 45 0c             	mov    0xc(%ebp),%eax
 33c:	01 d0                	add    %edx,%eax
 33e:	8b 00                	mov    (%eax),%eax
 340:	89 04 24             	mov    %eax,(%esp)
 343:	e8 68 fd ff ff       	call   b0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 348:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 34d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 351:	3b 45 08             	cmp    0x8(%ebp),%eax
 354:	7c d8                	jl     32e <main+0x2a>
    ls(argv[i]);
  exit();
 356:	e8 95 03 00 00       	call   6f0 <exit>
 35b:	90                   	nop

0000035c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 35c:	55                   	push   %ebp
 35d:	89 e5                	mov    %esp,%ebp
 35f:	57                   	push   %edi
 360:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 361:	8b 4d 08             	mov    0x8(%ebp),%ecx
 364:	8b 55 10             	mov    0x10(%ebp),%edx
 367:	8b 45 0c             	mov    0xc(%ebp),%eax
 36a:	89 cb                	mov    %ecx,%ebx
 36c:	89 df                	mov    %ebx,%edi
 36e:	89 d1                	mov    %edx,%ecx
 370:	fc                   	cld    
 371:	f3 aa                	rep stos %al,%es:(%edi)
 373:	89 ca                	mov    %ecx,%edx
 375:	89 fb                	mov    %edi,%ebx
 377:	89 5d 08             	mov    %ebx,0x8(%ebp)
 37a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 37d:	5b                   	pop    %ebx
 37e:	5f                   	pop    %edi
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    

00000381 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 381:	55                   	push   %ebp
 382:	89 e5                	mov    %esp,%ebp
 384:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 38d:	90                   	nop
 38e:	8b 45 0c             	mov    0xc(%ebp),%eax
 391:	0f b6 10             	movzbl (%eax),%edx
 394:	8b 45 08             	mov    0x8(%ebp),%eax
 397:	88 10                	mov    %dl,(%eax)
 399:	8b 45 08             	mov    0x8(%ebp),%eax
 39c:	0f b6 00             	movzbl (%eax),%eax
 39f:	84 c0                	test   %al,%al
 3a1:	0f 95 c0             	setne  %al
 3a4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3a8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 3ac:	84 c0                	test   %al,%al
 3ae:	75 de                	jne    38e <strcpy+0xd>
    ;
  return os;
 3b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3b8:	eb 08                	jmp    3c2 <strcmp+0xd>
    p++, q++;
 3ba:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3be:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3c2:	8b 45 08             	mov    0x8(%ebp),%eax
 3c5:	0f b6 00             	movzbl (%eax),%eax
 3c8:	84 c0                	test   %al,%al
 3ca:	74 10                	je     3dc <strcmp+0x27>
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	0f b6 10             	movzbl (%eax),%edx
 3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d5:	0f b6 00             	movzbl (%eax),%eax
 3d8:	38 c2                	cmp    %al,%dl
 3da:	74 de                	je     3ba <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3dc:	8b 45 08             	mov    0x8(%ebp),%eax
 3df:	0f b6 00             	movzbl (%eax),%eax
 3e2:	0f b6 d0             	movzbl %al,%edx
 3e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e8:	0f b6 00             	movzbl (%eax),%eax
 3eb:	0f b6 c0             	movzbl %al,%eax
 3ee:	89 d1                	mov    %edx,%ecx
 3f0:	29 c1                	sub    %eax,%ecx
 3f2:	89 c8                	mov    %ecx,%eax
}
 3f4:	5d                   	pop    %ebp
 3f5:	c3                   	ret    

000003f6 <strlen>:

uint
strlen(char *s)
{
 3f6:	55                   	push   %ebp
 3f7:	89 e5                	mov    %esp,%ebp
 3f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 403:	eb 04                	jmp    409 <strlen+0x13>
 405:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 409:	8b 55 fc             	mov    -0x4(%ebp),%edx
 40c:	8b 45 08             	mov    0x8(%ebp),%eax
 40f:	01 d0                	add    %edx,%eax
 411:	0f b6 00             	movzbl (%eax),%eax
 414:	84 c0                	test   %al,%al
 416:	75 ed                	jne    405 <strlen+0xf>
    ;
  return n;
 418:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 41b:	c9                   	leave  
 41c:	c3                   	ret    

0000041d <memset>:

void*
memset(void *dst, int c, uint n)
{
 41d:	55                   	push   %ebp
 41e:	89 e5                	mov    %esp,%ebp
 420:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 423:	8b 45 10             	mov    0x10(%ebp),%eax
 426:	89 44 24 08          	mov    %eax,0x8(%esp)
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 44 24 04          	mov    %eax,0x4(%esp)
 431:	8b 45 08             	mov    0x8(%ebp),%eax
 434:	89 04 24             	mov    %eax,(%esp)
 437:	e8 20 ff ff ff       	call   35c <stosb>
  return dst;
 43c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 43f:	c9                   	leave  
 440:	c3                   	ret    

00000441 <strchr>:

char*
strchr(const char *s, char c)
{
 441:	55                   	push   %ebp
 442:	89 e5                	mov    %esp,%ebp
 444:	83 ec 04             	sub    $0x4,%esp
 447:	8b 45 0c             	mov    0xc(%ebp),%eax
 44a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 44d:	eb 14                	jmp    463 <strchr+0x22>
    if(*s == c)
 44f:	8b 45 08             	mov    0x8(%ebp),%eax
 452:	0f b6 00             	movzbl (%eax),%eax
 455:	3a 45 fc             	cmp    -0x4(%ebp),%al
 458:	75 05                	jne    45f <strchr+0x1e>
      return (char*)s;
 45a:	8b 45 08             	mov    0x8(%ebp),%eax
 45d:	eb 13                	jmp    472 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 45f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 463:	8b 45 08             	mov    0x8(%ebp),%eax
 466:	0f b6 00             	movzbl (%eax),%eax
 469:	84 c0                	test   %al,%al
 46b:	75 e2                	jne    44f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 46d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 472:	c9                   	leave  
 473:	c3                   	ret    

00000474 <gets>:

char*
gets(char *buf, int max)
{
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 47a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 481:	eb 46                	jmp    4c9 <gets+0x55>
    cc = read(0, &c, 1);
 483:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48a:	00 
 48b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 48e:	89 44 24 04          	mov    %eax,0x4(%esp)
 492:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 499:	e8 6a 02 00 00       	call   708 <read>
 49e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 4a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4a5:	7e 2f                	jle    4d6 <gets+0x62>
      break;
    buf[i++] = c;
 4a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4aa:	8b 45 08             	mov    0x8(%ebp),%eax
 4ad:	01 c2                	add    %eax,%edx
 4af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b3:	88 02                	mov    %al,(%edx)
 4b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 4b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4bd:	3c 0a                	cmp    $0xa,%al
 4bf:	74 16                	je     4d7 <gets+0x63>
 4c1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4c5:	3c 0d                	cmp    $0xd,%al
 4c7:	74 0e                	je     4d7 <gets+0x63>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4cc:	83 c0 01             	add    $0x1,%eax
 4cf:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4d2:	7c af                	jl     483 <gets+0xf>
 4d4:	eb 01                	jmp    4d7 <gets+0x63>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 4d6:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4da:	8b 45 08             	mov    0x8(%ebp),%eax
 4dd:	01 d0                	add    %edx,%eax
 4df:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4e2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4e5:	c9                   	leave  
 4e6:	c3                   	ret    

000004e7 <stat>:

int
stat(char *n, struct stat *st)
{
 4e7:	55                   	push   %ebp
 4e8:	89 e5                	mov    %esp,%ebp
 4ea:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4ed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4f4:	00 
 4f5:	8b 45 08             	mov    0x8(%ebp),%eax
 4f8:	89 04 24             	mov    %eax,(%esp)
 4fb:	e8 30 02 00 00       	call   730 <open>
 500:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 503:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 507:	79 07                	jns    510 <stat+0x29>
    return -1;
 509:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 50e:	eb 23                	jmp    533 <stat+0x4c>
  r = fstat(fd, st);
 510:	8b 45 0c             	mov    0xc(%ebp),%eax
 513:	89 44 24 04          	mov    %eax,0x4(%esp)
 517:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51a:	89 04 24             	mov    %eax,(%esp)
 51d:	e8 26 02 00 00       	call   748 <fstat>
 522:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 525:	8b 45 f4             	mov    -0xc(%ebp),%eax
 528:	89 04 24             	mov    %eax,(%esp)
 52b:	e8 e8 01 00 00       	call   718 <close>
  return r;
 530:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 533:	c9                   	leave  
 534:	c3                   	ret    

00000535 <atoi>:

int
atoi(const char *s)
{
 535:	55                   	push   %ebp
 536:	89 e5                	mov    %esp,%ebp
 538:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 53b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 542:	eb 23                	jmp    567 <atoi+0x32>
    n = n*10 + *s++ - '0';
 544:	8b 55 fc             	mov    -0x4(%ebp),%edx
 547:	89 d0                	mov    %edx,%eax
 549:	c1 e0 02             	shl    $0x2,%eax
 54c:	01 d0                	add    %edx,%eax
 54e:	01 c0                	add    %eax,%eax
 550:	89 c2                	mov    %eax,%edx
 552:	8b 45 08             	mov    0x8(%ebp),%eax
 555:	0f b6 00             	movzbl (%eax),%eax
 558:	0f be c0             	movsbl %al,%eax
 55b:	01 d0                	add    %edx,%eax
 55d:	83 e8 30             	sub    $0x30,%eax
 560:	89 45 fc             	mov    %eax,-0x4(%ebp)
 563:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 567:	8b 45 08             	mov    0x8(%ebp),%eax
 56a:	0f b6 00             	movzbl (%eax),%eax
 56d:	3c 2f                	cmp    $0x2f,%al
 56f:	7e 0a                	jle    57b <atoi+0x46>
 571:	8b 45 08             	mov    0x8(%ebp),%eax
 574:	0f b6 00             	movzbl (%eax),%eax
 577:	3c 39                	cmp    $0x39,%al
 579:	7e c9                	jle    544 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 57b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 57e:	c9                   	leave  
 57f:	c3                   	ret    

00000580 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 586:	8b 45 08             	mov    0x8(%ebp),%eax
 589:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 58c:	8b 45 0c             	mov    0xc(%ebp),%eax
 58f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 592:	eb 13                	jmp    5a7 <memmove+0x27>
    *dst++ = *src++;
 594:	8b 45 f8             	mov    -0x8(%ebp),%eax
 597:	0f b6 10             	movzbl (%eax),%edx
 59a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59d:	88 10                	mov    %dl,(%eax)
 59f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 5a3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 5ab:	0f 9f c0             	setg   %al
 5ae:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 5b2:	84 c0                	test   %al,%al
 5b4:	75 de                	jne    594 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5b9:	c9                   	leave  
 5ba:	c3                   	ret    
 5bb:	90                   	nop

000005bc <SYS_ls_call01>:
 5bc:	6c                   	insb   (%dx),%es:(%edi)
 5bd:	73 5f                	jae    61e <SYS_ls_call10+0x8>
 5bf:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5c2:	6c                   	insb   (%dx),%es:(%edi)
 5c3:	30 31                	xor    %dh,(%ecx)
	...

000005c6 <SYS_ls_call02>:
 5c6:	6c                   	insb   (%dx),%es:(%edi)
 5c7:	73 5f                	jae    628 <SYS_ls_call11+0x8>
 5c9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5cc:	6c                   	insb   (%dx),%es:(%edi)
 5cd:	30 32                	xor    %dh,(%edx)
	...

000005d0 <SYS_ls_call03>:
 5d0:	6c                   	insb   (%dx),%es:(%edi)
 5d1:	73 5f                	jae    632 <SYS_ls_call12+0x8>
 5d3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5d6:	6c                   	insb   (%dx),%es:(%edi)
 5d7:	30 33                	xor    %dh,(%ebx)
	...

000005da <SYS_ls_call04>:
 5da:	6c                   	insb   (%dx),%es:(%edi)
 5db:	73 5f                	jae    63c <SYS_ls_call13+0x8>
 5dd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5e0:	6c                   	insb   (%dx),%es:(%edi)
 5e1:	30 34 00             	xor    %dh,(%eax,%eax,1)

000005e4 <SYS_ls_call05>:
 5e4:	6c                   	insb   (%dx),%es:(%edi)
 5e5:	73 5f                	jae    646 <SYS_ls_call14+0x8>
 5e7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5ea:	6c                   	insb   (%dx),%es:(%edi)
 5eb:	30 35 00 6c 73 5f    	xor    %dh,0x5f736c00

000005ee <SYS_ls_call06>:
 5ee:	6c                   	insb   (%dx),%es:(%edi)
 5ef:	73 5f                	jae    650 <SYS_ls_call15+0x8>
 5f1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5f4:	6c                   	insb   (%dx),%es:(%edi)
 5f5:	30 36                	xor    %dh,(%esi)
	...

000005f8 <SYS_ls_call07>:
 5f8:	6c                   	insb   (%dx),%es:(%edi)
 5f9:	73 5f                	jae    65a <SYS_ls_call16+0x8>
 5fb:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 5fe:	6c                   	insb   (%dx),%es:(%edi)
 5ff:	30 37                	xor    %dh,(%edi)
	...

00000602 <SYS_ls_call08>:
 602:	6c                   	insb   (%dx),%es:(%edi)
 603:	73 5f                	jae    664 <SYS_ls_call17+0x8>
 605:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 608:	6c                   	insb   (%dx),%es:(%edi)
 609:	30 38                	xor    %bh,(%eax)
	...

0000060c <SYS_ls_call09>:
 60c:	6c                   	insb   (%dx),%es:(%edi)
 60d:	73 5f                	jae    66e <SYS_ls_call18+0x8>
 60f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 612:	6c                   	insb   (%dx),%es:(%edi)
 613:	30 39                	xor    %bh,(%ecx)
	...

00000616 <SYS_ls_call10>:
 616:	6c                   	insb   (%dx),%es:(%edi)
 617:	73 5f                	jae    678 <SYS_ls_call19+0x8>
 619:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 61c:	6c                   	insb   (%dx),%es:(%edi)
 61d:	31 30                	xor    %esi,(%eax)
	...

00000620 <SYS_ls_call11>:
 620:	6c                   	insb   (%dx),%es:(%edi)
 621:	73 5f                	jae    682 <SYS_ls_call20+0x8>
 623:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 626:	6c                   	insb   (%dx),%es:(%edi)
 627:	31 31                	xor    %esi,(%ecx)
	...

0000062a <SYS_ls_call12>:
 62a:	6c                   	insb   (%dx),%es:(%edi)
 62b:	73 5f                	jae    68c <SYS_ls_call21+0x8>
 62d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 630:	6c                   	insb   (%dx),%es:(%edi)
 631:	31 32                	xor    %esi,(%edx)
	...

00000634 <SYS_ls_call13>:
 634:	6c                   	insb   (%dx),%es:(%edi)
 635:	73 5f                	jae    696 <SYS_ls_call22+0x8>
 637:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 63a:	6c                   	insb   (%dx),%es:(%edi)
 63b:	31 33                	xor    %esi,(%ebx)
	...

0000063e <SYS_ls_call14>:
 63e:	6c                   	insb   (%dx),%es:(%edi)
 63f:	73 5f                	jae    6a0 <SYS_ls_call23+0x8>
 641:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 644:	6c                   	insb   (%dx),%es:(%edi)
 645:	31 34 00             	xor    %esi,(%eax,%eax,1)

00000648 <SYS_ls_call15>:
 648:	6c                   	insb   (%dx),%es:(%edi)
 649:	73 5f                	jae    6aa <SYS_ls_call24+0x8>
 64b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 64e:	6c                   	insb   (%dx),%es:(%edi)
 64f:	31 35 00 6c 73 5f    	xor    %esi,0x5f736c00

00000652 <SYS_ls_call16>:
 652:	6c                   	insb   (%dx),%es:(%edi)
 653:	73 5f                	jae    6b4 <SYS_ls_call25+0x8>
 655:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 658:	6c                   	insb   (%dx),%es:(%edi)
 659:	31 36                	xor    %esi,(%esi)
	...

0000065c <SYS_ls_call17>:
 65c:	6c                   	insb   (%dx),%es:(%edi)
 65d:	73 5f                	jae    6be <SYS_ls_call26+0x8>
 65f:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 662:	6c                   	insb   (%dx),%es:(%edi)
 663:	31 37                	xor    %esi,(%edi)
	...

00000666 <SYS_ls_call18>:
 666:	6c                   	insb   (%dx),%es:(%edi)
 667:	73 5f                	jae    6c8 <SYS_ls_call27+0x8>
 669:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 66c:	6c                   	insb   (%dx),%es:(%edi)
 66d:	31 38                	xor    %edi,(%eax)
	...

00000670 <SYS_ls_call19>:
 670:	6c                   	insb   (%dx),%es:(%edi)
 671:	73 5f                	jae    6d2 <SYS_ls_call28+0x8>
 673:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 676:	6c                   	insb   (%dx),%es:(%edi)
 677:	31 39                	xor    %edi,(%ecx)
	...

0000067a <SYS_ls_call20>:
 67a:	6c                   	insb   (%dx),%es:(%edi)
 67b:	73 5f                	jae    6dc <SYS_ls_call29+0x8>
 67d:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 680:	6c                   	insb   (%dx),%es:(%edi)
 681:	32 30                	xor    (%eax),%dh
	...

00000684 <SYS_ls_call21>:
 684:	6c                   	insb   (%dx),%es:(%edi)
 685:	73 5f                	jae    6e6 <SYS_ls_call30+0x8>
 687:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 68a:	6c                   	insb   (%dx),%es:(%edi)
 68b:	32 31                	xor    (%ecx),%dh
	...

0000068e <SYS_ls_call22>:
 68e:	6c                   	insb   (%dx),%es:(%edi)
 68f:	73 5f                	jae    6f0 <exit>
 691:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 694:	6c                   	insb   (%dx),%es:(%edi)
 695:	32 32                	xor    (%edx),%dh
	...

00000698 <SYS_ls_call23>:
 698:	6c                   	insb   (%dx),%es:(%edi)
 699:	73 5f                	jae    6fa <wait+0x2>
 69b:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 69e:	6c                   	insb   (%dx),%es:(%edi)
 69f:	32 33                	xor    (%ebx),%dh
	...

000006a2 <SYS_ls_call24>:
 6a2:	6c                   	insb   (%dx),%es:(%edi)
 6a3:	73 5f                	jae    704 <pipe+0x4>
 6a5:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6a8:	6c                   	insb   (%dx),%es:(%edi)
 6a9:	32 34 00             	xor    (%eax,%eax,1),%dh

000006ac <SYS_ls_call25>:
 6ac:	6c                   	insb   (%dx),%es:(%edi)
 6ad:	73 5f                	jae    70e <read+0x6>
 6af:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6b2:	6c                   	insb   (%dx),%es:(%edi)
 6b3:	32 35 00 6c 73 5f    	xor    0x5f736c00,%dh

000006b6 <SYS_ls_call26>:
 6b6:	6c                   	insb   (%dx),%es:(%edi)
 6b7:	73 5f                	jae    718 <close>
 6b9:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6bc:	6c                   	insb   (%dx),%es:(%edi)
 6bd:	32 36                	xor    (%esi),%dh
	...

000006c0 <SYS_ls_call27>:
 6c0:	6c                   	insb   (%dx),%es:(%edi)
 6c1:	73 5f                	jae    722 <kill+0x2>
 6c3:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6c6:	6c                   	insb   (%dx),%es:(%edi)
 6c7:	32 37                	xor    (%edi),%dh
	...

000006ca <SYS_ls_call28>:
 6ca:	6c                   	insb   (%dx),%es:(%edi)
 6cb:	73 5f                	jae    72c <exec+0x4>
 6cd:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6d0:	6c                   	insb   (%dx),%es:(%edi)
 6d1:	32 38                	xor    (%eax),%bh
	...

000006d4 <SYS_ls_call29>:
 6d4:	6c                   	insb   (%dx),%es:(%edi)
 6d5:	73 5f                	jae    736 <open+0x6>
 6d7:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6da:	6c                   	insb   (%dx),%es:(%edi)
 6db:	32 39                	xor    (%ecx),%bh
	...

000006de <SYS_ls_call30>:
 6de:	6c                   	insb   (%dx),%es:(%edi)
 6df:	73 5f                	jae    740 <unlink>
 6e1:	63 61 6c             	arpl   %sp,0x6c(%ecx)
 6e4:	6c                   	insb   (%dx),%es:(%edi)
 6e5:	33 30                	xor    (%eax),%esi
	...

000006e8 <fork>:
        .string "ls_call29"

SYS_ls_call30:
        .string "ls_call30" 

SYSCALL(fork)
 6e8:	b8 01 00 00 00       	mov    $0x1,%eax
 6ed:	cd 40                	int    $0x40
 6ef:	c3                   	ret    

000006f0 <exit>:
SYSCALL(exit)
 6f0:	b8 02 00 00 00       	mov    $0x2,%eax
 6f5:	cd 40                	int    $0x40
 6f7:	c3                   	ret    

000006f8 <wait>:
SYSCALL(wait)
 6f8:	b8 03 00 00 00       	mov    $0x3,%eax
 6fd:	cd 40                	int    $0x40
 6ff:	c3                   	ret    

00000700 <pipe>:
SYSCALL(pipe)
 700:	b8 04 00 00 00       	mov    $0x4,%eax
 705:	cd 40                	int    $0x40
 707:	c3                   	ret    

00000708 <read>:
SYSCALL(read)
 708:	b8 05 00 00 00       	mov    $0x5,%eax
 70d:	cd 40                	int    $0x40
 70f:	c3                   	ret    

00000710 <write>:
SYSCALL(write)
 710:	b8 10 00 00 00       	mov    $0x10,%eax
 715:	cd 40                	int    $0x40
 717:	c3                   	ret    

00000718 <close>:
SYSCALL(close)
 718:	b8 15 00 00 00       	mov    $0x15,%eax
 71d:	cd 40                	int    $0x40
 71f:	c3                   	ret    

00000720 <kill>:
SYSCALL(kill)
 720:	b8 06 00 00 00       	mov    $0x6,%eax
 725:	cd 40                	int    $0x40
 727:	c3                   	ret    

00000728 <exec>:
SYSCALL(exec)
 728:	b8 07 00 00 00       	mov    $0x7,%eax
 72d:	cd 40                	int    $0x40
 72f:	c3                   	ret    

00000730 <open>:
SYSCALL(open)
 730:	b8 0f 00 00 00       	mov    $0xf,%eax
 735:	cd 40                	int    $0x40
 737:	c3                   	ret    

00000738 <mknod>:
SYSCALL(mknod)
 738:	b8 11 00 00 00       	mov    $0x11,%eax
 73d:	cd 40                	int    $0x40
 73f:	c3                   	ret    

00000740 <unlink>:
SYSCALL(unlink)
 740:	b8 12 00 00 00       	mov    $0x12,%eax
 745:	cd 40                	int    $0x40
 747:	c3                   	ret    

00000748 <fstat>:
SYSCALL(fstat)
 748:	b8 08 00 00 00       	mov    $0x8,%eax
 74d:	cd 40                	int    $0x40
 74f:	c3                   	ret    

00000750 <link>:
SYSCALL(link)
 750:	b8 13 00 00 00       	mov    $0x13,%eax
 755:	cd 40                	int    $0x40
 757:	c3                   	ret    

00000758 <mkdir>:
SYSCALL(mkdir)
 758:	b8 14 00 00 00       	mov    $0x14,%eax
 75d:	cd 40                	int    $0x40
 75f:	c3                   	ret    

00000760 <chdir>:
SYSCALL(chdir)
 760:	b8 09 00 00 00       	mov    $0x9,%eax
 765:	cd 40                	int    $0x40
 767:	c3                   	ret    

00000768 <dup>:
SYSCALL(dup)
 768:	b8 0a 00 00 00       	mov    $0xa,%eax
 76d:	cd 40                	int    $0x40
 76f:	c3                   	ret    

00000770 <getpid>:
SYSCALL(getpid)
 770:	b8 0b 00 00 00       	mov    $0xb,%eax
 775:	cd 40                	int    $0x40
 777:	c3                   	ret    

00000778 <sbrk>:
SYSCALL(sbrk)
 778:	b8 0c 00 00 00       	mov    $0xc,%eax
 77d:	cd 40                	int    $0x40
 77f:	c3                   	ret    

00000780 <sleep>:
SYSCALL(sleep)
 780:	b8 0d 00 00 00       	mov    $0xd,%eax
 785:	cd 40                	int    $0x40
 787:	c3                   	ret    

00000788 <uptime>:
SYSCALL(uptime)
 788:	b8 0e 00 00 00       	mov    $0xe,%eax
 78d:	cd 40                	int    $0x40
 78f:	c3                   	ret    

00000790 <date>:
SYSCALL(date)
 790:	b8 16 00 00 00       	mov    $0x16,%eax
 795:	cd 40                	int    $0x40
 797:	c3                   	ret    

00000798 <ls_call01>:

SYSCALL1(ls_call01)
 798:	b8 bc 05 00 00       	mov    $0x5bc,%eax
 79d:	cd 41                	int    $0x41
 79f:	c3                   	ret    

000007a0 <ls_call02>:
SYSCALL1(ls_call02)
 7a0:	b8 c6 05 00 00       	mov    $0x5c6,%eax
 7a5:	cd 41                	int    $0x41
 7a7:	c3                   	ret    

000007a8 <ls_call03>:
SYSCALL1(ls_call03)
 7a8:	b8 d0 05 00 00       	mov    $0x5d0,%eax
 7ad:	cd 41                	int    $0x41
 7af:	c3                   	ret    

000007b0 <ls_call04>:
SYSCALL1(ls_call04)
 7b0:	b8 da 05 00 00       	mov    $0x5da,%eax
 7b5:	cd 41                	int    $0x41
 7b7:	c3                   	ret    

000007b8 <ls_call05>:
SYSCALL1(ls_call05)
 7b8:	b8 e4 05 00 00       	mov    $0x5e4,%eax
 7bd:	cd 41                	int    $0x41
 7bf:	c3                   	ret    

000007c0 <ls_call06>:
SYSCALL1(ls_call06)
 7c0:	b8 ee 05 00 00       	mov    $0x5ee,%eax
 7c5:	cd 41                	int    $0x41
 7c7:	c3                   	ret    

000007c8 <ls_call07>:
SYSCALL1(ls_call07)
 7c8:	b8 f8 05 00 00       	mov    $0x5f8,%eax
 7cd:	cd 41                	int    $0x41
 7cf:	c3                   	ret    

000007d0 <ls_call08>:
SYSCALL1(ls_call08)
 7d0:	b8 02 06 00 00       	mov    $0x602,%eax
 7d5:	cd 41                	int    $0x41
 7d7:	c3                   	ret    

000007d8 <ls_call09>:
SYSCALL1(ls_call09)
 7d8:	b8 0c 06 00 00       	mov    $0x60c,%eax
 7dd:	cd 41                	int    $0x41
 7df:	c3                   	ret    

000007e0 <ls_call10>:
SYSCALL1(ls_call10)
 7e0:	b8 16 06 00 00       	mov    $0x616,%eax
 7e5:	cd 41                	int    $0x41
 7e7:	c3                   	ret    

000007e8 <ls_call11>:
SYSCALL1(ls_call11)
 7e8:	b8 20 06 00 00       	mov    $0x620,%eax
 7ed:	cd 41                	int    $0x41
 7ef:	c3                   	ret    

000007f0 <ls_call12>:
SYSCALL1(ls_call12)
 7f0:	b8 2a 06 00 00       	mov    $0x62a,%eax
 7f5:	cd 41                	int    $0x41
 7f7:	c3                   	ret    

000007f8 <ls_call13>:
SYSCALL1(ls_call13)
 7f8:	b8 34 06 00 00       	mov    $0x634,%eax
 7fd:	cd 41                	int    $0x41
 7ff:	c3                   	ret    

00000800 <ls_call14>:
SYSCALL1(ls_call14)
 800:	b8 3e 06 00 00       	mov    $0x63e,%eax
 805:	cd 41                	int    $0x41
 807:	c3                   	ret    

00000808 <ls_call15>:
SYSCALL1(ls_call15)
 808:	b8 48 06 00 00       	mov    $0x648,%eax
 80d:	cd 41                	int    $0x41
 80f:	c3                   	ret    

00000810 <ls_call16>:
SYSCALL1(ls_call16)
 810:	b8 52 06 00 00       	mov    $0x652,%eax
 815:	cd 41                	int    $0x41
 817:	c3                   	ret    

00000818 <ls_call17>:
SYSCALL1(ls_call17)
 818:	b8 5c 06 00 00       	mov    $0x65c,%eax
 81d:	cd 41                	int    $0x41
 81f:	c3                   	ret    

00000820 <ls_call18>:
SYSCALL1(ls_call18)
 820:	b8 66 06 00 00       	mov    $0x666,%eax
 825:	cd 41                	int    $0x41
 827:	c3                   	ret    

00000828 <ls_call19>:
SYSCALL1(ls_call19)
 828:	b8 70 06 00 00       	mov    $0x670,%eax
 82d:	cd 41                	int    $0x41
 82f:	c3                   	ret    

00000830 <ls_call20>:
SYSCALL1(ls_call20)
 830:	b8 7a 06 00 00       	mov    $0x67a,%eax
 835:	cd 41                	int    $0x41
 837:	c3                   	ret    

00000838 <ls_call21>:
SYSCALL1(ls_call21)
 838:	b8 84 06 00 00       	mov    $0x684,%eax
 83d:	cd 41                	int    $0x41
 83f:	c3                   	ret    

00000840 <ls_call22>:
SYSCALL1(ls_call22)
 840:	b8 8e 06 00 00       	mov    $0x68e,%eax
 845:	cd 41                	int    $0x41
 847:	c3                   	ret    

00000848 <ls_call23>:
SYSCALL1(ls_call23)
 848:	b8 98 06 00 00       	mov    $0x698,%eax
 84d:	cd 41                	int    $0x41
 84f:	c3                   	ret    

00000850 <ls_call24>:
SYSCALL1(ls_call24)
 850:	b8 a2 06 00 00       	mov    $0x6a2,%eax
 855:	cd 41                	int    $0x41
 857:	c3                   	ret    

00000858 <ls_call25>:
SYSCALL1(ls_call25)
 858:	b8 ac 06 00 00       	mov    $0x6ac,%eax
 85d:	cd 41                	int    $0x41
 85f:	c3                   	ret    

00000860 <ls_call26>:
SYSCALL1(ls_call26)
 860:	b8 b6 06 00 00       	mov    $0x6b6,%eax
 865:	cd 41                	int    $0x41
 867:	c3                   	ret    

00000868 <ls_call27>:
SYSCALL1(ls_call27)
 868:	b8 c0 06 00 00       	mov    $0x6c0,%eax
 86d:	cd 41                	int    $0x41
 86f:	c3                   	ret    

00000870 <ls_call28>:
SYSCALL1(ls_call28)
 870:	b8 ca 06 00 00       	mov    $0x6ca,%eax
 875:	cd 41                	int    $0x41
 877:	c3                   	ret    

00000878 <ls_call29>:
SYSCALL1(ls_call29)
 878:	b8 d4 06 00 00       	mov    $0x6d4,%eax
 87d:	cd 41                	int    $0x41
 87f:	c3                   	ret    

00000880 <ls_call30>:
SYSCALL1(ls_call30)
 880:	b8 de 06 00 00       	mov    $0x6de,%eax
 885:	cd 41                	int    $0x41
 887:	c3                   	ret    

00000888 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 888:	55                   	push   %ebp
 889:	89 e5                	mov    %esp,%ebp
 88b:	83 ec 28             	sub    $0x28,%esp
 88e:	8b 45 0c             	mov    0xc(%ebp),%eax
 891:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 894:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 89b:	00 
 89c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 89f:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a3:	8b 45 08             	mov    0x8(%ebp),%eax
 8a6:	89 04 24             	mov    %eax,(%esp)
 8a9:	e8 62 fe ff ff       	call   710 <write>
}
 8ae:	c9                   	leave  
 8af:	c3                   	ret    

000008b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 8b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 8bd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 8c1:	74 17                	je     8da <printint+0x2a>
 8c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 8c7:	79 11                	jns    8da <printint+0x2a>
    neg = 1;
 8c9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 8d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 8d3:	f7 d8                	neg    %eax
 8d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 8d8:	eb 06                	jmp    8e0 <printint+0x30>
  } else {
    x = xx;
 8da:	8b 45 0c             	mov    0xc(%ebp),%eax
 8dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 8e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 8e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 8ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8ed:	ba 00 00 00 00       	mov    $0x0,%edx
 8f2:	f7 f1                	div    %ecx
 8f4:	89 d0                	mov    %edx,%eax
 8f6:	0f b6 80 18 10 00 00 	movzbl 0x1018(%eax),%eax
 8fd:	8d 4d dc             	lea    -0x24(%ebp),%ecx
 900:	8b 55 f4             	mov    -0xc(%ebp),%edx
 903:	01 ca                	add    %ecx,%edx
 905:	88 02                	mov    %al,(%edx)
 907:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 90b:	8b 55 10             	mov    0x10(%ebp),%edx
 90e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 911:	8b 45 ec             	mov    -0x14(%ebp),%eax
 914:	ba 00 00 00 00       	mov    $0x0,%edx
 919:	f7 75 d4             	divl   -0x2c(%ebp)
 91c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 91f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 923:	75 c2                	jne    8e7 <printint+0x37>
  if(neg)
 925:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 929:	74 2e                	je     959 <printint+0xa9>
    buf[i++] = '-';
 92b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 92e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 931:	01 d0                	add    %edx,%eax
 933:	c6 00 2d             	movb   $0x2d,(%eax)
 936:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 93a:	eb 1d                	jmp    959 <printint+0xa9>
    putc(fd, buf[i]);
 93c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 93f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 942:	01 d0                	add    %edx,%eax
 944:	0f b6 00             	movzbl (%eax),%eax
 947:	0f be c0             	movsbl %al,%eax
 94a:	89 44 24 04          	mov    %eax,0x4(%esp)
 94e:	8b 45 08             	mov    0x8(%ebp),%eax
 951:	89 04 24             	mov    %eax,(%esp)
 954:	e8 2f ff ff ff       	call   888 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 959:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 95d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 961:	79 d9                	jns    93c <printint+0x8c>
    putc(fd, buf[i]);
}
 963:	c9                   	leave  
 964:	c3                   	ret    

00000965 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 965:	55                   	push   %ebp
 966:	89 e5                	mov    %esp,%ebp
 968:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 96b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 972:	8d 45 0c             	lea    0xc(%ebp),%eax
 975:	83 c0 04             	add    $0x4,%eax
 978:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 97b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 982:	e9 7d 01 00 00       	jmp    b04 <printf+0x19f>
    c = fmt[i] & 0xff;
 987:	8b 55 0c             	mov    0xc(%ebp),%edx
 98a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 98d:	01 d0                	add    %edx,%eax
 98f:	0f b6 00             	movzbl (%eax),%eax
 992:	0f be c0             	movsbl %al,%eax
 995:	25 ff 00 00 00       	and    $0xff,%eax
 99a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 99d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 9a1:	75 2c                	jne    9cf <printf+0x6a>
      if(c == '%'){
 9a3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 9a7:	75 0c                	jne    9b5 <printf+0x50>
        state = '%';
 9a9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 9b0:	e9 4b 01 00 00       	jmp    b00 <printf+0x19b>
      } else {
        putc(fd, c);
 9b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9b8:	0f be c0             	movsbl %al,%eax
 9bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 9bf:	8b 45 08             	mov    0x8(%ebp),%eax
 9c2:	89 04 24             	mov    %eax,(%esp)
 9c5:	e8 be fe ff ff       	call   888 <putc>
 9ca:	e9 31 01 00 00       	jmp    b00 <printf+0x19b>
      }
    } else if(state == '%'){
 9cf:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 9d3:	0f 85 27 01 00 00    	jne    b00 <printf+0x19b>
      if(c == 'd'){
 9d9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 9dd:	75 2d                	jne    a0c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 9df:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9e2:	8b 00                	mov    (%eax),%eax
 9e4:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 9eb:	00 
 9ec:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 9f3:	00 
 9f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 9f8:	8b 45 08             	mov    0x8(%ebp),%eax
 9fb:	89 04 24             	mov    %eax,(%esp)
 9fe:	e8 ad fe ff ff       	call   8b0 <printint>
        ap++;
 a03:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 a07:	e9 ed 00 00 00       	jmp    af9 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 a0c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 a10:	74 06                	je     a18 <printf+0xb3>
 a12:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 a16:	75 2d                	jne    a45 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 a18:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a1b:	8b 00                	mov    (%eax),%eax
 a1d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 a24:	00 
 a25:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 a2c:	00 
 a2d:	89 44 24 04          	mov    %eax,0x4(%esp)
 a31:	8b 45 08             	mov    0x8(%ebp),%eax
 a34:	89 04 24             	mov    %eax,(%esp)
 a37:	e8 74 fe ff ff       	call   8b0 <printint>
        ap++;
 a3c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 a40:	e9 b4 00 00 00       	jmp    af9 <printf+0x194>
      } else if(c == 's'){
 a45:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 a49:	75 46                	jne    a91 <printf+0x12c>
        s = (char*)*ap;
 a4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a4e:	8b 00                	mov    (%eax),%eax
 a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 a53:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 a57:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a5b:	75 27                	jne    a84 <printf+0x11f>
          s = "(null)";
 a5d:	c7 45 f4 7f 0d 00 00 	movl   $0xd7f,-0xc(%ebp)
        while(*s != 0){
 a64:	eb 1e                	jmp    a84 <printf+0x11f>
          putc(fd, *s);
 a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a69:	0f b6 00             	movzbl (%eax),%eax
 a6c:	0f be c0             	movsbl %al,%eax
 a6f:	89 44 24 04          	mov    %eax,0x4(%esp)
 a73:	8b 45 08             	mov    0x8(%ebp),%eax
 a76:	89 04 24             	mov    %eax,(%esp)
 a79:	e8 0a fe ff ff       	call   888 <putc>
          s++;
 a7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a82:	eb 01                	jmp    a85 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a84:	90                   	nop
 a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a88:	0f b6 00             	movzbl (%eax),%eax
 a8b:	84 c0                	test   %al,%al
 a8d:	75 d7                	jne    a66 <printf+0x101>
 a8f:	eb 68                	jmp    af9 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a91:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 a95:	75 1d                	jne    ab4 <printf+0x14f>
        putc(fd, *ap);
 a97:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a9a:	8b 00                	mov    (%eax),%eax
 a9c:	0f be c0             	movsbl %al,%eax
 a9f:	89 44 24 04          	mov    %eax,0x4(%esp)
 aa3:	8b 45 08             	mov    0x8(%ebp),%eax
 aa6:	89 04 24             	mov    %eax,(%esp)
 aa9:	e8 da fd ff ff       	call   888 <putc>
        ap++;
 aae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 ab2:	eb 45                	jmp    af9 <printf+0x194>
      } else if(c == '%'){
 ab4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 ab8:	75 17                	jne    ad1 <printf+0x16c>
        putc(fd, c);
 aba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 abd:	0f be c0             	movsbl %al,%eax
 ac0:	89 44 24 04          	mov    %eax,0x4(%esp)
 ac4:	8b 45 08             	mov    0x8(%ebp),%eax
 ac7:	89 04 24             	mov    %eax,(%esp)
 aca:	e8 b9 fd ff ff       	call   888 <putc>
 acf:	eb 28                	jmp    af9 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 ad1:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 ad8:	00 
 ad9:	8b 45 08             	mov    0x8(%ebp),%eax
 adc:	89 04 24             	mov    %eax,(%esp)
 adf:	e8 a4 fd ff ff       	call   888 <putc>
        putc(fd, c);
 ae4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 ae7:	0f be c0             	movsbl %al,%eax
 aea:	89 44 24 04          	mov    %eax,0x4(%esp)
 aee:	8b 45 08             	mov    0x8(%ebp),%eax
 af1:	89 04 24             	mov    %eax,(%esp)
 af4:	e8 8f fd ff ff       	call   888 <putc>
      }
      state = 0;
 af9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b00:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 b04:	8b 55 0c             	mov    0xc(%ebp),%edx
 b07:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b0a:	01 d0                	add    %edx,%eax
 b0c:	0f b6 00             	movzbl (%eax),%eax
 b0f:	84 c0                	test   %al,%al
 b11:	0f 85 70 fe ff ff    	jne    987 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 b17:	c9                   	leave  
 b18:	c3                   	ret    
 b19:	90                   	nop
 b1a:	90                   	nop
 b1b:	90                   	nop

00000b1c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b1c:	55                   	push   %ebp
 b1d:	89 e5                	mov    %esp,%ebp
 b1f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b22:	8b 45 08             	mov    0x8(%ebp),%eax
 b25:	83 e8 08             	sub    $0x8,%eax
 b28:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2b:	a1 44 10 00 00       	mov    0x1044,%eax
 b30:	89 45 fc             	mov    %eax,-0x4(%ebp)
 b33:	eb 24                	jmp    b59 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b35:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b38:	8b 00                	mov    (%eax),%eax
 b3a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 b3d:	77 12                	ja     b51 <free+0x35>
 b3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b42:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 b45:	77 24                	ja     b6b <free+0x4f>
 b47:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b4a:	8b 00                	mov    (%eax),%eax
 b4c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 b4f:	77 1a                	ja     b6b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b51:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b54:	8b 00                	mov    (%eax),%eax
 b56:	89 45 fc             	mov    %eax,-0x4(%ebp)
 b59:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b5c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 b5f:	76 d4                	jbe    b35 <free+0x19>
 b61:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b64:	8b 00                	mov    (%eax),%eax
 b66:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 b69:	76 ca                	jbe    b35 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 b6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b6e:	8b 40 04             	mov    0x4(%eax),%eax
 b71:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 b78:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b7b:	01 c2                	add    %eax,%edx
 b7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b80:	8b 00                	mov    (%eax),%eax
 b82:	39 c2                	cmp    %eax,%edx
 b84:	75 24                	jne    baa <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 b86:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b89:	8b 50 04             	mov    0x4(%eax),%edx
 b8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b8f:	8b 00                	mov    (%eax),%eax
 b91:	8b 40 04             	mov    0x4(%eax),%eax
 b94:	01 c2                	add    %eax,%edx
 b96:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b99:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 b9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b9f:	8b 00                	mov    (%eax),%eax
 ba1:	8b 10                	mov    (%eax),%edx
 ba3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ba6:	89 10                	mov    %edx,(%eax)
 ba8:	eb 0a                	jmp    bb4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 baa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bad:	8b 10                	mov    (%eax),%edx
 baf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 bb2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 bb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bb7:	8b 40 04             	mov    0x4(%eax),%eax
 bba:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 bc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bc4:	01 d0                	add    %edx,%eax
 bc6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 bc9:	75 20                	jne    beb <free+0xcf>
    p->s.size += bp->s.size;
 bcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bce:	8b 50 04             	mov    0x4(%eax),%edx
 bd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 bd4:	8b 40 04             	mov    0x4(%eax),%eax
 bd7:	01 c2                	add    %eax,%edx
 bd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bdc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 bdf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 be2:	8b 10                	mov    (%eax),%edx
 be4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 be7:	89 10                	mov    %edx,(%eax)
 be9:	eb 08                	jmp    bf3 <free+0xd7>
  } else
    p->s.ptr = bp;
 beb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bee:	8b 55 f8             	mov    -0x8(%ebp),%edx
 bf1:	89 10                	mov    %edx,(%eax)
  freep = p;
 bf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 bf6:	a3 44 10 00 00       	mov    %eax,0x1044
}
 bfb:	c9                   	leave  
 bfc:	c3                   	ret    

00000bfd <morecore>:

static Header*
morecore(uint nu)
{
 bfd:	55                   	push   %ebp
 bfe:	89 e5                	mov    %esp,%ebp
 c00:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 c03:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 c0a:	77 07                	ja     c13 <morecore+0x16>
    nu = 4096;
 c0c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 c13:	8b 45 08             	mov    0x8(%ebp),%eax
 c16:	c1 e0 03             	shl    $0x3,%eax
 c19:	89 04 24             	mov    %eax,(%esp)
 c1c:	e8 57 fb ff ff       	call   778 <sbrk>
 c21:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 c24:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 c28:	75 07                	jne    c31 <morecore+0x34>
    return 0;
 c2a:	b8 00 00 00 00       	mov    $0x0,%eax
 c2f:	eb 22                	jmp    c53 <morecore+0x56>
  hp = (Header*)p;
 c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 c37:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c3a:	8b 55 08             	mov    0x8(%ebp),%edx
 c3d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 c40:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c43:	83 c0 08             	add    $0x8,%eax
 c46:	89 04 24             	mov    %eax,(%esp)
 c49:	e8 ce fe ff ff       	call   b1c <free>
  return freep;
 c4e:	a1 44 10 00 00       	mov    0x1044,%eax
}
 c53:	c9                   	leave  
 c54:	c3                   	ret    

00000c55 <malloc>:

void*
malloc(uint nbytes)
{
 c55:	55                   	push   %ebp
 c56:	89 e5                	mov    %esp,%ebp
 c58:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c5b:	8b 45 08             	mov    0x8(%ebp),%eax
 c5e:	83 c0 07             	add    $0x7,%eax
 c61:	c1 e8 03             	shr    $0x3,%eax
 c64:	83 c0 01             	add    $0x1,%eax
 c67:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 c6a:	a1 44 10 00 00       	mov    0x1044,%eax
 c6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 c72:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c76:	75 23                	jne    c9b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 c78:	c7 45 f0 3c 10 00 00 	movl   $0x103c,-0x10(%ebp)
 c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c82:	a3 44 10 00 00       	mov    %eax,0x1044
 c87:	a1 44 10 00 00       	mov    0x1044,%eax
 c8c:	a3 3c 10 00 00       	mov    %eax,0x103c
    base.s.size = 0;
 c91:	c7 05 40 10 00 00 00 	movl   $0x0,0x1040
 c98:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c9e:	8b 00                	mov    (%eax),%eax
 ca0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ca6:	8b 40 04             	mov    0x4(%eax),%eax
 ca9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 cac:	72 4d                	jb     cfb <malloc+0xa6>
      if(p->s.size == nunits)
 cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cb1:	8b 40 04             	mov    0x4(%eax),%eax
 cb4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 cb7:	75 0c                	jne    cc5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cbc:	8b 10                	mov    (%eax),%edx
 cbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cc1:	89 10                	mov    %edx,(%eax)
 cc3:	eb 26                	jmp    ceb <malloc+0x96>
      else {
        p->s.size -= nunits;
 cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cc8:	8b 40 04             	mov    0x4(%eax),%eax
 ccb:	89 c2                	mov    %eax,%edx
 ccd:	2b 55 ec             	sub    -0x14(%ebp),%edx
 cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cd3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 cd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cd9:	8b 40 04             	mov    0x4(%eax),%eax
 cdc:	c1 e0 03             	shl    $0x3,%eax
 cdf:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ce2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ce5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ce8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 ceb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cee:	a3 44 10 00 00       	mov    %eax,0x1044
      return (void*)(p + 1);
 cf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cf6:	83 c0 08             	add    $0x8,%eax
 cf9:	eb 38                	jmp    d33 <malloc+0xde>
    }
    if(p == freep)
 cfb:	a1 44 10 00 00       	mov    0x1044,%eax
 d00:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 d03:	75 1b                	jne    d20 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 d05:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d08:	89 04 24             	mov    %eax,(%esp)
 d0b:	e8 ed fe ff ff       	call   bfd <morecore>
 d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
 d13:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d17:	75 07                	jne    d20 <malloc+0xcb>
        return 0;
 d19:	b8 00 00 00 00       	mov    $0x0,%eax
 d1e:	eb 13                	jmp    d33 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d20:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d23:	89 45 f0             	mov    %eax,-0x10(%ebp)
 d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d29:	8b 00                	mov    (%eax),%eax
 d2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 d2e:	e9 70 ff ff ff       	jmp    ca3 <malloc+0x4e>
}
 d33:	c9                   	leave  
 d34:	c3                   	ret    
