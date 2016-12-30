
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 67 38 10 80       	mov    $0x80103867,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 b8 85 10 	movl   $0x801085b8,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100049:	e8 3c 4f 00 00       	call   80104f8a <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 70 05 11 80 64 	movl   $0x80110564,0x80110570
80100055:	05 11 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 74 05 11 80 64 	movl   $0x80110564,0x80110574
8010005f:	05 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 74 05 11 80       	mov    0x80110574,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 74 05 11 80       	mov    %eax,0x80110574

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
801000ac:	72 bd                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ae:	c9                   	leave  
801000af:	c3                   	ret    

801000b0 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000b0:	55                   	push   %ebp
801000b1:	89 e5                	mov    %esp,%ebp
801000b3:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b6:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801000bd:	e8 e9 4e 00 00       	call   80104fab <acquire>

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c2:	a1 74 05 11 80       	mov    0x80110574,%eax
801000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000ca:	eb 63                	jmp    8010012f <bget+0x7f>
    if(b->dev == dev && b->blockno == blockno){
801000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000cf:	8b 40 04             	mov    0x4(%eax),%eax
801000d2:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d5:	75 4f                	jne    80100126 <bget+0x76>
801000d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000da:	8b 40 08             	mov    0x8(%eax),%eax
801000dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e0:	75 44                	jne    80100126 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e5:	8b 00                	mov    (%eax),%eax
801000e7:	83 e0 01             	and    $0x1,%eax
801000ea:	85 c0                	test   %eax,%eax
801000ec:	75 23                	jne    80100111 <bget+0x61>
        b->flags |= B_BUSY;
801000ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f1:	8b 00                	mov    (%eax),%eax
801000f3:	89 c2                	mov    %eax,%edx
801000f5:	83 ca 01             	or     $0x1,%edx
801000f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fb:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fd:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100104:	e8 04 4f 00 00       	call   8010500d <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 60 c6 10 	movl   $0x8010c660,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 a9 4b 00 00       	call   80104ccd <sleep>
      goto loop;
80100124:	eb 9c                	jmp    801000c2 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 10             	mov    0x10(%eax),%eax
8010012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010012f:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100136:	75 94                	jne    801000cc <bget+0x1c>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100138:	a1 70 05 11 80       	mov    0x80110570,%eax
8010013d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100140:	eb 4d                	jmp    8010018f <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100145:	8b 00                	mov    (%eax),%eax
80100147:	83 e0 01             	and    $0x1,%eax
8010014a:	85 c0                	test   %eax,%eax
8010014c:	75 38                	jne    80100186 <bget+0xd6>
8010014e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100151:	8b 00                	mov    (%eax),%eax
80100153:	83 e0 04             	and    $0x4,%eax
80100156:	85 c0                	test   %eax,%eax
80100158:	75 2c                	jne    80100186 <bget+0xd6>
      b->dev = dev;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	8b 55 08             	mov    0x8(%ebp),%edx
80100160:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 0c             	mov    0xc(%ebp),%edx
80100169:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100175:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010017c:	e8 8c 4e 00 00       	call   8010500d <release>
      return b;
80100181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100184:	eb 1e                	jmp    801001a4 <bget+0xf4>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100189:	8b 40 0c             	mov    0xc(%eax),%eax
8010018c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010018f:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100196:	75 aa                	jne    80100142 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100198:	c7 04 24 bf 85 10 80 	movl   $0x801085bf,(%esp)
8010019f:	e8 a2 03 00 00       	call   80100546 <panic>
}
801001a4:	c9                   	leave  
801001a5:	c3                   	ret    

801001a6 <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001a6:	55                   	push   %ebp
801001a7:	89 e5                	mov    %esp,%ebp
801001a9:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801001af:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b3:	8b 45 08             	mov    0x8(%ebp),%eax
801001b6:	89 04 24             	mov    %eax,(%esp)
801001b9:	e8 f2 fe ff ff       	call   801000b0 <bget>
801001be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c4:	8b 00                	mov    (%eax),%eax
801001c6:	83 e0 02             	and    $0x2,%eax
801001c9:	85 c0                	test   %eax,%eax
801001cb:	75 0b                	jne    801001d8 <bread+0x32>
    iderw(b);
801001cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d0:	89 04 24             	mov    %eax,(%esp)
801001d3:	e8 e3 26 00 00       	call   801028bb <iderw>
  }
  return b;
801001d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001db:	c9                   	leave  
801001dc:	c3                   	ret    

801001dd <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001dd:	55                   	push   %ebp
801001de:	89 e5                	mov    %esp,%ebp
801001e0:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e3:	8b 45 08             	mov    0x8(%ebp),%eax
801001e6:	8b 00                	mov    (%eax),%eax
801001e8:	83 e0 01             	and    $0x1,%eax
801001eb:	85 c0                	test   %eax,%eax
801001ed:	75 0c                	jne    801001fb <bwrite+0x1e>
    panic("bwrite");
801001ef:	c7 04 24 d0 85 10 80 	movl   $0x801085d0,(%esp)
801001f6:	e8 4b 03 00 00       	call   80100546 <panic>
  b->flags |= B_DIRTY;
801001fb:	8b 45 08             	mov    0x8(%ebp),%eax
801001fe:	8b 00                	mov    (%eax),%eax
80100200:	89 c2                	mov    %eax,%edx
80100202:	83 ca 04             	or     $0x4,%edx
80100205:	8b 45 08             	mov    0x8(%ebp),%eax
80100208:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020a:	8b 45 08             	mov    0x8(%ebp),%eax
8010020d:	89 04 24             	mov    %eax,(%esp)
80100210:	e8 a6 26 00 00       	call   801028bb <iderw>
}
80100215:	c9                   	leave  
80100216:	c3                   	ret    

80100217 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100217:	55                   	push   %ebp
80100218:	89 e5                	mov    %esp,%ebp
8010021a:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021d:	8b 45 08             	mov    0x8(%ebp),%eax
80100220:	8b 00                	mov    (%eax),%eax
80100222:	83 e0 01             	and    $0x1,%eax
80100225:	85 c0                	test   %eax,%eax
80100227:	75 0c                	jne    80100235 <brelse+0x1e>
    panic("brelse");
80100229:	c7 04 24 d7 85 10 80 	movl   $0x801085d7,(%esp)
80100230:	e8 11 03 00 00       	call   80100546 <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010023c:	e8 6a 4d 00 00       	call   80104fab <acquire>

  b->next->prev = b->prev;
80100241:	8b 45 08             	mov    0x8(%ebp),%eax
80100244:	8b 40 10             	mov    0x10(%eax),%eax
80100247:	8b 55 08             	mov    0x8(%ebp),%edx
8010024a:	8b 52 0c             	mov    0xc(%edx),%edx
8010024d:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100250:	8b 45 08             	mov    0x8(%ebp),%eax
80100253:	8b 40 0c             	mov    0xc(%eax),%eax
80100256:	8b 55 08             	mov    0x8(%ebp),%edx
80100259:	8b 52 10             	mov    0x10(%edx),%edx
8010025c:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010025f:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100265:	8b 45 08             	mov    0x8(%ebp),%eax
80100268:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
  bcache.head.next->prev = b;
80100275:	a1 74 05 11 80       	mov    0x80110574,%eax
8010027a:	8b 55 08             	mov    0x8(%ebp),%edx
8010027d:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100280:	8b 45 08             	mov    0x8(%ebp),%eax
80100283:	a3 74 05 11 80       	mov    %eax,0x80110574

  b->flags &= ~B_BUSY;
80100288:	8b 45 08             	mov    0x8(%ebp),%eax
8010028b:	8b 00                	mov    (%eax),%eax
8010028d:	89 c2                	mov    %eax,%edx
8010028f:	83 e2 fe             	and    $0xfffffffe,%edx
80100292:	8b 45 08             	mov    0x8(%ebp),%eax
80100295:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100297:	8b 45 08             	mov    0x8(%ebp),%eax
8010029a:	89 04 24             	mov    %eax,(%esp)
8010029d:	e8 04 4b 00 00       	call   80104da6 <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801002a9:	e8 5f 4d 00 00       	call   8010500d <release>
}
801002ae:	c9                   	leave  
801002af:	c3                   	ret    

801002b0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b0:	55                   	push   %ebp
801002b1:	89 e5                	mov    %esp,%ebp
801002b3:	53                   	push   %ebx
801002b4:	83 ec 14             	sub    $0x14,%esp
801002b7:	8b 45 08             	mov    0x8(%ebp),%eax
801002ba:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002be:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
801002c2:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
801002c6:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
801002ca:	ec                   	in     (%dx),%al
801002cb:	89 c3                	mov    %eax,%ebx
801002cd:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
801002d0:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
801002d4:	83 c4 14             	add    $0x14,%esp
801002d7:	5b                   	pop    %ebx
801002d8:	5d                   	pop    %ebp
801002d9:	c3                   	ret    

801002da <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002da:	55                   	push   %ebp
801002db:	89 e5                	mov    %esp,%ebp
801002dd:	83 ec 08             	sub    $0x8,%esp
801002e0:	8b 55 08             	mov    0x8(%ebp),%edx
801002e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801002e6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002ea:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002ed:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002f1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002f5:	ee                   	out    %al,(%dx)
}
801002f6:	c9                   	leave  
801002f7:	c3                   	ret    

801002f8 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002f8:	55                   	push   %ebp
801002f9:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002fb:	fa                   	cli    
}
801002fc:	5d                   	pop    %ebp
801002fd:	c3                   	ret    

801002fe <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002fe:	55                   	push   %ebp
801002ff:	89 e5                	mov    %esp,%ebp
80100301:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100304:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100308:	74 1c                	je     80100326 <printint+0x28>
8010030a:	8b 45 08             	mov    0x8(%ebp),%eax
8010030d:	c1 e8 1f             	shr    $0x1f,%eax
80100310:	0f b6 c0             	movzbl %al,%eax
80100313:	89 45 10             	mov    %eax,0x10(%ebp)
80100316:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010031a:	74 0a                	je     80100326 <printint+0x28>
    x = -xx;
8010031c:	8b 45 08             	mov    0x8(%ebp),%eax
8010031f:	f7 d8                	neg    %eax
80100321:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100324:	eb 06                	jmp    8010032c <printint+0x2e>
  else
    x = xx;
80100326:	8b 45 08             	mov    0x8(%ebp),%eax
80100329:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
8010032c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100333:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100336:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100339:	ba 00 00 00 00       	mov    $0x0,%edx
8010033e:	f7 f1                	div    %ecx
80100340:	89 d0                	mov    %edx,%eax
80100342:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100349:	8d 4d e0             	lea    -0x20(%ebp),%ecx
8010034c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010034f:	01 ca                	add    %ecx,%edx
80100351:	88 02                	mov    %al,(%edx)
80100353:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
80100357:	8b 55 0c             	mov    0xc(%ebp),%edx
8010035a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010035d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100360:	ba 00 00 00 00       	mov    $0x0,%edx
80100365:	f7 75 d4             	divl   -0x2c(%ebp)
80100368:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010036b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010036f:	75 c2                	jne    80100333 <printint+0x35>

  if(sign)
80100371:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100375:	74 27                	je     8010039e <printint+0xa0>
    buf[i++] = '-';
80100377:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010037a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010037d:	01 d0                	add    %edx,%eax
8010037f:	c6 00 2d             	movb   $0x2d,(%eax)
80100382:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
80100386:	eb 16                	jmp    8010039e <printint+0xa0>
    consputc(buf[i]);
80100388:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010038b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010038e:	01 d0                	add    %edx,%eax
80100390:	0f b6 00             	movzbl (%eax),%eax
80100393:	0f be c0             	movsbl %al,%eax
80100396:	89 04 24             	mov    %eax,(%esp)
80100399:	e8 d6 03 00 00       	call   80100774 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010039e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003a6:	79 e0                	jns    80100388 <printint+0x8a>
    consputc(buf[i]);
}
801003a8:	c9                   	leave  
801003a9:	c3                   	ret    

801003aa <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003aa:	55                   	push   %ebp
801003ab:	89 e5                	mov    %esp,%ebp
801003ad:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003b0:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003b8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003bc:	74 0c                	je     801003ca <cprintf+0x20>
    acquire(&cons.lock);
801003be:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801003c5:	e8 e1 4b 00 00       	call   80104fab <acquire>

  if (fmt == 0)
801003ca:	8b 45 08             	mov    0x8(%ebp),%eax
801003cd:	85 c0                	test   %eax,%eax
801003cf:	75 0c                	jne    801003dd <cprintf+0x33>
    panic("null fmt");
801003d1:	c7 04 24 de 85 10 80 	movl   $0x801085de,(%esp)
801003d8:	e8 69 01 00 00       	call   80100546 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003dd:	8d 45 0c             	lea    0xc(%ebp),%eax
801003e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801003ea:	e9 20 01 00 00       	jmp    8010050f <cprintf+0x165>
    if(c != '%'){
801003ef:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801003f3:	74 10                	je     80100405 <cprintf+0x5b>
      consputc(c);
801003f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801003f8:	89 04 24             	mov    %eax,(%esp)
801003fb:	e8 74 03 00 00       	call   80100774 <consputc>
      continue;
80100400:	e9 06 01 00 00       	jmp    8010050b <cprintf+0x161>
    }
    c = fmt[++i] & 0xff;
80100405:	8b 55 08             	mov    0x8(%ebp),%edx
80100408:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010040c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010040f:	01 d0                	add    %edx,%eax
80100411:	0f b6 00             	movzbl (%eax),%eax
80100414:	0f be c0             	movsbl %al,%eax
80100417:	25 ff 00 00 00       	and    $0xff,%eax
8010041c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010041f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100423:	0f 84 08 01 00 00    	je     80100531 <cprintf+0x187>
      break;
    switch(c){
80100429:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010042c:	83 f8 70             	cmp    $0x70,%eax
8010042f:	74 4d                	je     8010047e <cprintf+0xd4>
80100431:	83 f8 70             	cmp    $0x70,%eax
80100434:	7f 13                	jg     80100449 <cprintf+0x9f>
80100436:	83 f8 25             	cmp    $0x25,%eax
80100439:	0f 84 a6 00 00 00    	je     801004e5 <cprintf+0x13b>
8010043f:	83 f8 64             	cmp    $0x64,%eax
80100442:	74 14                	je     80100458 <cprintf+0xae>
80100444:	e9 aa 00 00 00       	jmp    801004f3 <cprintf+0x149>
80100449:	83 f8 73             	cmp    $0x73,%eax
8010044c:	74 53                	je     801004a1 <cprintf+0xf7>
8010044e:	83 f8 78             	cmp    $0x78,%eax
80100451:	74 2b                	je     8010047e <cprintf+0xd4>
80100453:	e9 9b 00 00 00       	jmp    801004f3 <cprintf+0x149>
    case 'd':
      printint(*argp++, 10, 1);
80100458:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010045b:	8b 00                	mov    (%eax),%eax
8010045d:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
80100461:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80100468:	00 
80100469:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100470:	00 
80100471:	89 04 24             	mov    %eax,(%esp)
80100474:	e8 85 fe ff ff       	call   801002fe <printint>
      break;
80100479:	e9 8d 00 00 00       	jmp    8010050b <cprintf+0x161>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010047e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100481:	8b 00                	mov    (%eax),%eax
80100483:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
80100487:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010048e:	00 
8010048f:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80100496:	00 
80100497:	89 04 24             	mov    %eax,(%esp)
8010049a:	e8 5f fe ff ff       	call   801002fe <printint>
      break;
8010049f:	eb 6a                	jmp    8010050b <cprintf+0x161>
    case 's':
      if((s = (char*)*argp++) == 0)
801004a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004a4:	8b 00                	mov    (%eax),%eax
801004a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004ad:	0f 94 c0             	sete   %al
801004b0:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
801004b4:	84 c0                	test   %al,%al
801004b6:	74 20                	je     801004d8 <cprintf+0x12e>
        s = "(null)";
801004b8:	c7 45 ec e7 85 10 80 	movl   $0x801085e7,-0x14(%ebp)
      for(; *s; s++)
801004bf:	eb 17                	jmp    801004d8 <cprintf+0x12e>
        consputc(*s);
801004c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004c4:	0f b6 00             	movzbl (%eax),%eax
801004c7:	0f be c0             	movsbl %al,%eax
801004ca:	89 04 24             	mov    %eax,(%esp)
801004cd:	e8 a2 02 00 00       	call   80100774 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004d2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004d6:	eb 01                	jmp    801004d9 <cprintf+0x12f>
801004d8:	90                   	nop
801004d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004dc:	0f b6 00             	movzbl (%eax),%eax
801004df:	84 c0                	test   %al,%al
801004e1:	75 de                	jne    801004c1 <cprintf+0x117>
        consputc(*s);
      break;
801004e3:	eb 26                	jmp    8010050b <cprintf+0x161>
    case '%':
      consputc('%');
801004e5:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004ec:	e8 83 02 00 00       	call   80100774 <consputc>
      break;
801004f1:	eb 18                	jmp    8010050b <cprintf+0x161>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004f3:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004fa:	e8 75 02 00 00       	call   80100774 <consputc>
      consputc(c);
801004ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100502:	89 04 24             	mov    %eax,(%esp)
80100505:	e8 6a 02 00 00       	call   80100774 <consputc>
      break;
8010050a:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010050b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010050f:	8b 55 08             	mov    0x8(%ebp),%edx
80100512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100515:	01 d0                	add    %edx,%eax
80100517:	0f b6 00             	movzbl (%eax),%eax
8010051a:	0f be c0             	movsbl %al,%eax
8010051d:	25 ff 00 00 00       	and    $0xff,%eax
80100522:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100525:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100529:	0f 85 c0 fe ff ff    	jne    801003ef <cprintf+0x45>
8010052f:	eb 01                	jmp    80100532 <cprintf+0x188>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100531:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100532:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100536:	74 0c                	je     80100544 <cprintf+0x19a>
    release(&cons.lock);
80100538:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010053f:	e8 c9 4a 00 00       	call   8010500d <release>
}
80100544:	c9                   	leave  
80100545:	c3                   	ret    

80100546 <panic>:

void
panic(char *s)
{
80100546:	55                   	push   %ebp
80100547:	89 e5                	mov    %esp,%ebp
80100549:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
8010054c:	e8 a7 fd ff ff       	call   801002f8 <cli>
  cons.locking = 0;
80100551:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
80100558:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010055b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100561:	0f b6 00             	movzbl (%eax),%eax
80100564:	0f b6 c0             	movzbl %al,%eax
80100567:	89 44 24 04          	mov    %eax,0x4(%esp)
8010056b:	c7 04 24 ee 85 10 80 	movl   $0x801085ee,(%esp)
80100572:	e8 33 fe ff ff       	call   801003aa <cprintf>
  cprintf(s);
80100577:	8b 45 08             	mov    0x8(%ebp),%eax
8010057a:	89 04 24             	mov    %eax,(%esp)
8010057d:	e8 28 fe ff ff       	call   801003aa <cprintf>
  cprintf("\n");
80100582:	c7 04 24 fd 85 10 80 	movl   $0x801085fd,(%esp)
80100589:	e8 1c fe ff ff       	call   801003aa <cprintf>
  getcallerpcs(&s, pcs);
8010058e:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100591:	89 44 24 04          	mov    %eax,0x4(%esp)
80100595:	8d 45 08             	lea    0x8(%ebp),%eax
80100598:	89 04 24             	mov    %eax,(%esp)
8010059b:	e8 bc 4a 00 00       	call   8010505c <getcallerpcs>
  for(i=0; i<10; i++)
801005a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005a7:	eb 1b                	jmp    801005c4 <panic+0x7e>
    cprintf(" %p", pcs[i]);
801005a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005ac:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801005b4:	c7 04 24 ff 85 10 80 	movl   $0x801085ff,(%esp)
801005bb:	e8 ea fd ff ff       	call   801003aa <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005c4:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005c8:	7e df                	jle    801005a9 <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005ca:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005d1:	00 00 00 
  for(;;)
    ;
801005d4:	eb fe                	jmp    801005d4 <panic+0x8e>

801005d6 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005d6:	55                   	push   %ebp
801005d7:	89 e5                	mov    %esp,%ebp
801005d9:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005dc:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005e3:	00 
801005e4:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005eb:	e8 ea fc ff ff       	call   801002da <outb>
  pos = inb(CRTPORT+1) << 8;
801005f0:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005f7:	e8 b4 fc ff ff       	call   801002b0 <inb>
801005fc:	0f b6 c0             	movzbl %al,%eax
801005ff:	c1 e0 08             	shl    $0x8,%eax
80100602:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100605:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010060c:	00 
8010060d:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100614:	e8 c1 fc ff ff       	call   801002da <outb>
  pos |= inb(CRTPORT+1);
80100619:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100620:	e8 8b fc ff ff       	call   801002b0 <inb>
80100625:	0f b6 c0             	movzbl %al,%eax
80100628:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010062b:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010062f:	75 30                	jne    80100661 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100631:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100634:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100639:	89 c8                	mov    %ecx,%eax
8010063b:	f7 ea                	imul   %edx
8010063d:	c1 fa 05             	sar    $0x5,%edx
80100640:	89 c8                	mov    %ecx,%eax
80100642:	c1 f8 1f             	sar    $0x1f,%eax
80100645:	29 c2                	sub    %eax,%edx
80100647:	89 d0                	mov    %edx,%eax
80100649:	c1 e0 02             	shl    $0x2,%eax
8010064c:	01 d0                	add    %edx,%eax
8010064e:	c1 e0 04             	shl    $0x4,%eax
80100651:	89 ca                	mov    %ecx,%edx
80100653:	29 c2                	sub    %eax,%edx
80100655:	b8 50 00 00 00       	mov    $0x50,%eax
8010065a:	29 d0                	sub    %edx,%eax
8010065c:	01 45 f4             	add    %eax,-0xc(%ebp)
8010065f:	eb 32                	jmp    80100693 <cgaputc+0xbd>
  else if(c == BACKSPACE){
80100661:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100668:	75 0c                	jne    80100676 <cgaputc+0xa0>
    if(pos > 0) --pos;
8010066a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010066e:	7e 23                	jle    80100693 <cgaputc+0xbd>
80100670:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100674:	eb 1d                	jmp    80100693 <cgaputc+0xbd>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100676:	a1 00 90 10 80       	mov    0x80109000,%eax
8010067b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010067e:	01 d2                	add    %edx,%edx
80100680:	01 c2                	add    %eax,%edx
80100682:	8b 45 08             	mov    0x8(%ebp),%eax
80100685:	66 25 ff 00          	and    $0xff,%ax
80100689:	80 cc 07             	or     $0x7,%ah
8010068c:	66 89 02             	mov    %ax,(%edx)
8010068f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  if(pos < 0 || pos > 25*80)
80100693:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100697:	78 09                	js     801006a2 <cgaputc+0xcc>
80100699:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801006a0:	7e 0c                	jle    801006ae <cgaputc+0xd8>
    panic("pos under/overflow");
801006a2:	c7 04 24 03 86 10 80 	movl   $0x80108603,(%esp)
801006a9:	e8 98 fe ff ff       	call   80100546 <panic>
  
  if((pos/80) >= 24){  // Scroll up.
801006ae:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006b5:	7e 53                	jle    8010070a <cgaputc+0x134>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006b7:	a1 00 90 10 80       	mov    0x80109000,%eax
801006bc:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006c2:	a1 00 90 10 80       	mov    0x80109000,%eax
801006c7:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006ce:	00 
801006cf:	89 54 24 04          	mov    %edx,0x4(%esp)
801006d3:	89 04 24             	mov    %eax,(%esp)
801006d6:	e8 fe 4b 00 00       	call   801052d9 <memmove>
    pos -= 80;
801006db:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006df:	b8 80 07 00 00       	mov    $0x780,%eax
801006e4:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006e7:	01 c0                	add    %eax,%eax
801006e9:	8b 15 00 90 10 80    	mov    0x80109000,%edx
801006ef:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006f2:	01 c9                	add    %ecx,%ecx
801006f4:	01 ca                	add    %ecx,%edx
801006f6:	89 44 24 08          	mov    %eax,0x8(%esp)
801006fa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100701:	00 
80100702:	89 14 24             	mov    %edx,(%esp)
80100705:	e8 fc 4a 00 00       	call   80105206 <memset>
  }
  
  outb(CRTPORT, 14);
8010070a:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
80100711:	00 
80100712:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100719:	e8 bc fb ff ff       	call   801002da <outb>
  outb(CRTPORT+1, pos>>8);
8010071e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100721:	c1 f8 08             	sar    $0x8,%eax
80100724:	0f b6 c0             	movzbl %al,%eax
80100727:	89 44 24 04          	mov    %eax,0x4(%esp)
8010072b:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100732:	e8 a3 fb ff ff       	call   801002da <outb>
  outb(CRTPORT, 15);
80100737:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010073e:	00 
8010073f:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100746:	e8 8f fb ff ff       	call   801002da <outb>
  outb(CRTPORT+1, pos);
8010074b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010074e:	0f b6 c0             	movzbl %al,%eax
80100751:	89 44 24 04          	mov    %eax,0x4(%esp)
80100755:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010075c:	e8 79 fb ff ff       	call   801002da <outb>
  crt[pos] = ' ' | 0x0700;
80100761:	a1 00 90 10 80       	mov    0x80109000,%eax
80100766:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100769:	01 d2                	add    %edx,%edx
8010076b:	01 d0                	add    %edx,%eax
8010076d:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100772:	c9                   	leave  
80100773:	c3                   	ret    

80100774 <consputc>:

void
consputc(int c)
{
80100774:	55                   	push   %ebp
80100775:	89 e5                	mov    %esp,%ebp
80100777:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
8010077a:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
8010077f:	85 c0                	test   %eax,%eax
80100781:	74 07                	je     8010078a <consputc+0x16>
    cli();
80100783:	e8 70 fb ff ff       	call   801002f8 <cli>
    for(;;)
      ;
80100788:	eb fe                	jmp    80100788 <consputc+0x14>
  }

  if(c == BACKSPACE){
8010078a:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100791:	75 26                	jne    801007b9 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100793:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010079a:	e8 52 64 00 00       	call   80106bf1 <uartputc>
8010079f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801007a6:	e8 46 64 00 00       	call   80106bf1 <uartputc>
801007ab:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007b2:	e8 3a 64 00 00       	call   80106bf1 <uartputc>
801007b7:	eb 0b                	jmp    801007c4 <consputc+0x50>
  } else
    uartputc(c);
801007b9:	8b 45 08             	mov    0x8(%ebp),%eax
801007bc:	89 04 24             	mov    %eax,(%esp)
801007bf:	e8 2d 64 00 00       	call   80106bf1 <uartputc>
  cgaputc(c);
801007c4:	8b 45 08             	mov    0x8(%ebp),%eax
801007c7:	89 04 24             	mov    %eax,(%esp)
801007ca:	e8 07 fe ff ff       	call   801005d6 <cgaputc>
}
801007cf:	c9                   	leave  
801007d0:	c3                   	ret    

801007d1 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d1:	55                   	push   %ebp
801007d2:	89 e5                	mov    %esp,%ebp
801007d4:	83 ec 28             	sub    $0x28,%esp
  int c, doprocdump = 0;
801007d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
801007de:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801007e5:	e8 c1 47 00 00       	call   80104fab <acquire>
  while((c = getc()) >= 0){
801007ea:	e9 43 01 00 00       	jmp    80100932 <consoleintr+0x161>
    switch(c){
801007ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801007f2:	83 f8 10             	cmp    $0x10,%eax
801007f5:	74 1e                	je     80100815 <consoleintr+0x44>
801007f7:	83 f8 10             	cmp    $0x10,%eax
801007fa:	7f 0a                	jg     80100806 <consoleintr+0x35>
801007fc:	83 f8 08             	cmp    $0x8,%eax
801007ff:	74 6a                	je     8010086b <consoleintr+0x9a>
80100801:	e9 96 00 00 00       	jmp    8010089c <consoleintr+0xcb>
80100806:	83 f8 15             	cmp    $0x15,%eax
80100809:	74 31                	je     8010083c <consoleintr+0x6b>
8010080b:	83 f8 7f             	cmp    $0x7f,%eax
8010080e:	74 5b                	je     8010086b <consoleintr+0x9a>
80100810:	e9 87 00 00 00       	jmp    8010089c <consoleintr+0xcb>
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
80100815:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
8010081c:	e9 11 01 00 00       	jmp    80100932 <consoleintr+0x161>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100821:	a1 08 08 11 80       	mov    0x80110808,%eax
80100826:	83 e8 01             	sub    $0x1,%eax
80100829:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
8010082e:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100835:	e8 3a ff ff ff       	call   80100774 <consputc>
8010083a:	eb 01                	jmp    8010083d <consoleintr+0x6c>
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010083c:	90                   	nop
8010083d:	8b 15 08 08 11 80    	mov    0x80110808,%edx
80100843:	a1 04 08 11 80       	mov    0x80110804,%eax
80100848:	39 c2                	cmp    %eax,%edx
8010084a:	0f 84 db 00 00 00    	je     8010092b <consoleintr+0x15a>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100850:	a1 08 08 11 80       	mov    0x80110808,%eax
80100855:	83 e8 01             	sub    $0x1,%eax
80100858:	83 e0 7f             	and    $0x7f,%eax
8010085b:	0f b6 80 80 07 11 80 	movzbl -0x7feef880(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100862:	3c 0a                	cmp    $0xa,%al
80100864:	75 bb                	jne    80100821 <consoleintr+0x50>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100866:	e9 c0 00 00 00       	jmp    8010092b <consoleintr+0x15a>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010086b:	8b 15 08 08 11 80    	mov    0x80110808,%edx
80100871:	a1 04 08 11 80       	mov    0x80110804,%eax
80100876:	39 c2                	cmp    %eax,%edx
80100878:	0f 84 b0 00 00 00    	je     8010092e <consoleintr+0x15d>
        input.e--;
8010087e:	a1 08 08 11 80       	mov    0x80110808,%eax
80100883:	83 e8 01             	sub    $0x1,%eax
80100886:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
8010088b:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100892:	e8 dd fe ff ff       	call   80100774 <consputc>
      }
      break;
80100897:	e9 92 00 00 00       	jmp    8010092e <consoleintr+0x15d>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010089c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801008a0:	0f 84 8b 00 00 00    	je     80100931 <consoleintr+0x160>
801008a6:	8b 15 08 08 11 80    	mov    0x80110808,%edx
801008ac:	a1 00 08 11 80       	mov    0x80110800,%eax
801008b1:	89 d1                	mov    %edx,%ecx
801008b3:	29 c1                	sub    %eax,%ecx
801008b5:	89 c8                	mov    %ecx,%eax
801008b7:	83 f8 7f             	cmp    $0x7f,%eax
801008ba:	77 75                	ja     80100931 <consoleintr+0x160>
        c = (c == '\r') ? '\n' : c;
801008bc:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008c0:	74 05                	je     801008c7 <consoleintr+0xf6>
801008c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008c5:	eb 05                	jmp    801008cc <consoleintr+0xfb>
801008c7:	b8 0a 00 00 00       	mov    $0xa,%eax
801008cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008cf:	a1 08 08 11 80       	mov    0x80110808,%eax
801008d4:	89 c1                	mov    %eax,%ecx
801008d6:	83 e1 7f             	and    $0x7f,%ecx
801008d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801008dc:	88 91 80 07 11 80    	mov    %dl,-0x7feef880(%ecx)
801008e2:	83 c0 01             	add    $0x1,%eax
801008e5:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(c);
801008ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008ed:	89 04 24             	mov    %eax,(%esp)
801008f0:	e8 7f fe ff ff       	call   80100774 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008f5:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801008f9:	74 18                	je     80100913 <consoleintr+0x142>
801008fb:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801008ff:	74 12                	je     80100913 <consoleintr+0x142>
80100901:	a1 08 08 11 80       	mov    0x80110808,%eax
80100906:	8b 15 00 08 11 80    	mov    0x80110800,%edx
8010090c:	83 ea 80             	sub    $0xffffff80,%edx
8010090f:	39 d0                	cmp    %edx,%eax
80100911:	75 1e                	jne    80100931 <consoleintr+0x160>
          input.w = input.e;
80100913:	a1 08 08 11 80       	mov    0x80110808,%eax
80100918:	a3 04 08 11 80       	mov    %eax,0x80110804
          wakeup(&input.r);
8010091d:	c7 04 24 00 08 11 80 	movl   $0x80110800,(%esp)
80100924:	e8 7d 44 00 00       	call   80104da6 <wakeup>
        }
      }
      break;
80100929:	eb 06                	jmp    80100931 <consoleintr+0x160>
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010092b:	90                   	nop
8010092c:	eb 04                	jmp    80100932 <consoleintr+0x161>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010092e:	90                   	nop
8010092f:	eb 01                	jmp    80100932 <consoleintr+0x161>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
80100931:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100932:	8b 45 08             	mov    0x8(%ebp),%eax
80100935:	ff d0                	call   *%eax
80100937:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010093a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010093e:	0f 89 ab fe ff ff    	jns    801007ef <consoleintr+0x1e>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100944:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010094b:	e8 bd 46 00 00       	call   8010500d <release>
  if(doprocdump) {
80100950:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100954:	74 05                	je     8010095b <consoleintr+0x18a>
    procdump();  // now call procdump() wo. cons.lock held
80100956:	e8 ee 44 00 00       	call   80104e49 <procdump>
  }
}
8010095b:	c9                   	leave  
8010095c:	c3                   	ret    

8010095d <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010095d:	55                   	push   %ebp
8010095e:	89 e5                	mov    %esp,%ebp
80100960:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100963:	8b 45 08             	mov    0x8(%ebp),%eax
80100966:	89 04 24             	mov    %eax,(%esp)
80100969:	e8 0a 11 00 00       	call   80101a78 <iunlock>
  target = n;
8010096e:	8b 45 10             	mov    0x10(%ebp),%eax
80100971:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100974:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010097b:	e8 2b 46 00 00       	call   80104fab <acquire>
  while(n > 0){
80100980:	e9 a8 00 00 00       	jmp    80100a2d <consoleread+0xd0>
    while(input.r == input.w){
      if(proc->killed){
80100985:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010098b:	8b 40 24             	mov    0x24(%eax),%eax
8010098e:	85 c0                	test   %eax,%eax
80100990:	74 21                	je     801009b3 <consoleread+0x56>
        release(&cons.lock);
80100992:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100999:	e8 6f 46 00 00       	call   8010500d <release>
        ilock(ip);
8010099e:	8b 45 08             	mov    0x8(%ebp),%eax
801009a1:	89 04 24             	mov    %eax,(%esp)
801009a4:	e8 7b 0f 00 00       	call   80101924 <ilock>
        return -1;
801009a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009ae:	e9 a9 00 00 00       	jmp    80100a5c <consoleread+0xff>
      }
      sleep(&input.r, &cons.lock);
801009b3:	c7 44 24 04 c0 b5 10 	movl   $0x8010b5c0,0x4(%esp)
801009ba:	80 
801009bb:	c7 04 24 00 08 11 80 	movl   $0x80110800,(%esp)
801009c2:	e8 06 43 00 00       	call   80104ccd <sleep>
801009c7:	eb 01                	jmp    801009ca <consoleread+0x6d>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801009c9:	90                   	nop
801009ca:	8b 15 00 08 11 80    	mov    0x80110800,%edx
801009d0:	a1 04 08 11 80       	mov    0x80110804,%eax
801009d5:	39 c2                	cmp    %eax,%edx
801009d7:	74 ac                	je     80100985 <consoleread+0x28>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009d9:	a1 00 08 11 80       	mov    0x80110800,%eax
801009de:	89 c2                	mov    %eax,%edx
801009e0:	83 e2 7f             	and    $0x7f,%edx
801009e3:	0f b6 92 80 07 11 80 	movzbl -0x7feef880(%edx),%edx
801009ea:	0f be d2             	movsbl %dl,%edx
801009ed:	89 55 f0             	mov    %edx,-0x10(%ebp)
801009f0:	83 c0 01             	add    $0x1,%eax
801009f3:	a3 00 08 11 80       	mov    %eax,0x80110800
    if(c == C('D')){  // EOF
801009f8:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009fc:	75 17                	jne    80100a15 <consoleread+0xb8>
      if(n < target){
801009fe:	8b 45 10             	mov    0x10(%ebp),%eax
80100a01:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a04:	73 2f                	jae    80100a35 <consoleread+0xd8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a06:	a1 00 08 11 80       	mov    0x80110800,%eax
80100a0b:	83 e8 01             	sub    $0x1,%eax
80100a0e:	a3 00 08 11 80       	mov    %eax,0x80110800
      }
      break;
80100a13:	eb 20                	jmp    80100a35 <consoleread+0xd8>
    }
    *dst++ = c;
80100a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100a18:	89 c2                	mov    %eax,%edx
80100a1a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a1d:	88 10                	mov    %dl,(%eax)
80100a1f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    --n;
80100a23:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a27:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a2b:	74 0b                	je     80100a38 <consoleread+0xdb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100a2d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a31:	7f 96                	jg     801009c9 <consoleread+0x6c>
80100a33:	eb 04                	jmp    80100a39 <consoleread+0xdc>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100a35:	90                   	nop
80100a36:	eb 01                	jmp    80100a39 <consoleread+0xdc>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100a38:	90                   	nop
  }
  release(&cons.lock);
80100a39:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a40:	e8 c8 45 00 00       	call   8010500d <release>
  ilock(ip);
80100a45:	8b 45 08             	mov    0x8(%ebp),%eax
80100a48:	89 04 24             	mov    %eax,(%esp)
80100a4b:	e8 d4 0e 00 00       	call   80101924 <ilock>

  return target - n;
80100a50:	8b 45 10             	mov    0x10(%ebp),%eax
80100a53:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a56:	89 d1                	mov    %edx,%ecx
80100a58:	29 c1                	sub    %eax,%ecx
80100a5a:	89 c8                	mov    %ecx,%eax
}
80100a5c:	c9                   	leave  
80100a5d:	c3                   	ret    

80100a5e <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a5e:	55                   	push   %ebp
80100a5f:	89 e5                	mov    %esp,%ebp
80100a61:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a64:	8b 45 08             	mov    0x8(%ebp),%eax
80100a67:	89 04 24             	mov    %eax,(%esp)
80100a6a:	e8 09 10 00 00       	call   80101a78 <iunlock>
  acquire(&cons.lock);
80100a6f:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a76:	e8 30 45 00 00       	call   80104fab <acquire>
  for(i = 0; i < n; i++)
80100a7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a82:	eb 1f                	jmp    80100aa3 <consolewrite+0x45>
    consputc(buf[i] & 0xff);
80100a84:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a87:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a8a:	01 d0                	add    %edx,%eax
80100a8c:	0f b6 00             	movzbl (%eax),%eax
80100a8f:	0f be c0             	movsbl %al,%eax
80100a92:	25 ff 00 00 00       	and    $0xff,%eax
80100a97:	89 04 24             	mov    %eax,(%esp)
80100a9a:	e8 d5 fc ff ff       	call   80100774 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100a9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100aa6:	3b 45 10             	cmp    0x10(%ebp),%eax
80100aa9:	7c d9                	jl     80100a84 <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100aab:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100ab2:	e8 56 45 00 00       	call   8010500d <release>
  ilock(ip);
80100ab7:	8b 45 08             	mov    0x8(%ebp),%eax
80100aba:	89 04 24             	mov    %eax,(%esp)
80100abd:	e8 62 0e 00 00       	call   80101924 <ilock>

  return n;
80100ac2:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ac5:	c9                   	leave  
80100ac6:	c3                   	ret    

80100ac7 <consoleinit>:

void
consoleinit(void)
{
80100ac7:	55                   	push   %ebp
80100ac8:	89 e5                	mov    %esp,%ebp
80100aca:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100acd:	c7 44 24 04 16 86 10 	movl   $0x80108616,0x4(%esp)
80100ad4:	80 
80100ad5:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100adc:	e8 a9 44 00 00       	call   80104f8a <initlock>

  devsw[CONSOLE].write = consolewrite;
80100ae1:	c7 05 cc 11 11 80 5e 	movl   $0x80100a5e,0x801111cc
80100ae8:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100aeb:	c7 05 c8 11 11 80 5d 	movl   $0x8010095d,0x801111c8
80100af2:	09 10 80 
  cons.locking = 1;
80100af5:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100afc:	00 00 00 

  picenable(IRQ_KBD);
80100aff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b06:	e8 06 34 00 00       	call   80103f11 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100b0b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100b12:	00 
80100b13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b1a:	e8 5b 1f 00 00       	call   80102a7a <ioapicenable>
}
80100b1f:	c9                   	leave  
80100b20:	c3                   	ret    
80100b21:	00 00                	add    %al,(%eax)
	...

80100b24 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b24:	55                   	push   %ebp
80100b25:	89 e5                	mov    %esp,%ebp
80100b27:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b2d:	e8 22 2a 00 00       	call   80103554 <begin_op>
  if((ip = namei(path)) == 0){
80100b32:	8b 45 08             	mov    0x8(%ebp),%eax
80100b35:	89 04 24             	mov    %eax,(%esp)
80100b38:	e8 9e 19 00 00       	call   801024db <namei>
80100b3d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b40:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b44:	75 0f                	jne    80100b55 <exec+0x31>
    end_op();
80100b46:	e8 8a 2a 00 00       	call   801035d5 <end_op>
    return -1;
80100b4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b50:	e9 f9 03 00 00       	jmp    80100f4e <exec+0x42a>
  }
  ilock(ip);
80100b55:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b58:	89 04 24             	mov    %eax,(%esp)
80100b5b:	e8 c4 0d 00 00       	call   80101924 <ilock>
  pgdir = 0;
80100b60:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b67:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b6e:	00 
80100b6f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b76:	00 
80100b77:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b7d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b81:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b84:	89 04 24             	mov    %eax,(%esp)
80100b87:	e8 ab 12 00 00       	call   80101e37 <readi>
80100b8c:	83 f8 33             	cmp    $0x33,%eax
80100b8f:	0f 86 6e 03 00 00    	jbe    80100f03 <exec+0x3df>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b95:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b9b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100ba0:	0f 85 60 03 00 00    	jne    80100f06 <exec+0x3e2>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100ba6:	e8 98 71 00 00       	call   80107d43 <setupkvm>
80100bab:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bae:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bb2:	0f 84 51 03 00 00    	je     80100f09 <exec+0x3e5>
    goto bad;

  // Load program into memory.
  sz = 0;
80100bb8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bbf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100bc6:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100bcc:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bcf:	e9 c5 00 00 00       	jmp    80100c99 <exec+0x175>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bd4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bd7:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100bde:	00 
80100bdf:	89 44 24 08          	mov    %eax,0x8(%esp)
80100be3:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100be9:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bed:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100bf0:	89 04 24             	mov    %eax,(%esp)
80100bf3:	e8 3f 12 00 00       	call   80101e37 <readi>
80100bf8:	83 f8 20             	cmp    $0x20,%eax
80100bfb:	0f 85 0b 03 00 00    	jne    80100f0c <exec+0x3e8>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c01:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c07:	83 f8 01             	cmp    $0x1,%eax
80100c0a:	75 7f                	jne    80100c8b <exec+0x167>
      continue;
    if(ph.memsz < ph.filesz)
80100c0c:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c12:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c18:	39 c2                	cmp    %eax,%edx
80100c1a:	0f 82 ef 02 00 00    	jb     80100f0f <exec+0x3eb>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c20:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c26:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c2c:	01 d0                	add    %edx,%eax
80100c2e:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c32:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c35:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c39:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c3c:	89 04 24             	mov    %eax,(%esp)
80100c3f:	e8 d1 74 00 00       	call   80108115 <allocuvm>
80100c44:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c47:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c4b:	0f 84 c1 02 00 00    	je     80100f12 <exec+0x3ee>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c51:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100c57:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c5d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c63:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100c67:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c6b:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100c6e:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c72:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c76:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c79:	89 04 24             	mov    %eax,(%esp)
80100c7c:	e8 a5 73 00 00       	call   80108026 <loaduvm>
80100c81:	85 c0                	test   %eax,%eax
80100c83:	0f 88 8c 02 00 00    	js     80100f15 <exec+0x3f1>
80100c89:	eb 01                	jmp    80100c8c <exec+0x168>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c8b:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c8c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c90:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c93:	83 c0 20             	add    $0x20,%eax
80100c96:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c99:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100ca0:	0f b7 c0             	movzwl %ax,%eax
80100ca3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100ca6:	0f 8f 28 ff ff ff    	jg     80100bd4 <exec+0xb0>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cac:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100caf:	89 04 24             	mov    %eax,(%esp)
80100cb2:	e8 f7 0e 00 00       	call   80101bae <iunlockput>
  end_op();
80100cb7:	e8 19 29 00 00       	call   801035d5 <end_op>
  ip = 0;
80100cbc:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cc6:	05 ff 0f 00 00       	add    $0xfff,%eax
80100ccb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cd0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cd3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd6:	05 00 20 00 00       	add    $0x2000,%eax
80100cdb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100cdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ce2:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ce6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ce9:	89 04 24             	mov    %eax,(%esp)
80100cec:	e8 24 74 00 00       	call   80108115 <allocuvm>
80100cf1:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cf4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cf8:	0f 84 1a 02 00 00    	je     80100f18 <exec+0x3f4>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d01:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d06:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d0a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d0d:	89 04 24             	mov    %eax,(%esp)
80100d10:	e8 30 76 00 00       	call   80108345 <clearpteu>
  sp = sz;
80100d15:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d18:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d1b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d22:	e9 97 00 00 00       	jmp    80100dbe <exec+0x29a>
    if(argc >= MAXARG)
80100d27:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d2b:	0f 87 ea 01 00 00    	ja     80100f1b <exec+0x3f7>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d34:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d3e:	01 d0                	add    %edx,%eax
80100d40:	8b 00                	mov    (%eax),%eax
80100d42:	89 04 24             	mov    %eax,(%esp)
80100d45:	e8 3a 47 00 00       	call   80105484 <strlen>
80100d4a:	f7 d0                	not    %eax
80100d4c:	89 c2                	mov    %eax,%edx
80100d4e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d51:	01 d0                	add    %edx,%eax
80100d53:	83 e0 fc             	and    $0xfffffffc,%eax
80100d56:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d5c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d63:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d66:	01 d0                	add    %edx,%eax
80100d68:	8b 00                	mov    (%eax),%eax
80100d6a:	89 04 24             	mov    %eax,(%esp)
80100d6d:	e8 12 47 00 00       	call   80105484 <strlen>
80100d72:	83 c0 01             	add    $0x1,%eax
80100d75:	89 c2                	mov    %eax,%edx
80100d77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d7a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100d81:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d84:	01 c8                	add    %ecx,%eax
80100d86:	8b 00                	mov    (%eax),%eax
80100d88:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100d8c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d90:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d93:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d97:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d9a:	89 04 24             	mov    %eax,(%esp)
80100d9d:	e8 68 77 00 00       	call   8010850a <copyout>
80100da2:	85 c0                	test   %eax,%eax
80100da4:	0f 88 74 01 00 00    	js     80100f1e <exec+0x3fa>
      goto bad;
    ustack[3+argc] = sp;
80100daa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dad:	8d 50 03             	lea    0x3(%eax),%edx
80100db0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100db3:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100dba:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dcb:	01 d0                	add    %edx,%eax
80100dcd:	8b 00                	mov    (%eax),%eax
80100dcf:	85 c0                	test   %eax,%eax
80100dd1:	0f 85 50 ff ff ff    	jne    80100d27 <exec+0x203>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dda:	83 c0 03             	add    $0x3,%eax
80100ddd:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100de4:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100de8:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100def:	ff ff ff 
  ustack[1] = argc;
80100df2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df5:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfe:	83 c0 01             	add    $0x1,%eax
80100e01:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e08:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e0b:	29 d0                	sub    %edx,%eax
80100e0d:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e16:	83 c0 04             	add    $0x4,%eax
80100e19:	c1 e0 02             	shl    $0x2,%eax
80100e1c:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e22:	83 c0 04             	add    $0x4,%eax
80100e25:	c1 e0 02             	shl    $0x2,%eax
80100e28:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100e2c:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e32:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e36:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e39:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e3d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100e40:	89 04 24             	mov    %eax,(%esp)
80100e43:	e8 c2 76 00 00       	call   8010850a <copyout>
80100e48:	85 c0                	test   %eax,%eax
80100e4a:	0f 88 d1 00 00 00    	js     80100f21 <exec+0x3fd>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e50:	8b 45 08             	mov    0x8(%ebp),%eax
80100e53:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e59:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e5c:	eb 17                	jmp    80100e75 <exec+0x351>
    if(*s == '/')
80100e5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e61:	0f b6 00             	movzbl (%eax),%eax
80100e64:	3c 2f                	cmp    $0x2f,%al
80100e66:	75 09                	jne    80100e71 <exec+0x34d>
      last = s+1;
80100e68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e6b:	83 c0 01             	add    $0x1,%eax
80100e6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e71:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e78:	0f b6 00             	movzbl (%eax),%eax
80100e7b:	84 c0                	test   %al,%al
80100e7d:	75 df                	jne    80100e5e <exec+0x33a>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e7f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e85:	8d 50 6c             	lea    0x6c(%eax),%edx
80100e88:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100e8f:	00 
80100e90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e93:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e97:	89 14 24             	mov    %edx,(%esp)
80100e9a:	e8 97 45 00 00       	call   80105436 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e9f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea5:	8b 40 04             	mov    0x4(%eax),%eax
80100ea8:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100eab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100eb4:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100eb7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ebd:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100ec0:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100ec2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec8:	8b 40 18             	mov    0x18(%eax),%eax
80100ecb:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ed1:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ed4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eda:	8b 40 18             	mov    0x18(%eax),%eax
80100edd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ee0:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100ee3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ee9:	89 04 24             	mov    %eax,(%esp)
80100eec:	e8 43 6f 00 00       	call   80107e34 <switchuvm>
  freevm(oldpgdir);
80100ef1:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ef4:	89 04 24             	mov    %eax,(%esp)
80100ef7:	e8 af 73 00 00       	call   801082ab <freevm>
  return 0;
80100efc:	b8 00 00 00 00       	mov    $0x0,%eax
80100f01:	eb 4b                	jmp    80100f4e <exec+0x42a>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100f03:	90                   	nop
80100f04:	eb 1c                	jmp    80100f22 <exec+0x3fe>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100f06:	90                   	nop
80100f07:	eb 19                	jmp    80100f22 <exec+0x3fe>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100f09:	90                   	nop
80100f0a:	eb 16                	jmp    80100f22 <exec+0x3fe>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100f0c:	90                   	nop
80100f0d:	eb 13                	jmp    80100f22 <exec+0x3fe>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100f0f:	90                   	nop
80100f10:	eb 10                	jmp    80100f22 <exec+0x3fe>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100f12:	90                   	nop
80100f13:	eb 0d                	jmp    80100f22 <exec+0x3fe>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100f15:	90                   	nop
80100f16:	eb 0a                	jmp    80100f22 <exec+0x3fe>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100f18:	90                   	nop
80100f19:	eb 07                	jmp    80100f22 <exec+0x3fe>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100f1b:	90                   	nop
80100f1c:	eb 04                	jmp    80100f22 <exec+0x3fe>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100f1e:	90                   	nop
80100f1f:	eb 01                	jmp    80100f22 <exec+0x3fe>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100f21:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100f22:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f26:	74 0b                	je     80100f33 <exec+0x40f>
    freevm(pgdir);
80100f28:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100f2b:	89 04 24             	mov    %eax,(%esp)
80100f2e:	e8 78 73 00 00       	call   801082ab <freevm>
  if(ip){
80100f33:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f37:	74 10                	je     80100f49 <exec+0x425>
    iunlockput(ip);
80100f39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100f3c:	89 04 24             	mov    %eax,(%esp)
80100f3f:	e8 6a 0c 00 00       	call   80101bae <iunlockput>
    end_op();
80100f44:	e8 8c 26 00 00       	call   801035d5 <end_op>
  }
  return -1;
80100f49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f4e:	c9                   	leave  
80100f4f:	c3                   	ret    

80100f50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100f56:	c7 44 24 04 1e 86 10 	movl   $0x8010861e,0x4(%esp)
80100f5d:	80 
80100f5e:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
80100f65:	e8 20 40 00 00       	call   80104f8a <initlock>
}
80100f6a:	c9                   	leave  
80100f6b:	c3                   	ret    

80100f6c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f6c:	55                   	push   %ebp
80100f6d:	89 e5                	mov    %esp,%ebp
80100f6f:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f72:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
80100f79:	e8 2d 40 00 00       	call   80104fab <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f7e:	c7 45 f4 54 08 11 80 	movl   $0x80110854,-0xc(%ebp)
80100f85:	eb 29                	jmp    80100fb0 <filealloc+0x44>
    if(f->ref == 0){
80100f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f8a:	8b 40 04             	mov    0x4(%eax),%eax
80100f8d:	85 c0                	test   %eax,%eax
80100f8f:	75 1b                	jne    80100fac <filealloc+0x40>
      f->ref = 1;
80100f91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f94:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f9b:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
80100fa2:	e8 66 40 00 00       	call   8010500d <release>
      return f;
80100fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100faa:	eb 1e                	jmp    80100fca <filealloc+0x5e>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fac:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fb0:	81 7d f4 b4 11 11 80 	cmpl   $0x801111b4,-0xc(%ebp)
80100fb7:	72 ce                	jb     80100f87 <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fb9:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
80100fc0:	e8 48 40 00 00       	call   8010500d <release>
  return 0;
80100fc5:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100fca:	c9                   	leave  
80100fcb:	c3                   	ret    

80100fcc <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fcc:	55                   	push   %ebp
80100fcd:	89 e5                	mov    %esp,%ebp
80100fcf:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
80100fd2:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
80100fd9:	e8 cd 3f 00 00       	call   80104fab <acquire>
  if(f->ref < 1)
80100fde:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe1:	8b 40 04             	mov    0x4(%eax),%eax
80100fe4:	85 c0                	test   %eax,%eax
80100fe6:	7f 0c                	jg     80100ff4 <filedup+0x28>
    panic("filedup");
80100fe8:	c7 04 24 25 86 10 80 	movl   $0x80108625,(%esp)
80100fef:	e8 52 f5 ff ff       	call   80100546 <panic>
  f->ref++;
80100ff4:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff7:	8b 40 04             	mov    0x4(%eax),%eax
80100ffa:	8d 50 01             	lea    0x1(%eax),%edx
80100ffd:	8b 45 08             	mov    0x8(%ebp),%eax
80101000:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101003:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
8010100a:	e8 fe 3f 00 00       	call   8010500d <release>
  return f;
8010100f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101012:	c9                   	leave  
80101013:	c3                   	ret    

80101014 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101014:	55                   	push   %ebp
80101015:	89 e5                	mov    %esp,%ebp
80101017:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
8010101a:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
80101021:	e8 85 3f 00 00       	call   80104fab <acquire>
  if(f->ref < 1)
80101026:	8b 45 08             	mov    0x8(%ebp),%eax
80101029:	8b 40 04             	mov    0x4(%eax),%eax
8010102c:	85 c0                	test   %eax,%eax
8010102e:	7f 0c                	jg     8010103c <fileclose+0x28>
    panic("fileclose");
80101030:	c7 04 24 2d 86 10 80 	movl   $0x8010862d,(%esp)
80101037:	e8 0a f5 ff ff       	call   80100546 <panic>
  if(--f->ref > 0){
8010103c:	8b 45 08             	mov    0x8(%ebp),%eax
8010103f:	8b 40 04             	mov    0x4(%eax),%eax
80101042:	8d 50 ff             	lea    -0x1(%eax),%edx
80101045:	8b 45 08             	mov    0x8(%ebp),%eax
80101048:	89 50 04             	mov    %edx,0x4(%eax)
8010104b:	8b 45 08             	mov    0x8(%ebp),%eax
8010104e:	8b 40 04             	mov    0x4(%eax),%eax
80101051:	85 c0                	test   %eax,%eax
80101053:	7e 11                	jle    80101066 <fileclose+0x52>
    release(&ftable.lock);
80101055:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
8010105c:	e8 ac 3f 00 00       	call   8010500d <release>
80101061:	e9 82 00 00 00       	jmp    801010e8 <fileclose+0xd4>
    return;
  }
  ff = *f;
80101066:	8b 45 08             	mov    0x8(%ebp),%eax
80101069:	8b 10                	mov    (%eax),%edx
8010106b:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010106e:	8b 50 04             	mov    0x4(%eax),%edx
80101071:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101074:	8b 50 08             	mov    0x8(%eax),%edx
80101077:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010107a:	8b 50 0c             	mov    0xc(%eax),%edx
8010107d:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101080:	8b 50 10             	mov    0x10(%eax),%edx
80101083:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101086:	8b 40 14             	mov    0x14(%eax),%eax
80101089:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
8010108c:	8b 45 08             	mov    0x8(%ebp),%eax
8010108f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101096:	8b 45 08             	mov    0x8(%ebp),%eax
80101099:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
8010109f:	c7 04 24 20 08 11 80 	movl   $0x80110820,(%esp)
801010a6:	e8 62 3f 00 00       	call   8010500d <release>
  
  if(ff.type == FD_PIPE)
801010ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ae:	83 f8 01             	cmp    $0x1,%eax
801010b1:	75 18                	jne    801010cb <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
801010b3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010b7:	0f be d0             	movsbl %al,%edx
801010ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010bd:	89 54 24 04          	mov    %edx,0x4(%esp)
801010c1:	89 04 24             	mov    %eax,(%esp)
801010c4:	e8 02 31 00 00       	call   801041cb <pipeclose>
801010c9:	eb 1d                	jmp    801010e8 <fileclose+0xd4>
  else if(ff.type == FD_INODE){
801010cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ce:	83 f8 02             	cmp    $0x2,%eax
801010d1:	75 15                	jne    801010e8 <fileclose+0xd4>
    begin_op();
801010d3:	e8 7c 24 00 00       	call   80103554 <begin_op>
    iput(ff.ip);
801010d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010db:	89 04 24             	mov    %eax,(%esp)
801010de:	e8 fa 09 00 00       	call   80101add <iput>
    end_op();
801010e3:	e8 ed 24 00 00       	call   801035d5 <end_op>
  }
}
801010e8:	c9                   	leave  
801010e9:	c3                   	ret    

801010ea <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010ea:	55                   	push   %ebp
801010eb:	89 e5                	mov    %esp,%ebp
801010ed:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
801010f0:	8b 45 08             	mov    0x8(%ebp),%eax
801010f3:	8b 00                	mov    (%eax),%eax
801010f5:	83 f8 02             	cmp    $0x2,%eax
801010f8:	75 38                	jne    80101132 <filestat+0x48>
    ilock(f->ip);
801010fa:	8b 45 08             	mov    0x8(%ebp),%eax
801010fd:	8b 40 10             	mov    0x10(%eax),%eax
80101100:	89 04 24             	mov    %eax,(%esp)
80101103:	e8 1c 08 00 00       	call   80101924 <ilock>
    stati(f->ip, st);
80101108:	8b 45 08             	mov    0x8(%ebp),%eax
8010110b:	8b 40 10             	mov    0x10(%eax),%eax
8010110e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101111:	89 54 24 04          	mov    %edx,0x4(%esp)
80101115:	89 04 24             	mov    %eax,(%esp)
80101118:	e8 d5 0c 00 00       	call   80101df2 <stati>
    iunlock(f->ip);
8010111d:	8b 45 08             	mov    0x8(%ebp),%eax
80101120:	8b 40 10             	mov    0x10(%eax),%eax
80101123:	89 04 24             	mov    %eax,(%esp)
80101126:	e8 4d 09 00 00       	call   80101a78 <iunlock>
    return 0;
8010112b:	b8 00 00 00 00       	mov    $0x0,%eax
80101130:	eb 05                	jmp    80101137 <filestat+0x4d>
  }
  return -1;
80101132:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101137:	c9                   	leave  
80101138:	c3                   	ret    

80101139 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101139:	55                   	push   %ebp
8010113a:	89 e5                	mov    %esp,%ebp
8010113c:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
8010113f:	8b 45 08             	mov    0x8(%ebp),%eax
80101142:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101146:	84 c0                	test   %al,%al
80101148:	75 0a                	jne    80101154 <fileread+0x1b>
    return -1;
8010114a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010114f:	e9 9f 00 00 00       	jmp    801011f3 <fileread+0xba>
  if(f->type == FD_PIPE)
80101154:	8b 45 08             	mov    0x8(%ebp),%eax
80101157:	8b 00                	mov    (%eax),%eax
80101159:	83 f8 01             	cmp    $0x1,%eax
8010115c:	75 1e                	jne    8010117c <fileread+0x43>
    return piperead(f->pipe, addr, n);
8010115e:	8b 45 08             	mov    0x8(%ebp),%eax
80101161:	8b 40 0c             	mov    0xc(%eax),%eax
80101164:	8b 55 10             	mov    0x10(%ebp),%edx
80101167:	89 54 24 08          	mov    %edx,0x8(%esp)
8010116b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010116e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101172:	89 04 24             	mov    %eax,(%esp)
80101175:	e8 d5 31 00 00       	call   8010434f <piperead>
8010117a:	eb 77                	jmp    801011f3 <fileread+0xba>
  if(f->type == FD_INODE){
8010117c:	8b 45 08             	mov    0x8(%ebp),%eax
8010117f:	8b 00                	mov    (%eax),%eax
80101181:	83 f8 02             	cmp    $0x2,%eax
80101184:	75 61                	jne    801011e7 <fileread+0xae>
    ilock(f->ip);
80101186:	8b 45 08             	mov    0x8(%ebp),%eax
80101189:	8b 40 10             	mov    0x10(%eax),%eax
8010118c:	89 04 24             	mov    %eax,(%esp)
8010118f:	e8 90 07 00 00       	call   80101924 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101194:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101197:	8b 45 08             	mov    0x8(%ebp),%eax
8010119a:	8b 50 14             	mov    0x14(%eax),%edx
8010119d:	8b 45 08             	mov    0x8(%ebp),%eax
801011a0:	8b 40 10             	mov    0x10(%eax),%eax
801011a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801011a7:	89 54 24 08          	mov    %edx,0x8(%esp)
801011ab:	8b 55 0c             	mov    0xc(%ebp),%edx
801011ae:	89 54 24 04          	mov    %edx,0x4(%esp)
801011b2:	89 04 24             	mov    %eax,(%esp)
801011b5:	e8 7d 0c 00 00       	call   80101e37 <readi>
801011ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011c1:	7e 11                	jle    801011d4 <fileread+0x9b>
      f->off += r;
801011c3:	8b 45 08             	mov    0x8(%ebp),%eax
801011c6:	8b 50 14             	mov    0x14(%eax),%edx
801011c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011cc:	01 c2                	add    %eax,%edx
801011ce:	8b 45 08             	mov    0x8(%ebp),%eax
801011d1:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801011d4:	8b 45 08             	mov    0x8(%ebp),%eax
801011d7:	8b 40 10             	mov    0x10(%eax),%eax
801011da:	89 04 24             	mov    %eax,(%esp)
801011dd:	e8 96 08 00 00       	call   80101a78 <iunlock>
    return r;
801011e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011e5:	eb 0c                	jmp    801011f3 <fileread+0xba>
  }
  panic("fileread");
801011e7:	c7 04 24 37 86 10 80 	movl   $0x80108637,(%esp)
801011ee:	e8 53 f3 ff ff       	call   80100546 <panic>
}
801011f3:	c9                   	leave  
801011f4:	c3                   	ret    

801011f5 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011f5:	55                   	push   %ebp
801011f6:	89 e5                	mov    %esp,%ebp
801011f8:	53                   	push   %ebx
801011f9:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
801011fc:	8b 45 08             	mov    0x8(%ebp),%eax
801011ff:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101203:	84 c0                	test   %al,%al
80101205:	75 0a                	jne    80101211 <filewrite+0x1c>
    return -1;
80101207:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010120c:	e9 23 01 00 00       	jmp    80101334 <filewrite+0x13f>
  if(f->type == FD_PIPE)
80101211:	8b 45 08             	mov    0x8(%ebp),%eax
80101214:	8b 00                	mov    (%eax),%eax
80101216:	83 f8 01             	cmp    $0x1,%eax
80101219:	75 21                	jne    8010123c <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
8010121b:	8b 45 08             	mov    0x8(%ebp),%eax
8010121e:	8b 40 0c             	mov    0xc(%eax),%eax
80101221:	8b 55 10             	mov    0x10(%ebp),%edx
80101224:	89 54 24 08          	mov    %edx,0x8(%esp)
80101228:	8b 55 0c             	mov    0xc(%ebp),%edx
8010122b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010122f:	89 04 24             	mov    %eax,(%esp)
80101232:	e8 26 30 00 00       	call   8010425d <pipewrite>
80101237:	e9 f8 00 00 00       	jmp    80101334 <filewrite+0x13f>
  if(f->type == FD_INODE){
8010123c:	8b 45 08             	mov    0x8(%ebp),%eax
8010123f:	8b 00                	mov    (%eax),%eax
80101241:	83 f8 02             	cmp    $0x2,%eax
80101244:	0f 85 de 00 00 00    	jne    80101328 <filewrite+0x133>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010124a:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
80101251:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101258:	e9 a8 00 00 00       	jmp    80101305 <filewrite+0x110>
      int n1 = n - i;
8010125d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101260:	8b 55 10             	mov    0x10(%ebp),%edx
80101263:	89 d1                	mov    %edx,%ecx
80101265:	29 c1                	sub    %eax,%ecx
80101267:	89 c8                	mov    %ecx,%eax
80101269:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010126c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010126f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101272:	7e 06                	jle    8010127a <filewrite+0x85>
        n1 = max;
80101274:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101277:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
8010127a:	e8 d5 22 00 00       	call   80103554 <begin_op>
      ilock(f->ip);
8010127f:	8b 45 08             	mov    0x8(%ebp),%eax
80101282:	8b 40 10             	mov    0x10(%eax),%eax
80101285:	89 04 24             	mov    %eax,(%esp)
80101288:	e8 97 06 00 00       	call   80101924 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010128d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101290:	8b 45 08             	mov    0x8(%ebp),%eax
80101293:	8b 50 14             	mov    0x14(%eax),%edx
80101296:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101299:	8b 45 0c             	mov    0xc(%ebp),%eax
8010129c:	01 c3                	add    %eax,%ebx
8010129e:	8b 45 08             	mov    0x8(%ebp),%eax
801012a1:	8b 40 10             	mov    0x10(%eax),%eax
801012a4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801012a8:	89 54 24 08          	mov    %edx,0x8(%esp)
801012ac:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801012b0:	89 04 24             	mov    %eax,(%esp)
801012b3:	e8 e5 0c 00 00       	call   80101f9d <writei>
801012b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012bf:	7e 11                	jle    801012d2 <filewrite+0xdd>
        f->off += r;
801012c1:	8b 45 08             	mov    0x8(%ebp),%eax
801012c4:	8b 50 14             	mov    0x14(%eax),%edx
801012c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012ca:	01 c2                	add    %eax,%edx
801012cc:	8b 45 08             	mov    0x8(%ebp),%eax
801012cf:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012d2:	8b 45 08             	mov    0x8(%ebp),%eax
801012d5:	8b 40 10             	mov    0x10(%eax),%eax
801012d8:	89 04 24             	mov    %eax,(%esp)
801012db:	e8 98 07 00 00       	call   80101a78 <iunlock>
      end_op();
801012e0:	e8 f0 22 00 00       	call   801035d5 <end_op>

      if(r < 0)
801012e5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012e9:	78 28                	js     80101313 <filewrite+0x11e>
        break;
      if(r != n1)
801012eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801012f1:	74 0c                	je     801012ff <filewrite+0x10a>
        panic("short filewrite");
801012f3:	c7 04 24 40 86 10 80 	movl   $0x80108640,(%esp)
801012fa:	e8 47 f2 ff ff       	call   80100546 <panic>
      i += r;
801012ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101302:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101305:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101308:	3b 45 10             	cmp    0x10(%ebp),%eax
8010130b:	0f 8c 4c ff ff ff    	jl     8010125d <filewrite+0x68>
80101311:	eb 01                	jmp    80101314 <filewrite+0x11f>
        f->off += r;
      iunlock(f->ip);
      end_op();

      if(r < 0)
        break;
80101313:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101314:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101317:	3b 45 10             	cmp    0x10(%ebp),%eax
8010131a:	75 05                	jne    80101321 <filewrite+0x12c>
8010131c:	8b 45 10             	mov    0x10(%ebp),%eax
8010131f:	eb 05                	jmp    80101326 <filewrite+0x131>
80101321:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101326:	eb 0c                	jmp    80101334 <filewrite+0x13f>
  }
  panic("filewrite");
80101328:	c7 04 24 50 86 10 80 	movl   $0x80108650,(%esp)
8010132f:	e8 12 f2 ff ff       	call   80100546 <panic>
}
80101334:	83 c4 24             	add    $0x24,%esp
80101337:	5b                   	pop    %ebx
80101338:	5d                   	pop    %ebp
80101339:	c3                   	ret    
	...

8010133c <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010133c:	55                   	push   %ebp
8010133d:	89 e5                	mov    %esp,%ebp
8010133f:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101342:	8b 45 08             	mov    0x8(%ebp),%eax
80101345:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010134c:	00 
8010134d:	89 04 24             	mov    %eax,(%esp)
80101350:	e8 51 ee ff ff       	call   801001a6 <bread>
80101355:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101358:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010135b:	83 c0 18             	add    $0x18,%eax
8010135e:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101365:	00 
80101366:	89 44 24 04          	mov    %eax,0x4(%esp)
8010136a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010136d:	89 04 24             	mov    %eax,(%esp)
80101370:	e8 64 3f 00 00       	call   801052d9 <memmove>
  brelse(bp);
80101375:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101378:	89 04 24             	mov    %eax,(%esp)
8010137b:	e8 97 ee ff ff       	call   80100217 <brelse>
}
80101380:	c9                   	leave  
80101381:	c3                   	ret    

80101382 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101382:	55                   	push   %ebp
80101383:	89 e5                	mov    %esp,%ebp
80101385:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101388:	8b 55 0c             	mov    0xc(%ebp),%edx
8010138b:	8b 45 08             	mov    0x8(%ebp),%eax
8010138e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101392:	89 04 24             	mov    %eax,(%esp)
80101395:	e8 0c ee ff ff       	call   801001a6 <bread>
8010139a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
8010139d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013a0:	83 c0 18             	add    $0x18,%eax
801013a3:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801013aa:	00 
801013ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801013b2:	00 
801013b3:	89 04 24             	mov    %eax,(%esp)
801013b6:	e8 4b 3e 00 00       	call   80105206 <memset>
  log_write(bp);
801013bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013be:	89 04 24             	mov    %eax,(%esp)
801013c1:	e8 96 23 00 00       	call   8010375c <log_write>
  brelse(bp);
801013c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013c9:	89 04 24             	mov    %eax,(%esp)
801013cc:	e8 46 ee ff ff       	call   80100217 <brelse>
}
801013d1:	c9                   	leave  
801013d2:	c3                   	ret    

801013d3 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013d3:	55                   	push   %ebp
801013d4:	89 e5                	mov    %esp,%ebp
801013d6:	53                   	push   %ebx
801013d7:	83 ec 24             	sub    $0x24,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801013da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801013e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013e8:	e9 10 01 00 00       	jmp    801014fd <balloc+0x12a>
    bp = bread(dev, BBLOCK(b, sb));
801013ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013f0:	89 c2                	mov    %eax,%edx
801013f2:	c1 fa 1f             	sar    $0x1f,%edx
801013f5:	c1 ea 14             	shr    $0x14,%edx
801013f8:	01 d0                	add    %edx,%eax
801013fa:	c1 f8 0c             	sar    $0xc,%eax
801013fd:	89 c2                	mov    %eax,%edx
801013ff:	a1 38 12 11 80       	mov    0x80111238,%eax
80101404:	01 d0                	add    %edx,%eax
80101406:	89 44 24 04          	mov    %eax,0x4(%esp)
8010140a:	8b 45 08             	mov    0x8(%ebp),%eax
8010140d:	89 04 24             	mov    %eax,(%esp)
80101410:	e8 91 ed ff ff       	call   801001a6 <bread>
80101415:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101418:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010141f:	e9 a7 00 00 00       	jmp    801014cb <balloc+0xf8>
      m = 1 << (bi % 8);
80101424:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101427:	89 c2                	mov    %eax,%edx
80101429:	c1 fa 1f             	sar    $0x1f,%edx
8010142c:	c1 ea 1d             	shr    $0x1d,%edx
8010142f:	01 d0                	add    %edx,%eax
80101431:	83 e0 07             	and    $0x7,%eax
80101434:	29 d0                	sub    %edx,%eax
80101436:	ba 01 00 00 00       	mov    $0x1,%edx
8010143b:	89 d3                	mov    %edx,%ebx
8010143d:	89 c1                	mov    %eax,%ecx
8010143f:	d3 e3                	shl    %cl,%ebx
80101441:	89 d8                	mov    %ebx,%eax
80101443:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101446:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101449:	89 c2                	mov    %eax,%edx
8010144b:	c1 fa 1f             	sar    $0x1f,%edx
8010144e:	c1 ea 1d             	shr    $0x1d,%edx
80101451:	01 d0                	add    %edx,%eax
80101453:	c1 f8 03             	sar    $0x3,%eax
80101456:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101459:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
8010145e:	0f b6 c0             	movzbl %al,%eax
80101461:	23 45 e8             	and    -0x18(%ebp),%eax
80101464:	85 c0                	test   %eax,%eax
80101466:	75 5f                	jne    801014c7 <balloc+0xf4>
        bp->data[bi/8] |= m;  // Mark block in use.
80101468:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010146b:	89 c2                	mov    %eax,%edx
8010146d:	c1 fa 1f             	sar    $0x1f,%edx
80101470:	c1 ea 1d             	shr    $0x1d,%edx
80101473:	01 d0                	add    %edx,%eax
80101475:	c1 f8 03             	sar    $0x3,%eax
80101478:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010147b:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101480:	89 d1                	mov    %edx,%ecx
80101482:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101485:	09 ca                	or     %ecx,%edx
80101487:	89 d1                	mov    %edx,%ecx
80101489:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010148c:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101490:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101493:	89 04 24             	mov    %eax,(%esp)
80101496:	e8 c1 22 00 00       	call   8010375c <log_write>
        brelse(bp);
8010149b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010149e:	89 04 24             	mov    %eax,(%esp)
801014a1:	e8 71 ed ff ff       	call   80100217 <brelse>
        bzero(dev, b + bi);
801014a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ac:	01 c2                	add    %eax,%edx
801014ae:	8b 45 08             	mov    0x8(%ebp),%eax
801014b1:	89 54 24 04          	mov    %edx,0x4(%esp)
801014b5:	89 04 24             	mov    %eax,(%esp)
801014b8:	e8 c5 fe ff ff       	call   80101382 <bzero>
        return b + bi;
801014bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014c3:	01 d0                	add    %edx,%eax
801014c5:	eb 52                	jmp    80101519 <balloc+0x146>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014c7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014cb:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014d2:	7f 17                	jg     801014eb <balloc+0x118>
801014d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014da:	01 d0                	add    %edx,%eax
801014dc:	89 c2                	mov    %eax,%edx
801014de:	a1 20 12 11 80       	mov    0x80111220,%eax
801014e3:	39 c2                	cmp    %eax,%edx
801014e5:	0f 82 39 ff ff ff    	jb     80101424 <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014ee:	89 04 24             	mov    %eax,(%esp)
801014f1:	e8 21 ed ff ff       	call   80100217 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801014f6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801014fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101500:	a1 20 12 11 80       	mov    0x80111220,%eax
80101505:	39 c2                	cmp    %eax,%edx
80101507:	0f 82 e0 fe ff ff    	jb     801013ed <balloc+0x1a>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010150d:	c7 04 24 5c 86 10 80 	movl   $0x8010865c,(%esp)
80101514:	e8 2d f0 ff ff       	call   80100546 <panic>
}
80101519:	83 c4 24             	add    $0x24,%esp
8010151c:	5b                   	pop    %ebx
8010151d:	5d                   	pop    %ebp
8010151e:	c3                   	ret    

8010151f <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010151f:	55                   	push   %ebp
80101520:	89 e5                	mov    %esp,%ebp
80101522:	53                   	push   %ebx
80101523:	83 ec 24             	sub    $0x24,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101526:	c7 44 24 04 20 12 11 	movl   $0x80111220,0x4(%esp)
8010152d:	80 
8010152e:	8b 45 08             	mov    0x8(%ebp),%eax
80101531:	89 04 24             	mov    %eax,(%esp)
80101534:	e8 03 fe ff ff       	call   8010133c <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101539:	8b 45 0c             	mov    0xc(%ebp),%eax
8010153c:	89 c2                	mov    %eax,%edx
8010153e:	c1 ea 0c             	shr    $0xc,%edx
80101541:	a1 38 12 11 80       	mov    0x80111238,%eax
80101546:	01 c2                	add    %eax,%edx
80101548:	8b 45 08             	mov    0x8(%ebp),%eax
8010154b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010154f:	89 04 24             	mov    %eax,(%esp)
80101552:	e8 4f ec ff ff       	call   801001a6 <bread>
80101557:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
8010155a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010155d:	25 ff 0f 00 00       	and    $0xfff,%eax
80101562:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101565:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101568:	89 c2                	mov    %eax,%edx
8010156a:	c1 fa 1f             	sar    $0x1f,%edx
8010156d:	c1 ea 1d             	shr    $0x1d,%edx
80101570:	01 d0                	add    %edx,%eax
80101572:	83 e0 07             	and    $0x7,%eax
80101575:	29 d0                	sub    %edx,%eax
80101577:	ba 01 00 00 00       	mov    $0x1,%edx
8010157c:	89 d3                	mov    %edx,%ebx
8010157e:	89 c1                	mov    %eax,%ecx
80101580:	d3 e3                	shl    %cl,%ebx
80101582:	89 d8                	mov    %ebx,%eax
80101584:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101587:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010158a:	89 c2                	mov    %eax,%edx
8010158c:	c1 fa 1f             	sar    $0x1f,%edx
8010158f:	c1 ea 1d             	shr    $0x1d,%edx
80101592:	01 d0                	add    %edx,%eax
80101594:	c1 f8 03             	sar    $0x3,%eax
80101597:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010159a:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
8010159f:	0f b6 c0             	movzbl %al,%eax
801015a2:	23 45 ec             	and    -0x14(%ebp),%eax
801015a5:	85 c0                	test   %eax,%eax
801015a7:	75 0c                	jne    801015b5 <bfree+0x96>
    panic("freeing free block");
801015a9:	c7 04 24 72 86 10 80 	movl   $0x80108672,(%esp)
801015b0:	e8 91 ef ff ff       	call   80100546 <panic>
  bp->data[bi/8] &= ~m;
801015b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015b8:	89 c2                	mov    %eax,%edx
801015ba:	c1 fa 1f             	sar    $0x1f,%edx
801015bd:	c1 ea 1d             	shr    $0x1d,%edx
801015c0:	01 d0                	add    %edx,%eax
801015c2:	c1 f8 03             	sar    $0x3,%eax
801015c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015c8:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015cd:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801015d0:	f7 d1                	not    %ecx
801015d2:	21 ca                	and    %ecx,%edx
801015d4:	89 d1                	mov    %edx,%ecx
801015d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015d9:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801015dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015e0:	89 04 24             	mov    %eax,(%esp)
801015e3:	e8 74 21 00 00       	call   8010375c <log_write>
  brelse(bp);
801015e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015eb:	89 04 24             	mov    %eax,(%esp)
801015ee:	e8 24 ec ff ff       	call   80100217 <brelse>
}
801015f3:	83 c4 24             	add    $0x24,%esp
801015f6:	5b                   	pop    %ebx
801015f7:	5d                   	pop    %ebp
801015f8:	c3                   	ret    

801015f9 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801015f9:	55                   	push   %ebp
801015fa:	89 e5                	mov    %esp,%ebp
801015fc:	57                   	push   %edi
801015fd:	56                   	push   %esi
801015fe:	53                   	push   %ebx
801015ff:	83 ec 3c             	sub    $0x3c,%esp
  initlock(&icache.lock, "icache");
80101602:	c7 44 24 04 85 86 10 	movl   $0x80108685,0x4(%esp)
80101609:	80 
8010160a:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101611:	e8 74 39 00 00       	call   80104f8a <initlock>
  readsb(dev, &sb);
80101616:	c7 44 24 04 20 12 11 	movl   $0x80111220,0x4(%esp)
8010161d:	80 
8010161e:	8b 45 08             	mov    0x8(%ebp),%eax
80101621:	89 04 24             	mov    %eax,(%esp)
80101624:	e8 13 fd ff ff       	call   8010133c <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
80101629:	a1 38 12 11 80       	mov    0x80111238,%eax
8010162e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101631:	8b 3d 34 12 11 80    	mov    0x80111234,%edi
80101637:	8b 35 30 12 11 80    	mov    0x80111230,%esi
8010163d:	8b 1d 2c 12 11 80    	mov    0x8011122c,%ebx
80101643:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80101649:	8b 15 24 12 11 80    	mov    0x80111224,%edx
8010164f:	a1 20 12 11 80       	mov    0x80111220,%eax
80101654:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101657:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010165a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
8010165e:	89 7c 24 18          	mov    %edi,0x18(%esp)
80101662:	89 74 24 14          	mov    %esi,0x14(%esp)
80101666:	89 5c 24 10          	mov    %ebx,0x10(%esp)
8010166a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010166e:	89 54 24 08          	mov    %edx,0x8(%esp)
80101672:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101675:	89 44 24 04          	mov    %eax,0x4(%esp)
80101679:	c7 04 24 8c 86 10 80 	movl   $0x8010868c,(%esp)
80101680:	e8 25 ed ff ff       	call   801003aa <cprintf>
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
80101685:	83 c4 3c             	add    $0x3c,%esp
80101688:	5b                   	pop    %ebx
80101689:	5e                   	pop    %esi
8010168a:	5f                   	pop    %edi
8010168b:	5d                   	pop    %ebp
8010168c:	c3                   	ret    

8010168d <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
8010168d:	55                   	push   %ebp
8010168e:	89 e5                	mov    %esp,%ebp
80101690:	83 ec 38             	sub    $0x38,%esp
80101693:	8b 45 0c             	mov    0xc(%ebp),%eax
80101696:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010169a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801016a1:	e9 9e 00 00 00       	jmp    80101744 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
801016a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016a9:	89 c2                	mov    %eax,%edx
801016ab:	c1 ea 03             	shr    $0x3,%edx
801016ae:	a1 34 12 11 80       	mov    0x80111234,%eax
801016b3:	01 d0                	add    %edx,%eax
801016b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801016b9:	8b 45 08             	mov    0x8(%ebp),%eax
801016bc:	89 04 24             	mov    %eax,(%esp)
801016bf:	e8 e2 ea ff ff       	call   801001a6 <bread>
801016c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801016c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016ca:	8d 50 18             	lea    0x18(%eax),%edx
801016cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016d0:	83 e0 07             	and    $0x7,%eax
801016d3:	c1 e0 06             	shl    $0x6,%eax
801016d6:	01 d0                	add    %edx,%eax
801016d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801016db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016de:	0f b7 00             	movzwl (%eax),%eax
801016e1:	66 85 c0             	test   %ax,%ax
801016e4:	75 4f                	jne    80101735 <ialloc+0xa8>
      memset(dip, 0, sizeof(*dip));
801016e6:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
801016ed:	00 
801016ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801016f5:	00 
801016f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016f9:	89 04 24             	mov    %eax,(%esp)
801016fc:	e8 05 3b 00 00       	call   80105206 <memset>
      dip->type = type;
80101701:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101704:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
80101708:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
8010170b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010170e:	89 04 24             	mov    %eax,(%esp)
80101711:	e8 46 20 00 00       	call   8010375c <log_write>
      brelse(bp);
80101716:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101719:	89 04 24             	mov    %eax,(%esp)
8010171c:	e8 f6 ea ff ff       	call   80100217 <brelse>
      return iget(dev, inum);
80101721:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101724:	89 44 24 04          	mov    %eax,0x4(%esp)
80101728:	8b 45 08             	mov    0x8(%ebp),%eax
8010172b:	89 04 24             	mov    %eax,(%esp)
8010172e:	e8 ed 00 00 00       	call   80101820 <iget>
80101733:	eb 2b                	jmp    80101760 <ialloc+0xd3>
    }
    brelse(bp);
80101735:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101738:	89 04 24             	mov    %eax,(%esp)
8010173b:	e8 d7 ea ff ff       	call   80100217 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101740:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101744:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101747:	a1 28 12 11 80       	mov    0x80111228,%eax
8010174c:	39 c2                	cmp    %eax,%edx
8010174e:	0f 82 52 ff ff ff    	jb     801016a6 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101754:	c7 04 24 df 86 10 80 	movl   $0x801086df,(%esp)
8010175b:	e8 e6 ed ff ff       	call   80100546 <panic>
}
80101760:	c9                   	leave  
80101761:	c3                   	ret    

80101762 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101762:	55                   	push   %ebp
80101763:	89 e5                	mov    %esp,%ebp
80101765:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101768:	8b 45 08             	mov    0x8(%ebp),%eax
8010176b:	8b 40 04             	mov    0x4(%eax),%eax
8010176e:	89 c2                	mov    %eax,%edx
80101770:	c1 ea 03             	shr    $0x3,%edx
80101773:	a1 34 12 11 80       	mov    0x80111234,%eax
80101778:	01 c2                	add    %eax,%edx
8010177a:	8b 45 08             	mov    0x8(%ebp),%eax
8010177d:	8b 00                	mov    (%eax),%eax
8010177f:	89 54 24 04          	mov    %edx,0x4(%esp)
80101783:	89 04 24             	mov    %eax,(%esp)
80101786:	e8 1b ea ff ff       	call   801001a6 <bread>
8010178b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101791:	8d 50 18             	lea    0x18(%eax),%edx
80101794:	8b 45 08             	mov    0x8(%ebp),%eax
80101797:	8b 40 04             	mov    0x4(%eax),%eax
8010179a:	83 e0 07             	and    $0x7,%eax
8010179d:	c1 e0 06             	shl    $0x6,%eax
801017a0:	01 d0                	add    %edx,%eax
801017a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017a5:	8b 45 08             	mov    0x8(%ebp),%eax
801017a8:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801017ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017af:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017b2:	8b 45 08             	mov    0x8(%ebp),%eax
801017b5:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801017b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017bc:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801017c0:	8b 45 08             	mov    0x8(%ebp),%eax
801017c3:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801017c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ca:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801017ce:	8b 45 08             	mov    0x8(%ebp),%eax
801017d1:	0f b7 50 16          	movzwl 0x16(%eax),%edx
801017d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017d8:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801017dc:	8b 45 08             	mov    0x8(%ebp),%eax
801017df:	8b 50 18             	mov    0x18(%eax),%edx
801017e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017e5:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017e8:	8b 45 08             	mov    0x8(%ebp),%eax
801017eb:	8d 50 1c             	lea    0x1c(%eax),%edx
801017ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017f1:	83 c0 0c             	add    $0xc,%eax
801017f4:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801017fb:	00 
801017fc:	89 54 24 04          	mov    %edx,0x4(%esp)
80101800:	89 04 24             	mov    %eax,(%esp)
80101803:	e8 d1 3a 00 00       	call   801052d9 <memmove>
  log_write(bp);
80101808:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010180b:	89 04 24             	mov    %eax,(%esp)
8010180e:	e8 49 1f 00 00       	call   8010375c <log_write>
  brelse(bp);
80101813:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101816:	89 04 24             	mov    %eax,(%esp)
80101819:	e8 f9 e9 ff ff       	call   80100217 <brelse>
}
8010181e:	c9                   	leave  
8010181f:	c3                   	ret    

80101820 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101826:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010182d:	e8 79 37 00 00       	call   80104fab <acquire>

  // Is the inode already cached?
  empty = 0;
80101832:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101839:	c7 45 f4 74 12 11 80 	movl   $0x80111274,-0xc(%ebp)
80101840:	eb 59                	jmp    8010189b <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101842:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101845:	8b 40 08             	mov    0x8(%eax),%eax
80101848:	85 c0                	test   %eax,%eax
8010184a:	7e 35                	jle    80101881 <iget+0x61>
8010184c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010184f:	8b 00                	mov    (%eax),%eax
80101851:	3b 45 08             	cmp    0x8(%ebp),%eax
80101854:	75 2b                	jne    80101881 <iget+0x61>
80101856:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101859:	8b 40 04             	mov    0x4(%eax),%eax
8010185c:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010185f:	75 20                	jne    80101881 <iget+0x61>
      ip->ref++;
80101861:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101864:	8b 40 08             	mov    0x8(%eax),%eax
80101867:	8d 50 01             	lea    0x1(%eax),%edx
8010186a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010186d:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101870:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101877:	e8 91 37 00 00       	call   8010500d <release>
      return ip;
8010187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010187f:	eb 6f                	jmp    801018f0 <iget+0xd0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101881:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101885:	75 10                	jne    80101897 <iget+0x77>
80101887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188a:	8b 40 08             	mov    0x8(%eax),%eax
8010188d:	85 c0                	test   %eax,%eax
8010188f:	75 06                	jne    80101897 <iget+0x77>
      empty = ip;
80101891:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101894:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101897:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
8010189b:	81 7d f4 14 22 11 80 	cmpl   $0x80112214,-0xc(%ebp)
801018a2:	72 9e                	jb     80101842 <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801018a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018a8:	75 0c                	jne    801018b6 <iget+0x96>
    panic("iget: no inodes");
801018aa:	c7 04 24 f1 86 10 80 	movl   $0x801086f1,(%esp)
801018b1:	e8 90 ec ff ff       	call   80100546 <panic>

  ip = empty;
801018b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801018bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018bf:	8b 55 08             	mov    0x8(%ebp),%edx
801018c2:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801018c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801018ca:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801018cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d0:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801018d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018da:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801018e1:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
801018e8:	e8 20 37 00 00       	call   8010500d <release>

  return ip;
801018ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801018f0:	c9                   	leave  
801018f1:	c3                   	ret    

801018f2 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018f2:	55                   	push   %ebp
801018f3:	89 e5                	mov    %esp,%ebp
801018f5:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
801018f8:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
801018ff:	e8 a7 36 00 00       	call   80104fab <acquire>
  ip->ref++;
80101904:	8b 45 08             	mov    0x8(%ebp),%eax
80101907:	8b 40 08             	mov    0x8(%eax),%eax
8010190a:	8d 50 01             	lea    0x1(%eax),%edx
8010190d:	8b 45 08             	mov    0x8(%ebp),%eax
80101910:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101913:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010191a:	e8 ee 36 00 00       	call   8010500d <release>
  return ip;
8010191f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101922:	c9                   	leave  
80101923:	c3                   	ret    

80101924 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101924:	55                   	push   %ebp
80101925:	89 e5                	mov    %esp,%ebp
80101927:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010192a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010192e:	74 0a                	je     8010193a <ilock+0x16>
80101930:	8b 45 08             	mov    0x8(%ebp),%eax
80101933:	8b 40 08             	mov    0x8(%eax),%eax
80101936:	85 c0                	test   %eax,%eax
80101938:	7f 0c                	jg     80101946 <ilock+0x22>
    panic("ilock");
8010193a:	c7 04 24 01 87 10 80 	movl   $0x80108701,(%esp)
80101941:	e8 00 ec ff ff       	call   80100546 <panic>

  acquire(&icache.lock);
80101946:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010194d:	e8 59 36 00 00       	call   80104fab <acquire>
  while(ip->flags & I_BUSY)
80101952:	eb 13                	jmp    80101967 <ilock+0x43>
    sleep(ip, &icache.lock);
80101954:	c7 44 24 04 40 12 11 	movl   $0x80111240,0x4(%esp)
8010195b:	80 
8010195c:	8b 45 08             	mov    0x8(%ebp),%eax
8010195f:	89 04 24             	mov    %eax,(%esp)
80101962:	e8 66 33 00 00       	call   80104ccd <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101967:	8b 45 08             	mov    0x8(%ebp),%eax
8010196a:	8b 40 0c             	mov    0xc(%eax),%eax
8010196d:	83 e0 01             	and    $0x1,%eax
80101970:	85 c0                	test   %eax,%eax
80101972:	75 e0                	jne    80101954 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101974:	8b 45 08             	mov    0x8(%ebp),%eax
80101977:	8b 40 0c             	mov    0xc(%eax),%eax
8010197a:	89 c2                	mov    %eax,%edx
8010197c:	83 ca 01             	or     $0x1,%edx
8010197f:	8b 45 08             	mov    0x8(%ebp),%eax
80101982:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101985:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010198c:	e8 7c 36 00 00       	call   8010500d <release>

  if(!(ip->flags & I_VALID)){
80101991:	8b 45 08             	mov    0x8(%ebp),%eax
80101994:	8b 40 0c             	mov    0xc(%eax),%eax
80101997:	83 e0 02             	and    $0x2,%eax
8010199a:	85 c0                	test   %eax,%eax
8010199c:	0f 85 d4 00 00 00    	jne    80101a76 <ilock+0x152>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019a2:	8b 45 08             	mov    0x8(%ebp),%eax
801019a5:	8b 40 04             	mov    0x4(%eax),%eax
801019a8:	89 c2                	mov    %eax,%edx
801019aa:	c1 ea 03             	shr    $0x3,%edx
801019ad:	a1 34 12 11 80       	mov    0x80111234,%eax
801019b2:	01 c2                	add    %eax,%edx
801019b4:	8b 45 08             	mov    0x8(%ebp),%eax
801019b7:	8b 00                	mov    (%eax),%eax
801019b9:	89 54 24 04          	mov    %edx,0x4(%esp)
801019bd:	89 04 24             	mov    %eax,(%esp)
801019c0:	e8 e1 e7 ff ff       	call   801001a6 <bread>
801019c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019cb:	8d 50 18             	lea    0x18(%eax),%edx
801019ce:	8b 45 08             	mov    0x8(%ebp),%eax
801019d1:	8b 40 04             	mov    0x4(%eax),%eax
801019d4:	83 e0 07             	and    $0x7,%eax
801019d7:	c1 e0 06             	shl    $0x6,%eax
801019da:	01 d0                	add    %edx,%eax
801019dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019e2:	0f b7 10             	movzwl (%eax),%edx
801019e5:	8b 45 08             	mov    0x8(%ebp),%eax
801019e8:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
801019ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019ef:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801019f3:	8b 45 08             	mov    0x8(%ebp),%eax
801019f6:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
801019fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019fd:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a01:	8b 45 08             	mov    0x8(%ebp),%eax
80101a04:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101a08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a0b:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a12:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101a16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a19:	8b 50 08             	mov    0x8(%eax),%edx
80101a1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1f:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a25:	8d 50 0c             	lea    0xc(%eax),%edx
80101a28:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2b:	83 c0 1c             	add    $0x1c,%eax
80101a2e:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101a35:	00 
80101a36:	89 54 24 04          	mov    %edx,0x4(%esp)
80101a3a:	89 04 24             	mov    %eax,(%esp)
80101a3d:	e8 97 38 00 00       	call   801052d9 <memmove>
    brelse(bp);
80101a42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a45:	89 04 24             	mov    %eax,(%esp)
80101a48:	e8 ca e7 ff ff       	call   80100217 <brelse>
    ip->flags |= I_VALID;
80101a4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a50:	8b 40 0c             	mov    0xc(%eax),%eax
80101a53:	89 c2                	mov    %eax,%edx
80101a55:	83 ca 02             	or     $0x2,%edx
80101a58:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5b:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a61:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a65:	66 85 c0             	test   %ax,%ax
80101a68:	75 0c                	jne    80101a76 <ilock+0x152>
      panic("ilock: no type");
80101a6a:	c7 04 24 07 87 10 80 	movl   $0x80108707,(%esp)
80101a71:	e8 d0 ea ff ff       	call   80100546 <panic>
  }
}
80101a76:	c9                   	leave  
80101a77:	c3                   	ret    

80101a78 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a78:	55                   	push   %ebp
80101a79:	89 e5                	mov    %esp,%ebp
80101a7b:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a7e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a82:	74 17                	je     80101a9b <iunlock+0x23>
80101a84:	8b 45 08             	mov    0x8(%ebp),%eax
80101a87:	8b 40 0c             	mov    0xc(%eax),%eax
80101a8a:	83 e0 01             	and    $0x1,%eax
80101a8d:	85 c0                	test   %eax,%eax
80101a8f:	74 0a                	je     80101a9b <iunlock+0x23>
80101a91:	8b 45 08             	mov    0x8(%ebp),%eax
80101a94:	8b 40 08             	mov    0x8(%eax),%eax
80101a97:	85 c0                	test   %eax,%eax
80101a99:	7f 0c                	jg     80101aa7 <iunlock+0x2f>
    panic("iunlock");
80101a9b:	c7 04 24 16 87 10 80 	movl   $0x80108716,(%esp)
80101aa2:	e8 9f ea ff ff       	call   80100546 <panic>

  acquire(&icache.lock);
80101aa7:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101aae:	e8 f8 34 00 00       	call   80104fab <acquire>
  ip->flags &= ~I_BUSY;
80101ab3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab6:	8b 40 0c             	mov    0xc(%eax),%eax
80101ab9:	89 c2                	mov    %eax,%edx
80101abb:	83 e2 fe             	and    $0xfffffffe,%edx
80101abe:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac1:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101ac4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac7:	89 04 24             	mov    %eax,(%esp)
80101aca:	e8 d7 32 00 00       	call   80104da6 <wakeup>
  release(&icache.lock);
80101acf:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101ad6:	e8 32 35 00 00       	call   8010500d <release>
}
80101adb:	c9                   	leave  
80101adc:	c3                   	ret    

80101add <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101add:	55                   	push   %ebp
80101ade:	89 e5                	mov    %esp,%ebp
80101ae0:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101ae3:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101aea:	e8 bc 34 00 00       	call   80104fab <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101aef:	8b 45 08             	mov    0x8(%ebp),%eax
80101af2:	8b 40 08             	mov    0x8(%eax),%eax
80101af5:	83 f8 01             	cmp    $0x1,%eax
80101af8:	0f 85 93 00 00 00    	jne    80101b91 <iput+0xb4>
80101afe:	8b 45 08             	mov    0x8(%ebp),%eax
80101b01:	8b 40 0c             	mov    0xc(%eax),%eax
80101b04:	83 e0 02             	and    $0x2,%eax
80101b07:	85 c0                	test   %eax,%eax
80101b09:	0f 84 82 00 00 00    	je     80101b91 <iput+0xb4>
80101b0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b12:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b16:	66 85 c0             	test   %ax,%ax
80101b19:	75 76                	jne    80101b91 <iput+0xb4>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101b1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1e:	8b 40 0c             	mov    0xc(%eax),%eax
80101b21:	83 e0 01             	and    $0x1,%eax
80101b24:	85 c0                	test   %eax,%eax
80101b26:	74 0c                	je     80101b34 <iput+0x57>
      panic("iput busy");
80101b28:	c7 04 24 1e 87 10 80 	movl   $0x8010871e,(%esp)
80101b2f:	e8 12 ea ff ff       	call   80100546 <panic>
    ip->flags |= I_BUSY;
80101b34:	8b 45 08             	mov    0x8(%ebp),%eax
80101b37:	8b 40 0c             	mov    0xc(%eax),%eax
80101b3a:	89 c2                	mov    %eax,%edx
80101b3c:	83 ca 01             	or     $0x1,%edx
80101b3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b42:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b45:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101b4c:	e8 bc 34 00 00       	call   8010500d <release>
    itrunc(ip);
80101b51:	8b 45 08             	mov    0x8(%ebp),%eax
80101b54:	89 04 24             	mov    %eax,(%esp)
80101b57:	e8 7d 01 00 00       	call   80101cd9 <itrunc>
    ip->type = 0;
80101b5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5f:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b65:	8b 45 08             	mov    0x8(%ebp),%eax
80101b68:	89 04 24             	mov    %eax,(%esp)
80101b6b:	e8 f2 fb ff ff       	call   80101762 <iupdate>
    acquire(&icache.lock);
80101b70:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101b77:	e8 2f 34 00 00       	call   80104fab <acquire>
    ip->flags = 0;
80101b7c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b86:	8b 45 08             	mov    0x8(%ebp),%eax
80101b89:	89 04 24             	mov    %eax,(%esp)
80101b8c:	e8 15 32 00 00       	call   80104da6 <wakeup>
  }
  ip->ref--;
80101b91:	8b 45 08             	mov    0x8(%ebp),%eax
80101b94:	8b 40 08             	mov    0x8(%eax),%eax
80101b97:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9d:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101ba0:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101ba7:	e8 61 34 00 00       	call   8010500d <release>
}
80101bac:	c9                   	leave  
80101bad:	c3                   	ret    

80101bae <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101bae:	55                   	push   %ebp
80101baf:	89 e5                	mov    %esp,%ebp
80101bb1:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101bb4:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb7:	89 04 24             	mov    %eax,(%esp)
80101bba:	e8 b9 fe ff ff       	call   80101a78 <iunlock>
  iput(ip);
80101bbf:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc2:	89 04 24             	mov    %eax,(%esp)
80101bc5:	e8 13 ff ff ff       	call   80101add <iput>
}
80101bca:	c9                   	leave  
80101bcb:	c3                   	ret    

80101bcc <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101bcc:	55                   	push   %ebp
80101bcd:	89 e5                	mov    %esp,%ebp
80101bcf:	53                   	push   %ebx
80101bd0:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101bd3:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101bd7:	77 3e                	ja     80101c17 <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101bd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdc:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bdf:	83 c2 04             	add    $0x4,%edx
80101be2:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101be6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101be9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bed:	75 20                	jne    80101c0f <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101bef:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf2:	8b 00                	mov    (%eax),%eax
80101bf4:	89 04 24             	mov    %eax,(%esp)
80101bf7:	e8 d7 f7 ff ff       	call   801013d3 <balloc>
80101bfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bff:	8b 45 08             	mov    0x8(%ebp),%eax
80101c02:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c05:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c08:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c0b:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c12:	e9 bc 00 00 00       	jmp    80101cd3 <bmap+0x107>
  }
  bn -= NDIRECT;
80101c17:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c1b:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c1f:	0f 87 a2 00 00 00    	ja     80101cc7 <bmap+0xfb>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c25:	8b 45 08             	mov    0x8(%ebp),%eax
80101c28:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c32:	75 19                	jne    80101c4d <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c34:	8b 45 08             	mov    0x8(%ebp),%eax
80101c37:	8b 00                	mov    (%eax),%eax
80101c39:	89 04 24             	mov    %eax,(%esp)
80101c3c:	e8 92 f7 ff ff       	call   801013d3 <balloc>
80101c41:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c44:	8b 45 08             	mov    0x8(%ebp),%eax
80101c47:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c4a:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101c4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c50:	8b 00                	mov    (%eax),%eax
80101c52:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c55:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c59:	89 04 24             	mov    %eax,(%esp)
80101c5c:	e8 45 e5 ff ff       	call   801001a6 <bread>
80101c61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c67:	83 c0 18             	add    $0x18,%eax
80101c6a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c77:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c7a:	01 d0                	add    %edx,%eax
80101c7c:	8b 00                	mov    (%eax),%eax
80101c7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c85:	75 30                	jne    80101cb7 <bmap+0xeb>
      a[bn] = addr = balloc(ip->dev);
80101c87:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c8a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c91:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c94:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101c97:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9a:	8b 00                	mov    (%eax),%eax
80101c9c:	89 04 24             	mov    %eax,(%esp)
80101c9f:	e8 2f f7 ff ff       	call   801013d3 <balloc>
80101ca4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101caa:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101cac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101caf:	89 04 24             	mov    %eax,(%esp)
80101cb2:	e8 a5 1a 00 00       	call   8010375c <log_write>
    }
    brelse(bp);
80101cb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cba:	89 04 24             	mov    %eax,(%esp)
80101cbd:	e8 55 e5 ff ff       	call   80100217 <brelse>
    return addr;
80101cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cc5:	eb 0c                	jmp    80101cd3 <bmap+0x107>
  }

  panic("bmap: out of range");
80101cc7:	c7 04 24 28 87 10 80 	movl   $0x80108728,(%esp)
80101cce:	e8 73 e8 ff ff       	call   80100546 <panic>
}
80101cd3:	83 c4 24             	add    $0x24,%esp
80101cd6:	5b                   	pop    %ebx
80101cd7:	5d                   	pop    %ebp
80101cd8:	c3                   	ret    

80101cd9 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101cd9:	55                   	push   %ebp
80101cda:	89 e5                	mov    %esp,%ebp
80101cdc:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cdf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101ce6:	eb 44                	jmp    80101d2c <itrunc+0x53>
    if(ip->addrs[i]){
80101ce8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ceb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cee:	83 c2 04             	add    $0x4,%edx
80101cf1:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101cf5:	85 c0                	test   %eax,%eax
80101cf7:	74 2f                	je     80101d28 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101cf9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cff:	83 c2 04             	add    $0x4,%edx
80101d02:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101d06:	8b 45 08             	mov    0x8(%ebp),%eax
80101d09:	8b 00                	mov    (%eax),%eax
80101d0b:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d0f:	89 04 24             	mov    %eax,(%esp)
80101d12:	e8 08 f8 ff ff       	call   8010151f <bfree>
      ip->addrs[i] = 0;
80101d17:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d1d:	83 c2 04             	add    $0x4,%edx
80101d20:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d27:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d2c:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d30:	7e b6                	jle    80101ce8 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101d32:	8b 45 08             	mov    0x8(%ebp),%eax
80101d35:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d38:	85 c0                	test   %eax,%eax
80101d3a:	0f 84 9b 00 00 00    	je     80101ddb <itrunc+0x102>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d40:	8b 45 08             	mov    0x8(%ebp),%eax
80101d43:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d46:	8b 45 08             	mov    0x8(%ebp),%eax
80101d49:	8b 00                	mov    (%eax),%eax
80101d4b:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d4f:	89 04 24             	mov    %eax,(%esp)
80101d52:	e8 4f e4 ff ff       	call   801001a6 <bread>
80101d57:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d5d:	83 c0 18             	add    $0x18,%eax
80101d60:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d63:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d6a:	eb 3b                	jmp    80101da7 <itrunc+0xce>
      if(a[j])
80101d6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d6f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d76:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d79:	01 d0                	add    %edx,%eax
80101d7b:	8b 00                	mov    (%eax),%eax
80101d7d:	85 c0                	test   %eax,%eax
80101d7f:	74 22                	je     80101da3 <itrunc+0xca>
        bfree(ip->dev, a[j]);
80101d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d84:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d8e:	01 d0                	add    %edx,%eax
80101d90:	8b 10                	mov    (%eax),%edx
80101d92:	8b 45 08             	mov    0x8(%ebp),%eax
80101d95:	8b 00                	mov    (%eax),%eax
80101d97:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d9b:	89 04 24             	mov    %eax,(%esp)
80101d9e:	e8 7c f7 ff ff       	call   8010151f <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101da3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101daa:	83 f8 7f             	cmp    $0x7f,%eax
80101dad:	76 bd                	jbe    80101d6c <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101daf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101db2:	89 04 24             	mov    %eax,(%esp)
80101db5:	e8 5d e4 ff ff       	call   80100217 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101dba:	8b 45 08             	mov    0x8(%ebp),%eax
80101dbd:	8b 50 4c             	mov    0x4c(%eax),%edx
80101dc0:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc3:	8b 00                	mov    (%eax),%eax
80101dc5:	89 54 24 04          	mov    %edx,0x4(%esp)
80101dc9:	89 04 24             	mov    %eax,(%esp)
80101dcc:	e8 4e f7 ff ff       	call   8010151f <bfree>
    ip->addrs[NDIRECT] = 0;
80101dd1:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd4:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101ddb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dde:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101de5:	8b 45 08             	mov    0x8(%ebp),%eax
80101de8:	89 04 24             	mov    %eax,(%esp)
80101deb:	e8 72 f9 ff ff       	call   80101762 <iupdate>
}
80101df0:	c9                   	leave  
80101df1:	c3                   	ret    

80101df2 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101df2:	55                   	push   %ebp
80101df3:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101df5:	8b 45 08             	mov    0x8(%ebp),%eax
80101df8:	8b 00                	mov    (%eax),%eax
80101dfa:	89 c2                	mov    %eax,%edx
80101dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dff:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e02:	8b 45 08             	mov    0x8(%ebp),%eax
80101e05:	8b 50 04             	mov    0x4(%eax),%edx
80101e08:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e0b:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e0e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e11:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e15:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e18:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1e:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e22:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e25:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101e29:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2c:	8b 50 18             	mov    0x18(%eax),%edx
80101e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e32:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e35:	5d                   	pop    %ebp
80101e36:	c3                   	ret    

80101e37 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e37:	55                   	push   %ebp
80101e38:	89 e5                	mov    %esp,%ebp
80101e3a:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e40:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e44:	66 83 f8 03          	cmp    $0x3,%ax
80101e48:	75 60                	jne    80101eaa <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e51:	66 85 c0             	test   %ax,%ax
80101e54:	78 20                	js     80101e76 <readi+0x3f>
80101e56:	8b 45 08             	mov    0x8(%ebp),%eax
80101e59:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e5d:	66 83 f8 09          	cmp    $0x9,%ax
80101e61:	7f 13                	jg     80101e76 <readi+0x3f>
80101e63:	8b 45 08             	mov    0x8(%ebp),%eax
80101e66:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e6a:	98                   	cwtl   
80101e6b:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101e72:	85 c0                	test   %eax,%eax
80101e74:	75 0a                	jne    80101e80 <readi+0x49>
      return -1;
80101e76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e7b:	e9 1b 01 00 00       	jmp    80101f9b <readi+0x164>
    return devsw[ip->major].read(ip, dst, n);
80101e80:	8b 45 08             	mov    0x8(%ebp),%eax
80101e83:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e87:	98                   	cwtl   
80101e88:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101e8f:	8b 55 14             	mov    0x14(%ebp),%edx
80101e92:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e96:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e99:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e9d:	8b 55 08             	mov    0x8(%ebp),%edx
80101ea0:	89 14 24             	mov    %edx,(%esp)
80101ea3:	ff d0                	call   *%eax
80101ea5:	e9 f1 00 00 00       	jmp    80101f9b <readi+0x164>
  }

  if(off > ip->size || off + n < off)
80101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
80101ead:	8b 40 18             	mov    0x18(%eax),%eax
80101eb0:	3b 45 10             	cmp    0x10(%ebp),%eax
80101eb3:	72 0d                	jb     80101ec2 <readi+0x8b>
80101eb5:	8b 45 14             	mov    0x14(%ebp),%eax
80101eb8:	8b 55 10             	mov    0x10(%ebp),%edx
80101ebb:	01 d0                	add    %edx,%eax
80101ebd:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ec0:	73 0a                	jae    80101ecc <readi+0x95>
    return -1;
80101ec2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ec7:	e9 cf 00 00 00       	jmp    80101f9b <readi+0x164>
  if(off + n > ip->size)
80101ecc:	8b 45 14             	mov    0x14(%ebp),%eax
80101ecf:	8b 55 10             	mov    0x10(%ebp),%edx
80101ed2:	01 c2                	add    %eax,%edx
80101ed4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed7:	8b 40 18             	mov    0x18(%eax),%eax
80101eda:	39 c2                	cmp    %eax,%edx
80101edc:	76 0c                	jbe    80101eea <readi+0xb3>
    n = ip->size - off;
80101ede:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee1:	8b 40 18             	mov    0x18(%eax),%eax
80101ee4:	2b 45 10             	sub    0x10(%ebp),%eax
80101ee7:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101ef1:	e9 96 00 00 00       	jmp    80101f8c <readi+0x155>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ef6:	8b 45 10             	mov    0x10(%ebp),%eax
80101ef9:	c1 e8 09             	shr    $0x9,%eax
80101efc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f00:	8b 45 08             	mov    0x8(%ebp),%eax
80101f03:	89 04 24             	mov    %eax,(%esp)
80101f06:	e8 c1 fc ff ff       	call   80101bcc <bmap>
80101f0b:	8b 55 08             	mov    0x8(%ebp),%edx
80101f0e:	8b 12                	mov    (%edx),%edx
80101f10:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f14:	89 14 24             	mov    %edx,(%esp)
80101f17:	e8 8a e2 ff ff       	call   801001a6 <bread>
80101f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f1f:	8b 45 10             	mov    0x10(%ebp),%eax
80101f22:	89 c2                	mov    %eax,%edx
80101f24:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101f2a:	b8 00 02 00 00       	mov    $0x200,%eax
80101f2f:	89 c1                	mov    %eax,%ecx
80101f31:	29 d1                	sub    %edx,%ecx
80101f33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f36:	8b 55 14             	mov    0x14(%ebp),%edx
80101f39:	29 c2                	sub    %eax,%edx
80101f3b:	89 c8                	mov    %ecx,%eax
80101f3d:	39 d0                	cmp    %edx,%eax
80101f3f:	76 02                	jbe    80101f43 <readi+0x10c>
80101f41:	89 d0                	mov    %edx,%eax
80101f43:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f46:	8b 45 10             	mov    0x10(%ebp),%eax
80101f49:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f4e:	8d 50 10             	lea    0x10(%eax),%edx
80101f51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f54:	01 d0                	add    %edx,%eax
80101f56:	8d 50 08             	lea    0x8(%eax),%edx
80101f59:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f5c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f60:	89 54 24 04          	mov    %edx,0x4(%esp)
80101f64:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f67:	89 04 24             	mov    %eax,(%esp)
80101f6a:	e8 6a 33 00 00       	call   801052d9 <memmove>
    brelse(bp);
80101f6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f72:	89 04 24             	mov    %eax,(%esp)
80101f75:	e8 9d e2 ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f7d:	01 45 f4             	add    %eax,-0xc(%ebp)
80101f80:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f83:	01 45 10             	add    %eax,0x10(%ebp)
80101f86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f89:	01 45 0c             	add    %eax,0xc(%ebp)
80101f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f8f:	3b 45 14             	cmp    0x14(%ebp),%eax
80101f92:	0f 82 5e ff ff ff    	jb     80101ef6 <readi+0xbf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101f98:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101f9b:	c9                   	leave  
80101f9c:	c3                   	ret    

80101f9d <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f9d:	55                   	push   %ebp
80101f9e:	89 e5                	mov    %esp,%ebp
80101fa0:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa6:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101faa:	66 83 f8 03          	cmp    $0x3,%ax
80101fae:	75 60                	jne    80102010 <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101fb0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb3:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fb7:	66 85 c0             	test   %ax,%ax
80101fba:	78 20                	js     80101fdc <writei+0x3f>
80101fbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbf:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fc3:	66 83 f8 09          	cmp    $0x9,%ax
80101fc7:	7f 13                	jg     80101fdc <writei+0x3f>
80101fc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcc:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fd0:	98                   	cwtl   
80101fd1:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80101fd8:	85 c0                	test   %eax,%eax
80101fda:	75 0a                	jne    80101fe6 <writei+0x49>
      return -1;
80101fdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fe1:	e9 46 01 00 00       	jmp    8010212c <writei+0x18f>
    return devsw[ip->major].write(ip, src, n);
80101fe6:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe9:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fed:	98                   	cwtl   
80101fee:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80101ff5:	8b 55 14             	mov    0x14(%ebp),%edx
80101ff8:	89 54 24 08          	mov    %edx,0x8(%esp)
80101ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
80101fff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102003:	8b 55 08             	mov    0x8(%ebp),%edx
80102006:	89 14 24             	mov    %edx,(%esp)
80102009:	ff d0                	call   *%eax
8010200b:	e9 1c 01 00 00       	jmp    8010212c <writei+0x18f>
  }

  if(off > ip->size || off + n < off)
80102010:	8b 45 08             	mov    0x8(%ebp),%eax
80102013:	8b 40 18             	mov    0x18(%eax),%eax
80102016:	3b 45 10             	cmp    0x10(%ebp),%eax
80102019:	72 0d                	jb     80102028 <writei+0x8b>
8010201b:	8b 45 14             	mov    0x14(%ebp),%eax
8010201e:	8b 55 10             	mov    0x10(%ebp),%edx
80102021:	01 d0                	add    %edx,%eax
80102023:	3b 45 10             	cmp    0x10(%ebp),%eax
80102026:	73 0a                	jae    80102032 <writei+0x95>
    return -1;
80102028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010202d:	e9 fa 00 00 00       	jmp    8010212c <writei+0x18f>
  if(off + n > MAXFILE*BSIZE)
80102032:	8b 45 14             	mov    0x14(%ebp),%eax
80102035:	8b 55 10             	mov    0x10(%ebp),%edx
80102038:	01 d0                	add    %edx,%eax
8010203a:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010203f:	76 0a                	jbe    8010204b <writei+0xae>
    return -1;
80102041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102046:	e9 e1 00 00 00       	jmp    8010212c <writei+0x18f>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010204b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102052:	e9 a1 00 00 00       	jmp    801020f8 <writei+0x15b>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102057:	8b 45 10             	mov    0x10(%ebp),%eax
8010205a:	c1 e8 09             	shr    $0x9,%eax
8010205d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102061:	8b 45 08             	mov    0x8(%ebp),%eax
80102064:	89 04 24             	mov    %eax,(%esp)
80102067:	e8 60 fb ff ff       	call   80101bcc <bmap>
8010206c:	8b 55 08             	mov    0x8(%ebp),%edx
8010206f:	8b 12                	mov    (%edx),%edx
80102071:	89 44 24 04          	mov    %eax,0x4(%esp)
80102075:	89 14 24             	mov    %edx,(%esp)
80102078:	e8 29 e1 ff ff       	call   801001a6 <bread>
8010207d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102080:	8b 45 10             	mov    0x10(%ebp),%eax
80102083:	89 c2                	mov    %eax,%edx
80102085:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010208b:	b8 00 02 00 00       	mov    $0x200,%eax
80102090:	89 c1                	mov    %eax,%ecx
80102092:	29 d1                	sub    %edx,%ecx
80102094:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102097:	8b 55 14             	mov    0x14(%ebp),%edx
8010209a:	29 c2                	sub    %eax,%edx
8010209c:	89 c8                	mov    %ecx,%eax
8010209e:	39 d0                	cmp    %edx,%eax
801020a0:	76 02                	jbe    801020a4 <writei+0x107>
801020a2:	89 d0                	mov    %edx,%eax
801020a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020a7:	8b 45 10             	mov    0x10(%ebp),%eax
801020aa:	25 ff 01 00 00       	and    $0x1ff,%eax
801020af:	8d 50 10             	lea    0x10(%eax),%edx
801020b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020b5:	01 d0                	add    %edx,%eax
801020b7:	8d 50 08             	lea    0x8(%eax),%edx
801020ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020bd:	89 44 24 08          	mov    %eax,0x8(%esp)
801020c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801020c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801020c8:	89 14 24             	mov    %edx,(%esp)
801020cb:	e8 09 32 00 00       	call   801052d9 <memmove>
    log_write(bp);
801020d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020d3:	89 04 24             	mov    %eax,(%esp)
801020d6:	e8 81 16 00 00       	call   8010375c <log_write>
    brelse(bp);
801020db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020de:	89 04 24             	mov    %eax,(%esp)
801020e1:	e8 31 e1 ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020e9:	01 45 f4             	add    %eax,-0xc(%ebp)
801020ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020ef:	01 45 10             	add    %eax,0x10(%ebp)
801020f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020f5:	01 45 0c             	add    %eax,0xc(%ebp)
801020f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020fb:	3b 45 14             	cmp    0x14(%ebp),%eax
801020fe:	0f 82 53 ff ff ff    	jb     80102057 <writei+0xba>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102104:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102108:	74 1f                	je     80102129 <writei+0x18c>
8010210a:	8b 45 08             	mov    0x8(%ebp),%eax
8010210d:	8b 40 18             	mov    0x18(%eax),%eax
80102110:	3b 45 10             	cmp    0x10(%ebp),%eax
80102113:	73 14                	jae    80102129 <writei+0x18c>
    ip->size = off;
80102115:	8b 45 08             	mov    0x8(%ebp),%eax
80102118:	8b 55 10             	mov    0x10(%ebp),%edx
8010211b:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
8010211e:	8b 45 08             	mov    0x8(%ebp),%eax
80102121:	89 04 24             	mov    %eax,(%esp)
80102124:	e8 39 f6 ff ff       	call   80101762 <iupdate>
  }
  return n;
80102129:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010212c:	c9                   	leave  
8010212d:	c3                   	ret    

8010212e <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010212e:	55                   	push   %ebp
8010212f:	89 e5                	mov    %esp,%ebp
80102131:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80102134:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010213b:	00 
8010213c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010213f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102143:	8b 45 08             	mov    0x8(%ebp),%eax
80102146:	89 04 24             	mov    %eax,(%esp)
80102149:	e8 2f 32 00 00       	call   8010537d <strncmp>
}
8010214e:	c9                   	leave  
8010214f:	c3                   	ret    

80102150 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102156:	8b 45 08             	mov    0x8(%ebp),%eax
80102159:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010215d:	66 83 f8 01          	cmp    $0x1,%ax
80102161:	74 0c                	je     8010216f <dirlookup+0x1f>
    panic("dirlookup not DIR");
80102163:	c7 04 24 3b 87 10 80 	movl   $0x8010873b,(%esp)
8010216a:	e8 d7 e3 ff ff       	call   80100546 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
8010216f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102176:	e9 87 00 00 00       	jmp    80102202 <dirlookup+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010217b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102182:	00 
80102183:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102186:	89 44 24 08          	mov    %eax,0x8(%esp)
8010218a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010218d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102191:	8b 45 08             	mov    0x8(%ebp),%eax
80102194:	89 04 24             	mov    %eax,(%esp)
80102197:	e8 9b fc ff ff       	call   80101e37 <readi>
8010219c:	83 f8 10             	cmp    $0x10,%eax
8010219f:	74 0c                	je     801021ad <dirlookup+0x5d>
      panic("dirlink read");
801021a1:	c7 04 24 4d 87 10 80 	movl   $0x8010874d,(%esp)
801021a8:	e8 99 e3 ff ff       	call   80100546 <panic>
    if(de.inum == 0)
801021ad:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021b1:	66 85 c0             	test   %ax,%ax
801021b4:	74 47                	je     801021fd <dirlookup+0xad>
      continue;
    if(namecmp(name, de.name) == 0){
801021b6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021b9:	83 c0 02             	add    $0x2,%eax
801021bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801021c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801021c3:	89 04 24             	mov    %eax,(%esp)
801021c6:	e8 63 ff ff ff       	call   8010212e <namecmp>
801021cb:	85 c0                	test   %eax,%eax
801021cd:	75 2f                	jne    801021fe <dirlookup+0xae>
      // entry matches path element
      if(poff)
801021cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021d3:	74 08                	je     801021dd <dirlookup+0x8d>
        *poff = off;
801021d5:	8b 45 10             	mov    0x10(%ebp),%eax
801021d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021db:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021dd:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021e1:	0f b7 c0             	movzwl %ax,%eax
801021e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021e7:	8b 45 08             	mov    0x8(%ebp),%eax
801021ea:	8b 00                	mov    (%eax),%eax
801021ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
801021ef:	89 54 24 04          	mov    %edx,0x4(%esp)
801021f3:	89 04 24             	mov    %eax,(%esp)
801021f6:	e8 25 f6 ff ff       	call   80101820 <iget>
801021fb:	eb 19                	jmp    80102216 <dirlookup+0xc6>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
801021fd:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021fe:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102202:	8b 45 08             	mov    0x8(%ebp),%eax
80102205:	8b 40 18             	mov    0x18(%eax),%eax
80102208:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010220b:	0f 87 6a ff ff ff    	ja     8010217b <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102211:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102216:	c9                   	leave  
80102217:	c3                   	ret    

80102218 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102218:	55                   	push   %ebp
80102219:	89 e5                	mov    %esp,%ebp
8010221b:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010221e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102225:	00 
80102226:	8b 45 0c             	mov    0xc(%ebp),%eax
80102229:	89 44 24 04          	mov    %eax,0x4(%esp)
8010222d:	8b 45 08             	mov    0x8(%ebp),%eax
80102230:	89 04 24             	mov    %eax,(%esp)
80102233:	e8 18 ff ff ff       	call   80102150 <dirlookup>
80102238:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010223b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010223f:	74 15                	je     80102256 <dirlink+0x3e>
    iput(ip);
80102241:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102244:	89 04 24             	mov    %eax,(%esp)
80102247:	e8 91 f8 ff ff       	call   80101add <iput>
    return -1;
8010224c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102251:	e9 b8 00 00 00       	jmp    8010230e <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102256:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010225d:	eb 44                	jmp    801022a3 <dirlink+0x8b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010225f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102262:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102269:	00 
8010226a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010226e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102271:	89 44 24 04          	mov    %eax,0x4(%esp)
80102275:	8b 45 08             	mov    0x8(%ebp),%eax
80102278:	89 04 24             	mov    %eax,(%esp)
8010227b:	e8 b7 fb ff ff       	call   80101e37 <readi>
80102280:	83 f8 10             	cmp    $0x10,%eax
80102283:	74 0c                	je     80102291 <dirlink+0x79>
      panic("dirlink read");
80102285:	c7 04 24 4d 87 10 80 	movl   $0x8010874d,(%esp)
8010228c:	e8 b5 e2 ff ff       	call   80100546 <panic>
    if(de.inum == 0)
80102291:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102295:	66 85 c0             	test   %ax,%ax
80102298:	74 18                	je     801022b2 <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010229a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010229d:	83 c0 10             	add    $0x10,%eax
801022a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801022a6:	8b 45 08             	mov    0x8(%ebp),%eax
801022a9:	8b 40 18             	mov    0x18(%eax),%eax
801022ac:	39 c2                	cmp    %eax,%edx
801022ae:	72 af                	jb     8010225f <dirlink+0x47>
801022b0:	eb 01                	jmp    801022b3 <dirlink+0x9b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801022b2:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801022b3:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801022ba:	00 
801022bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801022be:	89 44 24 04          	mov    %eax,0x4(%esp)
801022c2:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022c5:	83 c0 02             	add    $0x2,%eax
801022c8:	89 04 24             	mov    %eax,(%esp)
801022cb:	e8 05 31 00 00       	call   801053d5 <strncpy>
  de.inum = inum;
801022d0:	8b 45 10             	mov    0x10(%ebp),%eax
801022d3:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022da:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801022e1:	00 
801022e2:	89 44 24 08          	mov    %eax,0x8(%esp)
801022e6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801022ed:	8b 45 08             	mov    0x8(%ebp),%eax
801022f0:	89 04 24             	mov    %eax,(%esp)
801022f3:	e8 a5 fc ff ff       	call   80101f9d <writei>
801022f8:	83 f8 10             	cmp    $0x10,%eax
801022fb:	74 0c                	je     80102309 <dirlink+0xf1>
    panic("dirlink");
801022fd:	c7 04 24 5a 87 10 80 	movl   $0x8010875a,(%esp)
80102304:	e8 3d e2 ff ff       	call   80100546 <panic>
  
  return 0;
80102309:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010230e:	c9                   	leave  
8010230f:	c3                   	ret    

80102310 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
80102316:	eb 04                	jmp    8010231c <skipelem+0xc>
    path++;
80102318:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010231c:	8b 45 08             	mov    0x8(%ebp),%eax
8010231f:	0f b6 00             	movzbl (%eax),%eax
80102322:	3c 2f                	cmp    $0x2f,%al
80102324:	74 f2                	je     80102318 <skipelem+0x8>
    path++;
  if(*path == 0)
80102326:	8b 45 08             	mov    0x8(%ebp),%eax
80102329:	0f b6 00             	movzbl (%eax),%eax
8010232c:	84 c0                	test   %al,%al
8010232e:	75 0a                	jne    8010233a <skipelem+0x2a>
    return 0;
80102330:	b8 00 00 00 00       	mov    $0x0,%eax
80102335:	e9 88 00 00 00       	jmp    801023c2 <skipelem+0xb2>
  s = path;
8010233a:	8b 45 08             	mov    0x8(%ebp),%eax
8010233d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102340:	eb 04                	jmp    80102346 <skipelem+0x36>
    path++;
80102342:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102346:	8b 45 08             	mov    0x8(%ebp),%eax
80102349:	0f b6 00             	movzbl (%eax),%eax
8010234c:	3c 2f                	cmp    $0x2f,%al
8010234e:	74 0a                	je     8010235a <skipelem+0x4a>
80102350:	8b 45 08             	mov    0x8(%ebp),%eax
80102353:	0f b6 00             	movzbl (%eax),%eax
80102356:	84 c0                	test   %al,%al
80102358:	75 e8                	jne    80102342 <skipelem+0x32>
    path++;
  len = path - s;
8010235a:	8b 55 08             	mov    0x8(%ebp),%edx
8010235d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102360:	89 d1                	mov    %edx,%ecx
80102362:	29 c1                	sub    %eax,%ecx
80102364:	89 c8                	mov    %ecx,%eax
80102366:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102369:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010236d:	7e 1c                	jle    8010238b <skipelem+0x7b>
    memmove(name, s, DIRSIZ);
8010236f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102376:	00 
80102377:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010237a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010237e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102381:	89 04 24             	mov    %eax,(%esp)
80102384:	e8 50 2f 00 00       	call   801052d9 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102389:	eb 2a                	jmp    801023b5 <skipelem+0xa5>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
8010238b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010238e:	89 44 24 08          	mov    %eax,0x8(%esp)
80102392:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102395:	89 44 24 04          	mov    %eax,0x4(%esp)
80102399:	8b 45 0c             	mov    0xc(%ebp),%eax
8010239c:	89 04 24             	mov    %eax,(%esp)
8010239f:	e8 35 2f 00 00       	call   801052d9 <memmove>
    name[len] = 0;
801023a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801023a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801023aa:	01 d0                	add    %edx,%eax
801023ac:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801023af:	eb 04                	jmp    801023b5 <skipelem+0xa5>
    path++;
801023b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
801023b8:	0f b6 00             	movzbl (%eax),%eax
801023bb:	3c 2f                	cmp    $0x2f,%al
801023bd:	74 f2                	je     801023b1 <skipelem+0xa1>
    path++;
  return path;
801023bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
801023c2:	c9                   	leave  
801023c3:	c3                   	ret    

801023c4 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801023c4:	55                   	push   %ebp
801023c5:	89 e5                	mov    %esp,%ebp
801023c7:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
801023ca:	8b 45 08             	mov    0x8(%ebp),%eax
801023cd:	0f b6 00             	movzbl (%eax),%eax
801023d0:	3c 2f                	cmp    $0x2f,%al
801023d2:	75 1c                	jne    801023f0 <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
801023d4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801023db:	00 
801023dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801023e3:	e8 38 f4 ff ff       	call   80101820 <iget>
801023e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801023eb:	e9 af 00 00 00       	jmp    8010249f <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
801023f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801023f6:	8b 40 68             	mov    0x68(%eax),%eax
801023f9:	89 04 24             	mov    %eax,(%esp)
801023fc:	e8 f1 f4 ff ff       	call   801018f2 <idup>
80102401:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102404:	e9 96 00 00 00       	jmp    8010249f <namex+0xdb>
    ilock(ip);
80102409:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010240c:	89 04 24             	mov    %eax,(%esp)
8010240f:	e8 10 f5 ff ff       	call   80101924 <ilock>
    if(ip->type != T_DIR){
80102414:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102417:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010241b:	66 83 f8 01          	cmp    $0x1,%ax
8010241f:	74 15                	je     80102436 <namex+0x72>
      iunlockput(ip);
80102421:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102424:	89 04 24             	mov    %eax,(%esp)
80102427:	e8 82 f7 ff ff       	call   80101bae <iunlockput>
      return 0;
8010242c:	b8 00 00 00 00       	mov    $0x0,%eax
80102431:	e9 a3 00 00 00       	jmp    801024d9 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
80102436:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010243a:	74 1d                	je     80102459 <namex+0x95>
8010243c:	8b 45 08             	mov    0x8(%ebp),%eax
8010243f:	0f b6 00             	movzbl (%eax),%eax
80102442:	84 c0                	test   %al,%al
80102444:	75 13                	jne    80102459 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
80102446:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102449:	89 04 24             	mov    %eax,(%esp)
8010244c:	e8 27 f6 ff ff       	call   80101a78 <iunlock>
      return ip;
80102451:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102454:	e9 80 00 00 00       	jmp    801024d9 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102459:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102460:	00 
80102461:	8b 45 10             	mov    0x10(%ebp),%eax
80102464:	89 44 24 04          	mov    %eax,0x4(%esp)
80102468:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010246b:	89 04 24             	mov    %eax,(%esp)
8010246e:	e8 dd fc ff ff       	call   80102150 <dirlookup>
80102473:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102476:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010247a:	75 12                	jne    8010248e <namex+0xca>
      iunlockput(ip);
8010247c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010247f:	89 04 24             	mov    %eax,(%esp)
80102482:	e8 27 f7 ff ff       	call   80101bae <iunlockput>
      return 0;
80102487:	b8 00 00 00 00       	mov    $0x0,%eax
8010248c:	eb 4b                	jmp    801024d9 <namex+0x115>
    }
    iunlockput(ip);
8010248e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102491:	89 04 24             	mov    %eax,(%esp)
80102494:	e8 15 f7 ff ff       	call   80101bae <iunlockput>
    ip = next;
80102499:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010249c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010249f:	8b 45 10             	mov    0x10(%ebp),%eax
801024a2:	89 44 24 04          	mov    %eax,0x4(%esp)
801024a6:	8b 45 08             	mov    0x8(%ebp),%eax
801024a9:	89 04 24             	mov    %eax,(%esp)
801024ac:	e8 5f fe ff ff       	call   80102310 <skipelem>
801024b1:	89 45 08             	mov    %eax,0x8(%ebp)
801024b4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801024b8:	0f 85 4b ff ff ff    	jne    80102409 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801024be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024c2:	74 12                	je     801024d6 <namex+0x112>
    iput(ip);
801024c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024c7:	89 04 24             	mov    %eax,(%esp)
801024ca:	e8 0e f6 ff ff       	call   80101add <iput>
    return 0;
801024cf:	b8 00 00 00 00       	mov    $0x0,%eax
801024d4:	eb 03                	jmp    801024d9 <namex+0x115>
  }
  return ip;
801024d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801024d9:	c9                   	leave  
801024da:	c3                   	ret    

801024db <namei>:

struct inode*
namei(char *path)
{
801024db:	55                   	push   %ebp
801024dc:	89 e5                	mov    %esp,%ebp
801024de:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024e1:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024e4:	89 44 24 08          	mov    %eax,0x8(%esp)
801024e8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801024ef:	00 
801024f0:	8b 45 08             	mov    0x8(%ebp),%eax
801024f3:	89 04 24             	mov    %eax,(%esp)
801024f6:	e8 c9 fe ff ff       	call   801023c4 <namex>
}
801024fb:	c9                   	leave  
801024fc:	c3                   	ret    

801024fd <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024fd:	55                   	push   %ebp
801024fe:	89 e5                	mov    %esp,%ebp
80102500:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
80102503:	8b 45 0c             	mov    0xc(%ebp),%eax
80102506:	89 44 24 08          	mov    %eax,0x8(%esp)
8010250a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102511:	00 
80102512:	8b 45 08             	mov    0x8(%ebp),%eax
80102515:	89 04 24             	mov    %eax,(%esp)
80102518:	e8 a7 fe ff ff       	call   801023c4 <namex>
}
8010251d:	c9                   	leave  
8010251e:	c3                   	ret    
	...

80102520 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	53                   	push   %ebx
80102524:	83 ec 14             	sub    $0x14,%esp
80102527:	8b 45 08             	mov    0x8(%ebp),%eax
8010252a:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010252e:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80102532:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80102536:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
8010253a:	ec                   	in     (%dx),%al
8010253b:	89 c3                	mov    %eax,%ebx
8010253d:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80102540:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80102544:	83 c4 14             	add    $0x14,%esp
80102547:	5b                   	pop    %ebx
80102548:	5d                   	pop    %ebp
80102549:	c3                   	ret    

8010254a <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
8010254a:	55                   	push   %ebp
8010254b:	89 e5                	mov    %esp,%ebp
8010254d:	57                   	push   %edi
8010254e:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010254f:	8b 55 08             	mov    0x8(%ebp),%edx
80102552:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102555:	8b 45 10             	mov    0x10(%ebp),%eax
80102558:	89 cb                	mov    %ecx,%ebx
8010255a:	89 df                	mov    %ebx,%edi
8010255c:	89 c1                	mov    %eax,%ecx
8010255e:	fc                   	cld    
8010255f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102561:	89 c8                	mov    %ecx,%eax
80102563:	89 fb                	mov    %edi,%ebx
80102565:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102568:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010256b:	5b                   	pop    %ebx
8010256c:	5f                   	pop    %edi
8010256d:	5d                   	pop    %ebp
8010256e:	c3                   	ret    

8010256f <outb>:

static inline void
outb(ushort port, uchar data)
{
8010256f:	55                   	push   %ebp
80102570:	89 e5                	mov    %esp,%ebp
80102572:	83 ec 08             	sub    $0x8,%esp
80102575:	8b 55 08             	mov    0x8(%ebp),%edx
80102578:	8b 45 0c             	mov    0xc(%ebp),%eax
8010257b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010257f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102582:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102586:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010258a:	ee                   	out    %al,(%dx)
}
8010258b:	c9                   	leave  
8010258c:	c3                   	ret    

8010258d <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
8010258d:	55                   	push   %ebp
8010258e:	89 e5                	mov    %esp,%ebp
80102590:	56                   	push   %esi
80102591:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102592:	8b 55 08             	mov    0x8(%ebp),%edx
80102595:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102598:	8b 45 10             	mov    0x10(%ebp),%eax
8010259b:	89 cb                	mov    %ecx,%ebx
8010259d:	89 de                	mov    %ebx,%esi
8010259f:	89 c1                	mov    %eax,%ecx
801025a1:	fc                   	cld    
801025a2:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025a4:	89 c8                	mov    %ecx,%eax
801025a6:	89 f3                	mov    %esi,%ebx
801025a8:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025ab:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801025ae:	5b                   	pop    %ebx
801025af:	5e                   	pop    %esi
801025b0:	5d                   	pop    %ebp
801025b1:	c3                   	ret    

801025b2 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801025b2:	55                   	push   %ebp
801025b3:	89 e5                	mov    %esp,%ebp
801025b5:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801025b8:	90                   	nop
801025b9:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801025c0:	e8 5b ff ff ff       	call   80102520 <inb>
801025c5:	0f b6 c0             	movzbl %al,%eax
801025c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801025cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025ce:	25 c0 00 00 00       	and    $0xc0,%eax
801025d3:	83 f8 40             	cmp    $0x40,%eax
801025d6:	75 e1                	jne    801025b9 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801025d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025dc:	74 11                	je     801025ef <idewait+0x3d>
801025de:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025e1:	83 e0 21             	and    $0x21,%eax
801025e4:	85 c0                	test   %eax,%eax
801025e6:	74 07                	je     801025ef <idewait+0x3d>
    return -1;
801025e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025ed:	eb 05                	jmp    801025f4 <idewait+0x42>
  return 0;
801025ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
801025f4:	c9                   	leave  
801025f5:	c3                   	ret    

801025f6 <ideinit>:

void
ideinit(void)
{
801025f6:	55                   	push   %ebp
801025f7:	89 e5                	mov    %esp,%ebp
801025f9:	83 ec 28             	sub    $0x28,%esp
  int i;
  
  initlock(&idelock, "ide");
801025fc:	c7 44 24 04 62 87 10 	movl   $0x80108762,0x4(%esp)
80102603:	80 
80102604:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010260b:	e8 7a 29 00 00       	call   80104f8a <initlock>
  picenable(IRQ_IDE);
80102610:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102617:	e8 f5 18 00 00       	call   80103f11 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010261c:	a1 40 29 11 80       	mov    0x80112940,%eax
80102621:	83 e8 01             	sub    $0x1,%eax
80102624:	89 44 24 04          	mov    %eax,0x4(%esp)
80102628:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010262f:	e8 46 04 00 00       	call   80102a7a <ioapicenable>
  idewait(0);
80102634:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010263b:	e8 72 ff ff ff       	call   801025b2 <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102640:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102647:	00 
80102648:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
8010264f:	e8 1b ff ff ff       	call   8010256f <outb>
  for(i=0; i<1000; i++){
80102654:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010265b:	eb 20                	jmp    8010267d <ideinit+0x87>
    if(inb(0x1f7) != 0){
8010265d:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102664:	e8 b7 fe ff ff       	call   80102520 <inb>
80102669:	84 c0                	test   %al,%al
8010266b:	74 0c                	je     80102679 <ideinit+0x83>
      havedisk1 = 1;
8010266d:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
80102674:	00 00 00 
      break;
80102677:	eb 0d                	jmp    80102686 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102679:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010267d:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102684:	7e d7                	jle    8010265d <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102686:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
8010268d:	00 
8010268e:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102695:	e8 d5 fe ff ff       	call   8010256f <outb>
}
8010269a:	c9                   	leave  
8010269b:	c3                   	ret    

8010269c <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
8010269c:	55                   	push   %ebp
8010269d:	89 e5                	mov    %esp,%ebp
8010269f:	83 ec 28             	sub    $0x28,%esp
  if(b == 0)
801026a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026a6:	75 0c                	jne    801026b4 <idestart+0x18>
    panic("idestart");
801026a8:	c7 04 24 66 87 10 80 	movl   $0x80108766,(%esp)
801026af:	e8 92 de ff ff       	call   80100546 <panic>
  if(b->blockno >= FSSIZE)
801026b4:	8b 45 08             	mov    0x8(%ebp),%eax
801026b7:	8b 40 08             	mov    0x8(%eax),%eax
801026ba:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801026bf:	76 0c                	jbe    801026cd <idestart+0x31>
    panic("incorrect blockno");
801026c1:	c7 04 24 6f 87 10 80 	movl   $0x8010876f,(%esp)
801026c8:	e8 79 de ff ff       	call   80100546 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
801026cd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
801026d4:	8b 45 08             	mov    0x8(%ebp),%eax
801026d7:	8b 50 08             	mov    0x8(%eax),%edx
801026da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026dd:	0f af c2             	imul   %edx,%eax
801026e0:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
801026e3:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
801026e7:	7e 0c                	jle    801026f5 <idestart+0x59>
801026e9:	c7 04 24 66 87 10 80 	movl   $0x80108766,(%esp)
801026f0:	e8 51 de ff ff       	call   80100546 <panic>
  
  idewait(0);
801026f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801026fc:	e8 b1 fe ff ff       	call   801025b2 <idewait>
  outb(0x3f6, 0);  // generate interrupt
80102701:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102708:	00 
80102709:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
80102710:	e8 5a fe ff ff       	call   8010256f <outb>
  outb(0x1f2, sector_per_block);  // number of sectors
80102715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102718:	0f b6 c0             	movzbl %al,%eax
8010271b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010271f:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
80102726:	e8 44 fe ff ff       	call   8010256f <outb>
  outb(0x1f3, sector & 0xff);
8010272b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010272e:	0f b6 c0             	movzbl %al,%eax
80102731:	89 44 24 04          	mov    %eax,0x4(%esp)
80102735:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
8010273c:	e8 2e fe ff ff       	call   8010256f <outb>
  outb(0x1f4, (sector >> 8) & 0xff);
80102741:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102744:	c1 f8 08             	sar    $0x8,%eax
80102747:	0f b6 c0             	movzbl %al,%eax
8010274a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010274e:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102755:	e8 15 fe ff ff       	call   8010256f <outb>
  outb(0x1f5, (sector >> 16) & 0xff);
8010275a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010275d:	c1 f8 10             	sar    $0x10,%eax
80102760:	0f b6 c0             	movzbl %al,%eax
80102763:	89 44 24 04          	mov    %eax,0x4(%esp)
80102767:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
8010276e:	e8 fc fd ff ff       	call   8010256f <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102773:	8b 45 08             	mov    0x8(%ebp),%eax
80102776:	8b 40 04             	mov    0x4(%eax),%eax
80102779:	83 e0 01             	and    $0x1,%eax
8010277c:	89 c2                	mov    %eax,%edx
8010277e:	c1 e2 04             	shl    $0x4,%edx
80102781:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102784:	c1 f8 18             	sar    $0x18,%eax
80102787:	83 e0 0f             	and    $0xf,%eax
8010278a:	09 d0                	or     %edx,%eax
8010278c:	83 c8 e0             	or     $0xffffffe0,%eax
8010278f:	0f b6 c0             	movzbl %al,%eax
80102792:	89 44 24 04          	mov    %eax,0x4(%esp)
80102796:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
8010279d:	e8 cd fd ff ff       	call   8010256f <outb>
  if(b->flags & B_DIRTY){
801027a2:	8b 45 08             	mov    0x8(%ebp),%eax
801027a5:	8b 00                	mov    (%eax),%eax
801027a7:	83 e0 04             	and    $0x4,%eax
801027aa:	85 c0                	test   %eax,%eax
801027ac:	74 34                	je     801027e2 <idestart+0x146>
    outb(0x1f7, IDE_CMD_WRITE);
801027ae:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
801027b5:	00 
801027b6:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801027bd:	e8 ad fd ff ff       	call   8010256f <outb>
    outsl(0x1f0, b->data, BSIZE/4);
801027c2:	8b 45 08             	mov    0x8(%ebp),%eax
801027c5:	83 c0 18             	add    $0x18,%eax
801027c8:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801027cf:	00 
801027d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801027d4:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801027db:	e8 ad fd ff ff       	call   8010258d <outsl>
801027e0:	eb 14                	jmp    801027f6 <idestart+0x15a>
  } else {
    outb(0x1f7, IDE_CMD_READ);
801027e2:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
801027e9:	00 
801027ea:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801027f1:	e8 79 fd ff ff       	call   8010256f <outb>
  }
}
801027f6:	c9                   	leave  
801027f7:	c3                   	ret    

801027f8 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801027f8:	55                   	push   %ebp
801027f9:	89 e5                	mov    %esp,%ebp
801027fb:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801027fe:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102805:	e8 a1 27 00 00       	call   80104fab <acquire>
  if((b = idequeue) == 0){
8010280a:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010280f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102812:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102816:	75 11                	jne    80102829 <ideintr+0x31>
    release(&idelock);
80102818:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010281f:	e8 e9 27 00 00       	call   8010500d <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102824:	e9 90 00 00 00       	jmp    801028b9 <ideintr+0xc1>
  }
  idequeue = b->qnext;
80102829:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010282c:	8b 40 14             	mov    0x14(%eax),%eax
8010282f:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102834:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102837:	8b 00                	mov    (%eax),%eax
80102839:	83 e0 04             	and    $0x4,%eax
8010283c:	85 c0                	test   %eax,%eax
8010283e:	75 2e                	jne    8010286e <ideintr+0x76>
80102840:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102847:	e8 66 fd ff ff       	call   801025b2 <idewait>
8010284c:	85 c0                	test   %eax,%eax
8010284e:	78 1e                	js     8010286e <ideintr+0x76>
    insl(0x1f0, b->data, BSIZE/4);
80102850:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102853:	83 c0 18             	add    $0x18,%eax
80102856:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
8010285d:	00 
8010285e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102862:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102869:	e8 dc fc ff ff       	call   8010254a <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010286e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102871:	8b 00                	mov    (%eax),%eax
80102873:	89 c2                	mov    %eax,%edx
80102875:	83 ca 02             	or     $0x2,%edx
80102878:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010287b:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010287d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102880:	8b 00                	mov    (%eax),%eax
80102882:	89 c2                	mov    %eax,%edx
80102884:	83 e2 fb             	and    $0xfffffffb,%edx
80102887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010288a:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010288c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010288f:	89 04 24             	mov    %eax,(%esp)
80102892:	e8 0f 25 00 00       	call   80104da6 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102897:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010289c:	85 c0                	test   %eax,%eax
8010289e:	74 0d                	je     801028ad <ideintr+0xb5>
    idestart(idequeue);
801028a0:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801028a5:	89 04 24             	mov    %eax,(%esp)
801028a8:	e8 ef fd ff ff       	call   8010269c <idestart>

  release(&idelock);
801028ad:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801028b4:	e8 54 27 00 00       	call   8010500d <release>
}
801028b9:	c9                   	leave  
801028ba:	c3                   	ret    

801028bb <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801028bb:	55                   	push   %ebp
801028bc:	89 e5                	mov    %esp,%ebp
801028be:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801028c1:	8b 45 08             	mov    0x8(%ebp),%eax
801028c4:	8b 00                	mov    (%eax),%eax
801028c6:	83 e0 01             	and    $0x1,%eax
801028c9:	85 c0                	test   %eax,%eax
801028cb:	75 0c                	jne    801028d9 <iderw+0x1e>
    panic("iderw: buf not busy");
801028cd:	c7 04 24 81 87 10 80 	movl   $0x80108781,(%esp)
801028d4:	e8 6d dc ff ff       	call   80100546 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801028d9:	8b 45 08             	mov    0x8(%ebp),%eax
801028dc:	8b 00                	mov    (%eax),%eax
801028de:	83 e0 06             	and    $0x6,%eax
801028e1:	83 f8 02             	cmp    $0x2,%eax
801028e4:	75 0c                	jne    801028f2 <iderw+0x37>
    panic("iderw: nothing to do");
801028e6:	c7 04 24 95 87 10 80 	movl   $0x80108795,(%esp)
801028ed:	e8 54 dc ff ff       	call   80100546 <panic>
  if(b->dev != 0 && !havedisk1)
801028f2:	8b 45 08             	mov    0x8(%ebp),%eax
801028f5:	8b 40 04             	mov    0x4(%eax),%eax
801028f8:	85 c0                	test   %eax,%eax
801028fa:	74 15                	je     80102911 <iderw+0x56>
801028fc:	a1 38 b6 10 80       	mov    0x8010b638,%eax
80102901:	85 c0                	test   %eax,%eax
80102903:	75 0c                	jne    80102911 <iderw+0x56>
    panic("iderw: ide disk 1 not present");
80102905:	c7 04 24 aa 87 10 80 	movl   $0x801087aa,(%esp)
8010290c:	e8 35 dc ff ff       	call   80100546 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102911:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102918:	e8 8e 26 00 00       	call   80104fab <acquire>

  // Append b to idequeue.
  b->qnext = 0;
8010291d:	8b 45 08             	mov    0x8(%ebp),%eax
80102920:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102927:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
8010292e:	eb 0b                	jmp    8010293b <iderw+0x80>
80102930:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102933:	8b 00                	mov    (%eax),%eax
80102935:	83 c0 14             	add    $0x14,%eax
80102938:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010293b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010293e:	8b 00                	mov    (%eax),%eax
80102940:	85 c0                	test   %eax,%eax
80102942:	75 ec                	jne    80102930 <iderw+0x75>
    ;
  *pp = b;
80102944:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102947:	8b 55 08             	mov    0x8(%ebp),%edx
8010294a:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
8010294c:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102951:	3b 45 08             	cmp    0x8(%ebp),%eax
80102954:	75 22                	jne    80102978 <iderw+0xbd>
    idestart(b);
80102956:	8b 45 08             	mov    0x8(%ebp),%eax
80102959:	89 04 24             	mov    %eax,(%esp)
8010295c:	e8 3b fd ff ff       	call   8010269c <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102961:	eb 15                	jmp    80102978 <iderw+0xbd>
    sleep(b, &idelock);
80102963:	c7 44 24 04 00 b6 10 	movl   $0x8010b600,0x4(%esp)
8010296a:	80 
8010296b:	8b 45 08             	mov    0x8(%ebp),%eax
8010296e:	89 04 24             	mov    %eax,(%esp)
80102971:	e8 57 23 00 00       	call   80104ccd <sleep>
80102976:	eb 01                	jmp    80102979 <iderw+0xbe>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102978:	90                   	nop
80102979:	8b 45 08             	mov    0x8(%ebp),%eax
8010297c:	8b 00                	mov    (%eax),%eax
8010297e:	83 e0 06             	and    $0x6,%eax
80102981:	83 f8 02             	cmp    $0x2,%eax
80102984:	75 dd                	jne    80102963 <iderw+0xa8>
    sleep(b, &idelock);
  }

  release(&idelock);
80102986:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010298d:	e8 7b 26 00 00       	call   8010500d <release>
}
80102992:	c9                   	leave  
80102993:	c3                   	ret    

80102994 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102994:	55                   	push   %ebp
80102995:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102997:	a1 14 22 11 80       	mov    0x80112214,%eax
8010299c:	8b 55 08             	mov    0x8(%ebp),%edx
8010299f:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
801029a1:	a1 14 22 11 80       	mov    0x80112214,%eax
801029a6:	8b 40 10             	mov    0x10(%eax),%eax
}
801029a9:	5d                   	pop    %ebp
801029aa:	c3                   	ret    

801029ab <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
801029ab:	55                   	push   %ebp
801029ac:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801029ae:	a1 14 22 11 80       	mov    0x80112214,%eax
801029b3:	8b 55 08             	mov    0x8(%ebp),%edx
801029b6:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
801029b8:	a1 14 22 11 80       	mov    0x80112214,%eax
801029bd:	8b 55 0c             	mov    0xc(%ebp),%edx
801029c0:	89 50 10             	mov    %edx,0x10(%eax)
}
801029c3:	5d                   	pop    %ebp
801029c4:	c3                   	ret    

801029c5 <ioapicinit>:

void
ioapicinit(void)
{
801029c5:	55                   	push   %ebp
801029c6:	89 e5                	mov    %esp,%ebp
801029c8:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
801029cb:	a1 44 23 11 80       	mov    0x80112344,%eax
801029d0:	85 c0                	test   %eax,%eax
801029d2:	0f 84 9f 00 00 00    	je     80102a77 <ioapicinit+0xb2>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801029d8:	c7 05 14 22 11 80 00 	movl   $0xfec00000,0x80112214
801029df:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801029e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801029e9:	e8 a6 ff ff ff       	call   80102994 <ioapicread>
801029ee:	c1 e8 10             	shr    $0x10,%eax
801029f1:	25 ff 00 00 00       	and    $0xff,%eax
801029f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
801029f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102a00:	e8 8f ff ff ff       	call   80102994 <ioapicread>
80102a05:	c1 e8 18             	shr    $0x18,%eax
80102a08:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102a0b:	0f b6 05 40 23 11 80 	movzbl 0x80112340,%eax
80102a12:	0f b6 c0             	movzbl %al,%eax
80102a15:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102a18:	74 0c                	je     80102a26 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102a1a:	c7 04 24 c8 87 10 80 	movl   $0x801087c8,(%esp)
80102a21:	e8 84 d9 ff ff       	call   801003aa <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a2d:	eb 3e                	jmp    80102a6d <ioapicinit+0xa8>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a32:	83 c0 20             	add    $0x20,%eax
80102a35:	0d 00 00 01 00       	or     $0x10000,%eax
80102a3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102a3d:	83 c2 08             	add    $0x8,%edx
80102a40:	01 d2                	add    %edx,%edx
80102a42:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a46:	89 14 24             	mov    %edx,(%esp)
80102a49:	e8 5d ff ff ff       	call   801029ab <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102a4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a51:	83 c0 08             	add    $0x8,%eax
80102a54:	01 c0                	add    %eax,%eax
80102a56:	83 c0 01             	add    $0x1,%eax
80102a59:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102a60:	00 
80102a61:	89 04 24             	mov    %eax,(%esp)
80102a64:	e8 42 ff ff ff       	call   801029ab <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a69:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a70:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a73:	7e ba                	jle    80102a2f <ioapicinit+0x6a>
80102a75:	eb 01                	jmp    80102a78 <ioapicinit+0xb3>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102a77:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a78:	c9                   	leave  
80102a79:	c3                   	ret    

80102a7a <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a7a:	55                   	push   %ebp
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
80102a80:	a1 44 23 11 80       	mov    0x80112344,%eax
80102a85:	85 c0                	test   %eax,%eax
80102a87:	74 39                	je     80102ac2 <ioapicenable+0x48>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a89:	8b 45 08             	mov    0x8(%ebp),%eax
80102a8c:	83 c0 20             	add    $0x20,%eax
80102a8f:	8b 55 08             	mov    0x8(%ebp),%edx
80102a92:	83 c2 08             	add    $0x8,%edx
80102a95:	01 d2                	add    %edx,%edx
80102a97:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a9b:	89 14 24             	mov    %edx,(%esp)
80102a9e:	e8 08 ff ff ff       	call   801029ab <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
80102aa6:	c1 e0 18             	shl    $0x18,%eax
80102aa9:	8b 55 08             	mov    0x8(%ebp),%edx
80102aac:	83 c2 08             	add    $0x8,%edx
80102aaf:	01 d2                	add    %edx,%edx
80102ab1:	83 c2 01             	add    $0x1,%edx
80102ab4:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ab8:	89 14 24             	mov    %edx,(%esp)
80102abb:	e8 eb fe ff ff       	call   801029ab <ioapicwrite>
80102ac0:	eb 01                	jmp    80102ac3 <ioapicenable+0x49>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102ac2:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102ac3:	c9                   	leave  
80102ac4:	c3                   	ret    
80102ac5:	00 00                	add    %al,(%eax)
	...

80102ac8 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102ac8:	55                   	push   %ebp
80102ac9:	89 e5                	mov    %esp,%ebp
80102acb:	8b 45 08             	mov    0x8(%ebp),%eax
80102ace:	05 00 00 00 80       	add    $0x80000000,%eax
80102ad3:	5d                   	pop    %ebp
80102ad4:	c3                   	ret    

80102ad5 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102ad5:	55                   	push   %ebp
80102ad6:	89 e5                	mov    %esp,%ebp
80102ad8:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
80102adb:	c7 44 24 04 fa 87 10 	movl   $0x801087fa,0x4(%esp)
80102ae2:	80 
80102ae3:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102aea:	e8 9b 24 00 00       	call   80104f8a <initlock>
  kmem.use_lock = 0;
80102aef:	c7 05 54 22 11 80 00 	movl   $0x0,0x80112254
80102af6:	00 00 00 
  freerange(vstart, vend);
80102af9:	8b 45 0c             	mov    0xc(%ebp),%eax
80102afc:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b00:	8b 45 08             	mov    0x8(%ebp),%eax
80102b03:	89 04 24             	mov    %eax,(%esp)
80102b06:	e8 26 00 00 00       	call   80102b31 <freerange>
}
80102b0b:	c9                   	leave  
80102b0c:	c3                   	ret    

80102b0d <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102b0d:	55                   	push   %ebp
80102b0e:	89 e5                	mov    %esp,%ebp
80102b10:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102b13:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b16:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b1a:	8b 45 08             	mov    0x8(%ebp),%eax
80102b1d:	89 04 24             	mov    %eax,(%esp)
80102b20:	e8 0c 00 00 00       	call   80102b31 <freerange>
  kmem.use_lock = 1;
80102b25:	c7 05 54 22 11 80 01 	movl   $0x1,0x80112254
80102b2c:	00 00 00 
}
80102b2f:	c9                   	leave  
80102b30:	c3                   	ret    

80102b31 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102b31:	55                   	push   %ebp
80102b32:	89 e5                	mov    %esp,%ebp
80102b34:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102b37:	8b 45 08             	mov    0x8(%ebp),%eax
80102b3a:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b47:	eb 12                	jmp    80102b5b <freerange+0x2a>
    kfree(p);
80102b49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b4c:	89 04 24             	mov    %eax,(%esp)
80102b4f:	e8 16 00 00 00       	call   80102b6a <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b54:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b5e:	05 00 10 00 00       	add    $0x1000,%eax
80102b63:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b66:	76 e1                	jbe    80102b49 <freerange+0x18>
    kfree(p);
}
80102b68:	c9                   	leave  
80102b69:	c3                   	ret    

80102b6a <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b6a:	55                   	push   %ebp
80102b6b:	89 e5                	mov    %esp,%ebp
80102b6d:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102b70:	8b 45 08             	mov    0x8(%ebp),%eax
80102b73:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b78:	85 c0                	test   %eax,%eax
80102b7a:	75 1b                	jne    80102b97 <kfree+0x2d>
80102b7c:	81 7d 08 3c 51 11 80 	cmpl   $0x8011513c,0x8(%ebp)
80102b83:	72 12                	jb     80102b97 <kfree+0x2d>
80102b85:	8b 45 08             	mov    0x8(%ebp),%eax
80102b88:	89 04 24             	mov    %eax,(%esp)
80102b8b:	e8 38 ff ff ff       	call   80102ac8 <v2p>
80102b90:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b95:	76 0c                	jbe    80102ba3 <kfree+0x39>
    panic("kfree");
80102b97:	c7 04 24 ff 87 10 80 	movl   $0x801087ff,(%esp)
80102b9e:	e8 a3 d9 ff ff       	call   80100546 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102ba3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102baa:	00 
80102bab:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102bb2:	00 
80102bb3:	8b 45 08             	mov    0x8(%ebp),%eax
80102bb6:	89 04 24             	mov    %eax,(%esp)
80102bb9:	e8 48 26 00 00       	call   80105206 <memset>

  if(kmem.use_lock)
80102bbe:	a1 54 22 11 80       	mov    0x80112254,%eax
80102bc3:	85 c0                	test   %eax,%eax
80102bc5:	74 0c                	je     80102bd3 <kfree+0x69>
    acquire(&kmem.lock);
80102bc7:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102bce:	e8 d8 23 00 00       	call   80104fab <acquire>
  r = (struct run*)v;
80102bd3:	8b 45 08             	mov    0x8(%ebp),%eax
80102bd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102bd9:	8b 15 58 22 11 80    	mov    0x80112258,%edx
80102bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102be2:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102be7:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102bec:	a1 54 22 11 80       	mov    0x80112254,%eax
80102bf1:	85 c0                	test   %eax,%eax
80102bf3:	74 0c                	je     80102c01 <kfree+0x97>
    release(&kmem.lock);
80102bf5:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102bfc:	e8 0c 24 00 00       	call   8010500d <release>
}
80102c01:	c9                   	leave  
80102c02:	c3                   	ret    

80102c03 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102c03:	55                   	push   %ebp
80102c04:	89 e5                	mov    %esp,%ebp
80102c06:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102c09:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c0e:	85 c0                	test   %eax,%eax
80102c10:	74 0c                	je     80102c1e <kalloc+0x1b>
    acquire(&kmem.lock);
80102c12:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102c19:	e8 8d 23 00 00       	call   80104fab <acquire>
  r = kmem.freelist;
80102c1e:	a1 58 22 11 80       	mov    0x80112258,%eax
80102c23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102c26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c2a:	74 0a                	je     80102c36 <kalloc+0x33>
    kmem.freelist = r->next;
80102c2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c2f:	8b 00                	mov    (%eax),%eax
80102c31:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102c36:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c3b:	85 c0                	test   %eax,%eax
80102c3d:	74 0c                	je     80102c4b <kalloc+0x48>
    release(&kmem.lock);
80102c3f:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102c46:	e8 c2 23 00 00       	call   8010500d <release>
  return (char*)r;
80102c4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102c4e:	c9                   	leave  
80102c4f:	c3                   	ret    

80102c50 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 14             	sub    $0x14,%esp
80102c57:	8b 45 08             	mov    0x8(%ebp),%eax
80102c5a:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5e:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80102c62:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80102c66:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80102c6a:	ec                   	in     (%dx),%al
80102c6b:	89 c3                	mov    %eax,%ebx
80102c6d:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80102c70:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80102c74:	83 c4 14             	add    $0x14,%esp
80102c77:	5b                   	pop    %ebx
80102c78:	5d                   	pop    %ebp
80102c79:	c3                   	ret    

80102c7a <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c7a:	55                   	push   %ebp
80102c7b:	89 e5                	mov    %esp,%ebp
80102c7d:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102c80:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102c87:	e8 c4 ff ff ff       	call   80102c50 <inb>
80102c8c:	0f b6 c0             	movzbl %al,%eax
80102c8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c95:	83 e0 01             	and    $0x1,%eax
80102c98:	85 c0                	test   %eax,%eax
80102c9a:	75 0a                	jne    80102ca6 <kbdgetc+0x2c>
    return -1;
80102c9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ca1:	e9 25 01 00 00       	jmp    80102dcb <kbdgetc+0x151>
  data = inb(KBDATAP);
80102ca6:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
80102cad:	e8 9e ff ff ff       	call   80102c50 <inb>
80102cb2:	0f b6 c0             	movzbl %al,%eax
80102cb5:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102cb8:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102cbf:	75 17                	jne    80102cd8 <kbdgetc+0x5e>
    shift |= E0ESC;
80102cc1:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cc6:	83 c8 40             	or     $0x40,%eax
80102cc9:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102cce:	b8 00 00 00 00       	mov    $0x0,%eax
80102cd3:	e9 f3 00 00 00       	jmp    80102dcb <kbdgetc+0x151>
  } else if(data & 0x80){
80102cd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cdb:	25 80 00 00 00       	and    $0x80,%eax
80102ce0:	85 c0                	test   %eax,%eax
80102ce2:	74 45                	je     80102d29 <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102ce4:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102ce9:	83 e0 40             	and    $0x40,%eax
80102cec:	85 c0                	test   %eax,%eax
80102cee:	75 08                	jne    80102cf8 <kbdgetc+0x7e>
80102cf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cf3:	83 e0 7f             	and    $0x7f,%eax
80102cf6:	eb 03                	jmp    80102cfb <kbdgetc+0x81>
80102cf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cfb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102cfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d01:	05 20 90 10 80       	add    $0x80109020,%eax
80102d06:	0f b6 00             	movzbl (%eax),%eax
80102d09:	83 c8 40             	or     $0x40,%eax
80102d0c:	0f b6 c0             	movzbl %al,%eax
80102d0f:	f7 d0                	not    %eax
80102d11:	89 c2                	mov    %eax,%edx
80102d13:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d18:	21 d0                	and    %edx,%eax
80102d1a:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102d1f:	b8 00 00 00 00       	mov    $0x0,%eax
80102d24:	e9 a2 00 00 00       	jmp    80102dcb <kbdgetc+0x151>
  } else if(shift & E0ESC){
80102d29:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d2e:	83 e0 40             	and    $0x40,%eax
80102d31:	85 c0                	test   %eax,%eax
80102d33:	74 14                	je     80102d49 <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102d35:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102d3c:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d41:	83 e0 bf             	and    $0xffffffbf,%eax
80102d44:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102d49:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d4c:	05 20 90 10 80       	add    $0x80109020,%eax
80102d51:	0f b6 00             	movzbl (%eax),%eax
80102d54:	0f b6 d0             	movzbl %al,%edx
80102d57:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d5c:	09 d0                	or     %edx,%eax
80102d5e:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102d63:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d66:	05 20 91 10 80       	add    $0x80109120,%eax
80102d6b:	0f b6 00             	movzbl (%eax),%eax
80102d6e:	0f b6 d0             	movzbl %al,%edx
80102d71:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d76:	31 d0                	xor    %edx,%eax
80102d78:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102d7d:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d82:	83 e0 03             	and    $0x3,%eax
80102d85:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102d8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d8f:	01 d0                	add    %edx,%eax
80102d91:	0f b6 00             	movzbl (%eax),%eax
80102d94:	0f b6 c0             	movzbl %al,%eax
80102d97:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102d9a:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d9f:	83 e0 08             	and    $0x8,%eax
80102da2:	85 c0                	test   %eax,%eax
80102da4:	74 22                	je     80102dc8 <kbdgetc+0x14e>
    if('a' <= c && c <= 'z')
80102da6:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102daa:	76 0c                	jbe    80102db8 <kbdgetc+0x13e>
80102dac:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102db0:	77 06                	ja     80102db8 <kbdgetc+0x13e>
      c += 'A' - 'a';
80102db2:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102db6:	eb 10                	jmp    80102dc8 <kbdgetc+0x14e>
    else if('A' <= c && c <= 'Z')
80102db8:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102dbc:	76 0a                	jbe    80102dc8 <kbdgetc+0x14e>
80102dbe:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102dc2:	77 04                	ja     80102dc8 <kbdgetc+0x14e>
      c += 'a' - 'A';
80102dc4:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102dc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102dcb:	c9                   	leave  
80102dcc:	c3                   	ret    

80102dcd <kbdintr>:

void
kbdintr(void)
{
80102dcd:	55                   	push   %ebp
80102dce:	89 e5                	mov    %esp,%ebp
80102dd0:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102dd3:	c7 04 24 7a 2c 10 80 	movl   $0x80102c7a,(%esp)
80102dda:	e8 f2 d9 ff ff       	call   801007d1 <consoleintr>
}
80102ddf:	c9                   	leave  
80102de0:	c3                   	ret    
80102de1:	00 00                	add    %al,(%eax)
	...

80102de4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102de4:	55                   	push   %ebp
80102de5:	89 e5                	mov    %esp,%ebp
80102de7:	53                   	push   %ebx
80102de8:	83 ec 14             	sub    $0x14,%esp
80102deb:	8b 45 08             	mov    0x8(%ebp),%eax
80102dee:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102df2:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80102df6:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80102dfa:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80102dfe:	ec                   	in     (%dx),%al
80102dff:	89 c3                	mov    %eax,%ebx
80102e01:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80102e04:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80102e08:	83 c4 14             	add    $0x14,%esp
80102e0b:	5b                   	pop    %ebx
80102e0c:	5d                   	pop    %ebp
80102e0d:	c3                   	ret    

80102e0e <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102e0e:	55                   	push   %ebp
80102e0f:	89 e5                	mov    %esp,%ebp
80102e11:	83 ec 08             	sub    $0x8,%esp
80102e14:	8b 55 08             	mov    0x8(%ebp),%edx
80102e17:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e1a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102e1e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e21:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e25:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e29:	ee                   	out    %al,(%dx)
}
80102e2a:	c9                   	leave  
80102e2b:	c3                   	ret    

80102e2c <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102e2c:	55                   	push   %ebp
80102e2d:	89 e5                	mov    %esp,%ebp
80102e2f:	53                   	push   %ebx
80102e30:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102e33:	9c                   	pushf  
80102e34:	5b                   	pop    %ebx
80102e35:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80102e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102e3b:	83 c4 10             	add    $0x10,%esp
80102e3e:	5b                   	pop    %ebx
80102e3f:	5d                   	pop    %ebp
80102e40:	c3                   	ret    

80102e41 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102e41:	55                   	push   %ebp
80102e42:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102e44:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e49:	8b 55 08             	mov    0x8(%ebp),%edx
80102e4c:	c1 e2 02             	shl    $0x2,%edx
80102e4f:	01 c2                	add    %eax,%edx
80102e51:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e54:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102e56:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e5b:	83 c0 20             	add    $0x20,%eax
80102e5e:	8b 00                	mov    (%eax),%eax
}
80102e60:	5d                   	pop    %ebp
80102e61:	c3                   	ret    

80102e62 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102e62:	55                   	push   %ebp
80102e63:	89 e5                	mov    %esp,%ebp
80102e65:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
80102e68:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e6d:	85 c0                	test   %eax,%eax
80102e6f:	0f 84 47 01 00 00    	je     80102fbc <lapicinit+0x15a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102e75:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102e7c:	00 
80102e7d:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102e84:	e8 b8 ff ff ff       	call   80102e41 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102e89:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102e90:	00 
80102e91:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102e98:	e8 a4 ff ff ff       	call   80102e41 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102e9d:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102ea4:	00 
80102ea5:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102eac:	e8 90 ff ff ff       	call   80102e41 <lapicw>
  lapicw(TICR, 10000000); 
80102eb1:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102eb8:	00 
80102eb9:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102ec0:	e8 7c ff ff ff       	call   80102e41 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102ec5:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102ecc:	00 
80102ecd:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102ed4:	e8 68 ff ff ff       	call   80102e41 <lapicw>
  lapicw(LINT1, MASKED);
80102ed9:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102ee0:	00 
80102ee1:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102ee8:	e8 54 ff ff ff       	call   80102e41 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102eed:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102ef2:	83 c0 30             	add    $0x30,%eax
80102ef5:	8b 00                	mov    (%eax),%eax
80102ef7:	c1 e8 10             	shr    $0x10,%eax
80102efa:	25 ff 00 00 00       	and    $0xff,%eax
80102eff:	83 f8 03             	cmp    $0x3,%eax
80102f02:	76 14                	jbe    80102f18 <lapicinit+0xb6>
    lapicw(PCINT, MASKED);
80102f04:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102f0b:	00 
80102f0c:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102f13:	e8 29 ff ff ff       	call   80102e41 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102f18:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102f1f:	00 
80102f20:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102f27:	e8 15 ff ff ff       	call   80102e41 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102f2c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f33:	00 
80102f34:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102f3b:	e8 01 ff ff ff       	call   80102e41 <lapicw>
  lapicw(ESR, 0);
80102f40:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f47:	00 
80102f48:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102f4f:	e8 ed fe ff ff       	call   80102e41 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102f54:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f5b:	00 
80102f5c:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102f63:	e8 d9 fe ff ff       	call   80102e41 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102f68:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f6f:	00 
80102f70:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102f77:	e8 c5 fe ff ff       	call   80102e41 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102f7c:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102f83:	00 
80102f84:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f8b:	e8 b1 fe ff ff       	call   80102e41 <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102f90:	90                   	nop
80102f91:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f96:	05 00 03 00 00       	add    $0x300,%eax
80102f9b:	8b 00                	mov    (%eax),%eax
80102f9d:	25 00 10 00 00       	and    $0x1000,%eax
80102fa2:	85 c0                	test   %eax,%eax
80102fa4:	75 eb                	jne    80102f91 <lapicinit+0x12f>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102fa6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102fad:	00 
80102fae:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102fb5:	e8 87 fe ff ff       	call   80102e41 <lapicw>
80102fba:	eb 01                	jmp    80102fbd <lapicinit+0x15b>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80102fbc:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102fbd:	c9                   	leave  
80102fbe:	c3                   	ret    

80102fbf <cpunum>:

int
cpunum(void)
{
80102fbf:	55                   	push   %ebp
80102fc0:	89 e5                	mov    %esp,%ebp
80102fc2:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102fc5:	e8 62 fe ff ff       	call   80102e2c <readeflags>
80102fca:	25 00 02 00 00       	and    $0x200,%eax
80102fcf:	85 c0                	test   %eax,%eax
80102fd1:	74 29                	je     80102ffc <cpunum+0x3d>
    static int n;
    if(n++ == 0)
80102fd3:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102fd8:	85 c0                	test   %eax,%eax
80102fda:	0f 94 c2             	sete   %dl
80102fdd:	83 c0 01             	add    $0x1,%eax
80102fe0:	a3 40 b6 10 80       	mov    %eax,0x8010b640
80102fe5:	84 d2                	test   %dl,%dl
80102fe7:	74 13                	je     80102ffc <cpunum+0x3d>
      cprintf("cpu called from %x with interrupts enabled\n",
80102fe9:	8b 45 04             	mov    0x4(%ebp),%eax
80102fec:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff0:	c7 04 24 08 88 10 80 	movl   $0x80108808,(%esp)
80102ff7:	e8 ae d3 ff ff       	call   801003aa <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
80102ffc:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80103001:	85 c0                	test   %eax,%eax
80103003:	74 0f                	je     80103014 <cpunum+0x55>
    return lapic[ID]>>24;
80103005:	a1 5c 22 11 80       	mov    0x8011225c,%eax
8010300a:	83 c0 20             	add    $0x20,%eax
8010300d:	8b 00                	mov    (%eax),%eax
8010300f:	c1 e8 18             	shr    $0x18,%eax
80103012:	eb 05                	jmp    80103019 <cpunum+0x5a>
  return 0;
80103014:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103019:	c9                   	leave  
8010301a:	c3                   	ret    

8010301b <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
8010301b:	55                   	push   %ebp
8010301c:	89 e5                	mov    %esp,%ebp
8010301e:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80103021:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80103026:	85 c0                	test   %eax,%eax
80103028:	74 14                	je     8010303e <lapiceoi+0x23>
    lapicw(EOI, 0);
8010302a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103031:	00 
80103032:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80103039:	e8 03 fe ff ff       	call   80102e41 <lapicw>
}
8010303e:	c9                   	leave  
8010303f:	c3                   	ret    

80103040 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
}
80103043:	5d                   	pop    %ebp
80103044:	c3                   	ret    

80103045 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103045:	55                   	push   %ebp
80103046:	89 e5                	mov    %esp,%ebp
80103048:	83 ec 1c             	sub    $0x1c,%esp
8010304b:	8b 45 08             	mov    0x8(%ebp),%eax
8010304e:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80103051:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80103058:	00 
80103059:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80103060:	e8 a9 fd ff ff       	call   80102e0e <outb>
  outb(CMOS_PORT+1, 0x0A);
80103065:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
8010306c:	00 
8010306d:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80103074:	e8 95 fd ff ff       	call   80102e0e <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103079:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103080:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103083:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103088:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010308b:	8d 50 02             	lea    0x2(%eax),%edx
8010308e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103091:	c1 e8 04             	shr    $0x4,%eax
80103094:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103097:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010309b:	c1 e0 18             	shl    $0x18,%eax
8010309e:	89 44 24 04          	mov    %eax,0x4(%esp)
801030a2:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
801030a9:	e8 93 fd ff ff       	call   80102e41 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
801030ae:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
801030b5:	00 
801030b6:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801030bd:	e8 7f fd ff ff       	call   80102e41 <lapicw>
  microdelay(200);
801030c2:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
801030c9:	e8 72 ff ff ff       	call   80103040 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
801030ce:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
801030d5:	00 
801030d6:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801030dd:	e8 5f fd ff ff       	call   80102e41 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
801030e2:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
801030e9:	e8 52 ff ff ff       	call   80103040 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801030ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801030f5:	eb 40                	jmp    80103137 <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
801030f7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030fb:	c1 e0 18             	shl    $0x18,%eax
801030fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80103102:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80103109:	e8 33 fd ff ff       	call   80102e41 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
8010310e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103111:	c1 e8 0c             	shr    $0xc,%eax
80103114:	80 cc 06             	or     $0x6,%ah
80103117:	89 44 24 04          	mov    %eax,0x4(%esp)
8010311b:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80103122:	e8 1a fd ff ff       	call   80102e41 <lapicw>
    microdelay(200);
80103127:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
8010312e:	e8 0d ff ff ff       	call   80103040 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103133:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103137:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
8010313b:	7e ba                	jle    801030f7 <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010313d:	c9                   	leave  
8010313e:	c3                   	ret    

8010313f <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
8010313f:	55                   	push   %ebp
80103140:	89 e5                	mov    %esp,%ebp
80103142:	83 ec 08             	sub    $0x8,%esp
  outb(CMOS_PORT,  reg);
80103145:	8b 45 08             	mov    0x8(%ebp),%eax
80103148:	0f b6 c0             	movzbl %al,%eax
8010314b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010314f:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80103156:	e8 b3 fc ff ff       	call   80102e0e <outb>
  microdelay(200);
8010315b:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80103162:	e8 d9 fe ff ff       	call   80103040 <microdelay>

  return inb(CMOS_RETURN);
80103167:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
8010316e:	e8 71 fc ff ff       	call   80102de4 <inb>
80103173:	0f b6 c0             	movzbl %al,%eax
}
80103176:	c9                   	leave  
80103177:	c3                   	ret    

80103178 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
80103178:	55                   	push   %ebp
80103179:	89 e5                	mov    %esp,%ebp
8010317b:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
8010317e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80103185:	e8 b5 ff ff ff       	call   8010313f <cmos_read>
8010318a:	8b 55 08             	mov    0x8(%ebp),%edx
8010318d:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
8010318f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80103196:	e8 a4 ff ff ff       	call   8010313f <cmos_read>
8010319b:	8b 55 08             	mov    0x8(%ebp),%edx
8010319e:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
801031a1:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801031a8:	e8 92 ff ff ff       	call   8010313f <cmos_read>
801031ad:	8b 55 08             	mov    0x8(%ebp),%edx
801031b0:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
801031b3:	c7 04 24 07 00 00 00 	movl   $0x7,(%esp)
801031ba:	e8 80 ff ff ff       	call   8010313f <cmos_read>
801031bf:	8b 55 08             	mov    0x8(%ebp),%edx
801031c2:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
801031c5:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801031cc:	e8 6e ff ff ff       	call   8010313f <cmos_read>
801031d1:	8b 55 08             	mov    0x8(%ebp),%edx
801031d4:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
801031d7:	c7 04 24 09 00 00 00 	movl   $0x9,(%esp)
801031de:	e8 5c ff ff ff       	call   8010313f <cmos_read>
801031e3:	8b 55 08             	mov    0x8(%ebp),%edx
801031e6:	89 42 14             	mov    %eax,0x14(%edx)
}
801031e9:	c9                   	leave  
801031ea:	c3                   	ret    

801031eb <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801031eb:	55                   	push   %ebp
801031ec:	89 e5                	mov    %esp,%ebp
801031ee:	83 ec 58             	sub    $0x58,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801031f1:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
801031f8:	e8 42 ff ff ff       	call   8010313f <cmos_read>
801031fd:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80103200:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103203:	83 e0 04             	and    $0x4,%eax
80103206:	85 c0                	test   %eax,%eax
80103208:	0f 94 c0             	sete   %al
8010320b:	0f b6 c0             	movzbl %al,%eax
8010320e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103211:	eb 01                	jmp    80103214 <cmostime+0x29>
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
80103213:	90                   	nop

  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
80103214:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103217:	89 04 24             	mov    %eax,(%esp)
8010321a:	e8 59 ff ff ff       	call   80103178 <fill_rtcdate>
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
8010321f:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80103226:	e8 14 ff ff ff       	call   8010313f <cmos_read>
8010322b:	25 80 00 00 00       	and    $0x80,%eax
80103230:	85 c0                	test   %eax,%eax
80103232:	75 2b                	jne    8010325f <cmostime+0x74>
        continue;
    fill_rtcdate(&t2);
80103234:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103237:	89 04 24             	mov    %eax,(%esp)
8010323a:	e8 39 ff ff ff       	call   80103178 <fill_rtcdate>
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
8010323f:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80103246:	00 
80103247:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010324a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010324e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103251:	89 04 24             	mov    %eax,(%esp)
80103254:	e8 24 20 00 00       	call   8010527d <memcmp>
80103259:	85 c0                	test   %eax,%eax
8010325b:	75 b6                	jne    80103213 <cmostime+0x28>
      break;
8010325d:	eb 03                	jmp    80103262 <cmostime+0x77>

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
8010325f:	90                   	nop
    fill_rtcdate(&t2);
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
80103260:	eb b1                	jmp    80103213 <cmostime+0x28>

  // convert
  if (bcd) {
80103262:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103266:	0f 84 a8 00 00 00    	je     80103314 <cmostime+0x129>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010326c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010326f:	89 c2                	mov    %eax,%edx
80103271:	c1 ea 04             	shr    $0x4,%edx
80103274:	89 d0                	mov    %edx,%eax
80103276:	c1 e0 02             	shl    $0x2,%eax
80103279:	01 d0                	add    %edx,%eax
8010327b:	01 c0                	add    %eax,%eax
8010327d:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103280:	83 e2 0f             	and    $0xf,%edx
80103283:	01 d0                	add    %edx,%eax
80103285:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103288:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010328b:	89 c2                	mov    %eax,%edx
8010328d:	c1 ea 04             	shr    $0x4,%edx
80103290:	89 d0                	mov    %edx,%eax
80103292:	c1 e0 02             	shl    $0x2,%eax
80103295:	01 d0                	add    %edx,%eax
80103297:	01 c0                	add    %eax,%eax
80103299:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010329c:	83 e2 0f             	and    $0xf,%edx
8010329f:	01 d0                	add    %edx,%eax
801032a1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
801032a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801032a7:	89 c2                	mov    %eax,%edx
801032a9:	c1 ea 04             	shr    $0x4,%edx
801032ac:	89 d0                	mov    %edx,%eax
801032ae:	c1 e0 02             	shl    $0x2,%eax
801032b1:	01 d0                	add    %edx,%eax
801032b3:	01 c0                	add    %eax,%eax
801032b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
801032b8:	83 e2 0f             	and    $0xf,%edx
801032bb:	01 d0                	add    %edx,%eax
801032bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
801032c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032c3:	89 c2                	mov    %eax,%edx
801032c5:	c1 ea 04             	shr    $0x4,%edx
801032c8:	89 d0                	mov    %edx,%eax
801032ca:	c1 e0 02             	shl    $0x2,%eax
801032cd:	01 d0                	add    %edx,%eax
801032cf:	01 c0                	add    %eax,%eax
801032d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032d4:	83 e2 0f             	and    $0xf,%edx
801032d7:	01 d0                	add    %edx,%eax
801032d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
801032dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032df:	89 c2                	mov    %eax,%edx
801032e1:	c1 ea 04             	shr    $0x4,%edx
801032e4:	89 d0                	mov    %edx,%eax
801032e6:	c1 e0 02             	shl    $0x2,%eax
801032e9:	01 d0                	add    %edx,%eax
801032eb:	01 c0                	add    %eax,%eax
801032ed:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032f0:	83 e2 0f             	and    $0xf,%edx
801032f3:	01 d0                	add    %edx,%eax
801032f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
801032f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032fb:	89 c2                	mov    %eax,%edx
801032fd:	c1 ea 04             	shr    $0x4,%edx
80103300:	89 d0                	mov    %edx,%eax
80103302:	c1 e0 02             	shl    $0x2,%eax
80103305:	01 d0                	add    %edx,%eax
80103307:	01 c0                	add    %eax,%eax
80103309:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010330c:	83 e2 0f             	and    $0xf,%edx
8010330f:	01 d0                	add    %edx,%eax
80103311:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
80103314:	8b 45 08             	mov    0x8(%ebp),%eax
80103317:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010331a:	89 10                	mov    %edx,(%eax)
8010331c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010331f:	89 50 04             	mov    %edx,0x4(%eax)
80103322:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103325:	89 50 08             	mov    %edx,0x8(%eax)
80103328:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010332b:	89 50 0c             	mov    %edx,0xc(%eax)
8010332e:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103331:	89 50 10             	mov    %edx,0x10(%eax)
80103334:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103337:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
8010333a:	8b 45 08             	mov    0x8(%ebp),%eax
8010333d:	8b 40 14             	mov    0x14(%eax),%eax
80103340:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
80103346:	8b 45 08             	mov    0x8(%ebp),%eax
80103349:	89 50 14             	mov    %edx,0x14(%eax)
}
8010334c:	c9                   	leave  
8010334d:	c3                   	ret    
	...

80103350 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	83 ec 38             	sub    $0x38,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103356:	c7 44 24 04 34 88 10 	movl   $0x80108834,0x4(%esp)
8010335d:	80 
8010335e:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103365:	e8 20 1c 00 00       	call   80104f8a <initlock>
  readsb(dev, &sb);
8010336a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010336d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103371:	8b 45 08             	mov    0x8(%ebp),%eax
80103374:	89 04 24             	mov    %eax,(%esp)
80103377:	e8 c0 df ff ff       	call   8010133c <readsb>
  log.start = sb.logstart;
8010337c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010337f:	a3 94 22 11 80       	mov    %eax,0x80112294
  log.size = sb.nlog;
80103384:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103387:	a3 98 22 11 80       	mov    %eax,0x80112298
  log.dev = dev;
8010338c:	8b 45 08             	mov    0x8(%ebp),%eax
8010338f:	a3 a4 22 11 80       	mov    %eax,0x801122a4
  recover_from_log();
80103394:	e8 9a 01 00 00       	call   80103533 <recover_from_log>
}
80103399:	c9                   	leave  
8010339a:	c3                   	ret    

8010339b <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010339b:	55                   	push   %ebp
8010339c:	89 e5                	mov    %esp,%ebp
8010339e:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801033a8:	e9 8c 00 00 00       	jmp    80103439 <install_trans+0x9e>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801033ad:	8b 15 94 22 11 80    	mov    0x80112294,%edx
801033b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033b6:	01 d0                	add    %edx,%eax
801033b8:	83 c0 01             	add    $0x1,%eax
801033bb:	89 c2                	mov    %eax,%edx
801033bd:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801033c2:	89 54 24 04          	mov    %edx,0x4(%esp)
801033c6:	89 04 24             	mov    %eax,(%esp)
801033c9:	e8 d8 cd ff ff       	call   801001a6 <bread>
801033ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801033d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033d4:	83 c0 10             	add    $0x10,%eax
801033d7:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801033de:	89 c2                	mov    %eax,%edx
801033e0:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801033e5:	89 54 24 04          	mov    %edx,0x4(%esp)
801033e9:	89 04 24             	mov    %eax,(%esp)
801033ec:	e8 b5 cd ff ff       	call   801001a6 <bread>
801033f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801033f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033f7:	8d 50 18             	lea    0x18(%eax),%edx
801033fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033fd:	83 c0 18             	add    $0x18,%eax
80103400:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103407:	00 
80103408:	89 54 24 04          	mov    %edx,0x4(%esp)
8010340c:	89 04 24             	mov    %eax,(%esp)
8010340f:	e8 c5 1e 00 00       	call   801052d9 <memmove>
    bwrite(dbuf);  // write dst to disk
80103414:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103417:	89 04 24             	mov    %eax,(%esp)
8010341a:	e8 be cd ff ff       	call   801001dd <bwrite>
    brelse(lbuf); 
8010341f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103422:	89 04 24             	mov    %eax,(%esp)
80103425:	e8 ed cd ff ff       	call   80100217 <brelse>
    brelse(dbuf);
8010342a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010342d:	89 04 24             	mov    %eax,(%esp)
80103430:	e8 e2 cd ff ff       	call   80100217 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103435:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103439:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010343e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103441:	0f 8f 66 ff ff ff    	jg     801033ad <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103447:	c9                   	leave  
80103448:	c3                   	ret    

80103449 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103449:	55                   	push   %ebp
8010344a:	89 e5                	mov    %esp,%ebp
8010344c:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
8010344f:	a1 94 22 11 80       	mov    0x80112294,%eax
80103454:	89 c2                	mov    %eax,%edx
80103456:	a1 a4 22 11 80       	mov    0x801122a4,%eax
8010345b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010345f:	89 04 24             	mov    %eax,(%esp)
80103462:	e8 3f cd ff ff       	call   801001a6 <bread>
80103467:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010346a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010346d:	83 c0 18             	add    $0x18,%eax
80103470:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103473:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103476:	8b 00                	mov    (%eax),%eax
80103478:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  for (i = 0; i < log.lh.n; i++) {
8010347d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103484:	eb 1b                	jmp    801034a1 <read_head+0x58>
    log.lh.block[i] = lh->block[i];
80103486:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103489:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010348c:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103490:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103493:	83 c2 10             	add    $0x10,%edx
80103496:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010349d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034a1:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801034a6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034a9:	7f db                	jg     80103486 <read_head+0x3d>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
801034ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034ae:	89 04 24             	mov    %eax,(%esp)
801034b1:	e8 61 cd ff ff       	call   80100217 <brelse>
}
801034b6:	c9                   	leave  
801034b7:	c3                   	ret    

801034b8 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801034b8:	55                   	push   %ebp
801034b9:	89 e5                	mov    %esp,%ebp
801034bb:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
801034be:	a1 94 22 11 80       	mov    0x80112294,%eax
801034c3:	89 c2                	mov    %eax,%edx
801034c5:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801034ca:	89 54 24 04          	mov    %edx,0x4(%esp)
801034ce:	89 04 24             	mov    %eax,(%esp)
801034d1:	e8 d0 cc ff ff       	call   801001a6 <bread>
801034d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801034d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034dc:	83 c0 18             	add    $0x18,%eax
801034df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801034e2:	8b 15 a8 22 11 80    	mov    0x801122a8,%edx
801034e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034eb:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034f4:	eb 1b                	jmp    80103511 <write_head+0x59>
    hb->block[i] = log.lh.block[i];
801034f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034f9:	83 c0 10             	add    $0x10,%eax
801034fc:	8b 0c 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%ecx
80103503:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103506:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103509:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010350d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103511:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103516:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103519:	7f db                	jg     801034f6 <write_head+0x3e>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
8010351b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010351e:	89 04 24             	mov    %eax,(%esp)
80103521:	e8 b7 cc ff ff       	call   801001dd <bwrite>
  brelse(buf);
80103526:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103529:	89 04 24             	mov    %eax,(%esp)
8010352c:	e8 e6 cc ff ff       	call   80100217 <brelse>
}
80103531:	c9                   	leave  
80103532:	c3                   	ret    

80103533 <recover_from_log>:

static void
recover_from_log(void)
{
80103533:	55                   	push   %ebp
80103534:	89 e5                	mov    %esp,%ebp
80103536:	83 ec 08             	sub    $0x8,%esp
  read_head();      
80103539:	e8 0b ff ff ff       	call   80103449 <read_head>
  install_trans(); // if committed, copy from log to disk
8010353e:	e8 58 fe ff ff       	call   8010339b <install_trans>
  log.lh.n = 0;
80103543:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
8010354a:	00 00 00 
  write_head(); // clear the log
8010354d:	e8 66 ff ff ff       	call   801034b8 <write_head>
}
80103552:	c9                   	leave  
80103553:	c3                   	ret    

80103554 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103554:	55                   	push   %ebp
80103555:	89 e5                	mov    %esp,%ebp
80103557:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
8010355a:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103561:	e8 45 1a 00 00       	call   80104fab <acquire>
  while(1){
    if(log.committing){
80103566:	a1 a0 22 11 80       	mov    0x801122a0,%eax
8010356b:	85 c0                	test   %eax,%eax
8010356d:	74 16                	je     80103585 <begin_op+0x31>
      sleep(&log, &log.lock);
8010356f:	c7 44 24 04 60 22 11 	movl   $0x80112260,0x4(%esp)
80103576:	80 
80103577:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
8010357e:	e8 4a 17 00 00       	call   80104ccd <sleep>
    } else {
      log.outstanding += 1;
      release(&log.lock);
      break;
    }
  }
80103583:	eb e1                	jmp    80103566 <begin_op+0x12>
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103585:	8b 0d a8 22 11 80    	mov    0x801122a8,%ecx
8010358b:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103590:	8d 50 01             	lea    0x1(%eax),%edx
80103593:	89 d0                	mov    %edx,%eax
80103595:	c1 e0 02             	shl    $0x2,%eax
80103598:	01 d0                	add    %edx,%eax
8010359a:	01 c0                	add    %eax,%eax
8010359c:	01 c8                	add    %ecx,%eax
8010359e:	83 f8 1e             	cmp    $0x1e,%eax
801035a1:	7e 16                	jle    801035b9 <begin_op+0x65>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
801035a3:	c7 44 24 04 60 22 11 	movl   $0x80112260,0x4(%esp)
801035aa:	80 
801035ab:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
801035b2:	e8 16 17 00 00       	call   80104ccd <sleep>
    } else {
      log.outstanding += 1;
      release(&log.lock);
      break;
    }
  }
801035b7:	eb ad                	jmp    80103566 <begin_op+0x12>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
801035b9:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801035be:	83 c0 01             	add    $0x1,%eax
801035c1:	a3 9c 22 11 80       	mov    %eax,0x8011229c
      release(&log.lock);
801035c6:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
801035cd:	e8 3b 1a 00 00       	call   8010500d <release>
      break;
801035d2:	90                   	nop
    }
  }
}
801035d3:	c9                   	leave  
801035d4:	c3                   	ret    

801035d5 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801035d5:	55                   	push   %ebp
801035d6:	89 e5                	mov    %esp,%ebp
801035d8:	83 ec 28             	sub    $0x28,%esp
  int do_commit = 0;
801035db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
801035e2:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
801035e9:	e8 bd 19 00 00       	call   80104fab <acquire>
  log.outstanding -= 1;
801035ee:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801035f3:	83 e8 01             	sub    $0x1,%eax
801035f6:	a3 9c 22 11 80       	mov    %eax,0x8011229c
  if(log.committing)
801035fb:	a1 a0 22 11 80       	mov    0x801122a0,%eax
80103600:	85 c0                	test   %eax,%eax
80103602:	74 0c                	je     80103610 <end_op+0x3b>
    panic("log.committing");
80103604:	c7 04 24 38 88 10 80 	movl   $0x80108838,(%esp)
8010360b:	e8 36 cf ff ff       	call   80100546 <panic>
  if(log.outstanding == 0){
80103610:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103615:	85 c0                	test   %eax,%eax
80103617:	75 13                	jne    8010362c <end_op+0x57>
    do_commit = 1;
80103619:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103620:	c7 05 a0 22 11 80 01 	movl   $0x1,0x801122a0
80103627:	00 00 00 
8010362a:	eb 0c                	jmp    80103638 <end_op+0x63>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
8010362c:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103633:	e8 6e 17 00 00       	call   80104da6 <wakeup>
  }
  release(&log.lock);
80103638:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
8010363f:	e8 c9 19 00 00       	call   8010500d <release>

  if(do_commit){
80103644:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103648:	74 33                	je     8010367d <end_op+0xa8>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
8010364a:	e8 de 00 00 00       	call   8010372d <commit>
    acquire(&log.lock);
8010364f:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103656:	e8 50 19 00 00       	call   80104fab <acquire>
    log.committing = 0;
8010365b:	c7 05 a0 22 11 80 00 	movl   $0x0,0x801122a0
80103662:	00 00 00 
    wakeup(&log);
80103665:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
8010366c:	e8 35 17 00 00       	call   80104da6 <wakeup>
    release(&log.lock);
80103671:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103678:	e8 90 19 00 00       	call   8010500d <release>
  }
}
8010367d:	c9                   	leave  
8010367e:	c3                   	ret    

8010367f <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
8010367f:	55                   	push   %ebp
80103680:	89 e5                	mov    %esp,%ebp
80103682:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103685:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010368c:	e9 8c 00 00 00       	jmp    8010371d <write_log+0x9e>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103691:	8b 15 94 22 11 80    	mov    0x80112294,%edx
80103697:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010369a:	01 d0                	add    %edx,%eax
8010369c:	83 c0 01             	add    $0x1,%eax
8010369f:	89 c2                	mov    %eax,%edx
801036a1:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801036a6:	89 54 24 04          	mov    %edx,0x4(%esp)
801036aa:	89 04 24             	mov    %eax,(%esp)
801036ad:	e8 f4 ca ff ff       	call   801001a6 <bread>
801036b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801036b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036b8:	83 c0 10             	add    $0x10,%eax
801036bb:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801036c2:	89 c2                	mov    %eax,%edx
801036c4:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801036c9:	89 54 24 04          	mov    %edx,0x4(%esp)
801036cd:	89 04 24             	mov    %eax,(%esp)
801036d0:	e8 d1 ca ff ff       	call   801001a6 <bread>
801036d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
801036d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036db:	8d 50 18             	lea    0x18(%eax),%edx
801036de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036e1:	83 c0 18             	add    $0x18,%eax
801036e4:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801036eb:	00 
801036ec:	89 54 24 04          	mov    %edx,0x4(%esp)
801036f0:	89 04 24             	mov    %eax,(%esp)
801036f3:	e8 e1 1b 00 00       	call   801052d9 <memmove>
    bwrite(to);  // write the log
801036f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036fb:	89 04 24             	mov    %eax,(%esp)
801036fe:	e8 da ca ff ff       	call   801001dd <bwrite>
    brelse(from); 
80103703:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103706:	89 04 24             	mov    %eax,(%esp)
80103709:	e8 09 cb ff ff       	call   80100217 <brelse>
    brelse(to);
8010370e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103711:	89 04 24             	mov    %eax,(%esp)
80103714:	e8 fe ca ff ff       	call   80100217 <brelse>
static void 
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103719:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010371d:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103722:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103725:	0f 8f 66 ff ff ff    	jg     80103691 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from); 
    brelse(to);
  }
}
8010372b:	c9                   	leave  
8010372c:	c3                   	ret    

8010372d <commit>:

static void
commit()
{
8010372d:	55                   	push   %ebp
8010372e:	89 e5                	mov    %esp,%ebp
80103730:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103733:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103738:	85 c0                	test   %eax,%eax
8010373a:	7e 1e                	jle    8010375a <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
8010373c:	e8 3e ff ff ff       	call   8010367f <write_log>
    write_head();    // Write header to disk -- the real commit
80103741:	e8 72 fd ff ff       	call   801034b8 <write_head>
    install_trans(); // Now install writes to home locations
80103746:	e8 50 fc ff ff       	call   8010339b <install_trans>
    log.lh.n = 0; 
8010374b:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
80103752:	00 00 00 
    write_head();    // Erase the transaction from the log
80103755:	e8 5e fd ff ff       	call   801034b8 <write_head>
  }
}
8010375a:	c9                   	leave  
8010375b:	c3                   	ret    

8010375c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010375c:	55                   	push   %ebp
8010375d:	89 e5                	mov    %esp,%ebp
8010375f:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103762:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103767:	83 f8 1d             	cmp    $0x1d,%eax
8010376a:	7f 12                	jg     8010377e <log_write+0x22>
8010376c:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103771:	8b 15 98 22 11 80    	mov    0x80112298,%edx
80103777:	83 ea 01             	sub    $0x1,%edx
8010377a:	39 d0                	cmp    %edx,%eax
8010377c:	7c 0c                	jl     8010378a <log_write+0x2e>
    panic("too big a transaction");
8010377e:	c7 04 24 47 88 10 80 	movl   $0x80108847,(%esp)
80103785:	e8 bc cd ff ff       	call   80100546 <panic>
  if (log.outstanding < 1)
8010378a:	a1 9c 22 11 80       	mov    0x8011229c,%eax
8010378f:	85 c0                	test   %eax,%eax
80103791:	7f 0c                	jg     8010379f <log_write+0x43>
    panic("log_write outside of trans");
80103793:	c7 04 24 5d 88 10 80 	movl   $0x8010885d,(%esp)
8010379a:	e8 a7 cd ff ff       	call   80100546 <panic>

  acquire(&log.lock);
8010379f:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
801037a6:	e8 00 18 00 00       	call   80104fab <acquire>
  for (i = 0; i < log.lh.n; i++) {
801037ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037b2:	eb 1d                	jmp    801037d1 <log_write+0x75>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801037b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b7:	83 c0 10             	add    $0x10,%eax
801037ba:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801037c1:	89 c2                	mov    %eax,%edx
801037c3:	8b 45 08             	mov    0x8(%ebp),%eax
801037c6:	8b 40 08             	mov    0x8(%eax),%eax
801037c9:	39 c2                	cmp    %eax,%edx
801037cb:	74 10                	je     801037dd <log_write+0x81>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801037cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037d1:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801037d6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037d9:	7f d9                	jg     801037b4 <log_write+0x58>
801037db:	eb 01                	jmp    801037de <log_write+0x82>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
801037dd:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
801037de:	8b 45 08             	mov    0x8(%ebp),%eax
801037e1:	8b 40 08             	mov    0x8(%eax),%eax
801037e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801037e7:	83 c2 10             	add    $0x10,%edx
801037ea:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
  if (i == log.lh.n)
801037f1:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801037f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037f9:	75 0d                	jne    80103808 <log_write+0xac>
    log.lh.n++;
801037fb:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103800:	83 c0 01             	add    $0x1,%eax
80103803:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  b->flags |= B_DIRTY; // prevent eviction
80103808:	8b 45 08             	mov    0x8(%ebp),%eax
8010380b:	8b 00                	mov    (%eax),%eax
8010380d:	89 c2                	mov    %eax,%edx
8010380f:	83 ca 04             	or     $0x4,%edx
80103812:	8b 45 08             	mov    0x8(%ebp),%eax
80103815:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103817:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
8010381e:	e8 ea 17 00 00       	call   8010500d <release>
}
80103823:	c9                   	leave  
80103824:	c3                   	ret    
80103825:	00 00                	add    %al,(%eax)
	...

80103828 <v2p>:
80103828:	55                   	push   %ebp
80103829:	89 e5                	mov    %esp,%ebp
8010382b:	8b 45 08             	mov    0x8(%ebp),%eax
8010382e:	05 00 00 00 80       	add    $0x80000000,%eax
80103833:	5d                   	pop    %ebp
80103834:	c3                   	ret    

80103835 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103835:	55                   	push   %ebp
80103836:	89 e5                	mov    %esp,%ebp
80103838:	8b 45 08             	mov    0x8(%ebp),%eax
8010383b:	05 00 00 00 80       	add    $0x80000000,%eax
80103840:	5d                   	pop    %ebp
80103841:	c3                   	ret    

80103842 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103842:	55                   	push   %ebp
80103843:	89 e5                	mov    %esp,%ebp
80103845:	53                   	push   %ebx
80103846:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
80103849:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010384c:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
8010384f:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103852:	89 c3                	mov    %eax,%ebx
80103854:	89 d8                	mov    %ebx,%eax
80103856:	f0 87 02             	lock xchg %eax,(%edx)
80103859:	89 c3                	mov    %eax,%ebx
8010385b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
8010385e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103861:	83 c4 10             	add    $0x10,%esp
80103864:	5b                   	pop    %ebx
80103865:	5d                   	pop    %ebp
80103866:	c3                   	ret    

80103867 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103867:	55                   	push   %ebp
80103868:	89 e5                	mov    %esp,%ebp
8010386a:	83 e4 f0             	and    $0xfffffff0,%esp
8010386d:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103870:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80103877:	80 
80103878:	c7 04 24 3c 51 11 80 	movl   $0x8011513c,(%esp)
8010387f:	e8 51 f2 ff ff       	call   80102ad5 <kinit1>
  kvmalloc();      // kernel page table
80103884:	e8 77 45 00 00       	call   80107e00 <kvmalloc>
  mpinit();        // collect info about this machine
80103889:	e8 53 04 00 00       	call   80103ce1 <mpinit>
  lapicinit();
8010388e:	e8 cf f5 ff ff       	call   80102e62 <lapicinit>
  seginit();       // set up segments
80103893:	e8 fd 3e 00 00       	call   80107795 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103898:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010389e:	0f b6 00             	movzbl (%eax),%eax
801038a1:	0f b6 c0             	movzbl %al,%eax
801038a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801038a8:	c7 04 24 78 88 10 80 	movl   $0x80108878,(%esp)
801038af:	e8 f6 ca ff ff       	call   801003aa <cprintf>
  picinit();       // interrupt controller
801038b4:	e8 8d 06 00 00       	call   80103f46 <picinit>
  ioapicinit();    // another interrupt controller
801038b9:	e8 07 f1 ff ff       	call   801029c5 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801038be:	e8 04 d2 ff ff       	call   80100ac7 <consoleinit>
  uartinit();      // serial port
801038c3:	e8 18 32 00 00       	call   80106ae0 <uartinit>
  pinit();         // process table
801038c8:	e8 98 0b 00 00       	call   80104465 <pinit>
  tvinit();        // trap vectors
801038cd:	e8 b1 2d 00 00       	call   80106683 <tvinit>
  binit();         // buffer cache
801038d2:	e8 5d c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
801038d7:	e8 74 d6 ff ff       	call   80100f50 <fileinit>
  ideinit();       // disk
801038dc:	e8 15 ed ff ff       	call   801025f6 <ideinit>
  if(!ismp)
801038e1:	a1 44 23 11 80       	mov    0x80112344,%eax
801038e6:	85 c0                	test   %eax,%eax
801038e8:	75 05                	jne    801038ef <main+0x88>
    timerinit();   // uniprocessor timer
801038ea:	e8 d7 2c 00 00       	call   801065c6 <timerinit>
  startothers();   // start other processors
801038ef:	e8 7f 00 00 00       	call   80103973 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801038f4:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
801038fb:	8e 
801038fc:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103903:	e8 05 f2 ff ff       	call   80102b0d <kinit2>
  userinit();      // first user process
80103908:	e8 73 0c 00 00       	call   80104580 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
8010390d:	e8 1a 00 00 00       	call   8010392c <mpmain>

80103912 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103912:	55                   	push   %ebp
80103913:	89 e5                	mov    %esp,%ebp
80103915:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103918:	e8 fa 44 00 00       	call   80107e17 <switchkvm>
  seginit();
8010391d:	e8 73 3e 00 00       	call   80107795 <seginit>
  lapicinit();
80103922:	e8 3b f5 ff ff       	call   80102e62 <lapicinit>
  mpmain();
80103927:	e8 00 00 00 00       	call   8010392c <mpmain>

8010392c <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
8010392c:	55                   	push   %ebp
8010392d:	89 e5                	mov    %esp,%ebp
8010392f:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103932:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103938:	0f b6 00             	movzbl (%eax),%eax
8010393b:	0f b6 c0             	movzbl %al,%eax
8010393e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103942:	c7 04 24 8f 88 10 80 	movl   $0x8010888f,(%esp)
80103949:	e8 5c ca ff ff       	call   801003aa <cprintf>
  idtinit();       // load idt register
8010394e:	e8 a4 2e 00 00       	call   801067f7 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103953:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103959:	05 a8 00 00 00       	add    $0xa8,%eax
8010395e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80103965:	00 
80103966:	89 04 24             	mov    %eax,(%esp)
80103969:	e8 d4 fe ff ff       	call   80103842 <xchg>
  scheduler();     // start running processes
8010396e:	e8 7e 11 00 00       	call   80104af1 <scheduler>

80103973 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103973:	55                   	push   %ebp
80103974:	89 e5                	mov    %esp,%ebp
80103976:	53                   	push   %ebx
80103977:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
8010397a:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
80103981:	e8 af fe ff ff       	call   80103835 <p2v>
80103986:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103989:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010398e:	89 44 24 08          	mov    %eax,0x8(%esp)
80103992:	c7 44 24 04 0c b5 10 	movl   $0x8010b50c,0x4(%esp)
80103999:	80 
8010399a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010399d:	89 04 24             	mov    %eax,(%esp)
801039a0:	e8 34 19 00 00       	call   801052d9 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801039a5:	c7 45 f4 60 23 11 80 	movl   $0x80112360,-0xc(%ebp)
801039ac:	e9 86 00 00 00       	jmp    80103a37 <startothers+0xc4>
    if(c == cpus+cpunum())  // We've started already.
801039b1:	e8 09 f6 ff ff       	call   80102fbf <cpunum>
801039b6:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039bc:	05 60 23 11 80       	add    $0x80112360,%eax
801039c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801039c4:	74 69                	je     80103a2f <startothers+0xbc>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801039c6:	e8 38 f2 ff ff       	call   80102c03 <kalloc>
801039cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801039ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039d1:	83 e8 04             	sub    $0x4,%eax
801039d4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801039d7:	81 c2 00 10 00 00    	add    $0x1000,%edx
801039dd:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
801039df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039e2:	83 e8 08             	sub    $0x8,%eax
801039e5:	c7 00 12 39 10 80    	movl   $0x80103912,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801039eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039ee:	8d 58 f4             	lea    -0xc(%eax),%ebx
801039f1:	c7 04 24 00 a0 10 80 	movl   $0x8010a000,(%esp)
801039f8:	e8 2b fe ff ff       	call   80103828 <v2p>
801039fd:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801039ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a02:	89 04 24             	mov    %eax,(%esp)
80103a05:	e8 1e fe ff ff       	call   80103828 <v2p>
80103a0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103a0d:	0f b6 12             	movzbl (%edx),%edx
80103a10:	0f b6 d2             	movzbl %dl,%edx
80103a13:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a17:	89 14 24             	mov    %edx,(%esp)
80103a1a:	e8 26 f6 ff ff       	call   80103045 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103a1f:	90                   	nop
80103a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a23:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103a29:	85 c0                	test   %eax,%eax
80103a2b:	74 f3                	je     80103a20 <startothers+0xad>
80103a2d:	eb 01                	jmp    80103a30 <startothers+0xbd>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103a2f:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103a30:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103a37:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a3c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a42:	05 60 23 11 80       	add    $0x80112360,%eax
80103a47:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a4a:	0f 87 61 ff ff ff    	ja     801039b1 <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103a50:	83 c4 24             	add    $0x24,%esp
80103a53:	5b                   	pop    %ebx
80103a54:	5d                   	pop    %ebp
80103a55:	c3                   	ret    
	...

80103a58 <p2v>:
80103a58:	55                   	push   %ebp
80103a59:	89 e5                	mov    %esp,%ebp
80103a5b:	8b 45 08             	mov    0x8(%ebp),%eax
80103a5e:	05 00 00 00 80       	add    $0x80000000,%eax
80103a63:	5d                   	pop    %ebp
80103a64:	c3                   	ret    

80103a65 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103a65:	55                   	push   %ebp
80103a66:	89 e5                	mov    %esp,%ebp
80103a68:	53                   	push   %ebx
80103a69:	83 ec 14             	sub    $0x14,%esp
80103a6c:	8b 45 08             	mov    0x8(%ebp),%eax
80103a6f:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a73:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80103a77:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80103a7b:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80103a7f:	ec                   	in     (%dx),%al
80103a80:	89 c3                	mov    %eax,%ebx
80103a82:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80103a85:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80103a89:	83 c4 14             	add    $0x14,%esp
80103a8c:	5b                   	pop    %ebx
80103a8d:	5d                   	pop    %ebp
80103a8e:	c3                   	ret    

80103a8f <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a8f:	55                   	push   %ebp
80103a90:	89 e5                	mov    %esp,%ebp
80103a92:	83 ec 08             	sub    $0x8,%esp
80103a95:	8b 55 08             	mov    0x8(%ebp),%edx
80103a98:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a9b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a9f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103aa2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103aa6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103aaa:	ee                   	out    %al,(%dx)
}
80103aab:	c9                   	leave  
80103aac:	c3                   	ret    

80103aad <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103aad:	55                   	push   %ebp
80103aae:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103ab0:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80103ab5:	89 c2                	mov    %eax,%edx
80103ab7:	b8 60 23 11 80       	mov    $0x80112360,%eax
80103abc:	89 d1                	mov    %edx,%ecx
80103abe:	29 c1                	sub    %eax,%ecx
80103ac0:	89 c8                	mov    %ecx,%eax
80103ac2:	c1 f8 02             	sar    $0x2,%eax
80103ac5:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103acb:	5d                   	pop    %ebp
80103acc:	c3                   	ret    

80103acd <sum>:

static uchar
sum(uchar *addr, int len)
{
80103acd:	55                   	push   %ebp
80103ace:	89 e5                	mov    %esp,%ebp
80103ad0:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103ad3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103ada:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103ae1:	eb 15                	jmp    80103af8 <sum+0x2b>
    sum += addr[i];
80103ae3:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103ae6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ae9:	01 d0                	add    %edx,%eax
80103aeb:	0f b6 00             	movzbl (%eax),%eax
80103aee:	0f b6 c0             	movzbl %al,%eax
80103af1:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103af4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103af8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103afb:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103afe:	7c e3                	jl     80103ae3 <sum+0x16>
    sum += addr[i];
  return sum;
80103b00:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103b03:	c9                   	leave  
80103b04:	c3                   	ret    

80103b05 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103b05:	55                   	push   %ebp
80103b06:	89 e5                	mov    %esp,%ebp
80103b08:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103b0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103b0e:	89 04 24             	mov    %eax,(%esp)
80103b11:	e8 42 ff ff ff       	call   80103a58 <p2v>
80103b16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103b19:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b1f:	01 d0                	add    %edx,%eax
80103b21:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103b24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b27:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b2a:	eb 3f                	jmp    80103b6b <mpsearch1+0x66>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b2c:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103b33:	00 
80103b34:	c7 44 24 04 a0 88 10 	movl   $0x801088a0,0x4(%esp)
80103b3b:	80 
80103b3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b3f:	89 04 24             	mov    %eax,(%esp)
80103b42:	e8 36 17 00 00       	call   8010527d <memcmp>
80103b47:	85 c0                	test   %eax,%eax
80103b49:	75 1c                	jne    80103b67 <mpsearch1+0x62>
80103b4b:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80103b52:	00 
80103b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b56:	89 04 24             	mov    %eax,(%esp)
80103b59:	e8 6f ff ff ff       	call   80103acd <sum>
80103b5e:	84 c0                	test   %al,%al
80103b60:	75 05                	jne    80103b67 <mpsearch1+0x62>
      return (struct mp*)p;
80103b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b65:	eb 11                	jmp    80103b78 <mpsearch1+0x73>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103b67:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103b6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b6e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103b71:	72 b9                	jb     80103b2c <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103b73:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103b78:	c9                   	leave  
80103b79:	c3                   	ret    

80103b7a <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103b7a:	55                   	push   %ebp
80103b7b:	89 e5                	mov    %esp,%ebp
80103b7d:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103b80:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103b87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b8a:	83 c0 0f             	add    $0xf,%eax
80103b8d:	0f b6 00             	movzbl (%eax),%eax
80103b90:	0f b6 c0             	movzbl %al,%eax
80103b93:	89 c2                	mov    %eax,%edx
80103b95:	c1 e2 08             	shl    $0x8,%edx
80103b98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b9b:	83 c0 0e             	add    $0xe,%eax
80103b9e:	0f b6 00             	movzbl (%eax),%eax
80103ba1:	0f b6 c0             	movzbl %al,%eax
80103ba4:	09 d0                	or     %edx,%eax
80103ba6:	c1 e0 04             	shl    $0x4,%eax
80103ba9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bb0:	74 21                	je     80103bd3 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103bb2:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103bb9:	00 
80103bba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bbd:	89 04 24             	mov    %eax,(%esp)
80103bc0:	e8 40 ff ff ff       	call   80103b05 <mpsearch1>
80103bc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bc8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bcc:	74 50                	je     80103c1e <mpsearch+0xa4>
      return mp;
80103bce:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103bd1:	eb 5f                	jmp    80103c32 <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bd6:	83 c0 14             	add    $0x14,%eax
80103bd9:	0f b6 00             	movzbl (%eax),%eax
80103bdc:	0f b6 c0             	movzbl %al,%eax
80103bdf:	89 c2                	mov    %eax,%edx
80103be1:	c1 e2 08             	shl    $0x8,%edx
80103be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103be7:	83 c0 13             	add    $0x13,%eax
80103bea:	0f b6 00             	movzbl (%eax),%eax
80103bed:	0f b6 c0             	movzbl %al,%eax
80103bf0:	09 d0                	or     %edx,%eax
80103bf2:	c1 e0 0a             	shl    $0xa,%eax
80103bf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103bf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bfb:	2d 00 04 00 00       	sub    $0x400,%eax
80103c00:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103c07:	00 
80103c08:	89 04 24             	mov    %eax,(%esp)
80103c0b:	e8 f5 fe ff ff       	call   80103b05 <mpsearch1>
80103c10:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c13:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c17:	74 05                	je     80103c1e <mpsearch+0xa4>
      return mp;
80103c19:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c1c:	eb 14                	jmp    80103c32 <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
80103c1e:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80103c25:	00 
80103c26:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
80103c2d:	e8 d3 fe ff ff       	call   80103b05 <mpsearch1>
}
80103c32:	c9                   	leave  
80103c33:	c3                   	ret    

80103c34 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103c34:	55                   	push   %ebp
80103c35:	89 e5                	mov    %esp,%ebp
80103c37:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c3a:	e8 3b ff ff ff       	call   80103b7a <mpsearch>
80103c3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c46:	74 0a                	je     80103c52 <mpconfig+0x1e>
80103c48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c4b:	8b 40 04             	mov    0x4(%eax),%eax
80103c4e:	85 c0                	test   %eax,%eax
80103c50:	75 0a                	jne    80103c5c <mpconfig+0x28>
    return 0;
80103c52:	b8 00 00 00 00       	mov    $0x0,%eax
80103c57:	e9 83 00 00 00       	jmp    80103cdf <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c5f:	8b 40 04             	mov    0x4(%eax),%eax
80103c62:	89 04 24             	mov    %eax,(%esp)
80103c65:	e8 ee fd ff ff       	call   80103a58 <p2v>
80103c6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103c6d:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103c74:	00 
80103c75:	c7 44 24 04 a5 88 10 	movl   $0x801088a5,0x4(%esp)
80103c7c:	80 
80103c7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c80:	89 04 24             	mov    %eax,(%esp)
80103c83:	e8 f5 15 00 00       	call   8010527d <memcmp>
80103c88:	85 c0                	test   %eax,%eax
80103c8a:	74 07                	je     80103c93 <mpconfig+0x5f>
    return 0;
80103c8c:	b8 00 00 00 00       	mov    $0x0,%eax
80103c91:	eb 4c                	jmp    80103cdf <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
80103c93:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c96:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c9a:	3c 01                	cmp    $0x1,%al
80103c9c:	74 12                	je     80103cb0 <mpconfig+0x7c>
80103c9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ca1:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103ca5:	3c 04                	cmp    $0x4,%al
80103ca7:	74 07                	je     80103cb0 <mpconfig+0x7c>
    return 0;
80103ca9:	b8 00 00 00 00       	mov    $0x0,%eax
80103cae:	eb 2f                	jmp    80103cdf <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
80103cb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cb3:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103cb7:	0f b7 c0             	movzwl %ax,%eax
80103cba:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cc1:	89 04 24             	mov    %eax,(%esp)
80103cc4:	e8 04 fe ff ff       	call   80103acd <sum>
80103cc9:	84 c0                	test   %al,%al
80103ccb:	74 07                	je     80103cd4 <mpconfig+0xa0>
    return 0;
80103ccd:	b8 00 00 00 00       	mov    $0x0,%eax
80103cd2:	eb 0b                	jmp    80103cdf <mpconfig+0xab>
  *pmp = mp;
80103cd4:	8b 45 08             	mov    0x8(%ebp),%eax
80103cd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cda:	89 10                	mov    %edx,(%eax)
  return conf;
80103cdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103cdf:	c9                   	leave  
80103ce0:	c3                   	ret    

80103ce1 <mpinit>:

void
mpinit(void)
{
80103ce1:	55                   	push   %ebp
80103ce2:	89 e5                	mov    %esp,%ebp
80103ce4:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103ce7:	c7 05 44 b6 10 80 60 	movl   $0x80112360,0x8010b644
80103cee:	23 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103cf1:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103cf4:	89 04 24             	mov    %eax,(%esp)
80103cf7:	e8 38 ff ff ff       	call   80103c34 <mpconfig>
80103cfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103cff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d03:	0f 84 9c 01 00 00    	je     80103ea5 <mpinit+0x1c4>
    return;
  ismp = 1;
80103d09:	c7 05 44 23 11 80 01 	movl   $0x1,0x80112344
80103d10:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103d13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d16:	8b 40 24             	mov    0x24(%eax),%eax
80103d19:	a3 5c 22 11 80       	mov    %eax,0x8011225c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d21:	83 c0 2c             	add    $0x2c,%eax
80103d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d27:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d2a:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d2e:	0f b7 d0             	movzwl %ax,%edx
80103d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d34:	01 d0                	add    %edx,%eax
80103d36:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d39:	e9 f4 00 00 00       	jmp    80103e32 <mpinit+0x151>
    switch(*p){
80103d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d41:	0f b6 00             	movzbl (%eax),%eax
80103d44:	0f b6 c0             	movzbl %al,%eax
80103d47:	83 f8 04             	cmp    $0x4,%eax
80103d4a:	0f 87 bf 00 00 00    	ja     80103e0f <mpinit+0x12e>
80103d50:	8b 04 85 e8 88 10 80 	mov    -0x7fef7718(,%eax,4),%eax
80103d57:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103d5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d62:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d66:	0f b6 d0             	movzbl %al,%edx
80103d69:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d6e:	39 c2                	cmp    %eax,%edx
80103d70:	74 2d                	je     80103d9f <mpinit+0xbe>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103d72:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d75:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d79:	0f b6 d0             	movzbl %al,%edx
80103d7c:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d81:	89 54 24 08          	mov    %edx,0x8(%esp)
80103d85:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d89:	c7 04 24 aa 88 10 80 	movl   $0x801088aa,(%esp)
80103d90:	e8 15 c6 ff ff       	call   801003aa <cprintf>
        ismp = 0;
80103d95:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103d9c:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103d9f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103da2:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103da6:	0f b6 c0             	movzbl %al,%eax
80103da9:	83 e0 02             	and    $0x2,%eax
80103dac:	85 c0                	test   %eax,%eax
80103dae:	74 15                	je     80103dc5 <mpinit+0xe4>
        bcpu = &cpus[ncpu];
80103db0:	a1 40 29 11 80       	mov    0x80112940,%eax
80103db5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103dbb:	05 60 23 11 80       	add    $0x80112360,%eax
80103dc0:	a3 44 b6 10 80       	mov    %eax,0x8010b644
      cpus[ncpu].id = ncpu;
80103dc5:	8b 15 40 29 11 80    	mov    0x80112940,%edx
80103dcb:	a1 40 29 11 80       	mov    0x80112940,%eax
80103dd0:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103dd6:	81 c2 60 23 11 80    	add    $0x80112360,%edx
80103ddc:	88 02                	mov    %al,(%edx)
      ncpu++;
80103dde:	a1 40 29 11 80       	mov    0x80112940,%eax
80103de3:	83 c0 01             	add    $0x1,%eax
80103de6:	a3 40 29 11 80       	mov    %eax,0x80112940
      p += sizeof(struct mpproc);
80103deb:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103def:	eb 41                	jmp    80103e32 <mpinit+0x151>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103df1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103df7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103dfa:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103dfe:	a2 40 23 11 80       	mov    %al,0x80112340
      p += sizeof(struct mpioapic);
80103e03:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e07:	eb 29                	jmp    80103e32 <mpinit+0x151>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103e09:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e0d:	eb 23                	jmp    80103e32 <mpinit+0x151>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103e0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e12:	0f b6 00             	movzbl (%eax),%eax
80103e15:	0f b6 c0             	movzbl %al,%eax
80103e18:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e1c:	c7 04 24 c8 88 10 80 	movl   $0x801088c8,(%esp)
80103e23:	e8 82 c5 ff ff       	call   801003aa <cprintf>
      ismp = 0;
80103e28:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103e2f:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e35:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103e38:	0f 82 00 ff ff ff    	jb     80103d3e <mpinit+0x5d>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103e3e:	a1 44 23 11 80       	mov    0x80112344,%eax
80103e43:	85 c0                	test   %eax,%eax
80103e45:	75 1d                	jne    80103e64 <mpinit+0x183>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e47:	c7 05 40 29 11 80 01 	movl   $0x1,0x80112940
80103e4e:	00 00 00 
    lapic = 0;
80103e51:	c7 05 5c 22 11 80 00 	movl   $0x0,0x8011225c
80103e58:	00 00 00 
    ioapicid = 0;
80103e5b:	c6 05 40 23 11 80 00 	movb   $0x0,0x80112340
80103e62:	eb 41                	jmp    80103ea5 <mpinit+0x1c4>
    return;
  }

  if(mp->imcrp){
80103e64:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e67:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e6b:	84 c0                	test   %al,%al
80103e6d:	74 36                	je     80103ea5 <mpinit+0x1c4>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e6f:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
80103e76:	00 
80103e77:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
80103e7e:	e8 0c fc ff ff       	call   80103a8f <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103e83:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103e8a:	e8 d6 fb ff ff       	call   80103a65 <inb>
80103e8f:	83 c8 01             	or     $0x1,%eax
80103e92:	0f b6 c0             	movzbl %al,%eax
80103e95:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e99:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103ea0:	e8 ea fb ff ff       	call   80103a8f <outb>
  }
}
80103ea5:	c9                   	leave  
80103ea6:	c3                   	ret    
	...

80103ea8 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103ea8:	55                   	push   %ebp
80103ea9:	89 e5                	mov    %esp,%ebp
80103eab:	83 ec 08             	sub    $0x8,%esp
80103eae:	8b 55 08             	mov    0x8(%ebp),%edx
80103eb1:	8b 45 0c             	mov    0xc(%ebp),%eax
80103eb4:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103eb8:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ebb:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ebf:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ec3:	ee                   	out    %al,(%dx)
}
80103ec4:	c9                   	leave  
80103ec5:	c3                   	ret    

80103ec6 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103ec6:	55                   	push   %ebp
80103ec7:	89 e5                	mov    %esp,%ebp
80103ec9:	83 ec 0c             	sub    $0xc,%esp
80103ecc:	8b 45 08             	mov    0x8(%ebp),%eax
80103ecf:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103ed3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ed7:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103edd:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ee1:	0f b6 c0             	movzbl %al,%eax
80103ee4:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ee8:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103eef:	e8 b4 ff ff ff       	call   80103ea8 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103ef4:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ef8:	66 c1 e8 08          	shr    $0x8,%ax
80103efc:	0f b6 c0             	movzbl %al,%eax
80103eff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f03:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103f0a:	e8 99 ff ff ff       	call   80103ea8 <outb>
}
80103f0f:	c9                   	leave  
80103f10:	c3                   	ret    

80103f11 <picenable>:

void
picenable(int irq)
{
80103f11:	55                   	push   %ebp
80103f12:	89 e5                	mov    %esp,%ebp
80103f14:	53                   	push   %ebx
80103f15:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103f18:	8b 45 08             	mov    0x8(%ebp),%eax
80103f1b:	ba 01 00 00 00       	mov    $0x1,%edx
80103f20:	89 d3                	mov    %edx,%ebx
80103f22:	89 c1                	mov    %eax,%ecx
80103f24:	d3 e3                	shl    %cl,%ebx
80103f26:	89 d8                	mov    %ebx,%eax
80103f28:	89 c2                	mov    %eax,%edx
80103f2a:	f7 d2                	not    %edx
80103f2c:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f33:	21 d0                	and    %edx,%eax
80103f35:	0f b7 c0             	movzwl %ax,%eax
80103f38:	89 04 24             	mov    %eax,(%esp)
80103f3b:	e8 86 ff ff ff       	call   80103ec6 <picsetmask>
}
80103f40:	83 c4 04             	add    $0x4,%esp
80103f43:	5b                   	pop    %ebx
80103f44:	5d                   	pop    %ebp
80103f45:	c3                   	ret    

80103f46 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103f46:	55                   	push   %ebp
80103f47:	89 e5                	mov    %esp,%ebp
80103f49:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103f4c:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103f53:	00 
80103f54:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103f5b:	e8 48 ff ff ff       	call   80103ea8 <outb>
  outb(IO_PIC2+1, 0xFF);
80103f60:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103f67:	00 
80103f68:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103f6f:	e8 34 ff ff ff       	call   80103ea8 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103f74:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103f7b:	00 
80103f7c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103f83:	e8 20 ff ff ff       	call   80103ea8 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103f88:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80103f8f:	00 
80103f90:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103f97:	e8 0c ff ff ff       	call   80103ea8 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103f9c:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
80103fa3:	00 
80103fa4:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103fab:	e8 f8 fe ff ff       	call   80103ea8 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103fb0:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103fb7:	00 
80103fb8:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103fbf:	e8 e4 fe ff ff       	call   80103ea8 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103fc4:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103fcb:	00 
80103fcc:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103fd3:	e8 d0 fe ff ff       	call   80103ea8 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103fd8:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80103fdf:	00 
80103fe0:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103fe7:	e8 bc fe ff ff       	call   80103ea8 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103fec:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80103ff3:	00 
80103ff4:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103ffb:	e8 a8 fe ff ff       	call   80103ea8 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80104000:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80104007:	00 
80104008:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
8010400f:	e8 94 fe ff ff       	call   80103ea8 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80104014:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
8010401b:	00 
8010401c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80104023:	e8 80 fe ff ff       	call   80103ea8 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
80104028:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
8010402f:	00 
80104030:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80104037:	e8 6c fe ff ff       	call   80103ea8 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
8010403c:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80104043:	00 
80104044:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
8010404b:	e8 58 fe ff ff       	call   80103ea8 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80104050:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80104057:	00 
80104058:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
8010405f:	e8 44 fe ff ff       	call   80103ea8 <outb>

  if(irqmask != 0xFFFF)
80104064:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
8010406b:	66 83 f8 ff          	cmp    $0xffff,%ax
8010406f:	74 12                	je     80104083 <picinit+0x13d>
    picsetmask(irqmask);
80104071:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80104078:	0f b7 c0             	movzwl %ax,%eax
8010407b:	89 04 24             	mov    %eax,(%esp)
8010407e:	e8 43 fe ff ff       	call   80103ec6 <picsetmask>
}
80104083:	c9                   	leave  
80104084:	c3                   	ret    
80104085:	00 00                	add    %al,(%eax)
	...

80104088 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104088:	55                   	push   %ebp
80104089:	89 e5                	mov    %esp,%ebp
8010408b:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
8010408e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80104095:	8b 45 0c             	mov    0xc(%ebp),%eax
80104098:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010409e:	8b 45 0c             	mov    0xc(%ebp),%eax
801040a1:	8b 10                	mov    (%eax),%edx
801040a3:	8b 45 08             	mov    0x8(%ebp),%eax
801040a6:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801040a8:	e8 bf ce ff ff       	call   80100f6c <filealloc>
801040ad:	8b 55 08             	mov    0x8(%ebp),%edx
801040b0:	89 02                	mov    %eax,(%edx)
801040b2:	8b 45 08             	mov    0x8(%ebp),%eax
801040b5:	8b 00                	mov    (%eax),%eax
801040b7:	85 c0                	test   %eax,%eax
801040b9:	0f 84 c8 00 00 00    	je     80104187 <pipealloc+0xff>
801040bf:	e8 a8 ce ff ff       	call   80100f6c <filealloc>
801040c4:	8b 55 0c             	mov    0xc(%ebp),%edx
801040c7:	89 02                	mov    %eax,(%edx)
801040c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801040cc:	8b 00                	mov    (%eax),%eax
801040ce:	85 c0                	test   %eax,%eax
801040d0:	0f 84 b1 00 00 00    	je     80104187 <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801040d6:	e8 28 eb ff ff       	call   80102c03 <kalloc>
801040db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801040de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040e2:	0f 84 9e 00 00 00    	je     80104186 <pipealloc+0xfe>
    goto bad;
  p->readopen = 1;
801040e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040eb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801040f2:	00 00 00 
  p->writeopen = 1;
801040f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f8:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801040ff:	00 00 00 
  p->nwrite = 0;
80104102:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104105:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010410c:	00 00 00 
  p->nread = 0;
8010410f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104112:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104119:	00 00 00 
  initlock(&p->lock, "pipe");
8010411c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010411f:	c7 44 24 04 fc 88 10 	movl   $0x801088fc,0x4(%esp)
80104126:	80 
80104127:	89 04 24             	mov    %eax,(%esp)
8010412a:	e8 5b 0e 00 00       	call   80104f8a <initlock>
  (*f0)->type = FD_PIPE;
8010412f:	8b 45 08             	mov    0x8(%ebp),%eax
80104132:	8b 00                	mov    (%eax),%eax
80104134:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010413a:	8b 45 08             	mov    0x8(%ebp),%eax
8010413d:	8b 00                	mov    (%eax),%eax
8010413f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104143:	8b 45 08             	mov    0x8(%ebp),%eax
80104146:	8b 00                	mov    (%eax),%eax
80104148:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010414c:	8b 45 08             	mov    0x8(%ebp),%eax
8010414f:	8b 00                	mov    (%eax),%eax
80104151:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104154:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80104157:	8b 45 0c             	mov    0xc(%ebp),%eax
8010415a:	8b 00                	mov    (%eax),%eax
8010415c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104162:	8b 45 0c             	mov    0xc(%ebp),%eax
80104165:	8b 00                	mov    (%eax),%eax
80104167:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010416b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010416e:	8b 00                	mov    (%eax),%eax
80104170:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104174:	8b 45 0c             	mov    0xc(%ebp),%eax
80104177:	8b 00                	mov    (%eax),%eax
80104179:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010417c:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
8010417f:	b8 00 00 00 00       	mov    $0x0,%eax
80104184:	eb 43                	jmp    801041c9 <pipealloc+0x141>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80104186:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80104187:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010418b:	74 0b                	je     80104198 <pipealloc+0x110>
    kfree((char*)p);
8010418d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104190:	89 04 24             	mov    %eax,(%esp)
80104193:	e8 d2 e9 ff ff       	call   80102b6a <kfree>
  if(*f0)
80104198:	8b 45 08             	mov    0x8(%ebp),%eax
8010419b:	8b 00                	mov    (%eax),%eax
8010419d:	85 c0                	test   %eax,%eax
8010419f:	74 0d                	je     801041ae <pipealloc+0x126>
    fileclose(*f0);
801041a1:	8b 45 08             	mov    0x8(%ebp),%eax
801041a4:	8b 00                	mov    (%eax),%eax
801041a6:	89 04 24             	mov    %eax,(%esp)
801041a9:	e8 66 ce ff ff       	call   80101014 <fileclose>
  if(*f1)
801041ae:	8b 45 0c             	mov    0xc(%ebp),%eax
801041b1:	8b 00                	mov    (%eax),%eax
801041b3:	85 c0                	test   %eax,%eax
801041b5:	74 0d                	je     801041c4 <pipealloc+0x13c>
    fileclose(*f1);
801041b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801041ba:	8b 00                	mov    (%eax),%eax
801041bc:	89 04 24             	mov    %eax,(%esp)
801041bf:	e8 50 ce ff ff       	call   80101014 <fileclose>
  return -1;
801041c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041c9:	c9                   	leave  
801041ca:	c3                   	ret    

801041cb <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801041cb:	55                   	push   %ebp
801041cc:	89 e5                	mov    %esp,%ebp
801041ce:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
801041d1:	8b 45 08             	mov    0x8(%ebp),%eax
801041d4:	89 04 24             	mov    %eax,(%esp)
801041d7:	e8 cf 0d 00 00       	call   80104fab <acquire>
  if(writable){
801041dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801041e0:	74 1f                	je     80104201 <pipeclose+0x36>
    p->writeopen = 0;
801041e2:	8b 45 08             	mov    0x8(%ebp),%eax
801041e5:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801041ec:	00 00 00 
    wakeup(&p->nread);
801041ef:	8b 45 08             	mov    0x8(%ebp),%eax
801041f2:	05 34 02 00 00       	add    $0x234,%eax
801041f7:	89 04 24             	mov    %eax,(%esp)
801041fa:	e8 a7 0b 00 00       	call   80104da6 <wakeup>
801041ff:	eb 1d                	jmp    8010421e <pipeclose+0x53>
  } else {
    p->readopen = 0;
80104201:	8b 45 08             	mov    0x8(%ebp),%eax
80104204:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010420b:	00 00 00 
    wakeup(&p->nwrite);
8010420e:	8b 45 08             	mov    0x8(%ebp),%eax
80104211:	05 38 02 00 00       	add    $0x238,%eax
80104216:	89 04 24             	mov    %eax,(%esp)
80104219:	e8 88 0b 00 00       	call   80104da6 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010421e:	8b 45 08             	mov    0x8(%ebp),%eax
80104221:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104227:	85 c0                	test   %eax,%eax
80104229:	75 25                	jne    80104250 <pipeclose+0x85>
8010422b:	8b 45 08             	mov    0x8(%ebp),%eax
8010422e:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104234:	85 c0                	test   %eax,%eax
80104236:	75 18                	jne    80104250 <pipeclose+0x85>
    release(&p->lock);
80104238:	8b 45 08             	mov    0x8(%ebp),%eax
8010423b:	89 04 24             	mov    %eax,(%esp)
8010423e:	e8 ca 0d 00 00       	call   8010500d <release>
    kfree((char*)p);
80104243:	8b 45 08             	mov    0x8(%ebp),%eax
80104246:	89 04 24             	mov    %eax,(%esp)
80104249:	e8 1c e9 ff ff       	call   80102b6a <kfree>
8010424e:	eb 0b                	jmp    8010425b <pipeclose+0x90>
  } else
    release(&p->lock);
80104250:	8b 45 08             	mov    0x8(%ebp),%eax
80104253:	89 04 24             	mov    %eax,(%esp)
80104256:	e8 b2 0d 00 00       	call   8010500d <release>
}
8010425b:	c9                   	leave  
8010425c:	c3                   	ret    

8010425d <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010425d:	55                   	push   %ebp
8010425e:	89 e5                	mov    %esp,%ebp
80104260:	53                   	push   %ebx
80104261:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80104264:	8b 45 08             	mov    0x8(%ebp),%eax
80104267:	89 04 24             	mov    %eax,(%esp)
8010426a:	e8 3c 0d 00 00       	call   80104fab <acquire>
  for(i = 0; i < n; i++){
8010426f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104276:	e9 a8 00 00 00       	jmp    80104323 <pipewrite+0xc6>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
8010427b:	8b 45 08             	mov    0x8(%ebp),%eax
8010427e:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104284:	85 c0                	test   %eax,%eax
80104286:	74 0d                	je     80104295 <pipewrite+0x38>
80104288:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010428e:	8b 40 24             	mov    0x24(%eax),%eax
80104291:	85 c0                	test   %eax,%eax
80104293:	74 15                	je     801042aa <pipewrite+0x4d>
        release(&p->lock);
80104295:	8b 45 08             	mov    0x8(%ebp),%eax
80104298:	89 04 24             	mov    %eax,(%esp)
8010429b:	e8 6d 0d 00 00       	call   8010500d <release>
        return -1;
801042a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042a5:	e9 9f 00 00 00       	jmp    80104349 <pipewrite+0xec>
      }
      wakeup(&p->nread);
801042aa:	8b 45 08             	mov    0x8(%ebp),%eax
801042ad:	05 34 02 00 00       	add    $0x234,%eax
801042b2:	89 04 24             	mov    %eax,(%esp)
801042b5:	e8 ec 0a 00 00       	call   80104da6 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801042ba:	8b 45 08             	mov    0x8(%ebp),%eax
801042bd:	8b 55 08             	mov    0x8(%ebp),%edx
801042c0:	81 c2 38 02 00 00    	add    $0x238,%edx
801042c6:	89 44 24 04          	mov    %eax,0x4(%esp)
801042ca:	89 14 24             	mov    %edx,(%esp)
801042cd:	e8 fb 09 00 00       	call   80104ccd <sleep>
801042d2:	eb 01                	jmp    801042d5 <pipewrite+0x78>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042d4:	90                   	nop
801042d5:	8b 45 08             	mov    0x8(%ebp),%eax
801042d8:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801042de:	8b 45 08             	mov    0x8(%ebp),%eax
801042e1:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801042e7:	05 00 02 00 00       	add    $0x200,%eax
801042ec:	39 c2                	cmp    %eax,%edx
801042ee:	74 8b                	je     8010427b <pipewrite+0x1e>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801042f0:	8b 45 08             	mov    0x8(%ebp),%eax
801042f3:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042f9:	89 c3                	mov    %eax,%ebx
801042fb:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80104301:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104304:	8b 55 0c             	mov    0xc(%ebp),%edx
80104307:	01 ca                	add    %ecx,%edx
80104309:	0f b6 0a             	movzbl (%edx),%ecx
8010430c:	8b 55 08             	mov    0x8(%ebp),%edx
8010430f:	88 4c 1a 34          	mov    %cl,0x34(%edx,%ebx,1)
80104313:	8d 50 01             	lea    0x1(%eax),%edx
80104316:	8b 45 08             	mov    0x8(%ebp),%eax
80104319:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010431f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104323:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104326:	3b 45 10             	cmp    0x10(%ebp),%eax
80104329:	7c a9                	jl     801042d4 <pipewrite+0x77>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010432b:	8b 45 08             	mov    0x8(%ebp),%eax
8010432e:	05 34 02 00 00       	add    $0x234,%eax
80104333:	89 04 24             	mov    %eax,(%esp)
80104336:	e8 6b 0a 00 00       	call   80104da6 <wakeup>
  release(&p->lock);
8010433b:	8b 45 08             	mov    0x8(%ebp),%eax
8010433e:	89 04 24             	mov    %eax,(%esp)
80104341:	e8 c7 0c 00 00       	call   8010500d <release>
  return n;
80104346:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104349:	83 c4 24             	add    $0x24,%esp
8010434c:	5b                   	pop    %ebx
8010434d:	5d                   	pop    %ebp
8010434e:	c3                   	ret    

8010434f <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010434f:	55                   	push   %ebp
80104350:	89 e5                	mov    %esp,%ebp
80104352:	53                   	push   %ebx
80104353:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80104356:	8b 45 08             	mov    0x8(%ebp),%eax
80104359:	89 04 24             	mov    %eax,(%esp)
8010435c:	e8 4a 0c 00 00       	call   80104fab <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104361:	eb 3a                	jmp    8010439d <piperead+0x4e>
    if(proc->killed){
80104363:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104369:	8b 40 24             	mov    0x24(%eax),%eax
8010436c:	85 c0                	test   %eax,%eax
8010436e:	74 15                	je     80104385 <piperead+0x36>
      release(&p->lock);
80104370:	8b 45 08             	mov    0x8(%ebp),%eax
80104373:	89 04 24             	mov    %eax,(%esp)
80104376:	e8 92 0c 00 00       	call   8010500d <release>
      return -1;
8010437b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104380:	e9 b7 00 00 00       	jmp    8010443c <piperead+0xed>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104385:	8b 45 08             	mov    0x8(%ebp),%eax
80104388:	8b 55 08             	mov    0x8(%ebp),%edx
8010438b:	81 c2 34 02 00 00    	add    $0x234,%edx
80104391:	89 44 24 04          	mov    %eax,0x4(%esp)
80104395:	89 14 24             	mov    %edx,(%esp)
80104398:	e8 30 09 00 00       	call   80104ccd <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010439d:	8b 45 08             	mov    0x8(%ebp),%eax
801043a0:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801043a6:	8b 45 08             	mov    0x8(%ebp),%eax
801043a9:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043af:	39 c2                	cmp    %eax,%edx
801043b1:	75 0d                	jne    801043c0 <piperead+0x71>
801043b3:	8b 45 08             	mov    0x8(%ebp),%eax
801043b6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801043bc:	85 c0                	test   %eax,%eax
801043be:	75 a3                	jne    80104363 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801043c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801043c7:	eb 4a                	jmp    80104413 <piperead+0xc4>
    if(p->nread == p->nwrite)
801043c9:	8b 45 08             	mov    0x8(%ebp),%eax
801043cc:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801043d2:	8b 45 08             	mov    0x8(%ebp),%eax
801043d5:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043db:	39 c2                	cmp    %eax,%edx
801043dd:	74 3e                	je     8010441d <piperead+0xce>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801043df:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043e2:	8b 45 0c             	mov    0xc(%ebp),%eax
801043e5:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
801043e8:	8b 45 08             	mov    0x8(%ebp),%eax
801043eb:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801043f1:	89 c3                	mov    %eax,%ebx
801043f3:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801043f9:	8b 55 08             	mov    0x8(%ebp),%edx
801043fc:	0f b6 54 1a 34       	movzbl 0x34(%edx,%ebx,1),%edx
80104401:	88 11                	mov    %dl,(%ecx)
80104403:	8d 50 01             	lea    0x1(%eax),%edx
80104406:	8b 45 08             	mov    0x8(%ebp),%eax
80104409:	89 90 34 02 00 00    	mov    %edx,0x234(%eax)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010440f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104416:	3b 45 10             	cmp    0x10(%ebp),%eax
80104419:	7c ae                	jl     801043c9 <piperead+0x7a>
8010441b:	eb 01                	jmp    8010441e <piperead+0xcf>
    if(p->nread == p->nwrite)
      break;
8010441d:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010441e:	8b 45 08             	mov    0x8(%ebp),%eax
80104421:	05 38 02 00 00       	add    $0x238,%eax
80104426:	89 04 24             	mov    %eax,(%esp)
80104429:	e8 78 09 00 00       	call   80104da6 <wakeup>
  release(&p->lock);
8010442e:	8b 45 08             	mov    0x8(%ebp),%eax
80104431:	89 04 24             	mov    %eax,(%esp)
80104434:	e8 d4 0b 00 00       	call   8010500d <release>
  return i;
80104439:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010443c:	83 c4 24             	add    $0x24,%esp
8010443f:	5b                   	pop    %ebx
80104440:	5d                   	pop    %ebp
80104441:	c3                   	ret    
	...

80104444 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104444:	55                   	push   %ebp
80104445:	89 e5                	mov    %esp,%ebp
80104447:	53                   	push   %ebx
80104448:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010444b:	9c                   	pushf  
8010444c:	5b                   	pop    %ebx
8010444d:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80104450:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104453:	83 c4 10             	add    $0x10,%esp
80104456:	5b                   	pop    %ebx
80104457:	5d                   	pop    %ebp
80104458:	c3                   	ret    

80104459 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104459:	55                   	push   %ebp
8010445a:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010445c:	fb                   	sti    
}
8010445d:	5d                   	pop    %ebp
8010445e:	c3                   	ret    

8010445f <halt>:
  asm volatile("movl %0,%%cr3" : : "r" (val));
}

static inline void
halt()
{
8010445f:	55                   	push   %ebp
80104460:	89 e5                	mov    %esp,%ebp
  asm volatile("hlt" : :);
80104462:	f4                   	hlt    
}
80104463:	5d                   	pop    %ebp
80104464:	c3                   	ret    

80104465 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104465:	55                   	push   %ebp
80104466:	89 e5                	mov    %esp,%ebp
80104468:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
8010446b:	c7 44 24 04 01 89 10 	movl   $0x80108901,0x4(%esp)
80104472:	80 
80104473:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010447a:	e8 0b 0b 00 00       	call   80104f8a <initlock>
}
8010447f:	c9                   	leave  
80104480:	c3                   	ret    

80104481 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104481:	55                   	push   %ebp
80104482:	89 e5                	mov    %esp,%ebp
80104484:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104487:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010448e:	e8 18 0b 00 00       	call   80104fab <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104493:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
8010449a:	eb 0e                	jmp    801044aa <allocproc+0x29>
    if(p->state == UNUSED)
8010449c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449f:	8b 40 0c             	mov    0xc(%eax),%eax
801044a2:	85 c0                	test   %eax,%eax
801044a4:	74 23                	je     801044c9 <allocproc+0x48>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044a6:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801044aa:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
801044b1:	72 e9                	jb     8010449c <allocproc+0x1b>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
801044b3:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
801044ba:	e8 4e 0b 00 00       	call   8010500d <release>
  return 0;
801044bf:	b8 00 00 00 00       	mov    $0x0,%eax
801044c4:	e9 b5 00 00 00       	jmp    8010457e <allocproc+0xfd>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
801044c9:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801044ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044cd:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801044d4:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801044d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044dc:	89 42 10             	mov    %eax,0x10(%edx)
801044df:	83 c0 01             	add    $0x1,%eax
801044e2:	a3 04 b0 10 80       	mov    %eax,0x8010b004
  release(&ptable.lock);
801044e7:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
801044ee:	e8 1a 0b 00 00       	call   8010500d <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801044f3:	e8 0b e7 ff ff       	call   80102c03 <kalloc>
801044f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044fb:	89 42 08             	mov    %eax,0x8(%edx)
801044fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104501:	8b 40 08             	mov    0x8(%eax),%eax
80104504:	85 c0                	test   %eax,%eax
80104506:	75 11                	jne    80104519 <allocproc+0x98>
    p->state = UNUSED;
80104508:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104512:	b8 00 00 00 00       	mov    $0x0,%eax
80104517:	eb 65                	jmp    8010457e <allocproc+0xfd>
  }
  sp = p->kstack + KSTACKSIZE;
80104519:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010451c:	8b 40 08             	mov    0x8(%eax),%eax
8010451f:	05 00 10 00 00       	add    $0x1000,%eax
80104524:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104527:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
8010452b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104531:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104534:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80104538:	ba 38 66 10 80       	mov    $0x80106638,%edx
8010453d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104540:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104542:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104546:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104549:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010454c:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
8010454f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104552:	8b 40 1c             	mov    0x1c(%eax),%eax
80104555:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010455c:	00 
8010455d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104564:	00 
80104565:	89 04 24             	mov    %eax,(%esp)
80104568:	e8 99 0c 00 00       	call   80105206 <memset>
  p->context->eip = (uint)forkret;
8010456d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104570:	8b 40 1c             	mov    0x1c(%eax),%eax
80104573:	ba 8e 4c 10 80       	mov    $0x80104c8e,%edx
80104578:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
8010457b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010457e:	c9                   	leave  
8010457f:	c3                   	ret    

80104580 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104586:	e8 f6 fe ff ff       	call   80104481 <allocproc>
8010458b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
8010458e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104591:	a3 48 b6 10 80       	mov    %eax,0x8010b648
  if((p->pgdir = setupkvm()) == 0)
80104596:	e8 a8 37 00 00       	call   80107d43 <setupkvm>
8010459b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010459e:	89 42 04             	mov    %eax,0x4(%edx)
801045a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045a4:	8b 40 04             	mov    0x4(%eax),%eax
801045a7:	85 c0                	test   %eax,%eax
801045a9:	75 0c                	jne    801045b7 <userinit+0x37>
    panic("userinit: out of memory?");
801045ab:	c7 04 24 08 89 10 80 	movl   $0x80108908,(%esp)
801045b2:	e8 8f bf ff ff       	call   80100546 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801045b7:	ba 2c 00 00 00       	mov    $0x2c,%edx
801045bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045bf:	8b 40 04             	mov    0x4(%eax),%eax
801045c2:	89 54 24 08          	mov    %edx,0x8(%esp)
801045c6:	c7 44 24 04 e0 b4 10 	movl   $0x8010b4e0,0x4(%esp)
801045cd:	80 
801045ce:	89 04 24             	mov    %eax,(%esp)
801045d1:	e8 c5 39 00 00       	call   80107f9b <inituvm>
  p->sz = PGSIZE;
801045d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045d9:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
801045df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e2:	8b 40 18             	mov    0x18(%eax),%eax
801045e5:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801045ec:	00 
801045ed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801045f4:	00 
801045f5:	89 04 24             	mov    %eax,(%esp)
801045f8:	e8 09 0c 00 00       	call   80105206 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801045fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104600:	8b 40 18             	mov    0x18(%eax),%eax
80104603:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104609:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010460c:	8b 40 18             	mov    0x18(%eax),%eax
8010460f:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104615:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104618:	8b 40 18             	mov    0x18(%eax),%eax
8010461b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010461e:	8b 52 18             	mov    0x18(%edx),%edx
80104621:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104625:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104629:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010462c:	8b 40 18             	mov    0x18(%eax),%eax
8010462f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104632:	8b 52 18             	mov    0x18(%edx),%edx
80104635:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104639:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010463d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104640:	8b 40 18             	mov    0x18(%eax),%eax
80104643:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010464a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010464d:	8b 40 18             	mov    0x18(%eax),%eax
80104650:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104657:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010465a:	8b 40 18             	mov    0x18(%eax),%eax
8010465d:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104664:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104667:	83 c0 6c             	add    $0x6c,%eax
8010466a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104671:	00 
80104672:	c7 44 24 04 21 89 10 	movl   $0x80108921,0x4(%esp)
80104679:	80 
8010467a:	89 04 24             	mov    %eax,(%esp)
8010467d:	e8 b4 0d 00 00       	call   80105436 <safestrcpy>
  p->cwd = namei("/");
80104682:	c7 04 24 2a 89 10 80 	movl   $0x8010892a,(%esp)
80104689:	e8 4d de ff ff       	call   801024db <namei>
8010468e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104691:	89 42 68             	mov    %eax,0x68(%edx)

  p->state = RUNNABLE;
80104694:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104697:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
8010469e:	c9                   	leave  
8010469f:	c3                   	ret    

801046a0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	83 ec 28             	sub    $0x28,%esp
  uint sz;
  
  sz = proc->sz;
801046a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046ac:	8b 00                	mov    (%eax),%eax
801046ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801046b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801046b5:	7e 34                	jle    801046eb <growproc+0x4b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801046b7:	8b 55 08             	mov    0x8(%ebp),%edx
801046ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046bd:	01 c2                	add    %eax,%edx
801046bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046c5:	8b 40 04             	mov    0x4(%eax),%eax
801046c8:	89 54 24 08          	mov    %edx,0x8(%esp)
801046cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046cf:	89 54 24 04          	mov    %edx,0x4(%esp)
801046d3:	89 04 24             	mov    %eax,(%esp)
801046d6:	e8 3a 3a 00 00       	call   80108115 <allocuvm>
801046db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801046de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801046e2:	75 41                	jne    80104725 <growproc+0x85>
      return -1;
801046e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046e9:	eb 58                	jmp    80104743 <growproc+0xa3>
  } else if(n < 0){
801046eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801046ef:	79 34                	jns    80104725 <growproc+0x85>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801046f1:	8b 55 08             	mov    0x8(%ebp),%edx
801046f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046f7:	01 c2                	add    %eax,%edx
801046f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046ff:	8b 40 04             	mov    0x4(%eax),%eax
80104702:	89 54 24 08          	mov    %edx,0x8(%esp)
80104706:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104709:	89 54 24 04          	mov    %edx,0x4(%esp)
8010470d:	89 04 24             	mov    %eax,(%esp)
80104710:	e8 da 3a 00 00       	call   801081ef <deallocuvm>
80104715:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104718:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010471c:	75 07                	jne    80104725 <growproc+0x85>
      return -1;
8010471e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104723:	eb 1e                	jmp    80104743 <growproc+0xa3>
  }
  proc->sz = sz;
80104725:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010472e:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104730:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104736:	89 04 24             	mov    %eax,(%esp)
80104739:	e8 f6 36 00 00       	call   80107e34 <switchuvm>
  return 0;
8010473e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104743:	c9                   	leave  
80104744:	c3                   	ret    

80104745 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104745:	55                   	push   %ebp
80104746:	89 e5                	mov    %esp,%ebp
80104748:	57                   	push   %edi
80104749:	56                   	push   %esi
8010474a:	53                   	push   %ebx
8010474b:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
8010474e:	e8 2e fd ff ff       	call   80104481 <allocproc>
80104753:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104756:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010475a:	75 0a                	jne    80104766 <fork+0x21>
    return -1;
8010475c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104761:	e9 52 01 00 00       	jmp    801048b8 <fork+0x173>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104766:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010476c:	8b 10                	mov    (%eax),%edx
8010476e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104774:	8b 40 04             	mov    0x4(%eax),%eax
80104777:	89 54 24 04          	mov    %edx,0x4(%esp)
8010477b:	89 04 24             	mov    %eax,(%esp)
8010477e:	e8 08 3c 00 00       	call   8010838b <copyuvm>
80104783:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104786:	89 42 04             	mov    %eax,0x4(%edx)
80104789:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010478c:	8b 40 04             	mov    0x4(%eax),%eax
8010478f:	85 c0                	test   %eax,%eax
80104791:	75 2c                	jne    801047bf <fork+0x7a>
    kfree(np->kstack);
80104793:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104796:	8b 40 08             	mov    0x8(%eax),%eax
80104799:	89 04 24             	mov    %eax,(%esp)
8010479c:	e8 c9 e3 ff ff       	call   80102b6a <kfree>
    np->kstack = 0;
801047a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047a4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801047ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047ae:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801047b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047ba:	e9 f9 00 00 00       	jmp    801048b8 <fork+0x173>
  }
  np->sz = proc->sz;
801047bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047c5:	8b 10                	mov    (%eax),%edx
801047c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047ca:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
801047cc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047d6:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
801047d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047dc:	8b 50 18             	mov    0x18(%eax),%edx
801047df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047e5:	8b 40 18             	mov    0x18(%eax),%eax
801047e8:	89 c3                	mov    %eax,%ebx
801047ea:	b8 13 00 00 00       	mov    $0x13,%eax
801047ef:	89 d7                	mov    %edx,%edi
801047f1:	89 de                	mov    %ebx,%esi
801047f3:	89 c1                	mov    %eax,%ecx
801047f5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801047f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047fa:	8b 40 18             	mov    0x18(%eax),%eax
801047fd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104804:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010480b:	eb 3d                	jmp    8010484a <fork+0x105>
    if(proc->ofile[i])
8010480d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104813:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104816:	83 c2 08             	add    $0x8,%edx
80104819:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010481d:	85 c0                	test   %eax,%eax
8010481f:	74 25                	je     80104846 <fork+0x101>
      np->ofile[i] = filedup(proc->ofile[i]);
80104821:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104827:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010482a:	83 c2 08             	add    $0x8,%edx
8010482d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104831:	89 04 24             	mov    %eax,(%esp)
80104834:	e8 93 c7 ff ff       	call   80100fcc <filedup>
80104839:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010483c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010483f:	83 c1 08             	add    $0x8,%ecx
80104842:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104846:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010484a:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
8010484e:	7e bd                	jle    8010480d <fork+0xc8>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104850:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104856:	8b 40 68             	mov    0x68(%eax),%eax
80104859:	89 04 24             	mov    %eax,(%esp)
8010485c:	e8 91 d0 ff ff       	call   801018f2 <idup>
80104861:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104864:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104867:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010486d:	8d 50 6c             	lea    0x6c(%eax),%edx
80104870:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104873:	83 c0 6c             	add    $0x6c,%eax
80104876:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010487d:	00 
8010487e:	89 54 24 04          	mov    %edx,0x4(%esp)
80104882:	89 04 24             	mov    %eax,(%esp)
80104885:	e8 ac 0b 00 00       	call   80105436 <safestrcpy>
 
  pid = np->pid;
8010488a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010488d:	8b 40 10             	mov    0x10(%eax),%eax
80104890:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
80104893:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010489a:	e8 0c 07 00 00       	call   80104fab <acquire>
  np->state = RUNNABLE;
8010489f:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048a2:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
801048a9:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
801048b0:	e8 58 07 00 00       	call   8010500d <release>
  
  return pid;
801048b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801048b8:	83 c4 2c             	add    $0x2c,%esp
801048bb:	5b                   	pop    %ebx
801048bc:	5e                   	pop    %esi
801048bd:	5f                   	pop    %edi
801048be:	5d                   	pop    %ebp
801048bf:	c3                   	ret    

801048c0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
801048c6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801048cd:	a1 48 b6 10 80       	mov    0x8010b648,%eax
801048d2:	39 c2                	cmp    %eax,%edx
801048d4:	75 0c                	jne    801048e2 <exit+0x22>
    panic("init exiting");
801048d6:	c7 04 24 2c 89 10 80 	movl   $0x8010892c,(%esp)
801048dd:	e8 64 bc ff ff       	call   80100546 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801048e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801048e9:	eb 44                	jmp    8010492f <exit+0x6f>
    if(proc->ofile[fd]){
801048eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048f1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048f4:	83 c2 08             	add    $0x8,%edx
801048f7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801048fb:	85 c0                	test   %eax,%eax
801048fd:	74 2c                	je     8010492b <exit+0x6b>
      fileclose(proc->ofile[fd]);
801048ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104905:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104908:	83 c2 08             	add    $0x8,%edx
8010490b:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010490f:	89 04 24             	mov    %eax,(%esp)
80104912:	e8 fd c6 ff ff       	call   80101014 <fileclose>
      proc->ofile[fd] = 0;
80104917:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010491d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104920:	83 c2 08             	add    $0x8,%edx
80104923:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010492a:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010492b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010492f:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104933:	7e b6                	jle    801048eb <exit+0x2b>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80104935:	e8 1a ec ff ff       	call   80103554 <begin_op>
  iput(proc->cwd);
8010493a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104940:	8b 40 68             	mov    0x68(%eax),%eax
80104943:	89 04 24             	mov    %eax,(%esp)
80104946:	e8 92 d1 ff ff       	call   80101add <iput>
  end_op();
8010494b:	e8 85 ec ff ff       	call   801035d5 <end_op>
  proc->cwd = 0;
80104950:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104956:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
8010495d:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104964:	e8 42 06 00 00       	call   80104fab <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104969:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010496f:	8b 40 14             	mov    0x14(%eax),%eax
80104972:	89 04 24             	mov    %eax,(%esp)
80104975:	e8 ee 03 00 00       	call   80104d68 <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010497a:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104981:	eb 38                	jmp    801049bb <exit+0xfb>
    if(p->parent == proc){
80104983:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104986:	8b 50 14             	mov    0x14(%eax),%edx
80104989:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010498f:	39 c2                	cmp    %eax,%edx
80104991:	75 24                	jne    801049b7 <exit+0xf7>
      p->parent = initproc;
80104993:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
80104999:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010499c:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010499f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a2:	8b 40 0c             	mov    0xc(%eax),%eax
801049a5:	83 f8 05             	cmp    $0x5,%eax
801049a8:	75 0d                	jne    801049b7 <exit+0xf7>
        wakeup1(initproc);
801049aa:	a1 48 b6 10 80       	mov    0x8010b648,%eax
801049af:	89 04 24             	mov    %eax,(%esp)
801049b2:	e8 b1 03 00 00       	call   80104d68 <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049b7:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801049bb:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
801049c2:	72 bf                	jb     80104983 <exit+0xc3>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
801049c4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049ca:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
801049d1:	e8 d4 01 00 00       	call   80104baa <sched>
  panic("zombie exit");
801049d6:	c7 04 24 39 89 10 80 	movl   $0x80108939,(%esp)
801049dd:	e8 64 bb ff ff       	call   80100546 <panic>

801049e2 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801049e2:	55                   	push   %ebp
801049e3:	89 e5                	mov    %esp,%ebp
801049e5:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801049e8:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
801049ef:	e8 b7 05 00 00       	call   80104fab <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
801049f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049fb:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104a02:	e9 9a 00 00 00       	jmp    80104aa1 <wait+0xbf>
      if(p->parent != proc)
80104a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a0a:	8b 50 14             	mov    0x14(%eax),%edx
80104a0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a13:	39 c2                	cmp    %eax,%edx
80104a15:	0f 85 81 00 00 00    	jne    80104a9c <wait+0xba>
        continue;
      havekids = 1;
80104a1b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a25:	8b 40 0c             	mov    0xc(%eax),%eax
80104a28:	83 f8 05             	cmp    $0x5,%eax
80104a2b:	75 70                	jne    80104a9d <wait+0xbb>
        // Found one.
        pid = p->pid;
80104a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a30:	8b 40 10             	mov    0x10(%eax),%eax
80104a33:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a39:	8b 40 08             	mov    0x8(%eax),%eax
80104a3c:	89 04 24             	mov    %eax,(%esp)
80104a3f:	e8 26 e1 ff ff       	call   80102b6a <kfree>
        p->kstack = 0;
80104a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a47:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104a4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a51:	8b 40 04             	mov    0x4(%eax),%eax
80104a54:	89 04 24             	mov    %eax,(%esp)
80104a57:	e8 4f 38 00 00       	call   801082ab <freevm>
        p->state = UNUSED;
80104a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a5f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a69:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a73:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a7d:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a84:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104a8b:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104a92:	e8 76 05 00 00       	call   8010500d <release>
        return pid;
80104a97:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a9a:	eb 53                	jmp    80104aef <wait+0x10d>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104a9c:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a9d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104aa1:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104aa8:	0f 82 59 ff ff ff    	jb     80104a07 <wait+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104aae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104ab2:	74 0d                	je     80104ac1 <wait+0xdf>
80104ab4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aba:	8b 40 24             	mov    0x24(%eax),%eax
80104abd:	85 c0                	test   %eax,%eax
80104abf:	74 13                	je     80104ad4 <wait+0xf2>
      release(&ptable.lock);
80104ac1:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104ac8:	e8 40 05 00 00       	call   8010500d <release>
      return -1;
80104acd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad2:	eb 1b                	jmp    80104aef <wait+0x10d>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104ad4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ada:	c7 44 24 04 60 29 11 	movl   $0x80112960,0x4(%esp)
80104ae1:	80 
80104ae2:	89 04 24             	mov    %eax,(%esp)
80104ae5:	e8 e3 01 00 00       	call   80104ccd <sleep>
  }
80104aea:	e9 05 ff ff ff       	jmp    801049f4 <wait+0x12>
}
80104aef:	c9                   	leave  
80104af0:	c3                   	ret    

80104af1 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104af1:	55                   	push   %ebp
80104af2:	89 e5                	mov    %esp,%ebp
80104af4:	83 ec 28             	sub    $0x28,%esp
80104af7:	eb 01                	jmp    80104afa <scheduler+0x9>
    release(&ptable.lock);

    if (ran == 0) {
      halt();
    }
  }
80104af9:	90                   	nop
  struct proc *p;
  int ran;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104afa:	e8 5a f9 ff ff       	call   80104459 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104aff:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104b06:	e8 a0 04 00 00       	call   80104fab <acquire>
    for(ran = 0, p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b0b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104b12:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104b19:	eb 66                	jmp    80104b81 <scheduler+0x90>
      if(p->state != RUNNABLE)
80104b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b1e:	8b 40 0c             	mov    0xc(%eax),%eax
80104b21:	83 f8 03             	cmp    $0x3,%eax
80104b24:	75 56                	jne    80104b7c <scheduler+0x8b>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      ran = 1;
80104b26:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      proc = p;
80104b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b30:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b39:	89 04 24             	mov    %eax,(%esp)
80104b3c:	e8 f3 32 00 00       	call   80107e34 <switchuvm>
      p->state = RUNNING;
80104b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b44:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104b4b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b51:	8b 40 1c             	mov    0x1c(%eax),%eax
80104b54:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104b5b:	83 c2 04             	add    $0x4,%edx
80104b5e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b62:	89 14 24             	mov    %edx,(%esp)
80104b65:	e8 42 09 00 00       	call   801054ac <swtch>
      switchkvm();
80104b6a:	e8 a8 32 00 00       	call   80107e17 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104b6f:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104b76:	00 00 00 00 
80104b7a:	eb 01                	jmp    80104b7d <scheduler+0x8c>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(ran = 0, p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104b7c:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(ran = 0, p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b7d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104b81:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104b88:	72 91                	jb     80104b1b <scheduler+0x2a>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104b8a:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104b91:	e8 77 04 00 00       	call   8010500d <release>

    if (ran == 0) {
80104b96:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104b9a:	0f 85 59 ff ff ff    	jne    80104af9 <scheduler+0x8>
      halt();
80104ba0:	e8 ba f8 ff ff       	call   8010445f <halt>
    }
  }
80104ba5:	e9 4f ff ff ff       	jmp    80104af9 <scheduler+0x8>

80104baa <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104baa:	55                   	push   %ebp
80104bab:	89 e5                	mov    %esp,%ebp
80104bad:	83 ec 28             	sub    $0x28,%esp
  int intena;

  if(!holding(&ptable.lock))
80104bb0:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104bb7:	e8 19 05 00 00       	call   801050d5 <holding>
80104bbc:	85 c0                	test   %eax,%eax
80104bbe:	75 0c                	jne    80104bcc <sched+0x22>
    panic("sched ptable.lock");
80104bc0:	c7 04 24 45 89 10 80 	movl   $0x80108945,(%esp)
80104bc7:	e8 7a b9 ff ff       	call   80100546 <panic>
  if(cpu->ncli != 1)
80104bcc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bd2:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104bd8:	83 f8 01             	cmp    $0x1,%eax
80104bdb:	74 0c                	je     80104be9 <sched+0x3f>
    panic("sched locks");
80104bdd:	c7 04 24 57 89 10 80 	movl   $0x80108957,(%esp)
80104be4:	e8 5d b9 ff ff       	call   80100546 <panic>
  if(proc->state == RUNNING)
80104be9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bef:	8b 40 0c             	mov    0xc(%eax),%eax
80104bf2:	83 f8 04             	cmp    $0x4,%eax
80104bf5:	75 0c                	jne    80104c03 <sched+0x59>
    panic("sched running");
80104bf7:	c7 04 24 63 89 10 80 	movl   $0x80108963,(%esp)
80104bfe:	e8 43 b9 ff ff       	call   80100546 <panic>
  if(readeflags()&FL_IF)
80104c03:	e8 3c f8 ff ff       	call   80104444 <readeflags>
80104c08:	25 00 02 00 00       	and    $0x200,%eax
80104c0d:	85 c0                	test   %eax,%eax
80104c0f:	74 0c                	je     80104c1d <sched+0x73>
    panic("sched interruptible");
80104c11:	c7 04 24 71 89 10 80 	movl   $0x80108971,(%esp)
80104c18:	e8 29 b9 ff ff       	call   80100546 <panic>
  intena = cpu->intena;
80104c1d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c23:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104c29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104c2c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c32:	8b 40 04             	mov    0x4(%eax),%eax
80104c35:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c3c:	83 c2 1c             	add    $0x1c,%edx
80104c3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c43:	89 14 24             	mov    %edx,(%esp)
80104c46:	e8 61 08 00 00       	call   801054ac <swtch>
  cpu->intena = intena;
80104c4b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c51:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c54:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104c5a:	c9                   	leave  
80104c5b:	c3                   	ret    

80104c5c <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104c5c:	55                   	push   %ebp
80104c5d:	89 e5                	mov    %esp,%ebp
80104c5f:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104c62:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104c69:	e8 3d 03 00 00       	call   80104fab <acquire>
  proc->state = RUNNABLE;
80104c6e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c74:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104c7b:	e8 2a ff ff ff       	call   80104baa <sched>
  release(&ptable.lock);
80104c80:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104c87:	e8 81 03 00 00       	call   8010500d <release>
}
80104c8c:	c9                   	leave  
80104c8d:	c3                   	ret    

80104c8e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104c8e:	55                   	push   %ebp
80104c8f:	89 e5                	mov    %esp,%ebp
80104c91:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104c94:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104c9b:	e8 6d 03 00 00       	call   8010500d <release>

  if (first) {
80104ca0:	a1 20 b0 10 80       	mov    0x8010b020,%eax
80104ca5:	85 c0                	test   %eax,%eax
80104ca7:	74 22                	je     80104ccb <forkret+0x3d>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104ca9:	c7 05 20 b0 10 80 00 	movl   $0x0,0x8010b020
80104cb0:	00 00 00 
    iinit(ROOTDEV);
80104cb3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104cba:	e8 3a c9 ff ff       	call   801015f9 <iinit>
    initlog(ROOTDEV);
80104cbf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104cc6:	e8 85 e6 ff ff       	call   80103350 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104ccb:	c9                   	leave  
80104ccc:	c3                   	ret    

80104ccd <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104ccd:	55                   	push   %ebp
80104cce:	89 e5                	mov    %esp,%ebp
80104cd0:	83 ec 18             	sub    $0x18,%esp
  if(proc == 0)
80104cd3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cd9:	85 c0                	test   %eax,%eax
80104cdb:	75 0c                	jne    80104ce9 <sleep+0x1c>
    panic("sleep");
80104cdd:	c7 04 24 85 89 10 80 	movl   $0x80108985,(%esp)
80104ce4:	e8 5d b8 ff ff       	call   80100546 <panic>

  if(lk == 0)
80104ce9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104ced:	75 0c                	jne    80104cfb <sleep+0x2e>
    panic("sleep without lk");
80104cef:	c7 04 24 8b 89 10 80 	movl   $0x8010898b,(%esp)
80104cf6:	e8 4b b8 ff ff       	call   80100546 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104cfb:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104d02:	74 17                	je     80104d1b <sleep+0x4e>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104d04:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104d0b:	e8 9b 02 00 00       	call   80104fab <acquire>
    release(lk);
80104d10:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d13:	89 04 24             	mov    %eax,(%esp)
80104d16:	e8 f2 02 00 00       	call   8010500d <release>
  }

  // Go to sleep.
  proc->chan = chan;
80104d1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d21:	8b 55 08             	mov    0x8(%ebp),%edx
80104d24:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104d27:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d2d:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104d34:	e8 71 fe ff ff       	call   80104baa <sched>

  // Tidy up.
  proc->chan = 0;
80104d39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d3f:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104d46:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104d4d:	74 17                	je     80104d66 <sleep+0x99>
    release(&ptable.lock);
80104d4f:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104d56:	e8 b2 02 00 00       	call   8010500d <release>
    acquire(lk);
80104d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d5e:	89 04 24             	mov    %eax,(%esp)
80104d61:	e8 45 02 00 00       	call   80104fab <acquire>
  }
}
80104d66:	c9                   	leave  
80104d67:	c3                   	ret    

80104d68 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104d68:	55                   	push   %ebp
80104d69:	89 e5                	mov    %esp,%ebp
80104d6b:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d6e:	c7 45 fc 94 29 11 80 	movl   $0x80112994,-0x4(%ebp)
80104d75:	eb 24                	jmp    80104d9b <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104d77:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d7a:	8b 40 0c             	mov    0xc(%eax),%eax
80104d7d:	83 f8 02             	cmp    $0x2,%eax
80104d80:	75 15                	jne    80104d97 <wakeup1+0x2f>
80104d82:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d85:	8b 40 20             	mov    0x20(%eax),%eax
80104d88:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d8b:	75 0a                	jne    80104d97 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104d8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d90:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d97:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104d9b:	81 7d fc 94 48 11 80 	cmpl   $0x80114894,-0x4(%ebp)
80104da2:	72 d3                	jb     80104d77 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104da4:	c9                   	leave  
80104da5:	c3                   	ret    

80104da6 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104da6:	55                   	push   %ebp
80104da7:	89 e5                	mov    %esp,%ebp
80104da9:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80104dac:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104db3:	e8 f3 01 00 00       	call   80104fab <acquire>
  wakeup1(chan);
80104db8:	8b 45 08             	mov    0x8(%ebp),%eax
80104dbb:	89 04 24             	mov    %eax,(%esp)
80104dbe:	e8 a5 ff ff ff       	call   80104d68 <wakeup1>
  release(&ptable.lock);
80104dc3:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104dca:	e8 3e 02 00 00       	call   8010500d <release>
}
80104dcf:	c9                   	leave  
80104dd0:	c3                   	ret    

80104dd1 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104dd1:	55                   	push   %ebp
80104dd2:	89 e5                	mov    %esp,%ebp
80104dd4:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104dd7:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104dde:	e8 c8 01 00 00       	call   80104fab <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104de3:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104dea:	eb 41                	jmp    80104e2d <kill+0x5c>
    if(p->pid == pid){
80104dec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104def:	8b 40 10             	mov    0x10(%eax),%eax
80104df2:	3b 45 08             	cmp    0x8(%ebp),%eax
80104df5:	75 32                	jne    80104e29 <kill+0x58>
      p->killed = 1;
80104df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dfa:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e04:	8b 40 0c             	mov    0xc(%eax),%eax
80104e07:	83 f8 02             	cmp    $0x2,%eax
80104e0a:	75 0a                	jne    80104e16 <kill+0x45>
        p->state = RUNNABLE;
80104e0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e0f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104e16:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104e1d:	e8 eb 01 00 00       	call   8010500d <release>
      return 0;
80104e22:	b8 00 00 00 00       	mov    $0x0,%eax
80104e27:	eb 1e                	jmp    80104e47 <kill+0x76>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e29:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104e2d:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104e34:	72 b6                	jb     80104dec <kill+0x1b>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104e36:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104e3d:	e8 cb 01 00 00       	call   8010500d <release>
  return -1;
80104e42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e47:	c9                   	leave  
80104e48:	c3                   	ret    

80104e49 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104e49:	55                   	push   %ebp
80104e4a:	89 e5                	mov    %esp,%ebp
80104e4c:	83 ec 58             	sub    $0x58,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e4f:	c7 45 f0 94 29 11 80 	movl   $0x80112994,-0x10(%ebp)
80104e56:	e9 d8 00 00 00       	jmp    80104f33 <procdump+0xea>
    if(p->state == UNUSED)
80104e5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e5e:	8b 40 0c             	mov    0xc(%eax),%eax
80104e61:	85 c0                	test   %eax,%eax
80104e63:	0f 84 c5 00 00 00    	je     80104f2e <procdump+0xe5>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e6c:	8b 40 0c             	mov    0xc(%eax),%eax
80104e6f:	83 f8 05             	cmp    $0x5,%eax
80104e72:	77 23                	ja     80104e97 <procdump+0x4e>
80104e74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e77:	8b 40 0c             	mov    0xc(%eax),%eax
80104e7a:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104e81:	85 c0                	test   %eax,%eax
80104e83:	74 12                	je     80104e97 <procdump+0x4e>
      state = states[p->state];
80104e85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e88:	8b 40 0c             	mov    0xc(%eax),%eax
80104e8b:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104e92:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104e95:	eb 07                	jmp    80104e9e <procdump+0x55>
    else
      state = "???";
80104e97:	c7 45 ec 9c 89 10 80 	movl   $0x8010899c,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104e9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ea1:	8d 50 6c             	lea    0x6c(%eax),%edx
80104ea4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ea7:	8b 40 10             	mov    0x10(%eax),%eax
80104eaa:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104eae:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104eb1:	89 54 24 08          	mov    %edx,0x8(%esp)
80104eb5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104eb9:	c7 04 24 a0 89 10 80 	movl   $0x801089a0,(%esp)
80104ec0:	e8 e5 b4 ff ff       	call   801003aa <cprintf>
    if(p->state == SLEEPING){
80104ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ec8:	8b 40 0c             	mov    0xc(%eax),%eax
80104ecb:	83 f8 02             	cmp    $0x2,%eax
80104ece:	75 50                	jne    80104f20 <procdump+0xd7>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ed0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ed3:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ed6:	8b 40 0c             	mov    0xc(%eax),%eax
80104ed9:	83 c0 08             	add    $0x8,%eax
80104edc:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104edf:	89 54 24 04          	mov    %edx,0x4(%esp)
80104ee3:	89 04 24             	mov    %eax,(%esp)
80104ee6:	e8 71 01 00 00       	call   8010505c <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104eeb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104ef2:	eb 1b                	jmp    80104f0f <procdump+0xc6>
        cprintf(" %p", pc[i]);
80104ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ef7:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104efb:	89 44 24 04          	mov    %eax,0x4(%esp)
80104eff:	c7 04 24 a9 89 10 80 	movl   $0x801089a9,(%esp)
80104f06:	e8 9f b4 ff ff       	call   801003aa <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104f0b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104f0f:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104f13:	7f 0b                	jg     80104f20 <procdump+0xd7>
80104f15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f18:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f1c:	85 c0                	test   %eax,%eax
80104f1e:	75 d4                	jne    80104ef4 <procdump+0xab>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104f20:	c7 04 24 ad 89 10 80 	movl   $0x801089ad,(%esp)
80104f27:	e8 7e b4 ff ff       	call   801003aa <cprintf>
80104f2c:	eb 01                	jmp    80104f2f <procdump+0xe6>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104f2e:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f2f:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104f33:	81 7d f0 94 48 11 80 	cmpl   $0x80114894,-0x10(%ebp)
80104f3a:	0f 82 1b ff ff ff    	jb     80104e5b <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104f40:	c9                   	leave  
80104f41:	c3                   	ret    
	...

80104f44 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104f44:	55                   	push   %ebp
80104f45:	89 e5                	mov    %esp,%ebp
80104f47:	53                   	push   %ebx
80104f48:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104f4b:	9c                   	pushf  
80104f4c:	5b                   	pop    %ebx
80104f4d:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80104f50:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104f53:	83 c4 10             	add    $0x10,%esp
80104f56:	5b                   	pop    %ebx
80104f57:	5d                   	pop    %ebp
80104f58:	c3                   	ret    

80104f59 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104f59:	55                   	push   %ebp
80104f5a:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104f5c:	fa                   	cli    
}
80104f5d:	5d                   	pop    %ebp
80104f5e:	c3                   	ret    

80104f5f <sti>:

static inline void
sti(void)
{
80104f5f:	55                   	push   %ebp
80104f60:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104f62:	fb                   	sti    
}
80104f63:	5d                   	pop    %ebp
80104f64:	c3                   	ret    

80104f65 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104f65:	55                   	push   %ebp
80104f66:	89 e5                	mov    %esp,%ebp
80104f68:	53                   	push   %ebx
80104f69:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
80104f6c:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
80104f72:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104f75:	89 c3                	mov    %eax,%ebx
80104f77:	89 d8                	mov    %ebx,%eax
80104f79:	f0 87 02             	lock xchg %eax,(%edx)
80104f7c:	89 c3                	mov    %eax,%ebx
80104f7e:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104f81:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104f84:	83 c4 10             	add    $0x10,%esp
80104f87:	5b                   	pop    %ebx
80104f88:	5d                   	pop    %ebp
80104f89:	c3                   	ret    

80104f8a <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f8a:	55                   	push   %ebp
80104f8b:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80104f90:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f93:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104f96:	8b 45 08             	mov    0x8(%ebp),%eax
80104f99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104f9f:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104fa9:	5d                   	pop    %ebp
80104faa:	c3                   	ret    

80104fab <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104fab:	55                   	push   %ebp
80104fac:	89 e5                	mov    %esp,%ebp
80104fae:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104fb1:	e8 49 01 00 00       	call   801050ff <pushcli>
  if(holding(lk))
80104fb6:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb9:	89 04 24             	mov    %eax,(%esp)
80104fbc:	e8 14 01 00 00       	call   801050d5 <holding>
80104fc1:	85 c0                	test   %eax,%eax
80104fc3:	74 0c                	je     80104fd1 <acquire+0x26>
    panic("acquire");
80104fc5:	c7 04 24 d9 89 10 80 	movl   $0x801089d9,(%esp)
80104fcc:	e8 75 b5 ff ff       	call   80100546 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104fd1:	90                   	nop
80104fd2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fd5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80104fdc:	00 
80104fdd:	89 04 24             	mov    %eax,(%esp)
80104fe0:	e8 80 ff ff ff       	call   80104f65 <xchg>
80104fe5:	85 c0                	test   %eax,%eax
80104fe7:	75 e9                	jne    80104fd2 <acquire+0x27>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104fe9:	8b 45 08             	mov    0x8(%ebp),%eax
80104fec:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104ff3:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104ff6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ff9:	83 c0 0c             	add    $0xc,%eax
80104ffc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105000:	8d 45 08             	lea    0x8(%ebp),%eax
80105003:	89 04 24             	mov    %eax,(%esp)
80105006:	e8 51 00 00 00       	call   8010505c <getcallerpcs>
}
8010500b:	c9                   	leave  
8010500c:	c3                   	ret    

8010500d <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
8010500d:	55                   	push   %ebp
8010500e:	89 e5                	mov    %esp,%ebp
80105010:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80105013:	8b 45 08             	mov    0x8(%ebp),%eax
80105016:	89 04 24             	mov    %eax,(%esp)
80105019:	e8 b7 00 00 00       	call   801050d5 <holding>
8010501e:	85 c0                	test   %eax,%eax
80105020:	75 0c                	jne    8010502e <release+0x21>
    panic("release");
80105022:	c7 04 24 e1 89 10 80 	movl   $0x801089e1,(%esp)
80105029:	e8 18 b5 ff ff       	call   80100546 <panic>

  lk->pcs[0] = 0;
8010502e:	8b 45 08             	mov    0x8(%ebp),%eax
80105031:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105038:	8b 45 08             	mov    0x8(%ebp),%eax
8010503b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80105042:	8b 45 08             	mov    0x8(%ebp),%eax
80105045:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010504c:	00 
8010504d:	89 04 24             	mov    %eax,(%esp)
80105050:	e8 10 ff ff ff       	call   80104f65 <xchg>

  popcli();
80105055:	e8 ed 00 00 00       	call   80105147 <popcli>
}
8010505a:	c9                   	leave  
8010505b:	c3                   	ret    

8010505c <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
8010505c:	55                   	push   %ebp
8010505d:	89 e5                	mov    %esp,%ebp
8010505f:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80105062:	8b 45 08             	mov    0x8(%ebp),%eax
80105065:	83 e8 08             	sub    $0x8,%eax
80105068:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
8010506b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105072:	eb 38                	jmp    801050ac <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105074:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80105078:	74 53                	je     801050cd <getcallerpcs+0x71>
8010507a:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105081:	76 4a                	jbe    801050cd <getcallerpcs+0x71>
80105083:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80105087:	74 44                	je     801050cd <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105089:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010508c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105093:	8b 45 0c             	mov    0xc(%ebp),%eax
80105096:	01 c2                	add    %eax,%edx
80105098:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010509b:	8b 40 04             	mov    0x4(%eax),%eax
8010509e:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801050a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050a3:	8b 00                	mov    (%eax),%eax
801050a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050a8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801050ac:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801050b0:	7e c2                	jle    80105074 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801050b2:	eb 19                	jmp    801050cd <getcallerpcs+0x71>
    pcs[i] = 0;
801050b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801050be:	8b 45 0c             	mov    0xc(%ebp),%eax
801050c1:	01 d0                	add    %edx,%eax
801050c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801050c9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801050cd:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801050d1:	7e e1                	jle    801050b4 <getcallerpcs+0x58>
    pcs[i] = 0;
}
801050d3:	c9                   	leave  
801050d4:	c3                   	ret    

801050d5 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801050d5:	55                   	push   %ebp
801050d6:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
801050d8:	8b 45 08             	mov    0x8(%ebp),%eax
801050db:	8b 00                	mov    (%eax),%eax
801050dd:	85 c0                	test   %eax,%eax
801050df:	74 17                	je     801050f8 <holding+0x23>
801050e1:	8b 45 08             	mov    0x8(%ebp),%eax
801050e4:	8b 50 08             	mov    0x8(%eax),%edx
801050e7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050ed:	39 c2                	cmp    %eax,%edx
801050ef:	75 07                	jne    801050f8 <holding+0x23>
801050f1:	b8 01 00 00 00       	mov    $0x1,%eax
801050f6:	eb 05                	jmp    801050fd <holding+0x28>
801050f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801050fd:	5d                   	pop    %ebp
801050fe:	c3                   	ret    

801050ff <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801050ff:	55                   	push   %ebp
80105100:	89 e5                	mov    %esp,%ebp
80105102:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80105105:	e8 3a fe ff ff       	call   80104f44 <readeflags>
8010510a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
8010510d:	e8 47 fe ff ff       	call   80104f59 <cli>
  if(cpu->ncli++ == 0)
80105112:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105118:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010511e:	85 d2                	test   %edx,%edx
80105120:	0f 94 c1             	sete   %cl
80105123:	83 c2 01             	add    $0x1,%edx
80105126:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
8010512c:	84 c9                	test   %cl,%cl
8010512e:	74 15                	je     80105145 <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
80105130:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105136:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105139:	81 e2 00 02 00 00    	and    $0x200,%edx
8010513f:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105145:	c9                   	leave  
80105146:	c3                   	ret    

80105147 <popcli>:

void
popcli(void)
{
80105147:	55                   	push   %ebp
80105148:	89 e5                	mov    %esp,%ebp
8010514a:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
8010514d:	e8 f2 fd ff ff       	call   80104f44 <readeflags>
80105152:	25 00 02 00 00       	and    $0x200,%eax
80105157:	85 c0                	test   %eax,%eax
80105159:	74 0c                	je     80105167 <popcli+0x20>
    panic("popcli - interruptible");
8010515b:	c7 04 24 e9 89 10 80 	movl   $0x801089e9,(%esp)
80105162:	e8 df b3 ff ff       	call   80100546 <panic>
  if(--cpu->ncli < 0)
80105167:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010516d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105173:	83 ea 01             	sub    $0x1,%edx
80105176:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
8010517c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105182:	85 c0                	test   %eax,%eax
80105184:	79 0c                	jns    80105192 <popcli+0x4b>
    panic("popcli");
80105186:	c7 04 24 00 8a 10 80 	movl   $0x80108a00,(%esp)
8010518d:	e8 b4 b3 ff ff       	call   80100546 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105192:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105198:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010519e:	85 c0                	test   %eax,%eax
801051a0:	75 15                	jne    801051b7 <popcli+0x70>
801051a2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051a8:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801051ae:	85 c0                	test   %eax,%eax
801051b0:	74 05                	je     801051b7 <popcli+0x70>
    sti();
801051b2:	e8 a8 fd ff ff       	call   80104f5f <sti>
}
801051b7:	c9                   	leave  
801051b8:	c3                   	ret    
801051b9:	00 00                	add    %al,(%eax)
	...

801051bc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
801051bc:	55                   	push   %ebp
801051bd:	89 e5                	mov    %esp,%ebp
801051bf:	57                   	push   %edi
801051c0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
801051c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051c4:	8b 55 10             	mov    0x10(%ebp),%edx
801051c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ca:	89 cb                	mov    %ecx,%ebx
801051cc:	89 df                	mov    %ebx,%edi
801051ce:	89 d1                	mov    %edx,%ecx
801051d0:	fc                   	cld    
801051d1:	f3 aa                	rep stos %al,%es:(%edi)
801051d3:	89 ca                	mov    %ecx,%edx
801051d5:	89 fb                	mov    %edi,%ebx
801051d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
801051da:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801051dd:	5b                   	pop    %ebx
801051de:	5f                   	pop    %edi
801051df:	5d                   	pop    %ebp
801051e0:	c3                   	ret    

801051e1 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
801051e1:	55                   	push   %ebp
801051e2:	89 e5                	mov    %esp,%ebp
801051e4:	57                   	push   %edi
801051e5:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
801051e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051e9:	8b 55 10             	mov    0x10(%ebp),%edx
801051ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ef:	89 cb                	mov    %ecx,%ebx
801051f1:	89 df                	mov    %ebx,%edi
801051f3:	89 d1                	mov    %edx,%ecx
801051f5:	fc                   	cld    
801051f6:	f3 ab                	rep stos %eax,%es:(%edi)
801051f8:	89 ca                	mov    %ecx,%edx
801051fa:	89 fb                	mov    %edi,%ebx
801051fc:	89 5d 08             	mov    %ebx,0x8(%ebp)
801051ff:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105202:	5b                   	pop    %ebx
80105203:	5f                   	pop    %edi
80105204:	5d                   	pop    %ebp
80105205:	c3                   	ret    

80105206 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105206:	55                   	push   %ebp
80105207:	89 e5                	mov    %esp,%ebp
80105209:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
8010520c:	8b 45 08             	mov    0x8(%ebp),%eax
8010520f:	83 e0 03             	and    $0x3,%eax
80105212:	85 c0                	test   %eax,%eax
80105214:	75 49                	jne    8010525f <memset+0x59>
80105216:	8b 45 10             	mov    0x10(%ebp),%eax
80105219:	83 e0 03             	and    $0x3,%eax
8010521c:	85 c0                	test   %eax,%eax
8010521e:	75 3f                	jne    8010525f <memset+0x59>
    c &= 0xFF;
80105220:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105227:	8b 45 10             	mov    0x10(%ebp),%eax
8010522a:	c1 e8 02             	shr    $0x2,%eax
8010522d:	89 c2                	mov    %eax,%edx
8010522f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105232:	89 c1                	mov    %eax,%ecx
80105234:	c1 e1 18             	shl    $0x18,%ecx
80105237:	8b 45 0c             	mov    0xc(%ebp),%eax
8010523a:	c1 e0 10             	shl    $0x10,%eax
8010523d:	09 c1                	or     %eax,%ecx
8010523f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105242:	c1 e0 08             	shl    $0x8,%eax
80105245:	09 c8                	or     %ecx,%eax
80105247:	0b 45 0c             	or     0xc(%ebp),%eax
8010524a:	89 54 24 08          	mov    %edx,0x8(%esp)
8010524e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105252:	8b 45 08             	mov    0x8(%ebp),%eax
80105255:	89 04 24             	mov    %eax,(%esp)
80105258:	e8 84 ff ff ff       	call   801051e1 <stosl>
8010525d:	eb 19                	jmp    80105278 <memset+0x72>
  } else
    stosb(dst, c, n);
8010525f:	8b 45 10             	mov    0x10(%ebp),%eax
80105262:	89 44 24 08          	mov    %eax,0x8(%esp)
80105266:	8b 45 0c             	mov    0xc(%ebp),%eax
80105269:	89 44 24 04          	mov    %eax,0x4(%esp)
8010526d:	8b 45 08             	mov    0x8(%ebp),%eax
80105270:	89 04 24             	mov    %eax,(%esp)
80105273:	e8 44 ff ff ff       	call   801051bc <stosb>
  return dst;
80105278:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010527b:	c9                   	leave  
8010527c:	c3                   	ret    

8010527d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010527d:	55                   	push   %ebp
8010527e:	89 e5                	mov    %esp,%ebp
80105280:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80105283:	8b 45 08             	mov    0x8(%ebp),%eax
80105286:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105289:	8b 45 0c             	mov    0xc(%ebp),%eax
8010528c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010528f:	eb 32                	jmp    801052c3 <memcmp+0x46>
    if(*s1 != *s2)
80105291:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105294:	0f b6 10             	movzbl (%eax),%edx
80105297:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010529a:	0f b6 00             	movzbl (%eax),%eax
8010529d:	38 c2                	cmp    %al,%dl
8010529f:	74 1a                	je     801052bb <memcmp+0x3e>
      return *s1 - *s2;
801052a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052a4:	0f b6 00             	movzbl (%eax),%eax
801052a7:	0f b6 d0             	movzbl %al,%edx
801052aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052ad:	0f b6 00             	movzbl (%eax),%eax
801052b0:	0f b6 c0             	movzbl %al,%eax
801052b3:	89 d1                	mov    %edx,%ecx
801052b5:	29 c1                	sub    %eax,%ecx
801052b7:	89 c8                	mov    %ecx,%eax
801052b9:	eb 1c                	jmp    801052d7 <memcmp+0x5a>
    s1++, s2++;
801052bb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801052bf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801052c3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052c7:	0f 95 c0             	setne  %al
801052ca:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052ce:	84 c0                	test   %al,%al
801052d0:	75 bf                	jne    80105291 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801052d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801052d7:	c9                   	leave  
801052d8:	c3                   	ret    

801052d9 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801052d9:	55                   	push   %ebp
801052da:	89 e5                	mov    %esp,%ebp
801052dc:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801052df:	8b 45 0c             	mov    0xc(%ebp),%eax
801052e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801052e5:	8b 45 08             	mov    0x8(%ebp),%eax
801052e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
801052eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801052f1:	73 54                	jae    80105347 <memmove+0x6e>
801052f3:	8b 45 10             	mov    0x10(%ebp),%eax
801052f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052f9:	01 d0                	add    %edx,%eax
801052fb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801052fe:	76 47                	jbe    80105347 <memmove+0x6e>
    s += n;
80105300:	8b 45 10             	mov    0x10(%ebp),%eax
80105303:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105306:	8b 45 10             	mov    0x10(%ebp),%eax
80105309:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
8010530c:	eb 13                	jmp    80105321 <memmove+0x48>
      *--d = *--s;
8010530e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105312:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105316:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105319:	0f b6 10             	movzbl (%eax),%edx
8010531c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010531f:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105321:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105325:	0f 95 c0             	setne  %al
80105328:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010532c:	84 c0                	test   %al,%al
8010532e:	75 de                	jne    8010530e <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105330:	eb 25                	jmp    80105357 <memmove+0x7e>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
80105332:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105335:	0f b6 10             	movzbl (%eax),%edx
80105338:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010533b:	88 10                	mov    %dl,(%eax)
8010533d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105341:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105345:	eb 01                	jmp    80105348 <memmove+0x6f>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105347:	90                   	nop
80105348:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010534c:	0f 95 c0             	setne  %al
8010534f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105353:	84 c0                	test   %al,%al
80105355:	75 db                	jne    80105332 <memmove+0x59>
      *d++ = *s++;

  return dst;
80105357:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010535a:	c9                   	leave  
8010535b:	c3                   	ret    

8010535c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
8010535c:	55                   	push   %ebp
8010535d:	89 e5                	mov    %esp,%ebp
8010535f:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80105362:	8b 45 10             	mov    0x10(%ebp),%eax
80105365:	89 44 24 08          	mov    %eax,0x8(%esp)
80105369:	8b 45 0c             	mov    0xc(%ebp),%eax
8010536c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105370:	8b 45 08             	mov    0x8(%ebp),%eax
80105373:	89 04 24             	mov    %eax,(%esp)
80105376:	e8 5e ff ff ff       	call   801052d9 <memmove>
}
8010537b:	c9                   	leave  
8010537c:	c3                   	ret    

8010537d <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
8010537d:	55                   	push   %ebp
8010537e:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80105380:	eb 0c                	jmp    8010538e <strncmp+0x11>
    n--, p++, q++;
80105382:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105386:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010538a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010538e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105392:	74 1a                	je     801053ae <strncmp+0x31>
80105394:	8b 45 08             	mov    0x8(%ebp),%eax
80105397:	0f b6 00             	movzbl (%eax),%eax
8010539a:	84 c0                	test   %al,%al
8010539c:	74 10                	je     801053ae <strncmp+0x31>
8010539e:	8b 45 08             	mov    0x8(%ebp),%eax
801053a1:	0f b6 10             	movzbl (%eax),%edx
801053a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801053a7:	0f b6 00             	movzbl (%eax),%eax
801053aa:	38 c2                	cmp    %al,%dl
801053ac:	74 d4                	je     80105382 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
801053ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053b2:	75 07                	jne    801053bb <strncmp+0x3e>
    return 0;
801053b4:	b8 00 00 00 00       	mov    $0x0,%eax
801053b9:	eb 18                	jmp    801053d3 <strncmp+0x56>
  return (uchar)*p - (uchar)*q;
801053bb:	8b 45 08             	mov    0x8(%ebp),%eax
801053be:	0f b6 00             	movzbl (%eax),%eax
801053c1:	0f b6 d0             	movzbl %al,%edx
801053c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801053c7:	0f b6 00             	movzbl (%eax),%eax
801053ca:	0f b6 c0             	movzbl %al,%eax
801053cd:	89 d1                	mov    %edx,%ecx
801053cf:	29 c1                	sub    %eax,%ecx
801053d1:	89 c8                	mov    %ecx,%eax
}
801053d3:	5d                   	pop    %ebp
801053d4:	c3                   	ret    

801053d5 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801053d5:	55                   	push   %ebp
801053d6:	89 e5                	mov    %esp,%ebp
801053d8:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801053db:	8b 45 08             	mov    0x8(%ebp),%eax
801053de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801053e1:	90                   	nop
801053e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053e6:	0f 9f c0             	setg   %al
801053e9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801053ed:	84 c0                	test   %al,%al
801053ef:	74 30                	je     80105421 <strncpy+0x4c>
801053f1:	8b 45 0c             	mov    0xc(%ebp),%eax
801053f4:	0f b6 10             	movzbl (%eax),%edx
801053f7:	8b 45 08             	mov    0x8(%ebp),%eax
801053fa:	88 10                	mov    %dl,(%eax)
801053fc:	8b 45 08             	mov    0x8(%ebp),%eax
801053ff:	0f b6 00             	movzbl (%eax),%eax
80105402:	84 c0                	test   %al,%al
80105404:	0f 95 c0             	setne  %al
80105407:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010540b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010540f:	84 c0                	test   %al,%al
80105411:	75 cf                	jne    801053e2 <strncpy+0xd>
    ;
  while(n-- > 0)
80105413:	eb 0c                	jmp    80105421 <strncpy+0x4c>
    *s++ = 0;
80105415:	8b 45 08             	mov    0x8(%ebp),%eax
80105418:	c6 00 00             	movb   $0x0,(%eax)
8010541b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010541f:	eb 01                	jmp    80105422 <strncpy+0x4d>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105421:	90                   	nop
80105422:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105426:	0f 9f c0             	setg   %al
80105429:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010542d:	84 c0                	test   %al,%al
8010542f:	75 e4                	jne    80105415 <strncpy+0x40>
    *s++ = 0;
  return os;
80105431:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105434:	c9                   	leave  
80105435:	c3                   	ret    

80105436 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105436:	55                   	push   %ebp
80105437:	89 e5                	mov    %esp,%ebp
80105439:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
8010543c:	8b 45 08             	mov    0x8(%ebp),%eax
8010543f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105442:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105446:	7f 05                	jg     8010544d <safestrcpy+0x17>
    return os;
80105448:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010544b:	eb 35                	jmp    80105482 <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
8010544d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105451:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105455:	7e 22                	jle    80105479 <safestrcpy+0x43>
80105457:	8b 45 0c             	mov    0xc(%ebp),%eax
8010545a:	0f b6 10             	movzbl (%eax),%edx
8010545d:	8b 45 08             	mov    0x8(%ebp),%eax
80105460:	88 10                	mov    %dl,(%eax)
80105462:	8b 45 08             	mov    0x8(%ebp),%eax
80105465:	0f b6 00             	movzbl (%eax),%eax
80105468:	84 c0                	test   %al,%al
8010546a:	0f 95 c0             	setne  %al
8010546d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105471:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105475:	84 c0                	test   %al,%al
80105477:	75 d4                	jne    8010544d <safestrcpy+0x17>
    ;
  *s = 0;
80105479:	8b 45 08             	mov    0x8(%ebp),%eax
8010547c:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010547f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105482:	c9                   	leave  
80105483:	c3                   	ret    

80105484 <strlen>:

int
strlen(const char *s)
{
80105484:	55                   	push   %ebp
80105485:	89 e5                	mov    %esp,%ebp
80105487:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
8010548a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105491:	eb 04                	jmp    80105497 <strlen+0x13>
80105493:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105497:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010549a:	8b 45 08             	mov    0x8(%ebp),%eax
8010549d:	01 d0                	add    %edx,%eax
8010549f:	0f b6 00             	movzbl (%eax),%eax
801054a2:	84 c0                	test   %al,%al
801054a4:	75 ed                	jne    80105493 <strlen+0xf>
    ;
  return n;
801054a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054a9:	c9                   	leave  
801054aa:	c3                   	ret    
	...

801054ac <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801054ac:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801054b0:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801054b4:	55                   	push   %ebp
  pushl %ebx
801054b5:	53                   	push   %ebx
  pushl %esi
801054b6:	56                   	push   %esi
  pushl %edi
801054b7:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801054b8:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801054ba:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801054bc:	5f                   	pop    %edi
  popl %esi
801054bd:	5e                   	pop    %esi
  popl %ebx
801054be:	5b                   	pop    %ebx
  popl %ebp
801054bf:	5d                   	pop    %ebp
  ret
801054c0:	c3                   	ret    
801054c1:	00 00                	add    %al,(%eax)
	...

801054c4 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801054c4:	55                   	push   %ebp
801054c5:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801054c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054cd:	8b 00                	mov    (%eax),%eax
801054cf:	3b 45 08             	cmp    0x8(%ebp),%eax
801054d2:	76 12                	jbe    801054e6 <fetchint+0x22>
801054d4:	8b 45 08             	mov    0x8(%ebp),%eax
801054d7:	8d 50 04             	lea    0x4(%eax),%edx
801054da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054e0:	8b 00                	mov    (%eax),%eax
801054e2:	39 c2                	cmp    %eax,%edx
801054e4:	76 07                	jbe    801054ed <fetchint+0x29>
    return -1;
801054e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054eb:	eb 0f                	jmp    801054fc <fetchint+0x38>
  *ip = *(int*)(addr);
801054ed:	8b 45 08             	mov    0x8(%ebp),%eax
801054f0:	8b 10                	mov    (%eax),%edx
801054f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801054f5:	89 10                	mov    %edx,(%eax)
  return 0;
801054f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801054fc:	5d                   	pop    %ebp
801054fd:	c3                   	ret    

801054fe <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801054fe:	55                   	push   %ebp
801054ff:	89 e5                	mov    %esp,%ebp
80105501:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105504:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010550a:	8b 00                	mov    (%eax),%eax
8010550c:	3b 45 08             	cmp    0x8(%ebp),%eax
8010550f:	77 07                	ja     80105518 <fetchstr+0x1a>
    return -1;
80105511:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105516:	eb 48                	jmp    80105560 <fetchstr+0x62>
  *pp = (char*)addr;
80105518:	8b 55 08             	mov    0x8(%ebp),%edx
8010551b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010551e:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105520:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105526:	8b 00                	mov    (%eax),%eax
80105528:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
8010552b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010552e:	8b 00                	mov    (%eax),%eax
80105530:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105533:	eb 1e                	jmp    80105553 <fetchstr+0x55>
    if(*s == 0)
80105535:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105538:	0f b6 00             	movzbl (%eax),%eax
8010553b:	84 c0                	test   %al,%al
8010553d:	75 10                	jne    8010554f <fetchstr+0x51>
      return s - *pp;
8010553f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105542:	8b 45 0c             	mov    0xc(%ebp),%eax
80105545:	8b 00                	mov    (%eax),%eax
80105547:	89 d1                	mov    %edx,%ecx
80105549:	29 c1                	sub    %eax,%ecx
8010554b:	89 c8                	mov    %ecx,%eax
8010554d:	eb 11                	jmp    80105560 <fetchstr+0x62>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010554f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105553:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105556:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105559:	72 da                	jb     80105535 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
8010555b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105560:	c9                   	leave  
80105561:	c3                   	ret    

80105562 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105562:	55                   	push   %ebp
80105563:	89 e5                	mov    %esp,%ebp
80105565:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105568:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010556e:	8b 40 18             	mov    0x18(%eax),%eax
80105571:	8b 50 44             	mov    0x44(%eax),%edx
80105574:	8b 45 08             	mov    0x8(%ebp),%eax
80105577:	c1 e0 02             	shl    $0x2,%eax
8010557a:	01 d0                	add    %edx,%eax
8010557c:	8d 50 04             	lea    0x4(%eax),%edx
8010557f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105582:	89 44 24 04          	mov    %eax,0x4(%esp)
80105586:	89 14 24             	mov    %edx,(%esp)
80105589:	e8 36 ff ff ff       	call   801054c4 <fetchint>
}
8010558e:	c9                   	leave  
8010558f:	c3                   	ret    

80105590 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105596:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105599:	89 44 24 04          	mov    %eax,0x4(%esp)
8010559d:	8b 45 08             	mov    0x8(%ebp),%eax
801055a0:	89 04 24             	mov    %eax,(%esp)
801055a3:	e8 ba ff ff ff       	call   80105562 <argint>
801055a8:	85 c0                	test   %eax,%eax
801055aa:	79 07                	jns    801055b3 <argptr+0x23>
    return -1;
801055ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055b1:	eb 3d                	jmp    801055f0 <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801055b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055b6:	89 c2                	mov    %eax,%edx
801055b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055be:	8b 00                	mov    (%eax),%eax
801055c0:	39 c2                	cmp    %eax,%edx
801055c2:	73 16                	jae    801055da <argptr+0x4a>
801055c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055c7:	89 c2                	mov    %eax,%edx
801055c9:	8b 45 10             	mov    0x10(%ebp),%eax
801055cc:	01 c2                	add    %eax,%edx
801055ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055d4:	8b 00                	mov    (%eax),%eax
801055d6:	39 c2                	cmp    %eax,%edx
801055d8:	76 07                	jbe    801055e1 <argptr+0x51>
    return -1;
801055da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055df:	eb 0f                	jmp    801055f0 <argptr+0x60>
  *pp = (char*)i;
801055e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055e4:	89 c2                	mov    %eax,%edx
801055e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801055e9:	89 10                	mov    %edx,(%eax)
  return 0;
801055eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
801055f0:	c9                   	leave  
801055f1:	c3                   	ret    

801055f2 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801055f2:	55                   	push   %ebp
801055f3:	89 e5                	mov    %esp,%ebp
801055f5:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
801055f8:	8d 45 fc             	lea    -0x4(%ebp),%eax
801055fb:	89 44 24 04          	mov    %eax,0x4(%esp)
801055ff:	8b 45 08             	mov    0x8(%ebp),%eax
80105602:	89 04 24             	mov    %eax,(%esp)
80105605:	e8 58 ff ff ff       	call   80105562 <argint>
8010560a:	85 c0                	test   %eax,%eax
8010560c:	79 07                	jns    80105615 <argstr+0x23>
    return -1;
8010560e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105613:	eb 12                	jmp    80105627 <argstr+0x35>
  return fetchstr(addr, pp);
80105615:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105618:	8b 55 0c             	mov    0xc(%ebp),%edx
8010561b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010561f:	89 04 24             	mov    %eax,(%esp)
80105622:	e8 d7 fe ff ff       	call   801054fe <fetchstr>
}
80105627:	c9                   	leave  
80105628:	c3                   	ret    

80105629 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105629:	55                   	push   %ebp
8010562a:	89 e5                	mov    %esp,%ebp
8010562c:	53                   	push   %ebx
8010562d:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
80105630:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105636:	8b 40 18             	mov    0x18(%eax),%eax
80105639:	8b 40 1c             	mov    0x1c(%eax),%eax
8010563c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010563f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105643:	7e 30                	jle    80105675 <syscall+0x4c>
80105645:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105648:	83 f8 15             	cmp    $0x15,%eax
8010564b:	77 28                	ja     80105675 <syscall+0x4c>
8010564d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105650:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105657:	85 c0                	test   %eax,%eax
80105659:	74 1a                	je     80105675 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
8010565b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105661:	8b 58 18             	mov    0x18(%eax),%ebx
80105664:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105667:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010566e:	ff d0                	call   *%eax
80105670:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105673:	eb 3d                	jmp    801056b2 <syscall+0x89>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105675:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010567b:	8d 48 6c             	lea    0x6c(%eax),%ecx
8010567e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105684:	8b 40 10             	mov    0x10(%eax),%eax
80105687:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010568a:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010568e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105692:	89 44 24 04          	mov    %eax,0x4(%esp)
80105696:	c7 04 24 07 8a 10 80 	movl   $0x80108a07,(%esp)
8010569d:	e8 08 ad ff ff       	call   801003aa <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801056a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056a8:	8b 40 18             	mov    0x18(%eax),%eax
801056ab:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801056b2:	83 c4 24             	add    $0x24,%esp
801056b5:	5b                   	pop    %ebx
801056b6:	5d                   	pop    %ebp
801056b7:	c3                   	ret    

801056b8 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801056b8:	55                   	push   %ebp
801056b9:	89 e5                	mov    %esp,%ebp
801056bb:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801056be:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056c1:	89 44 24 04          	mov    %eax,0x4(%esp)
801056c5:	8b 45 08             	mov    0x8(%ebp),%eax
801056c8:	89 04 24             	mov    %eax,(%esp)
801056cb:	e8 92 fe ff ff       	call   80105562 <argint>
801056d0:	85 c0                	test   %eax,%eax
801056d2:	79 07                	jns    801056db <argfd+0x23>
    return -1;
801056d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d9:	eb 50                	jmp    8010572b <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801056db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056de:	85 c0                	test   %eax,%eax
801056e0:	78 21                	js     80105703 <argfd+0x4b>
801056e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056e5:	83 f8 0f             	cmp    $0xf,%eax
801056e8:	7f 19                	jg     80105703 <argfd+0x4b>
801056ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801056f3:	83 c2 08             	add    $0x8,%edx
801056f6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801056fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
801056fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105701:	75 07                	jne    8010570a <argfd+0x52>
    return -1;
80105703:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105708:	eb 21                	jmp    8010572b <argfd+0x73>
  if(pfd)
8010570a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010570e:	74 08                	je     80105718 <argfd+0x60>
    *pfd = fd;
80105710:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105713:	8b 45 0c             	mov    0xc(%ebp),%eax
80105716:	89 10                	mov    %edx,(%eax)
  if(pf)
80105718:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010571c:	74 08                	je     80105726 <argfd+0x6e>
    *pf = f;
8010571e:	8b 45 10             	mov    0x10(%ebp),%eax
80105721:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105724:	89 10                	mov    %edx,(%eax)
  return 0;
80105726:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010572b:	c9                   	leave  
8010572c:	c3                   	ret    

8010572d <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010572d:	55                   	push   %ebp
8010572e:	89 e5                	mov    %esp,%ebp
80105730:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105733:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010573a:	eb 30                	jmp    8010576c <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
8010573c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105742:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105745:	83 c2 08             	add    $0x8,%edx
80105748:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010574c:	85 c0                	test   %eax,%eax
8010574e:	75 18                	jne    80105768 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105750:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105756:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105759:	8d 4a 08             	lea    0x8(%edx),%ecx
8010575c:	8b 55 08             	mov    0x8(%ebp),%edx
8010575f:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105763:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105766:	eb 0f                	jmp    80105777 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105768:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010576c:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105770:	7e ca                	jle    8010573c <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105772:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105777:	c9                   	leave  
80105778:	c3                   	ret    

80105779 <sys_dup>:

int
sys_dup(void)
{
80105779:	55                   	push   %ebp
8010577a:	89 e5                	mov    %esp,%ebp
8010577c:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
8010577f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105782:	89 44 24 08          	mov    %eax,0x8(%esp)
80105786:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010578d:	00 
8010578e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105795:	e8 1e ff ff ff       	call   801056b8 <argfd>
8010579a:	85 c0                	test   %eax,%eax
8010579c:	79 07                	jns    801057a5 <sys_dup+0x2c>
    return -1;
8010579e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057a3:	eb 29                	jmp    801057ce <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801057a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057a8:	89 04 24             	mov    %eax,(%esp)
801057ab:	e8 7d ff ff ff       	call   8010572d <fdalloc>
801057b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057b7:	79 07                	jns    801057c0 <sys_dup+0x47>
    return -1;
801057b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057be:	eb 0e                	jmp    801057ce <sys_dup+0x55>
  filedup(f);
801057c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057c3:	89 04 24             	mov    %eax,(%esp)
801057c6:	e8 01 b8 ff ff       	call   80100fcc <filedup>
  return fd;
801057cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801057ce:	c9                   	leave  
801057cf:	c3                   	ret    

801057d0 <sys_read>:

int
sys_read(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801057d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d9:	89 44 24 08          	mov    %eax,0x8(%esp)
801057dd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801057e4:	00 
801057e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057ec:	e8 c7 fe ff ff       	call   801056b8 <argfd>
801057f1:	85 c0                	test   %eax,%eax
801057f3:	78 35                	js     8010582a <sys_read+0x5a>
801057f5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057f8:	89 44 24 04          	mov    %eax,0x4(%esp)
801057fc:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105803:	e8 5a fd ff ff       	call   80105562 <argint>
80105808:	85 c0                	test   %eax,%eax
8010580a:	78 1e                	js     8010582a <sys_read+0x5a>
8010580c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010580f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105813:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105816:	89 44 24 04          	mov    %eax,0x4(%esp)
8010581a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105821:	e8 6a fd ff ff       	call   80105590 <argptr>
80105826:	85 c0                	test   %eax,%eax
80105828:	79 07                	jns    80105831 <sys_read+0x61>
    return -1;
8010582a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582f:	eb 19                	jmp    8010584a <sys_read+0x7a>
  return fileread(f, p, n);
80105831:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105834:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105837:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010583a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010583e:	89 54 24 04          	mov    %edx,0x4(%esp)
80105842:	89 04 24             	mov    %eax,(%esp)
80105845:	e8 ef b8 ff ff       	call   80101139 <fileread>
}
8010584a:	c9                   	leave  
8010584b:	c3                   	ret    

8010584c <sys_write>:

int
sys_write(void)
{
8010584c:	55                   	push   %ebp
8010584d:	89 e5                	mov    %esp,%ebp
8010584f:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105852:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105855:	89 44 24 08          	mov    %eax,0x8(%esp)
80105859:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105860:	00 
80105861:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105868:	e8 4b fe ff ff       	call   801056b8 <argfd>
8010586d:	85 c0                	test   %eax,%eax
8010586f:	78 35                	js     801058a6 <sys_write+0x5a>
80105871:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105874:	89 44 24 04          	mov    %eax,0x4(%esp)
80105878:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010587f:	e8 de fc ff ff       	call   80105562 <argint>
80105884:	85 c0                	test   %eax,%eax
80105886:	78 1e                	js     801058a6 <sys_write+0x5a>
80105888:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010588b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010588f:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105892:	89 44 24 04          	mov    %eax,0x4(%esp)
80105896:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010589d:	e8 ee fc ff ff       	call   80105590 <argptr>
801058a2:	85 c0                	test   %eax,%eax
801058a4:	79 07                	jns    801058ad <sys_write+0x61>
    return -1;
801058a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ab:	eb 19                	jmp    801058c6 <sys_write+0x7a>
  return filewrite(f, p, n);
801058ad:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801058b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801058b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058b6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801058ba:	89 54 24 04          	mov    %edx,0x4(%esp)
801058be:	89 04 24             	mov    %eax,(%esp)
801058c1:	e8 2f b9 ff ff       	call   801011f5 <filewrite>
}
801058c6:	c9                   	leave  
801058c7:	c3                   	ret    

801058c8 <sys_close>:

int
sys_close(void)
{
801058c8:	55                   	push   %ebp
801058c9:	89 e5                	mov    %esp,%ebp
801058cb:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801058ce:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058d1:	89 44 24 08          	mov    %eax,0x8(%esp)
801058d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801058dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058e3:	e8 d0 fd ff ff       	call   801056b8 <argfd>
801058e8:	85 c0                	test   %eax,%eax
801058ea:	79 07                	jns    801058f3 <sys_close+0x2b>
    return -1;
801058ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f1:	eb 24                	jmp    80105917 <sys_close+0x4f>
  proc->ofile[fd] = 0;
801058f3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058fc:	83 c2 08             	add    $0x8,%edx
801058ff:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105906:	00 
  fileclose(f);
80105907:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010590a:	89 04 24             	mov    %eax,(%esp)
8010590d:	e8 02 b7 ff ff       	call   80101014 <fileclose>
  return 0;
80105912:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105917:	c9                   	leave  
80105918:	c3                   	ret    

80105919 <sys_fstat>:

int
sys_fstat(void)
{
80105919:	55                   	push   %ebp
8010591a:	89 e5                	mov    %esp,%ebp
8010591c:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010591f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105922:	89 44 24 08          	mov    %eax,0x8(%esp)
80105926:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010592d:	00 
8010592e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105935:	e8 7e fd ff ff       	call   801056b8 <argfd>
8010593a:	85 c0                	test   %eax,%eax
8010593c:	78 1f                	js     8010595d <sys_fstat+0x44>
8010593e:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80105945:	00 
80105946:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105949:	89 44 24 04          	mov    %eax,0x4(%esp)
8010594d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105954:	e8 37 fc ff ff       	call   80105590 <argptr>
80105959:	85 c0                	test   %eax,%eax
8010595b:	79 07                	jns    80105964 <sys_fstat+0x4b>
    return -1;
8010595d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105962:	eb 12                	jmp    80105976 <sys_fstat+0x5d>
  return filestat(f, st);
80105964:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010596a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010596e:	89 04 24             	mov    %eax,(%esp)
80105971:	e8 74 b7 ff ff       	call   801010ea <filestat>
}
80105976:	c9                   	leave  
80105977:	c3                   	ret    

80105978 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105978:	55                   	push   %ebp
80105979:	89 e5                	mov    %esp,%ebp
8010597b:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010597e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105981:	89 44 24 04          	mov    %eax,0x4(%esp)
80105985:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010598c:	e8 61 fc ff ff       	call   801055f2 <argstr>
80105991:	85 c0                	test   %eax,%eax
80105993:	78 17                	js     801059ac <sys_link+0x34>
80105995:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105998:	89 44 24 04          	mov    %eax,0x4(%esp)
8010599c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801059a3:	e8 4a fc ff ff       	call   801055f2 <argstr>
801059a8:	85 c0                	test   %eax,%eax
801059aa:	79 0a                	jns    801059b6 <sys_link+0x3e>
    return -1;
801059ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059b1:	e9 41 01 00 00       	jmp    80105af7 <sys_link+0x17f>

  begin_op();
801059b6:	e8 99 db ff ff       	call   80103554 <begin_op>
  if((ip = namei(old)) == 0){
801059bb:	8b 45 d8             	mov    -0x28(%ebp),%eax
801059be:	89 04 24             	mov    %eax,(%esp)
801059c1:	e8 15 cb ff ff       	call   801024db <namei>
801059c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801059cd:	75 0f                	jne    801059de <sys_link+0x66>
    end_op();
801059cf:	e8 01 dc ff ff       	call   801035d5 <end_op>
    return -1;
801059d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d9:	e9 19 01 00 00       	jmp    80105af7 <sys_link+0x17f>
  }

  ilock(ip);
801059de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e1:	89 04 24             	mov    %eax,(%esp)
801059e4:	e8 3b bf ff ff       	call   80101924 <ilock>
  if(ip->type == T_DIR){
801059e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059ec:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801059f0:	66 83 f8 01          	cmp    $0x1,%ax
801059f4:	75 1a                	jne    80105a10 <sys_link+0x98>
    iunlockput(ip);
801059f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059f9:	89 04 24             	mov    %eax,(%esp)
801059fc:	e8 ad c1 ff ff       	call   80101bae <iunlockput>
    end_op();
80105a01:	e8 cf db ff ff       	call   801035d5 <end_op>
    return -1;
80105a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a0b:	e9 e7 00 00 00       	jmp    80105af7 <sys_link+0x17f>
  }

  ip->nlink++;
80105a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a13:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a17:	8d 50 01             	lea    0x1(%eax),%edx
80105a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a1d:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a24:	89 04 24             	mov    %eax,(%esp)
80105a27:	e8 36 bd ff ff       	call   80101762 <iupdate>
  iunlock(ip);
80105a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a2f:	89 04 24             	mov    %eax,(%esp)
80105a32:	e8 41 c0 ff ff       	call   80101a78 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105a37:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a3a:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105a3d:	89 54 24 04          	mov    %edx,0x4(%esp)
80105a41:	89 04 24             	mov    %eax,(%esp)
80105a44:	e8 b4 ca ff ff       	call   801024fd <nameiparent>
80105a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a4c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a50:	74 68                	je     80105aba <sys_link+0x142>
    goto bad;
  ilock(dp);
80105a52:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a55:	89 04 24             	mov    %eax,(%esp)
80105a58:	e8 c7 be ff ff       	call   80101924 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a60:	8b 10                	mov    (%eax),%edx
80105a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a65:	8b 00                	mov    (%eax),%eax
80105a67:	39 c2                	cmp    %eax,%edx
80105a69:	75 20                	jne    80105a8b <sys_link+0x113>
80105a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a6e:	8b 40 04             	mov    0x4(%eax),%eax
80105a71:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a75:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105a78:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a7f:	89 04 24             	mov    %eax,(%esp)
80105a82:	e8 91 c7 ff ff       	call   80102218 <dirlink>
80105a87:	85 c0                	test   %eax,%eax
80105a89:	79 0d                	jns    80105a98 <sys_link+0x120>
    iunlockput(dp);
80105a8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a8e:	89 04 24             	mov    %eax,(%esp)
80105a91:	e8 18 c1 ff ff       	call   80101bae <iunlockput>
    goto bad;
80105a96:	eb 23                	jmp    80105abb <sys_link+0x143>
  }
  iunlockput(dp);
80105a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a9b:	89 04 24             	mov    %eax,(%esp)
80105a9e:	e8 0b c1 ff ff       	call   80101bae <iunlockput>
  iput(ip);
80105aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aa6:	89 04 24             	mov    %eax,(%esp)
80105aa9:	e8 2f c0 ff ff       	call   80101add <iput>

  end_op();
80105aae:	e8 22 db ff ff       	call   801035d5 <end_op>

  return 0;
80105ab3:	b8 00 00 00 00       	mov    $0x0,%eax
80105ab8:	eb 3d                	jmp    80105af7 <sys_link+0x17f>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105aba:	90                   	nop
  end_op();

  return 0;

bad:
  ilock(ip);
80105abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105abe:	89 04 24             	mov    %eax,(%esp)
80105ac1:	e8 5e be ff ff       	call   80101924 <ilock>
  ip->nlink--;
80105ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ac9:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105acd:	8d 50 ff             	lea    -0x1(%eax),%edx
80105ad0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ad3:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ada:	89 04 24             	mov    %eax,(%esp)
80105add:	e8 80 bc ff ff       	call   80101762 <iupdate>
  iunlockput(ip);
80105ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae5:	89 04 24             	mov    %eax,(%esp)
80105ae8:	e8 c1 c0 ff ff       	call   80101bae <iunlockput>
  end_op();
80105aed:	e8 e3 da ff ff       	call   801035d5 <end_op>
  return -1;
80105af2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105af7:	c9                   	leave  
80105af8:	c3                   	ret    

80105af9 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105af9:	55                   	push   %ebp
80105afa:	89 e5                	mov    %esp,%ebp
80105afc:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105aff:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105b06:	eb 4b                	jmp    80105b53 <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b0b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105b12:	00 
80105b13:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b17:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b1e:	8b 45 08             	mov    0x8(%ebp),%eax
80105b21:	89 04 24             	mov    %eax,(%esp)
80105b24:	e8 0e c3 ff ff       	call   80101e37 <readi>
80105b29:	83 f8 10             	cmp    $0x10,%eax
80105b2c:	74 0c                	je     80105b3a <isdirempty+0x41>
      panic("isdirempty: readi");
80105b2e:	c7 04 24 23 8a 10 80 	movl   $0x80108a23,(%esp)
80105b35:	e8 0c aa ff ff       	call   80100546 <panic>
    if(de.inum != 0)
80105b3a:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105b3e:	66 85 c0             	test   %ax,%ax
80105b41:	74 07                	je     80105b4a <isdirempty+0x51>
      return 0;
80105b43:	b8 00 00 00 00       	mov    $0x0,%eax
80105b48:	eb 1b                	jmp    80105b65 <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b4d:	83 c0 10             	add    $0x10,%eax
80105b50:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b53:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b56:	8b 45 08             	mov    0x8(%ebp),%eax
80105b59:	8b 40 18             	mov    0x18(%eax),%eax
80105b5c:	39 c2                	cmp    %eax,%edx
80105b5e:	72 a8                	jb     80105b08 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105b60:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105b65:	c9                   	leave  
80105b66:	c3                   	ret    

80105b67 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105b67:	55                   	push   %ebp
80105b68:	89 e5                	mov    %esp,%ebp
80105b6a:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105b6d:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105b70:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b74:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105b7b:	e8 72 fa ff ff       	call   801055f2 <argstr>
80105b80:	85 c0                	test   %eax,%eax
80105b82:	79 0a                	jns    80105b8e <sys_unlink+0x27>
    return -1;
80105b84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b89:	e9 af 01 00 00       	jmp    80105d3d <sys_unlink+0x1d6>

  begin_op();
80105b8e:	e8 c1 d9 ff ff       	call   80103554 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b93:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105b96:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105b99:	89 54 24 04          	mov    %edx,0x4(%esp)
80105b9d:	89 04 24             	mov    %eax,(%esp)
80105ba0:	e8 58 c9 ff ff       	call   801024fd <nameiparent>
80105ba5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ba8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105bac:	75 0f                	jne    80105bbd <sys_unlink+0x56>
    end_op();
80105bae:	e8 22 da ff ff       	call   801035d5 <end_op>
    return -1;
80105bb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bb8:	e9 80 01 00 00       	jmp    80105d3d <sys_unlink+0x1d6>
  }

  ilock(dp);
80105bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc0:	89 04 24             	mov    %eax,(%esp)
80105bc3:	e8 5c bd ff ff       	call   80101924 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105bc8:	c7 44 24 04 35 8a 10 	movl   $0x80108a35,0x4(%esp)
80105bcf:	80 
80105bd0:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105bd3:	89 04 24             	mov    %eax,(%esp)
80105bd6:	e8 53 c5 ff ff       	call   8010212e <namecmp>
80105bdb:	85 c0                	test   %eax,%eax
80105bdd:	0f 84 45 01 00 00    	je     80105d28 <sys_unlink+0x1c1>
80105be3:	c7 44 24 04 37 8a 10 	movl   $0x80108a37,0x4(%esp)
80105bea:	80 
80105beb:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105bee:	89 04 24             	mov    %eax,(%esp)
80105bf1:	e8 38 c5 ff ff       	call   8010212e <namecmp>
80105bf6:	85 c0                	test   %eax,%eax
80105bf8:	0f 84 2a 01 00 00    	je     80105d28 <sys_unlink+0x1c1>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105bfe:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105c01:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c05:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105c08:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c0f:	89 04 24             	mov    %eax,(%esp)
80105c12:	e8 39 c5 ff ff       	call   80102150 <dirlookup>
80105c17:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c1a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c1e:	0f 84 03 01 00 00    	je     80105d27 <sys_unlink+0x1c0>
    goto bad;
  ilock(ip);
80105c24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c27:	89 04 24             	mov    %eax,(%esp)
80105c2a:	e8 f5 bc ff ff       	call   80101924 <ilock>

  if(ip->nlink < 1)
80105c2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c32:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c36:	66 85 c0             	test   %ax,%ax
80105c39:	7f 0c                	jg     80105c47 <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105c3b:	c7 04 24 3a 8a 10 80 	movl   $0x80108a3a,(%esp)
80105c42:	e8 ff a8 ff ff       	call   80100546 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c47:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c4a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c4e:	66 83 f8 01          	cmp    $0x1,%ax
80105c52:	75 1f                	jne    80105c73 <sys_unlink+0x10c>
80105c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c57:	89 04 24             	mov    %eax,(%esp)
80105c5a:	e8 9a fe ff ff       	call   80105af9 <isdirempty>
80105c5f:	85 c0                	test   %eax,%eax
80105c61:	75 10                	jne    80105c73 <sys_unlink+0x10c>
    iunlockput(ip);
80105c63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c66:	89 04 24             	mov    %eax,(%esp)
80105c69:	e8 40 bf ff ff       	call   80101bae <iunlockput>
    goto bad;
80105c6e:	e9 b5 00 00 00       	jmp    80105d28 <sys_unlink+0x1c1>
  }

  memset(&de, 0, sizeof(de));
80105c73:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80105c7a:	00 
80105c7b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105c82:	00 
80105c83:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c86:	89 04 24             	mov    %eax,(%esp)
80105c89:	e8 78 f5 ff ff       	call   80105206 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c8e:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105c91:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105c98:	00 
80105c99:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c9d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ca4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ca7:	89 04 24             	mov    %eax,(%esp)
80105caa:	e8 ee c2 ff ff       	call   80101f9d <writei>
80105caf:	83 f8 10             	cmp    $0x10,%eax
80105cb2:	74 0c                	je     80105cc0 <sys_unlink+0x159>
    panic("unlink: writei");
80105cb4:	c7 04 24 4c 8a 10 80 	movl   $0x80108a4c,(%esp)
80105cbb:	e8 86 a8 ff ff       	call   80100546 <panic>
  if(ip->type == T_DIR){
80105cc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cc3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105cc7:	66 83 f8 01          	cmp    $0x1,%ax
80105ccb:	75 1c                	jne    80105ce9 <sys_unlink+0x182>
    dp->nlink--;
80105ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd0:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cd4:	8d 50 ff             	lea    -0x1(%eax),%edx
80105cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cda:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105cde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ce1:	89 04 24             	mov    %eax,(%esp)
80105ce4:	e8 79 ba ff ff       	call   80101762 <iupdate>
  }
  iunlockput(dp);
80105ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cec:	89 04 24             	mov    %eax,(%esp)
80105cef:	e8 ba be ff ff       	call   80101bae <iunlockput>

  ip->nlink--;
80105cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cf7:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cfb:	8d 50 ff             	lea    -0x1(%eax),%edx
80105cfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d01:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105d05:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d08:	89 04 24             	mov    %eax,(%esp)
80105d0b:	e8 52 ba ff ff       	call   80101762 <iupdate>
  iunlockput(ip);
80105d10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d13:	89 04 24             	mov    %eax,(%esp)
80105d16:	e8 93 be ff ff       	call   80101bae <iunlockput>

  end_op();
80105d1b:	e8 b5 d8 ff ff       	call   801035d5 <end_op>

  return 0;
80105d20:	b8 00 00 00 00       	mov    $0x0,%eax
80105d25:	eb 16                	jmp    80105d3d <sys_unlink+0x1d6>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105d27:	90                   	nop
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105d28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d2b:	89 04 24             	mov    %eax,(%esp)
80105d2e:	e8 7b be ff ff       	call   80101bae <iunlockput>
  end_op();
80105d33:	e8 9d d8 ff ff       	call   801035d5 <end_op>
  return -1;
80105d38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d3d:	c9                   	leave  
80105d3e:	c3                   	ret    

80105d3f <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105d3f:	55                   	push   %ebp
80105d40:	89 e5                	mov    %esp,%ebp
80105d42:	83 ec 48             	sub    $0x48,%esp
80105d45:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105d48:	8b 55 10             	mov    0x10(%ebp),%edx
80105d4b:	8b 45 14             	mov    0x14(%ebp),%eax
80105d4e:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105d52:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105d56:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105d5a:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d5d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d61:	8b 45 08             	mov    0x8(%ebp),%eax
80105d64:	89 04 24             	mov    %eax,(%esp)
80105d67:	e8 91 c7 ff ff       	call   801024fd <nameiparent>
80105d6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d73:	75 0a                	jne    80105d7f <create+0x40>
    return 0;
80105d75:	b8 00 00 00 00       	mov    $0x0,%eax
80105d7a:	e9 7e 01 00 00       	jmp    80105efd <create+0x1be>
  ilock(dp);
80105d7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d82:	89 04 24             	mov    %eax,(%esp)
80105d85:	e8 9a bb ff ff       	call   80101924 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105d8a:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d8d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105d91:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d94:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d9b:	89 04 24             	mov    %eax,(%esp)
80105d9e:	e8 ad c3 ff ff       	call   80102150 <dirlookup>
80105da3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105da6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105daa:	74 47                	je     80105df3 <create+0xb4>
    iunlockput(dp);
80105dac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105daf:	89 04 24             	mov    %eax,(%esp)
80105db2:	e8 f7 bd ff ff       	call   80101bae <iunlockput>
    ilock(ip);
80105db7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dba:	89 04 24             	mov    %eax,(%esp)
80105dbd:	e8 62 bb ff ff       	call   80101924 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105dc2:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105dc7:	75 15                	jne    80105dde <create+0x9f>
80105dc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dcc:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105dd0:	66 83 f8 02          	cmp    $0x2,%ax
80105dd4:	75 08                	jne    80105dde <create+0x9f>
      return ip;
80105dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dd9:	e9 1f 01 00 00       	jmp    80105efd <create+0x1be>
    iunlockput(ip);
80105dde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105de1:	89 04 24             	mov    %eax,(%esp)
80105de4:	e8 c5 bd ff ff       	call   80101bae <iunlockput>
    return 0;
80105de9:	b8 00 00 00 00       	mov    $0x0,%eax
80105dee:	e9 0a 01 00 00       	jmp    80105efd <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105df3:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dfa:	8b 00                	mov    (%eax),%eax
80105dfc:	89 54 24 04          	mov    %edx,0x4(%esp)
80105e00:	89 04 24             	mov    %eax,(%esp)
80105e03:	e8 85 b8 ff ff       	call   8010168d <ialloc>
80105e08:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e0b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e0f:	75 0c                	jne    80105e1d <create+0xde>
    panic("create: ialloc");
80105e11:	c7 04 24 5b 8a 10 80 	movl   $0x80108a5b,(%esp)
80105e18:	e8 29 a7 ff ff       	call   80100546 <panic>

  ilock(ip);
80105e1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e20:	89 04 24             	mov    %eax,(%esp)
80105e23:	e8 fc ba ff ff       	call   80101924 <ilock>
  ip->major = major;
80105e28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e2b:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105e2f:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e36:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105e3a:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e41:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105e47:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e4a:	89 04 24             	mov    %eax,(%esp)
80105e4d:	e8 10 b9 ff ff       	call   80101762 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105e52:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105e57:	75 6a                	jne    80105ec3 <create+0x184>
    dp->nlink++;  // for ".."
80105e59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e5c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e60:	8d 50 01             	lea    0x1(%eax),%edx
80105e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e66:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e6d:	89 04 24             	mov    %eax,(%esp)
80105e70:	e8 ed b8 ff ff       	call   80101762 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e78:	8b 40 04             	mov    0x4(%eax),%eax
80105e7b:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e7f:	c7 44 24 04 35 8a 10 	movl   $0x80108a35,0x4(%esp)
80105e86:	80 
80105e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e8a:	89 04 24             	mov    %eax,(%esp)
80105e8d:	e8 86 c3 ff ff       	call   80102218 <dirlink>
80105e92:	85 c0                	test   %eax,%eax
80105e94:	78 21                	js     80105eb7 <create+0x178>
80105e96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e99:	8b 40 04             	mov    0x4(%eax),%eax
80105e9c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ea0:	c7 44 24 04 37 8a 10 	movl   $0x80108a37,0x4(%esp)
80105ea7:	80 
80105ea8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eab:	89 04 24             	mov    %eax,(%esp)
80105eae:	e8 65 c3 ff ff       	call   80102218 <dirlink>
80105eb3:	85 c0                	test   %eax,%eax
80105eb5:	79 0c                	jns    80105ec3 <create+0x184>
      panic("create dots");
80105eb7:	c7 04 24 6a 8a 10 80 	movl   $0x80108a6a,(%esp)
80105ebe:	e8 83 a6 ff ff       	call   80100546 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105ec3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ec6:	8b 40 04             	mov    0x4(%eax),%eax
80105ec9:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ecd:	8d 45 de             	lea    -0x22(%ebp),%eax
80105ed0:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ed4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ed7:	89 04 24             	mov    %eax,(%esp)
80105eda:	e8 39 c3 ff ff       	call   80102218 <dirlink>
80105edf:	85 c0                	test   %eax,%eax
80105ee1:	79 0c                	jns    80105eef <create+0x1b0>
    panic("create: dirlink");
80105ee3:	c7 04 24 76 8a 10 80 	movl   $0x80108a76,(%esp)
80105eea:	e8 57 a6 ff ff       	call   80100546 <panic>

  iunlockput(dp);
80105eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ef2:	89 04 24             	mov    %eax,(%esp)
80105ef5:	e8 b4 bc ff ff       	call   80101bae <iunlockput>

  return ip;
80105efa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105efd:	c9                   	leave  
80105efe:	c3                   	ret    

80105eff <sys_open>:

int
sys_open(void)
{
80105eff:	55                   	push   %ebp
80105f00:	89 e5                	mov    %esp,%ebp
80105f02:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f05:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f08:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f0c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f13:	e8 da f6 ff ff       	call   801055f2 <argstr>
80105f18:	85 c0                	test   %eax,%eax
80105f1a:	78 17                	js     80105f33 <sys_open+0x34>
80105f1c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105f2a:	e8 33 f6 ff ff       	call   80105562 <argint>
80105f2f:	85 c0                	test   %eax,%eax
80105f31:	79 0a                	jns    80105f3d <sys_open+0x3e>
    return -1;
80105f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f38:	e9 5c 01 00 00       	jmp    80106099 <sys_open+0x19a>

  begin_op();
80105f3d:	e8 12 d6 ff ff       	call   80103554 <begin_op>

  if(omode & O_CREATE){
80105f42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f45:	25 00 02 00 00       	and    $0x200,%eax
80105f4a:	85 c0                	test   %eax,%eax
80105f4c:	74 3b                	je     80105f89 <sys_open+0x8a>
    ip = create(path, T_FILE, 0, 0);
80105f4e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f51:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105f58:	00 
80105f59:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105f60:	00 
80105f61:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80105f68:	00 
80105f69:	89 04 24             	mov    %eax,(%esp)
80105f6c:	e8 ce fd ff ff       	call   80105d3f <create>
80105f71:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80105f74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f78:	75 6b                	jne    80105fe5 <sys_open+0xe6>
      end_op();
80105f7a:	e8 56 d6 ff ff       	call   801035d5 <end_op>
      return -1;
80105f7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f84:	e9 10 01 00 00       	jmp    80106099 <sys_open+0x19a>
    }
  } else {
    if((ip = namei(path)) == 0){
80105f89:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f8c:	89 04 24             	mov    %eax,(%esp)
80105f8f:	e8 47 c5 ff ff       	call   801024db <namei>
80105f94:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f9b:	75 0f                	jne    80105fac <sys_open+0xad>
      end_op();
80105f9d:	e8 33 d6 ff ff       	call   801035d5 <end_op>
      return -1;
80105fa2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fa7:	e9 ed 00 00 00       	jmp    80106099 <sys_open+0x19a>
    }
    ilock(ip);
80105fac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105faf:	89 04 24             	mov    %eax,(%esp)
80105fb2:	e8 6d b9 ff ff       	call   80101924 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fba:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105fbe:	66 83 f8 01          	cmp    $0x1,%ax
80105fc2:	75 21                	jne    80105fe5 <sys_open+0xe6>
80105fc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fc7:	85 c0                	test   %eax,%eax
80105fc9:	74 1a                	je     80105fe5 <sys_open+0xe6>
      iunlockput(ip);
80105fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fce:	89 04 24             	mov    %eax,(%esp)
80105fd1:	e8 d8 bb ff ff       	call   80101bae <iunlockput>
      end_op();
80105fd6:	e8 fa d5 ff ff       	call   801035d5 <end_op>
      return -1;
80105fdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fe0:	e9 b4 00 00 00       	jmp    80106099 <sys_open+0x19a>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105fe5:	e8 82 af ff ff       	call   80100f6c <filealloc>
80105fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ff1:	74 14                	je     80106007 <sys_open+0x108>
80105ff3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ff6:	89 04 24             	mov    %eax,(%esp)
80105ff9:	e8 2f f7 ff ff       	call   8010572d <fdalloc>
80105ffe:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106001:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106005:	79 28                	jns    8010602f <sys_open+0x130>
    if(f)
80106007:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010600b:	74 0b                	je     80106018 <sys_open+0x119>
      fileclose(f);
8010600d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106010:	89 04 24             	mov    %eax,(%esp)
80106013:	e8 fc af ff ff       	call   80101014 <fileclose>
    iunlockput(ip);
80106018:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010601b:	89 04 24             	mov    %eax,(%esp)
8010601e:	e8 8b bb ff ff       	call   80101bae <iunlockput>
    end_op();
80106023:	e8 ad d5 ff ff       	call   801035d5 <end_op>
    return -1;
80106028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010602d:	eb 6a                	jmp    80106099 <sys_open+0x19a>
  }
  iunlock(ip);
8010602f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106032:	89 04 24             	mov    %eax,(%esp)
80106035:	e8 3e ba ff ff       	call   80101a78 <iunlock>
  end_op();
8010603a:	e8 96 d5 ff ff       	call   801035d5 <end_op>

  f->type = FD_INODE;
8010603f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106042:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106048:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010604b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010604e:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80106051:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106054:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
8010605b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010605e:	83 e0 01             	and    $0x1,%eax
80106061:	85 c0                	test   %eax,%eax
80106063:	0f 94 c0             	sete   %al
80106066:	89 c2                	mov    %eax,%edx
80106068:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010606b:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010606e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106071:	83 e0 01             	and    $0x1,%eax
80106074:	85 c0                	test   %eax,%eax
80106076:	75 0a                	jne    80106082 <sys_open+0x183>
80106078:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010607b:	83 e0 02             	and    $0x2,%eax
8010607e:	85 c0                	test   %eax,%eax
80106080:	74 07                	je     80106089 <sys_open+0x18a>
80106082:	b8 01 00 00 00       	mov    $0x1,%eax
80106087:	eb 05                	jmp    8010608e <sys_open+0x18f>
80106089:	b8 00 00 00 00       	mov    $0x0,%eax
8010608e:	89 c2                	mov    %eax,%edx
80106090:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106093:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106096:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106099:	c9                   	leave  
8010609a:	c3                   	ret    

8010609b <sys_mkdir>:

int
sys_mkdir(void)
{
8010609b:	55                   	push   %ebp
8010609c:	89 e5                	mov    %esp,%ebp
8010609e:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801060a1:	e8 ae d4 ff ff       	call   80103554 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801060a6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801060ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060b4:	e8 39 f5 ff ff       	call   801055f2 <argstr>
801060b9:	85 c0                	test   %eax,%eax
801060bb:	78 2c                	js     801060e9 <sys_mkdir+0x4e>
801060bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060c0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
801060c7:	00 
801060c8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801060cf:	00 
801060d0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801060d7:	00 
801060d8:	89 04 24             	mov    %eax,(%esp)
801060db:	e8 5f fc ff ff       	call   80105d3f <create>
801060e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060e7:	75 0c                	jne    801060f5 <sys_mkdir+0x5a>
    end_op();
801060e9:	e8 e7 d4 ff ff       	call   801035d5 <end_op>
    return -1;
801060ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060f3:	eb 15                	jmp    8010610a <sys_mkdir+0x6f>
  }
  iunlockput(ip);
801060f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060f8:	89 04 24             	mov    %eax,(%esp)
801060fb:	e8 ae ba ff ff       	call   80101bae <iunlockput>
  end_op();
80106100:	e8 d0 d4 ff ff       	call   801035d5 <end_op>
  return 0;
80106105:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010610a:	c9                   	leave  
8010610b:	c3                   	ret    

8010610c <sys_mknod>:

int
sys_mknod(void)
{
8010610c:	55                   	push   %ebp
8010610d:	89 e5                	mov    %esp,%ebp
8010610f:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
80106112:	e8 3d d4 ff ff       	call   80103554 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80106117:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010611a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010611e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106125:	e8 c8 f4 ff ff       	call   801055f2 <argstr>
8010612a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010612d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106131:	78 5e                	js     80106191 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
80106133:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106136:	89 44 24 04          	mov    %eax,0x4(%esp)
8010613a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106141:	e8 1c f4 ff ff       	call   80105562 <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
80106146:	85 c0                	test   %eax,%eax
80106148:	78 47                	js     80106191 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010614a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010614d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106151:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106158:	e8 05 f4 ff ff       	call   80105562 <argint>
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010615d:	85 c0                	test   %eax,%eax
8010615f:	78 30                	js     80106191 <sys_mknod+0x85>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106161:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106164:	0f bf c8             	movswl %ax,%ecx
80106167:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010616a:	0f bf d0             	movswl %ax,%edx
8010616d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106170:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106174:	89 54 24 08          	mov    %edx,0x8(%esp)
80106178:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
8010617f:	00 
80106180:	89 04 24             	mov    %eax,(%esp)
80106183:	e8 b7 fb ff ff       	call   80105d3f <create>
80106188:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010618b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010618f:	75 0c                	jne    8010619d <sys_mknod+0x91>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80106191:	e8 3f d4 ff ff       	call   801035d5 <end_op>
    return -1;
80106196:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010619b:	eb 15                	jmp    801061b2 <sys_mknod+0xa6>
  }
  iunlockput(ip);
8010619d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061a0:	89 04 24             	mov    %eax,(%esp)
801061a3:	e8 06 ba ff ff       	call   80101bae <iunlockput>
  end_op();
801061a8:	e8 28 d4 ff ff       	call   801035d5 <end_op>
  return 0;
801061ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061b2:	c9                   	leave  
801061b3:	c3                   	ret    

801061b4 <sys_chdir>:

int
sys_chdir(void)
{
801061b4:	55                   	push   %ebp
801061b5:	89 e5                	mov    %esp,%ebp
801061b7:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801061ba:	e8 95 d3 ff ff       	call   80103554 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801061bf:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801061c6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061cd:	e8 20 f4 ff ff       	call   801055f2 <argstr>
801061d2:	85 c0                	test   %eax,%eax
801061d4:	78 14                	js     801061ea <sys_chdir+0x36>
801061d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061d9:	89 04 24             	mov    %eax,(%esp)
801061dc:	e8 fa c2 ff ff       	call   801024db <namei>
801061e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061e8:	75 0c                	jne    801061f6 <sys_chdir+0x42>
    end_op();
801061ea:	e8 e6 d3 ff ff       	call   801035d5 <end_op>
    return -1;
801061ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061f4:	eb 61                	jmp    80106257 <sys_chdir+0xa3>
  }
  ilock(ip);
801061f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061f9:	89 04 24             	mov    %eax,(%esp)
801061fc:	e8 23 b7 ff ff       	call   80101924 <ilock>
  if(ip->type != T_DIR){
80106201:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106204:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106208:	66 83 f8 01          	cmp    $0x1,%ax
8010620c:	74 17                	je     80106225 <sys_chdir+0x71>
    iunlockput(ip);
8010620e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106211:	89 04 24             	mov    %eax,(%esp)
80106214:	e8 95 b9 ff ff       	call   80101bae <iunlockput>
    end_op();
80106219:	e8 b7 d3 ff ff       	call   801035d5 <end_op>
    return -1;
8010621e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106223:	eb 32                	jmp    80106257 <sys_chdir+0xa3>
  }
  iunlock(ip);
80106225:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106228:	89 04 24             	mov    %eax,(%esp)
8010622b:	e8 48 b8 ff ff       	call   80101a78 <iunlock>
  iput(proc->cwd);
80106230:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106236:	8b 40 68             	mov    0x68(%eax),%eax
80106239:	89 04 24             	mov    %eax,(%esp)
8010623c:	e8 9c b8 ff ff       	call   80101add <iput>
  end_op();
80106241:	e8 8f d3 ff ff       	call   801035d5 <end_op>
  proc->cwd = ip;
80106246:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010624c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010624f:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106252:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106257:	c9                   	leave  
80106258:	c3                   	ret    

80106259 <sys_exec>:

int
sys_exec(void)
{
80106259:	55                   	push   %ebp
8010625a:	89 e5                	mov    %esp,%ebp
8010625c:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106262:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106265:	89 44 24 04          	mov    %eax,0x4(%esp)
80106269:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106270:	e8 7d f3 ff ff       	call   801055f2 <argstr>
80106275:	85 c0                	test   %eax,%eax
80106277:	78 1a                	js     80106293 <sys_exec+0x3a>
80106279:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010627f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106283:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010628a:	e8 d3 f2 ff ff       	call   80105562 <argint>
8010628f:	85 c0                	test   %eax,%eax
80106291:	79 0a                	jns    8010629d <sys_exec+0x44>
    return -1;
80106293:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106298:	e9 c8 00 00 00       	jmp    80106365 <sys_exec+0x10c>
  }
  memset(argv, 0, sizeof(argv));
8010629d:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801062a4:	00 
801062a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801062ac:	00 
801062ad:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801062b3:	89 04 24             	mov    %eax,(%esp)
801062b6:	e8 4b ef ff ff       	call   80105206 <memset>
  for(i=0;; i++){
801062bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801062c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062c5:	83 f8 1f             	cmp    $0x1f,%eax
801062c8:	76 0a                	jbe    801062d4 <sys_exec+0x7b>
      return -1;
801062ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062cf:	e9 91 00 00 00       	jmp    80106365 <sys_exec+0x10c>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801062d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d7:	c1 e0 02             	shl    $0x2,%eax
801062da:	89 c2                	mov    %eax,%edx
801062dc:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801062e2:	01 c2                	add    %eax,%edx
801062e4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801062ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801062ee:	89 14 24             	mov    %edx,(%esp)
801062f1:	e8 ce f1 ff ff       	call   801054c4 <fetchint>
801062f6:	85 c0                	test   %eax,%eax
801062f8:	79 07                	jns    80106301 <sys_exec+0xa8>
      return -1;
801062fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062ff:	eb 64                	jmp    80106365 <sys_exec+0x10c>
    if(uarg == 0){
80106301:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106307:	85 c0                	test   %eax,%eax
80106309:	75 26                	jne    80106331 <sys_exec+0xd8>
      argv[i] = 0;
8010630b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010630e:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106315:	00 00 00 00 
      break;
80106319:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010631a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010631d:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106323:	89 54 24 04          	mov    %edx,0x4(%esp)
80106327:	89 04 24             	mov    %eax,(%esp)
8010632a:	e8 f5 a7 ff ff       	call   80100b24 <exec>
8010632f:	eb 34                	jmp    80106365 <sys_exec+0x10c>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106331:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106337:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010633a:	c1 e2 02             	shl    $0x2,%edx
8010633d:	01 c2                	add    %eax,%edx
8010633f:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106345:	89 54 24 04          	mov    %edx,0x4(%esp)
80106349:	89 04 24             	mov    %eax,(%esp)
8010634c:	e8 ad f1 ff ff       	call   801054fe <fetchstr>
80106351:	85 c0                	test   %eax,%eax
80106353:	79 07                	jns    8010635c <sys_exec+0x103>
      return -1;
80106355:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010635a:	eb 09                	jmp    80106365 <sys_exec+0x10c>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010635c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80106360:	e9 5d ff ff ff       	jmp    801062c2 <sys_exec+0x69>
  return exec(path, argv);
}
80106365:	c9                   	leave  
80106366:	c3                   	ret    

80106367 <sys_pipe>:

int
sys_pipe(void)
{
80106367:	55                   	push   %ebp
80106368:	89 e5                	mov    %esp,%ebp
8010636a:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010636d:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80106374:	00 
80106375:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106378:	89 44 24 04          	mov    %eax,0x4(%esp)
8010637c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106383:	e8 08 f2 ff ff       	call   80105590 <argptr>
80106388:	85 c0                	test   %eax,%eax
8010638a:	79 0a                	jns    80106396 <sys_pipe+0x2f>
    return -1;
8010638c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106391:	e9 9b 00 00 00       	jmp    80106431 <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80106396:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106399:	89 44 24 04          	mov    %eax,0x4(%esp)
8010639d:	8d 45 e8             	lea    -0x18(%ebp),%eax
801063a0:	89 04 24             	mov    %eax,(%esp)
801063a3:	e8 e0 dc ff ff       	call   80104088 <pipealloc>
801063a8:	85 c0                	test   %eax,%eax
801063aa:	79 07                	jns    801063b3 <sys_pipe+0x4c>
    return -1;
801063ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063b1:	eb 7e                	jmp    80106431 <sys_pipe+0xca>
  fd0 = -1;
801063b3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801063ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
801063bd:	89 04 24             	mov    %eax,(%esp)
801063c0:	e8 68 f3 ff ff       	call   8010572d <fdalloc>
801063c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801063c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801063cc:	78 14                	js     801063e2 <sys_pipe+0x7b>
801063ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063d1:	89 04 24             	mov    %eax,(%esp)
801063d4:	e8 54 f3 ff ff       	call   8010572d <fdalloc>
801063d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801063dc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801063e0:	79 37                	jns    80106419 <sys_pipe+0xb2>
    if(fd0 >= 0)
801063e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801063e6:	78 14                	js     801063fc <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
801063e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801063ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063f1:	83 c2 08             	add    $0x8,%edx
801063f4:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801063fb:	00 
    fileclose(rf);
801063fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
801063ff:	89 04 24             	mov    %eax,(%esp)
80106402:	e8 0d ac ff ff       	call   80101014 <fileclose>
    fileclose(wf);
80106407:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010640a:	89 04 24             	mov    %eax,(%esp)
8010640d:	e8 02 ac ff ff       	call   80101014 <fileclose>
    return -1;
80106412:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106417:	eb 18                	jmp    80106431 <sys_pipe+0xca>
  }
  fd[0] = fd0;
80106419:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010641c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010641f:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106421:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106424:	8d 50 04             	lea    0x4(%eax),%edx
80106427:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010642a:	89 02                	mov    %eax,(%edx)
  return 0;
8010642c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106431:	c9                   	leave  
80106432:	c3                   	ret    
	...

80106434 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106434:	55                   	push   %ebp
80106435:	89 e5                	mov    %esp,%ebp
80106437:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010643a:	e8 06 e3 ff ff       	call   80104745 <fork>
}
8010643f:	c9                   	leave  
80106440:	c3                   	ret    

80106441 <sys_exit>:

int
sys_exit(void)
{
80106441:	55                   	push   %ebp
80106442:	89 e5                	mov    %esp,%ebp
80106444:	83 ec 08             	sub    $0x8,%esp
  exit();
80106447:	e8 74 e4 ff ff       	call   801048c0 <exit>
  return 0;  // not reached
8010644c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106451:	c9                   	leave  
80106452:	c3                   	ret    

80106453 <sys_wait>:

int
sys_wait(void)
{
80106453:	55                   	push   %ebp
80106454:	89 e5                	mov    %esp,%ebp
80106456:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106459:	e8 84 e5 ff ff       	call   801049e2 <wait>
}
8010645e:	c9                   	leave  
8010645f:	c3                   	ret    

80106460 <sys_kill>:

int
sys_kill(void)
{
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106466:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106469:	89 44 24 04          	mov    %eax,0x4(%esp)
8010646d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106474:	e8 e9 f0 ff ff       	call   80105562 <argint>
80106479:	85 c0                	test   %eax,%eax
8010647b:	79 07                	jns    80106484 <sys_kill+0x24>
    return -1;
8010647d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106482:	eb 0b                	jmp    8010648f <sys_kill+0x2f>
  return kill(pid);
80106484:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106487:	89 04 24             	mov    %eax,(%esp)
8010648a:	e8 42 e9 ff ff       	call   80104dd1 <kill>
}
8010648f:	c9                   	leave  
80106490:	c3                   	ret    

80106491 <sys_getpid>:

int
sys_getpid(void)
{
80106491:	55                   	push   %ebp
80106492:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106494:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010649a:	8b 40 10             	mov    0x10(%eax),%eax
}
8010649d:	5d                   	pop    %ebp
8010649e:	c3                   	ret    

8010649f <sys_sbrk>:

int
sys_sbrk(void)
{
8010649f:	55                   	push   %ebp
801064a0:	89 e5                	mov    %esp,%ebp
801064a2:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801064a5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801064ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064b3:	e8 aa f0 ff ff       	call   80105562 <argint>
801064b8:	85 c0                	test   %eax,%eax
801064ba:	79 07                	jns    801064c3 <sys_sbrk+0x24>
    return -1;
801064bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064c1:	eb 24                	jmp    801064e7 <sys_sbrk+0x48>
  addr = proc->sz;
801064c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064c9:	8b 00                	mov    (%eax),%eax
801064cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801064ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064d1:	89 04 24             	mov    %eax,(%esp)
801064d4:	e8 c7 e1 ff ff       	call   801046a0 <growproc>
801064d9:	85 c0                	test   %eax,%eax
801064db:	79 07                	jns    801064e4 <sys_sbrk+0x45>
    return -1;
801064dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064e2:	eb 03                	jmp    801064e7 <sys_sbrk+0x48>
  return addr;
801064e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801064e7:	c9                   	leave  
801064e8:	c3                   	ret    

801064e9 <sys_sleep>:

int
sys_sleep(void)
{
801064e9:	55                   	push   %ebp
801064ea:	89 e5                	mov    %esp,%ebp
801064ec:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
801064ef:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801064f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064fd:	e8 60 f0 ff ff       	call   80105562 <argint>
80106502:	85 c0                	test   %eax,%eax
80106504:	79 07                	jns    8010650d <sys_sleep+0x24>
    return -1;
80106506:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010650b:	eb 6c                	jmp    80106579 <sys_sleep+0x90>
  acquire(&tickslock);
8010650d:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
80106514:	e8 92 ea ff ff       	call   80104fab <acquire>
  ticks0 = ticks;
80106519:	a1 e0 50 11 80       	mov    0x801150e0,%eax
8010651e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106521:	eb 34                	jmp    80106557 <sys_sleep+0x6e>
    if(proc->killed){
80106523:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106529:	8b 40 24             	mov    0x24(%eax),%eax
8010652c:	85 c0                	test   %eax,%eax
8010652e:	74 13                	je     80106543 <sys_sleep+0x5a>
      release(&tickslock);
80106530:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
80106537:	e8 d1 ea ff ff       	call   8010500d <release>
      return -1;
8010653c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106541:	eb 36                	jmp    80106579 <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
80106543:	c7 44 24 04 a0 48 11 	movl   $0x801148a0,0x4(%esp)
8010654a:	80 
8010654b:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
80106552:	e8 76 e7 ff ff       	call   80104ccd <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106557:	a1 e0 50 11 80       	mov    0x801150e0,%eax
8010655c:	89 c2                	mov    %eax,%edx
8010655e:	2b 55 f4             	sub    -0xc(%ebp),%edx
80106561:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106564:	39 c2                	cmp    %eax,%edx
80106566:	72 bb                	jb     80106523 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106568:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
8010656f:	e8 99 ea ff ff       	call   8010500d <release>
  return 0;
80106574:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106579:	c9                   	leave  
8010657a:	c3                   	ret    

8010657b <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
8010657b:	55                   	push   %ebp
8010657c:	89 e5                	mov    %esp,%ebp
8010657e:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
80106581:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
80106588:	e8 1e ea ff ff       	call   80104fab <acquire>
  xticks = ticks;
8010658d:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106592:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106595:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
8010659c:	e8 6c ea ff ff       	call   8010500d <release>
  return xticks;
801065a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801065a4:	c9                   	leave  
801065a5:	c3                   	ret    
	...

801065a8 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801065a8:	55                   	push   %ebp
801065a9:	89 e5                	mov    %esp,%ebp
801065ab:	83 ec 08             	sub    $0x8,%esp
801065ae:	8b 55 08             	mov    0x8(%ebp),%edx
801065b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801065b4:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801065b8:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801065bb:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801065bf:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801065c3:	ee                   	out    %al,(%dx)
}
801065c4:	c9                   	leave  
801065c5:	c3                   	ret    

801065c6 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801065c6:	55                   	push   %ebp
801065c7:	89 e5                	mov    %esp,%ebp
801065c9:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801065cc:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
801065d3:	00 
801065d4:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
801065db:	e8 c8 ff ff ff       	call   801065a8 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801065e0:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
801065e7:	00 
801065e8:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801065ef:	e8 b4 ff ff ff       	call   801065a8 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
801065f4:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
801065fb:	00 
801065fc:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80106603:	e8 a0 ff ff ff       	call   801065a8 <outb>
  picenable(IRQ_TIMER);
80106608:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010660f:	e8 fd d8 ff ff       	call   80103f11 <picenable>
}
80106614:	c9                   	leave  
80106615:	c3                   	ret    
	...

80106618 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106618:	1e                   	push   %ds
  pushl %es
80106619:	06                   	push   %es
  pushl %fs
8010661a:	0f a0                	push   %fs
  pushl %gs
8010661c:	0f a8                	push   %gs
  pushal
8010661e:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
8010661f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106623:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106625:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106627:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010662b:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
8010662d:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
8010662f:	54                   	push   %esp
  call trap
80106630:	e8 de 01 00 00       	call   80106813 <trap>
  addl $4, %esp
80106635:	83 c4 04             	add    $0x4,%esp

80106638 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106638:	61                   	popa   
  popl %gs
80106639:	0f a9                	pop    %gs
  popl %fs
8010663b:	0f a1                	pop    %fs
  popl %es
8010663d:	07                   	pop    %es
  popl %ds
8010663e:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010663f:	83 c4 08             	add    $0x8,%esp
  iret
80106642:	cf                   	iret   
	...

80106644 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106644:	55                   	push   %ebp
80106645:	89 e5                	mov    %esp,%ebp
80106647:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010664a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010664d:	83 e8 01             	sub    $0x1,%eax
80106650:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106654:	8b 45 08             	mov    0x8(%ebp),%eax
80106657:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010665b:	8b 45 08             	mov    0x8(%ebp),%eax
8010665e:	c1 e8 10             	shr    $0x10,%eax
80106661:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106665:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106668:	0f 01 18             	lidtl  (%eax)
}
8010666b:	c9                   	leave  
8010666c:	c3                   	ret    

8010666d <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
8010666d:	55                   	push   %ebp
8010666e:	89 e5                	mov    %esp,%ebp
80106670:	53                   	push   %ebx
80106671:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106674:	0f 20 d3             	mov    %cr2,%ebx
80106677:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return val;
8010667a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
8010667d:	83 c4 10             	add    $0x10,%esp
80106680:	5b                   	pop    %ebx
80106681:	5d                   	pop    %ebp
80106682:	c3                   	ret    

80106683 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106683:	55                   	push   %ebp
80106684:	89 e5                	mov    %esp,%ebp
80106686:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
80106689:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106690:	e9 c3 00 00 00       	jmp    80106758 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106698:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
8010669f:	89 c2                	mov    %eax,%edx
801066a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066a4:	66 89 14 c5 e0 48 11 	mov    %dx,-0x7feeb720(,%eax,8)
801066ab:	80 
801066ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066af:	66 c7 04 c5 e2 48 11 	movw   $0x8,-0x7feeb71e(,%eax,8)
801066b6:	80 08 00 
801066b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066bc:	0f b6 14 c5 e4 48 11 	movzbl -0x7feeb71c(,%eax,8),%edx
801066c3:	80 
801066c4:	83 e2 e0             	and    $0xffffffe0,%edx
801066c7:	88 14 c5 e4 48 11 80 	mov    %dl,-0x7feeb71c(,%eax,8)
801066ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066d1:	0f b6 14 c5 e4 48 11 	movzbl -0x7feeb71c(,%eax,8),%edx
801066d8:	80 
801066d9:	83 e2 1f             	and    $0x1f,%edx
801066dc:	88 14 c5 e4 48 11 80 	mov    %dl,-0x7feeb71c(,%eax,8)
801066e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066e6:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
801066ed:	80 
801066ee:	83 e2 f0             	and    $0xfffffff0,%edx
801066f1:	83 ca 0e             	or     $0xe,%edx
801066f4:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
801066fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066fe:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
80106705:	80 
80106706:	83 e2 ef             	and    $0xffffffef,%edx
80106709:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
80106710:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106713:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
8010671a:	80 
8010671b:	83 e2 9f             	and    $0xffffff9f,%edx
8010671e:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
80106725:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106728:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
8010672f:	80 
80106730:	83 ca 80             	or     $0xffffff80,%edx
80106733:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
8010673a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010673d:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
80106744:	c1 e8 10             	shr    $0x10,%eax
80106747:	89 c2                	mov    %eax,%edx
80106749:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010674c:	66 89 14 c5 e6 48 11 	mov    %dx,-0x7feeb71a(,%eax,8)
80106753:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106754:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106758:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010675f:	0f 8e 30 ff ff ff    	jle    80106695 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106765:	a1 98 b1 10 80       	mov    0x8010b198,%eax
8010676a:	66 a3 e0 4a 11 80    	mov    %ax,0x80114ae0
80106770:	66 c7 05 e2 4a 11 80 	movw   $0x8,0x80114ae2
80106777:	08 00 
80106779:	0f b6 05 e4 4a 11 80 	movzbl 0x80114ae4,%eax
80106780:	83 e0 e0             	and    $0xffffffe0,%eax
80106783:	a2 e4 4a 11 80       	mov    %al,0x80114ae4
80106788:	0f b6 05 e4 4a 11 80 	movzbl 0x80114ae4,%eax
8010678f:	83 e0 1f             	and    $0x1f,%eax
80106792:	a2 e4 4a 11 80       	mov    %al,0x80114ae4
80106797:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
8010679e:	83 c8 0f             	or     $0xf,%eax
801067a1:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801067a6:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
801067ad:	83 e0 ef             	and    $0xffffffef,%eax
801067b0:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801067b5:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
801067bc:	83 c8 60             	or     $0x60,%eax
801067bf:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801067c4:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
801067cb:	83 c8 80             	or     $0xffffff80,%eax
801067ce:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801067d3:	a1 98 b1 10 80       	mov    0x8010b198,%eax
801067d8:	c1 e8 10             	shr    $0x10,%eax
801067db:	66 a3 e6 4a 11 80    	mov    %ax,0x80114ae6
  
  initlock(&tickslock, "time");
801067e1:	c7 44 24 04 88 8a 10 	movl   $0x80108a88,0x4(%esp)
801067e8:	80 
801067e9:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
801067f0:	e8 95 e7 ff ff       	call   80104f8a <initlock>
}
801067f5:	c9                   	leave  
801067f6:	c3                   	ret    

801067f7 <idtinit>:

void
idtinit(void)
{
801067f7:	55                   	push   %ebp
801067f8:	89 e5                	mov    %esp,%ebp
801067fa:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
801067fd:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
80106804:	00 
80106805:	c7 04 24 e0 48 11 80 	movl   $0x801148e0,(%esp)
8010680c:	e8 33 fe ff ff       	call   80106644 <lidt>
}
80106811:	c9                   	leave  
80106812:	c3                   	ret    

80106813 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106813:	55                   	push   %ebp
80106814:	89 e5                	mov    %esp,%ebp
80106816:	57                   	push   %edi
80106817:	56                   	push   %esi
80106818:	53                   	push   %ebx
80106819:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
8010681c:	8b 45 08             	mov    0x8(%ebp),%eax
8010681f:	8b 40 30             	mov    0x30(%eax),%eax
80106822:	83 f8 40             	cmp    $0x40,%eax
80106825:	75 3e                	jne    80106865 <trap+0x52>
    if(proc->killed)
80106827:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010682d:	8b 40 24             	mov    0x24(%eax),%eax
80106830:	85 c0                	test   %eax,%eax
80106832:	74 05                	je     80106839 <trap+0x26>
      exit();
80106834:	e8 87 e0 ff ff       	call   801048c0 <exit>
    proc->tf = tf;
80106839:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010683f:	8b 55 08             	mov    0x8(%ebp),%edx
80106842:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106845:	e8 df ed ff ff       	call   80105629 <syscall>
    if(proc->killed)
8010684a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106850:	8b 40 24             	mov    0x24(%eax),%eax
80106853:	85 c0                	test   %eax,%eax
80106855:	0f 84 34 02 00 00    	je     80106a8f <trap+0x27c>
      exit();
8010685b:	e8 60 e0 ff ff       	call   801048c0 <exit>
    return;
80106860:	e9 2a 02 00 00       	jmp    80106a8f <trap+0x27c>
  }

  switch(tf->trapno){
80106865:	8b 45 08             	mov    0x8(%ebp),%eax
80106868:	8b 40 30             	mov    0x30(%eax),%eax
8010686b:	83 e8 20             	sub    $0x20,%eax
8010686e:	83 f8 1f             	cmp    $0x1f,%eax
80106871:	0f 87 bc 00 00 00    	ja     80106933 <trap+0x120>
80106877:	8b 04 85 30 8b 10 80 	mov    -0x7fef74d0(,%eax,4),%eax
8010687e:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106880:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106886:	0f b6 00             	movzbl (%eax),%eax
80106889:	84 c0                	test   %al,%al
8010688b:	75 31                	jne    801068be <trap+0xab>
      acquire(&tickslock);
8010688d:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
80106894:	e8 12 e7 ff ff       	call   80104fab <acquire>
      ticks++;
80106899:	a1 e0 50 11 80       	mov    0x801150e0,%eax
8010689e:	83 c0 01             	add    $0x1,%eax
801068a1:	a3 e0 50 11 80       	mov    %eax,0x801150e0
      wakeup(&ticks);
801068a6:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
801068ad:	e8 f4 e4 ff ff       	call   80104da6 <wakeup>
      release(&tickslock);
801068b2:	c7 04 24 a0 48 11 80 	movl   $0x801148a0,(%esp)
801068b9:	e8 4f e7 ff ff       	call   8010500d <release>
    }
    lapiceoi();
801068be:	e8 58 c7 ff ff       	call   8010301b <lapiceoi>
    break;
801068c3:	e9 41 01 00 00       	jmp    80106a09 <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801068c8:	e8 2b bf ff ff       	call   801027f8 <ideintr>
    lapiceoi();
801068cd:	e8 49 c7 ff ff       	call   8010301b <lapiceoi>
    break;
801068d2:	e9 32 01 00 00       	jmp    80106a09 <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801068d7:	e8 f1 c4 ff ff       	call   80102dcd <kbdintr>
    lapiceoi();
801068dc:	e8 3a c7 ff ff       	call   8010301b <lapiceoi>
    break;
801068e1:	e9 23 01 00 00       	jmp    80106a09 <trap+0x1f6>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801068e6:	e8 a9 03 00 00       	call   80106c94 <uartintr>
    lapiceoi();
801068eb:	e8 2b c7 ff ff       	call   8010301b <lapiceoi>
    break;
801068f0:	e9 14 01 00 00       	jmp    80106a09 <trap+0x1f6>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
801068f5:	8b 45 08             	mov    0x8(%ebp),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801068f8:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801068fb:	8b 45 08             	mov    0x8(%ebp),%eax
801068fe:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106902:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106905:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010690b:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010690e:	0f b6 c0             	movzbl %al,%eax
80106911:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106915:	89 54 24 08          	mov    %edx,0x8(%esp)
80106919:	89 44 24 04          	mov    %eax,0x4(%esp)
8010691d:	c7 04 24 90 8a 10 80 	movl   $0x80108a90,(%esp)
80106924:	e8 81 9a ff ff       	call   801003aa <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106929:	e8 ed c6 ff ff       	call   8010301b <lapiceoi>
    break;
8010692e:	e9 d6 00 00 00       	jmp    80106a09 <trap+0x1f6>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106933:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106939:	85 c0                	test   %eax,%eax
8010693b:	74 11                	je     8010694e <trap+0x13b>
8010693d:	8b 45 08             	mov    0x8(%ebp),%eax
80106940:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106944:	0f b7 c0             	movzwl %ax,%eax
80106947:	83 e0 03             	and    $0x3,%eax
8010694a:	85 c0                	test   %eax,%eax
8010694c:	75 46                	jne    80106994 <trap+0x181>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010694e:	e8 1a fd ff ff       	call   8010666d <rcr2>
              tf->trapno, cpu->id, tf->eip, rcr2());
80106953:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106956:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106959:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106960:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106963:	0f b6 ca             	movzbl %dl,%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106966:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106969:	8b 52 30             	mov    0x30(%edx),%edx
8010696c:	89 44 24 10          	mov    %eax,0x10(%esp)
80106970:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80106974:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106978:	89 54 24 04          	mov    %edx,0x4(%esp)
8010697c:	c7 04 24 b4 8a 10 80 	movl   $0x80108ab4,(%esp)
80106983:	e8 22 9a ff ff       	call   801003aa <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106988:	c7 04 24 e6 8a 10 80 	movl   $0x80108ae6,(%esp)
8010698f:	e8 b2 9b ff ff       	call   80100546 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106994:	e8 d4 fc ff ff       	call   8010666d <rcr2>
80106999:	89 c2                	mov    %eax,%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010699b:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010699e:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801069a1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801069a7:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801069aa:	0f b6 f0             	movzbl %al,%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801069ad:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801069b0:	8b 58 34             	mov    0x34(%eax),%ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801069b3:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801069b6:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801069b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069bf:	83 c0 6c             	add    $0x6c,%eax
801069c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069c5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801069cb:	8b 40 10             	mov    0x10(%eax),%eax
801069ce:	89 54 24 1c          	mov    %edx,0x1c(%esp)
801069d2:	89 7c 24 18          	mov    %edi,0x18(%esp)
801069d6:	89 74 24 14          	mov    %esi,0x14(%esp)
801069da:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801069de:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801069e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801069e5:	89 54 24 08          	mov    %edx,0x8(%esp)
801069e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801069ed:	c7 04 24 ec 8a 10 80 	movl   $0x80108aec,(%esp)
801069f4:	e8 b1 99 ff ff       	call   801003aa <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
801069f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069ff:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106a06:	eb 01                	jmp    80106a09 <trap+0x1f6>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106a08:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106a09:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a0f:	85 c0                	test   %eax,%eax
80106a11:	74 24                	je     80106a37 <trap+0x224>
80106a13:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a19:	8b 40 24             	mov    0x24(%eax),%eax
80106a1c:	85 c0                	test   %eax,%eax
80106a1e:	74 17                	je     80106a37 <trap+0x224>
80106a20:	8b 45 08             	mov    0x8(%ebp),%eax
80106a23:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a27:	0f b7 c0             	movzwl %ax,%eax
80106a2a:	83 e0 03             	and    $0x3,%eax
80106a2d:	83 f8 03             	cmp    $0x3,%eax
80106a30:	75 05                	jne    80106a37 <trap+0x224>
    exit();
80106a32:	e8 89 de ff ff       	call   801048c0 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106a37:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a3d:	85 c0                	test   %eax,%eax
80106a3f:	74 1e                	je     80106a5f <trap+0x24c>
80106a41:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a47:	8b 40 0c             	mov    0xc(%eax),%eax
80106a4a:	83 f8 04             	cmp    $0x4,%eax
80106a4d:	75 10                	jne    80106a5f <trap+0x24c>
80106a4f:	8b 45 08             	mov    0x8(%ebp),%eax
80106a52:	8b 40 30             	mov    0x30(%eax),%eax
80106a55:	83 f8 20             	cmp    $0x20,%eax
80106a58:	75 05                	jne    80106a5f <trap+0x24c>
    yield();
80106a5a:	e8 fd e1 ff ff       	call   80104c5c <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106a5f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a65:	85 c0                	test   %eax,%eax
80106a67:	74 27                	je     80106a90 <trap+0x27d>
80106a69:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a6f:	8b 40 24             	mov    0x24(%eax),%eax
80106a72:	85 c0                	test   %eax,%eax
80106a74:	74 1a                	je     80106a90 <trap+0x27d>
80106a76:	8b 45 08             	mov    0x8(%ebp),%eax
80106a79:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a7d:	0f b7 c0             	movzwl %ax,%eax
80106a80:	83 e0 03             	and    $0x3,%eax
80106a83:	83 f8 03             	cmp    $0x3,%eax
80106a86:	75 08                	jne    80106a90 <trap+0x27d>
    exit();
80106a88:	e8 33 de ff ff       	call   801048c0 <exit>
80106a8d:	eb 01                	jmp    80106a90 <trap+0x27d>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106a8f:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106a90:	83 c4 3c             	add    $0x3c,%esp
80106a93:	5b                   	pop    %ebx
80106a94:	5e                   	pop    %esi
80106a95:	5f                   	pop    %edi
80106a96:	5d                   	pop    %ebp
80106a97:	c3                   	ret    

80106a98 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106a98:	55                   	push   %ebp
80106a99:	89 e5                	mov    %esp,%ebp
80106a9b:	53                   	push   %ebx
80106a9c:	83 ec 14             	sub    $0x14,%esp
80106a9f:	8b 45 08             	mov    0x8(%ebp),%eax
80106aa2:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106aa6:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80106aaa:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80106aae:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80106ab2:	ec                   	in     (%dx),%al
80106ab3:	89 c3                	mov    %eax,%ebx
80106ab5:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80106ab8:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80106abc:	83 c4 14             	add    $0x14,%esp
80106abf:	5b                   	pop    %ebx
80106ac0:	5d                   	pop    %ebp
80106ac1:	c3                   	ret    

80106ac2 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106ac2:	55                   	push   %ebp
80106ac3:	89 e5                	mov    %esp,%ebp
80106ac5:	83 ec 08             	sub    $0x8,%esp
80106ac8:	8b 55 08             	mov    0x8(%ebp),%edx
80106acb:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ace:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106ad2:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ad5:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106ad9:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106add:	ee                   	out    %al,(%dx)
}
80106ade:	c9                   	leave  
80106adf:	c3                   	ret    

80106ae0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106ae6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106aed:	00 
80106aee:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106af5:	e8 c8 ff ff ff       	call   80106ac2 <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106afa:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
80106b01:	00 
80106b02:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106b09:	e8 b4 ff ff ff       	call   80106ac2 <outb>
  outb(COM1+0, 115200/9600);
80106b0e:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80106b15:	00 
80106b16:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106b1d:	e8 a0 ff ff ff       	call   80106ac2 <outb>
  outb(COM1+1, 0);
80106b22:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b29:	00 
80106b2a:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106b31:	e8 8c ff ff ff       	call   80106ac2 <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106b36:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106b3d:	00 
80106b3e:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106b45:	e8 78 ff ff ff       	call   80106ac2 <outb>
  outb(COM1+4, 0);
80106b4a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b51:	00 
80106b52:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106b59:	e8 64 ff ff ff       	call   80106ac2 <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106b5e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106b65:	00 
80106b66:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106b6d:	e8 50 ff ff ff       	call   80106ac2 <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106b72:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106b79:	e8 1a ff ff ff       	call   80106a98 <inb>
80106b7e:	3c ff                	cmp    $0xff,%al
80106b80:	74 6c                	je     80106bee <uartinit+0x10e>
    return;
  uart = 1;
80106b82:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
80106b89:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106b8c:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106b93:	e8 00 ff ff ff       	call   80106a98 <inb>
  inb(COM1+0);
80106b98:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106b9f:	e8 f4 fe ff ff       	call   80106a98 <inb>
  picenable(IRQ_COM1);
80106ba4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106bab:	e8 61 d3 ff ff       	call   80103f11 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106bb0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106bb7:	00 
80106bb8:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106bbf:	e8 b6 be ff ff       	call   80102a7a <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106bc4:	c7 45 f4 b0 8b 10 80 	movl   $0x80108bb0,-0xc(%ebp)
80106bcb:	eb 15                	jmp    80106be2 <uartinit+0x102>
    uartputc(*p);
80106bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bd0:	0f b6 00             	movzbl (%eax),%eax
80106bd3:	0f be c0             	movsbl %al,%eax
80106bd6:	89 04 24             	mov    %eax,(%esp)
80106bd9:	e8 13 00 00 00       	call   80106bf1 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106bde:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106be2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106be5:	0f b6 00             	movzbl (%eax),%eax
80106be8:	84 c0                	test   %al,%al
80106bea:	75 e1                	jne    80106bcd <uartinit+0xed>
80106bec:	eb 01                	jmp    80106bef <uartinit+0x10f>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106bee:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106bef:	c9                   	leave  
80106bf0:	c3                   	ret    

80106bf1 <uartputc>:

void
uartputc(int c)
{
80106bf1:	55                   	push   %ebp
80106bf2:	89 e5                	mov    %esp,%ebp
80106bf4:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80106bf7:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106bfc:	85 c0                	test   %eax,%eax
80106bfe:	74 4d                	je     80106c4d <uartputc+0x5c>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106c07:	eb 10                	jmp    80106c19 <uartputc+0x28>
    microdelay(10);
80106c09:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106c10:	e8 2b c4 ff ff       	call   80103040 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c15:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c19:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106c1d:	7f 16                	jg     80106c35 <uartputc+0x44>
80106c1f:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106c26:	e8 6d fe ff ff       	call   80106a98 <inb>
80106c2b:	0f b6 c0             	movzbl %al,%eax
80106c2e:	83 e0 20             	and    $0x20,%eax
80106c31:	85 c0                	test   %eax,%eax
80106c33:	74 d4                	je     80106c09 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106c35:	8b 45 08             	mov    0x8(%ebp),%eax
80106c38:	0f b6 c0             	movzbl %al,%eax
80106c3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c3f:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106c46:	e8 77 fe ff ff       	call   80106ac2 <outb>
80106c4b:	eb 01                	jmp    80106c4e <uartputc+0x5d>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106c4d:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106c4e:	c9                   	leave  
80106c4f:	c3                   	ret    

80106c50 <uartgetc>:

static int
uartgetc(void)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80106c56:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106c5b:	85 c0                	test   %eax,%eax
80106c5d:	75 07                	jne    80106c66 <uartgetc+0x16>
    return -1;
80106c5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c64:	eb 2c                	jmp    80106c92 <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80106c66:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106c6d:	e8 26 fe ff ff       	call   80106a98 <inb>
80106c72:	0f b6 c0             	movzbl %al,%eax
80106c75:	83 e0 01             	and    $0x1,%eax
80106c78:	85 c0                	test   %eax,%eax
80106c7a:	75 07                	jne    80106c83 <uartgetc+0x33>
    return -1;
80106c7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c81:	eb 0f                	jmp    80106c92 <uartgetc+0x42>
  return inb(COM1+0);
80106c83:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106c8a:	e8 09 fe ff ff       	call   80106a98 <inb>
80106c8f:	0f b6 c0             	movzbl %al,%eax
}
80106c92:	c9                   	leave  
80106c93:	c3                   	ret    

80106c94 <uartintr>:

void
uartintr(void)
{
80106c94:	55                   	push   %ebp
80106c95:	89 e5                	mov    %esp,%ebp
80106c97:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106c9a:	c7 04 24 50 6c 10 80 	movl   $0x80106c50,(%esp)
80106ca1:	e8 2b 9b ff ff       	call   801007d1 <consoleintr>
}
80106ca6:	c9                   	leave  
80106ca7:	c3                   	ret    

80106ca8 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106ca8:	6a 00                	push   $0x0
  pushl $0
80106caa:	6a 00                	push   $0x0
  jmp alltraps
80106cac:	e9 67 f9 ff ff       	jmp    80106618 <alltraps>

80106cb1 <vector1>:
.globl vector1
vector1:
  pushl $0
80106cb1:	6a 00                	push   $0x0
  pushl $1
80106cb3:	6a 01                	push   $0x1
  jmp alltraps
80106cb5:	e9 5e f9 ff ff       	jmp    80106618 <alltraps>

80106cba <vector2>:
.globl vector2
vector2:
  pushl $0
80106cba:	6a 00                	push   $0x0
  pushl $2
80106cbc:	6a 02                	push   $0x2
  jmp alltraps
80106cbe:	e9 55 f9 ff ff       	jmp    80106618 <alltraps>

80106cc3 <vector3>:
.globl vector3
vector3:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $3
80106cc5:	6a 03                	push   $0x3
  jmp alltraps
80106cc7:	e9 4c f9 ff ff       	jmp    80106618 <alltraps>

80106ccc <vector4>:
.globl vector4
vector4:
  pushl $0
80106ccc:	6a 00                	push   $0x0
  pushl $4
80106cce:	6a 04                	push   $0x4
  jmp alltraps
80106cd0:	e9 43 f9 ff ff       	jmp    80106618 <alltraps>

80106cd5 <vector5>:
.globl vector5
vector5:
  pushl $0
80106cd5:	6a 00                	push   $0x0
  pushl $5
80106cd7:	6a 05                	push   $0x5
  jmp alltraps
80106cd9:	e9 3a f9 ff ff       	jmp    80106618 <alltraps>

80106cde <vector6>:
.globl vector6
vector6:
  pushl $0
80106cde:	6a 00                	push   $0x0
  pushl $6
80106ce0:	6a 06                	push   $0x6
  jmp alltraps
80106ce2:	e9 31 f9 ff ff       	jmp    80106618 <alltraps>

80106ce7 <vector7>:
.globl vector7
vector7:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $7
80106ce9:	6a 07                	push   $0x7
  jmp alltraps
80106ceb:	e9 28 f9 ff ff       	jmp    80106618 <alltraps>

80106cf0 <vector8>:
.globl vector8
vector8:
  pushl $8
80106cf0:	6a 08                	push   $0x8
  jmp alltraps
80106cf2:	e9 21 f9 ff ff       	jmp    80106618 <alltraps>

80106cf7 <vector9>:
.globl vector9
vector9:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $9
80106cf9:	6a 09                	push   $0x9
  jmp alltraps
80106cfb:	e9 18 f9 ff ff       	jmp    80106618 <alltraps>

80106d00 <vector10>:
.globl vector10
vector10:
  pushl $10
80106d00:	6a 0a                	push   $0xa
  jmp alltraps
80106d02:	e9 11 f9 ff ff       	jmp    80106618 <alltraps>

80106d07 <vector11>:
.globl vector11
vector11:
  pushl $11
80106d07:	6a 0b                	push   $0xb
  jmp alltraps
80106d09:	e9 0a f9 ff ff       	jmp    80106618 <alltraps>

80106d0e <vector12>:
.globl vector12
vector12:
  pushl $12
80106d0e:	6a 0c                	push   $0xc
  jmp alltraps
80106d10:	e9 03 f9 ff ff       	jmp    80106618 <alltraps>

80106d15 <vector13>:
.globl vector13
vector13:
  pushl $13
80106d15:	6a 0d                	push   $0xd
  jmp alltraps
80106d17:	e9 fc f8 ff ff       	jmp    80106618 <alltraps>

80106d1c <vector14>:
.globl vector14
vector14:
  pushl $14
80106d1c:	6a 0e                	push   $0xe
  jmp alltraps
80106d1e:	e9 f5 f8 ff ff       	jmp    80106618 <alltraps>

80106d23 <vector15>:
.globl vector15
vector15:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $15
80106d25:	6a 0f                	push   $0xf
  jmp alltraps
80106d27:	e9 ec f8 ff ff       	jmp    80106618 <alltraps>

80106d2c <vector16>:
.globl vector16
vector16:
  pushl $0
80106d2c:	6a 00                	push   $0x0
  pushl $16
80106d2e:	6a 10                	push   $0x10
  jmp alltraps
80106d30:	e9 e3 f8 ff ff       	jmp    80106618 <alltraps>

80106d35 <vector17>:
.globl vector17
vector17:
  pushl $17
80106d35:	6a 11                	push   $0x11
  jmp alltraps
80106d37:	e9 dc f8 ff ff       	jmp    80106618 <alltraps>

80106d3c <vector18>:
.globl vector18
vector18:
  pushl $0
80106d3c:	6a 00                	push   $0x0
  pushl $18
80106d3e:	6a 12                	push   $0x12
  jmp alltraps
80106d40:	e9 d3 f8 ff ff       	jmp    80106618 <alltraps>

80106d45 <vector19>:
.globl vector19
vector19:
  pushl $0
80106d45:	6a 00                	push   $0x0
  pushl $19
80106d47:	6a 13                	push   $0x13
  jmp alltraps
80106d49:	e9 ca f8 ff ff       	jmp    80106618 <alltraps>

80106d4e <vector20>:
.globl vector20
vector20:
  pushl $0
80106d4e:	6a 00                	push   $0x0
  pushl $20
80106d50:	6a 14                	push   $0x14
  jmp alltraps
80106d52:	e9 c1 f8 ff ff       	jmp    80106618 <alltraps>

80106d57 <vector21>:
.globl vector21
vector21:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $21
80106d59:	6a 15                	push   $0x15
  jmp alltraps
80106d5b:	e9 b8 f8 ff ff       	jmp    80106618 <alltraps>

80106d60 <vector22>:
.globl vector22
vector22:
  pushl $0
80106d60:	6a 00                	push   $0x0
  pushl $22
80106d62:	6a 16                	push   $0x16
  jmp alltraps
80106d64:	e9 af f8 ff ff       	jmp    80106618 <alltraps>

80106d69 <vector23>:
.globl vector23
vector23:
  pushl $0
80106d69:	6a 00                	push   $0x0
  pushl $23
80106d6b:	6a 17                	push   $0x17
  jmp alltraps
80106d6d:	e9 a6 f8 ff ff       	jmp    80106618 <alltraps>

80106d72 <vector24>:
.globl vector24
vector24:
  pushl $0
80106d72:	6a 00                	push   $0x0
  pushl $24
80106d74:	6a 18                	push   $0x18
  jmp alltraps
80106d76:	e9 9d f8 ff ff       	jmp    80106618 <alltraps>

80106d7b <vector25>:
.globl vector25
vector25:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $25
80106d7d:	6a 19                	push   $0x19
  jmp alltraps
80106d7f:	e9 94 f8 ff ff       	jmp    80106618 <alltraps>

80106d84 <vector26>:
.globl vector26
vector26:
  pushl $0
80106d84:	6a 00                	push   $0x0
  pushl $26
80106d86:	6a 1a                	push   $0x1a
  jmp alltraps
80106d88:	e9 8b f8 ff ff       	jmp    80106618 <alltraps>

80106d8d <vector27>:
.globl vector27
vector27:
  pushl $0
80106d8d:	6a 00                	push   $0x0
  pushl $27
80106d8f:	6a 1b                	push   $0x1b
  jmp alltraps
80106d91:	e9 82 f8 ff ff       	jmp    80106618 <alltraps>

80106d96 <vector28>:
.globl vector28
vector28:
  pushl $0
80106d96:	6a 00                	push   $0x0
  pushl $28
80106d98:	6a 1c                	push   $0x1c
  jmp alltraps
80106d9a:	e9 79 f8 ff ff       	jmp    80106618 <alltraps>

80106d9f <vector29>:
.globl vector29
vector29:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $29
80106da1:	6a 1d                	push   $0x1d
  jmp alltraps
80106da3:	e9 70 f8 ff ff       	jmp    80106618 <alltraps>

80106da8 <vector30>:
.globl vector30
vector30:
  pushl $0
80106da8:	6a 00                	push   $0x0
  pushl $30
80106daa:	6a 1e                	push   $0x1e
  jmp alltraps
80106dac:	e9 67 f8 ff ff       	jmp    80106618 <alltraps>

80106db1 <vector31>:
.globl vector31
vector31:
  pushl $0
80106db1:	6a 00                	push   $0x0
  pushl $31
80106db3:	6a 1f                	push   $0x1f
  jmp alltraps
80106db5:	e9 5e f8 ff ff       	jmp    80106618 <alltraps>

80106dba <vector32>:
.globl vector32
vector32:
  pushl $0
80106dba:	6a 00                	push   $0x0
  pushl $32
80106dbc:	6a 20                	push   $0x20
  jmp alltraps
80106dbe:	e9 55 f8 ff ff       	jmp    80106618 <alltraps>

80106dc3 <vector33>:
.globl vector33
vector33:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $33
80106dc5:	6a 21                	push   $0x21
  jmp alltraps
80106dc7:	e9 4c f8 ff ff       	jmp    80106618 <alltraps>

80106dcc <vector34>:
.globl vector34
vector34:
  pushl $0
80106dcc:	6a 00                	push   $0x0
  pushl $34
80106dce:	6a 22                	push   $0x22
  jmp alltraps
80106dd0:	e9 43 f8 ff ff       	jmp    80106618 <alltraps>

80106dd5 <vector35>:
.globl vector35
vector35:
  pushl $0
80106dd5:	6a 00                	push   $0x0
  pushl $35
80106dd7:	6a 23                	push   $0x23
  jmp alltraps
80106dd9:	e9 3a f8 ff ff       	jmp    80106618 <alltraps>

80106dde <vector36>:
.globl vector36
vector36:
  pushl $0
80106dde:	6a 00                	push   $0x0
  pushl $36
80106de0:	6a 24                	push   $0x24
  jmp alltraps
80106de2:	e9 31 f8 ff ff       	jmp    80106618 <alltraps>

80106de7 <vector37>:
.globl vector37
vector37:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $37
80106de9:	6a 25                	push   $0x25
  jmp alltraps
80106deb:	e9 28 f8 ff ff       	jmp    80106618 <alltraps>

80106df0 <vector38>:
.globl vector38
vector38:
  pushl $0
80106df0:	6a 00                	push   $0x0
  pushl $38
80106df2:	6a 26                	push   $0x26
  jmp alltraps
80106df4:	e9 1f f8 ff ff       	jmp    80106618 <alltraps>

80106df9 <vector39>:
.globl vector39
vector39:
  pushl $0
80106df9:	6a 00                	push   $0x0
  pushl $39
80106dfb:	6a 27                	push   $0x27
  jmp alltraps
80106dfd:	e9 16 f8 ff ff       	jmp    80106618 <alltraps>

80106e02 <vector40>:
.globl vector40
vector40:
  pushl $0
80106e02:	6a 00                	push   $0x0
  pushl $40
80106e04:	6a 28                	push   $0x28
  jmp alltraps
80106e06:	e9 0d f8 ff ff       	jmp    80106618 <alltraps>

80106e0b <vector41>:
.globl vector41
vector41:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $41
80106e0d:	6a 29                	push   $0x29
  jmp alltraps
80106e0f:	e9 04 f8 ff ff       	jmp    80106618 <alltraps>

80106e14 <vector42>:
.globl vector42
vector42:
  pushl $0
80106e14:	6a 00                	push   $0x0
  pushl $42
80106e16:	6a 2a                	push   $0x2a
  jmp alltraps
80106e18:	e9 fb f7 ff ff       	jmp    80106618 <alltraps>

80106e1d <vector43>:
.globl vector43
vector43:
  pushl $0
80106e1d:	6a 00                	push   $0x0
  pushl $43
80106e1f:	6a 2b                	push   $0x2b
  jmp alltraps
80106e21:	e9 f2 f7 ff ff       	jmp    80106618 <alltraps>

80106e26 <vector44>:
.globl vector44
vector44:
  pushl $0
80106e26:	6a 00                	push   $0x0
  pushl $44
80106e28:	6a 2c                	push   $0x2c
  jmp alltraps
80106e2a:	e9 e9 f7 ff ff       	jmp    80106618 <alltraps>

80106e2f <vector45>:
.globl vector45
vector45:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $45
80106e31:	6a 2d                	push   $0x2d
  jmp alltraps
80106e33:	e9 e0 f7 ff ff       	jmp    80106618 <alltraps>

80106e38 <vector46>:
.globl vector46
vector46:
  pushl $0
80106e38:	6a 00                	push   $0x0
  pushl $46
80106e3a:	6a 2e                	push   $0x2e
  jmp alltraps
80106e3c:	e9 d7 f7 ff ff       	jmp    80106618 <alltraps>

80106e41 <vector47>:
.globl vector47
vector47:
  pushl $0
80106e41:	6a 00                	push   $0x0
  pushl $47
80106e43:	6a 2f                	push   $0x2f
  jmp alltraps
80106e45:	e9 ce f7 ff ff       	jmp    80106618 <alltraps>

80106e4a <vector48>:
.globl vector48
vector48:
  pushl $0
80106e4a:	6a 00                	push   $0x0
  pushl $48
80106e4c:	6a 30                	push   $0x30
  jmp alltraps
80106e4e:	e9 c5 f7 ff ff       	jmp    80106618 <alltraps>

80106e53 <vector49>:
.globl vector49
vector49:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $49
80106e55:	6a 31                	push   $0x31
  jmp alltraps
80106e57:	e9 bc f7 ff ff       	jmp    80106618 <alltraps>

80106e5c <vector50>:
.globl vector50
vector50:
  pushl $0
80106e5c:	6a 00                	push   $0x0
  pushl $50
80106e5e:	6a 32                	push   $0x32
  jmp alltraps
80106e60:	e9 b3 f7 ff ff       	jmp    80106618 <alltraps>

80106e65 <vector51>:
.globl vector51
vector51:
  pushl $0
80106e65:	6a 00                	push   $0x0
  pushl $51
80106e67:	6a 33                	push   $0x33
  jmp alltraps
80106e69:	e9 aa f7 ff ff       	jmp    80106618 <alltraps>

80106e6e <vector52>:
.globl vector52
vector52:
  pushl $0
80106e6e:	6a 00                	push   $0x0
  pushl $52
80106e70:	6a 34                	push   $0x34
  jmp alltraps
80106e72:	e9 a1 f7 ff ff       	jmp    80106618 <alltraps>

80106e77 <vector53>:
.globl vector53
vector53:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $53
80106e79:	6a 35                	push   $0x35
  jmp alltraps
80106e7b:	e9 98 f7 ff ff       	jmp    80106618 <alltraps>

80106e80 <vector54>:
.globl vector54
vector54:
  pushl $0
80106e80:	6a 00                	push   $0x0
  pushl $54
80106e82:	6a 36                	push   $0x36
  jmp alltraps
80106e84:	e9 8f f7 ff ff       	jmp    80106618 <alltraps>

80106e89 <vector55>:
.globl vector55
vector55:
  pushl $0
80106e89:	6a 00                	push   $0x0
  pushl $55
80106e8b:	6a 37                	push   $0x37
  jmp alltraps
80106e8d:	e9 86 f7 ff ff       	jmp    80106618 <alltraps>

80106e92 <vector56>:
.globl vector56
vector56:
  pushl $0
80106e92:	6a 00                	push   $0x0
  pushl $56
80106e94:	6a 38                	push   $0x38
  jmp alltraps
80106e96:	e9 7d f7 ff ff       	jmp    80106618 <alltraps>

80106e9b <vector57>:
.globl vector57
vector57:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $57
80106e9d:	6a 39                	push   $0x39
  jmp alltraps
80106e9f:	e9 74 f7 ff ff       	jmp    80106618 <alltraps>

80106ea4 <vector58>:
.globl vector58
vector58:
  pushl $0
80106ea4:	6a 00                	push   $0x0
  pushl $58
80106ea6:	6a 3a                	push   $0x3a
  jmp alltraps
80106ea8:	e9 6b f7 ff ff       	jmp    80106618 <alltraps>

80106ead <vector59>:
.globl vector59
vector59:
  pushl $0
80106ead:	6a 00                	push   $0x0
  pushl $59
80106eaf:	6a 3b                	push   $0x3b
  jmp alltraps
80106eb1:	e9 62 f7 ff ff       	jmp    80106618 <alltraps>

80106eb6 <vector60>:
.globl vector60
vector60:
  pushl $0
80106eb6:	6a 00                	push   $0x0
  pushl $60
80106eb8:	6a 3c                	push   $0x3c
  jmp alltraps
80106eba:	e9 59 f7 ff ff       	jmp    80106618 <alltraps>

80106ebf <vector61>:
.globl vector61
vector61:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $61
80106ec1:	6a 3d                	push   $0x3d
  jmp alltraps
80106ec3:	e9 50 f7 ff ff       	jmp    80106618 <alltraps>

80106ec8 <vector62>:
.globl vector62
vector62:
  pushl $0
80106ec8:	6a 00                	push   $0x0
  pushl $62
80106eca:	6a 3e                	push   $0x3e
  jmp alltraps
80106ecc:	e9 47 f7 ff ff       	jmp    80106618 <alltraps>

80106ed1 <vector63>:
.globl vector63
vector63:
  pushl $0
80106ed1:	6a 00                	push   $0x0
  pushl $63
80106ed3:	6a 3f                	push   $0x3f
  jmp alltraps
80106ed5:	e9 3e f7 ff ff       	jmp    80106618 <alltraps>

80106eda <vector64>:
.globl vector64
vector64:
  pushl $0
80106eda:	6a 00                	push   $0x0
  pushl $64
80106edc:	6a 40                	push   $0x40
  jmp alltraps
80106ede:	e9 35 f7 ff ff       	jmp    80106618 <alltraps>

80106ee3 <vector65>:
.globl vector65
vector65:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $65
80106ee5:	6a 41                	push   $0x41
  jmp alltraps
80106ee7:	e9 2c f7 ff ff       	jmp    80106618 <alltraps>

80106eec <vector66>:
.globl vector66
vector66:
  pushl $0
80106eec:	6a 00                	push   $0x0
  pushl $66
80106eee:	6a 42                	push   $0x42
  jmp alltraps
80106ef0:	e9 23 f7 ff ff       	jmp    80106618 <alltraps>

80106ef5 <vector67>:
.globl vector67
vector67:
  pushl $0
80106ef5:	6a 00                	push   $0x0
  pushl $67
80106ef7:	6a 43                	push   $0x43
  jmp alltraps
80106ef9:	e9 1a f7 ff ff       	jmp    80106618 <alltraps>

80106efe <vector68>:
.globl vector68
vector68:
  pushl $0
80106efe:	6a 00                	push   $0x0
  pushl $68
80106f00:	6a 44                	push   $0x44
  jmp alltraps
80106f02:	e9 11 f7 ff ff       	jmp    80106618 <alltraps>

80106f07 <vector69>:
.globl vector69
vector69:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $69
80106f09:	6a 45                	push   $0x45
  jmp alltraps
80106f0b:	e9 08 f7 ff ff       	jmp    80106618 <alltraps>

80106f10 <vector70>:
.globl vector70
vector70:
  pushl $0
80106f10:	6a 00                	push   $0x0
  pushl $70
80106f12:	6a 46                	push   $0x46
  jmp alltraps
80106f14:	e9 ff f6 ff ff       	jmp    80106618 <alltraps>

80106f19 <vector71>:
.globl vector71
vector71:
  pushl $0
80106f19:	6a 00                	push   $0x0
  pushl $71
80106f1b:	6a 47                	push   $0x47
  jmp alltraps
80106f1d:	e9 f6 f6 ff ff       	jmp    80106618 <alltraps>

80106f22 <vector72>:
.globl vector72
vector72:
  pushl $0
80106f22:	6a 00                	push   $0x0
  pushl $72
80106f24:	6a 48                	push   $0x48
  jmp alltraps
80106f26:	e9 ed f6 ff ff       	jmp    80106618 <alltraps>

80106f2b <vector73>:
.globl vector73
vector73:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $73
80106f2d:	6a 49                	push   $0x49
  jmp alltraps
80106f2f:	e9 e4 f6 ff ff       	jmp    80106618 <alltraps>

80106f34 <vector74>:
.globl vector74
vector74:
  pushl $0
80106f34:	6a 00                	push   $0x0
  pushl $74
80106f36:	6a 4a                	push   $0x4a
  jmp alltraps
80106f38:	e9 db f6 ff ff       	jmp    80106618 <alltraps>

80106f3d <vector75>:
.globl vector75
vector75:
  pushl $0
80106f3d:	6a 00                	push   $0x0
  pushl $75
80106f3f:	6a 4b                	push   $0x4b
  jmp alltraps
80106f41:	e9 d2 f6 ff ff       	jmp    80106618 <alltraps>

80106f46 <vector76>:
.globl vector76
vector76:
  pushl $0
80106f46:	6a 00                	push   $0x0
  pushl $76
80106f48:	6a 4c                	push   $0x4c
  jmp alltraps
80106f4a:	e9 c9 f6 ff ff       	jmp    80106618 <alltraps>

80106f4f <vector77>:
.globl vector77
vector77:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $77
80106f51:	6a 4d                	push   $0x4d
  jmp alltraps
80106f53:	e9 c0 f6 ff ff       	jmp    80106618 <alltraps>

80106f58 <vector78>:
.globl vector78
vector78:
  pushl $0
80106f58:	6a 00                	push   $0x0
  pushl $78
80106f5a:	6a 4e                	push   $0x4e
  jmp alltraps
80106f5c:	e9 b7 f6 ff ff       	jmp    80106618 <alltraps>

80106f61 <vector79>:
.globl vector79
vector79:
  pushl $0
80106f61:	6a 00                	push   $0x0
  pushl $79
80106f63:	6a 4f                	push   $0x4f
  jmp alltraps
80106f65:	e9 ae f6 ff ff       	jmp    80106618 <alltraps>

80106f6a <vector80>:
.globl vector80
vector80:
  pushl $0
80106f6a:	6a 00                	push   $0x0
  pushl $80
80106f6c:	6a 50                	push   $0x50
  jmp alltraps
80106f6e:	e9 a5 f6 ff ff       	jmp    80106618 <alltraps>

80106f73 <vector81>:
.globl vector81
vector81:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $81
80106f75:	6a 51                	push   $0x51
  jmp alltraps
80106f77:	e9 9c f6 ff ff       	jmp    80106618 <alltraps>

80106f7c <vector82>:
.globl vector82
vector82:
  pushl $0
80106f7c:	6a 00                	push   $0x0
  pushl $82
80106f7e:	6a 52                	push   $0x52
  jmp alltraps
80106f80:	e9 93 f6 ff ff       	jmp    80106618 <alltraps>

80106f85 <vector83>:
.globl vector83
vector83:
  pushl $0
80106f85:	6a 00                	push   $0x0
  pushl $83
80106f87:	6a 53                	push   $0x53
  jmp alltraps
80106f89:	e9 8a f6 ff ff       	jmp    80106618 <alltraps>

80106f8e <vector84>:
.globl vector84
vector84:
  pushl $0
80106f8e:	6a 00                	push   $0x0
  pushl $84
80106f90:	6a 54                	push   $0x54
  jmp alltraps
80106f92:	e9 81 f6 ff ff       	jmp    80106618 <alltraps>

80106f97 <vector85>:
.globl vector85
vector85:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $85
80106f99:	6a 55                	push   $0x55
  jmp alltraps
80106f9b:	e9 78 f6 ff ff       	jmp    80106618 <alltraps>

80106fa0 <vector86>:
.globl vector86
vector86:
  pushl $0
80106fa0:	6a 00                	push   $0x0
  pushl $86
80106fa2:	6a 56                	push   $0x56
  jmp alltraps
80106fa4:	e9 6f f6 ff ff       	jmp    80106618 <alltraps>

80106fa9 <vector87>:
.globl vector87
vector87:
  pushl $0
80106fa9:	6a 00                	push   $0x0
  pushl $87
80106fab:	6a 57                	push   $0x57
  jmp alltraps
80106fad:	e9 66 f6 ff ff       	jmp    80106618 <alltraps>

80106fb2 <vector88>:
.globl vector88
vector88:
  pushl $0
80106fb2:	6a 00                	push   $0x0
  pushl $88
80106fb4:	6a 58                	push   $0x58
  jmp alltraps
80106fb6:	e9 5d f6 ff ff       	jmp    80106618 <alltraps>

80106fbb <vector89>:
.globl vector89
vector89:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $89
80106fbd:	6a 59                	push   $0x59
  jmp alltraps
80106fbf:	e9 54 f6 ff ff       	jmp    80106618 <alltraps>

80106fc4 <vector90>:
.globl vector90
vector90:
  pushl $0
80106fc4:	6a 00                	push   $0x0
  pushl $90
80106fc6:	6a 5a                	push   $0x5a
  jmp alltraps
80106fc8:	e9 4b f6 ff ff       	jmp    80106618 <alltraps>

80106fcd <vector91>:
.globl vector91
vector91:
  pushl $0
80106fcd:	6a 00                	push   $0x0
  pushl $91
80106fcf:	6a 5b                	push   $0x5b
  jmp alltraps
80106fd1:	e9 42 f6 ff ff       	jmp    80106618 <alltraps>

80106fd6 <vector92>:
.globl vector92
vector92:
  pushl $0
80106fd6:	6a 00                	push   $0x0
  pushl $92
80106fd8:	6a 5c                	push   $0x5c
  jmp alltraps
80106fda:	e9 39 f6 ff ff       	jmp    80106618 <alltraps>

80106fdf <vector93>:
.globl vector93
vector93:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $93
80106fe1:	6a 5d                	push   $0x5d
  jmp alltraps
80106fe3:	e9 30 f6 ff ff       	jmp    80106618 <alltraps>

80106fe8 <vector94>:
.globl vector94
vector94:
  pushl $0
80106fe8:	6a 00                	push   $0x0
  pushl $94
80106fea:	6a 5e                	push   $0x5e
  jmp alltraps
80106fec:	e9 27 f6 ff ff       	jmp    80106618 <alltraps>

80106ff1 <vector95>:
.globl vector95
vector95:
  pushl $0
80106ff1:	6a 00                	push   $0x0
  pushl $95
80106ff3:	6a 5f                	push   $0x5f
  jmp alltraps
80106ff5:	e9 1e f6 ff ff       	jmp    80106618 <alltraps>

80106ffa <vector96>:
.globl vector96
vector96:
  pushl $0
80106ffa:	6a 00                	push   $0x0
  pushl $96
80106ffc:	6a 60                	push   $0x60
  jmp alltraps
80106ffe:	e9 15 f6 ff ff       	jmp    80106618 <alltraps>

80107003 <vector97>:
.globl vector97
vector97:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $97
80107005:	6a 61                	push   $0x61
  jmp alltraps
80107007:	e9 0c f6 ff ff       	jmp    80106618 <alltraps>

8010700c <vector98>:
.globl vector98
vector98:
  pushl $0
8010700c:	6a 00                	push   $0x0
  pushl $98
8010700e:	6a 62                	push   $0x62
  jmp alltraps
80107010:	e9 03 f6 ff ff       	jmp    80106618 <alltraps>

80107015 <vector99>:
.globl vector99
vector99:
  pushl $0
80107015:	6a 00                	push   $0x0
  pushl $99
80107017:	6a 63                	push   $0x63
  jmp alltraps
80107019:	e9 fa f5 ff ff       	jmp    80106618 <alltraps>

8010701e <vector100>:
.globl vector100
vector100:
  pushl $0
8010701e:	6a 00                	push   $0x0
  pushl $100
80107020:	6a 64                	push   $0x64
  jmp alltraps
80107022:	e9 f1 f5 ff ff       	jmp    80106618 <alltraps>

80107027 <vector101>:
.globl vector101
vector101:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $101
80107029:	6a 65                	push   $0x65
  jmp alltraps
8010702b:	e9 e8 f5 ff ff       	jmp    80106618 <alltraps>

80107030 <vector102>:
.globl vector102
vector102:
  pushl $0
80107030:	6a 00                	push   $0x0
  pushl $102
80107032:	6a 66                	push   $0x66
  jmp alltraps
80107034:	e9 df f5 ff ff       	jmp    80106618 <alltraps>

80107039 <vector103>:
.globl vector103
vector103:
  pushl $0
80107039:	6a 00                	push   $0x0
  pushl $103
8010703b:	6a 67                	push   $0x67
  jmp alltraps
8010703d:	e9 d6 f5 ff ff       	jmp    80106618 <alltraps>

80107042 <vector104>:
.globl vector104
vector104:
  pushl $0
80107042:	6a 00                	push   $0x0
  pushl $104
80107044:	6a 68                	push   $0x68
  jmp alltraps
80107046:	e9 cd f5 ff ff       	jmp    80106618 <alltraps>

8010704b <vector105>:
.globl vector105
vector105:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $105
8010704d:	6a 69                	push   $0x69
  jmp alltraps
8010704f:	e9 c4 f5 ff ff       	jmp    80106618 <alltraps>

80107054 <vector106>:
.globl vector106
vector106:
  pushl $0
80107054:	6a 00                	push   $0x0
  pushl $106
80107056:	6a 6a                	push   $0x6a
  jmp alltraps
80107058:	e9 bb f5 ff ff       	jmp    80106618 <alltraps>

8010705d <vector107>:
.globl vector107
vector107:
  pushl $0
8010705d:	6a 00                	push   $0x0
  pushl $107
8010705f:	6a 6b                	push   $0x6b
  jmp alltraps
80107061:	e9 b2 f5 ff ff       	jmp    80106618 <alltraps>

80107066 <vector108>:
.globl vector108
vector108:
  pushl $0
80107066:	6a 00                	push   $0x0
  pushl $108
80107068:	6a 6c                	push   $0x6c
  jmp alltraps
8010706a:	e9 a9 f5 ff ff       	jmp    80106618 <alltraps>

8010706f <vector109>:
.globl vector109
vector109:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $109
80107071:	6a 6d                	push   $0x6d
  jmp alltraps
80107073:	e9 a0 f5 ff ff       	jmp    80106618 <alltraps>

80107078 <vector110>:
.globl vector110
vector110:
  pushl $0
80107078:	6a 00                	push   $0x0
  pushl $110
8010707a:	6a 6e                	push   $0x6e
  jmp alltraps
8010707c:	e9 97 f5 ff ff       	jmp    80106618 <alltraps>

80107081 <vector111>:
.globl vector111
vector111:
  pushl $0
80107081:	6a 00                	push   $0x0
  pushl $111
80107083:	6a 6f                	push   $0x6f
  jmp alltraps
80107085:	e9 8e f5 ff ff       	jmp    80106618 <alltraps>

8010708a <vector112>:
.globl vector112
vector112:
  pushl $0
8010708a:	6a 00                	push   $0x0
  pushl $112
8010708c:	6a 70                	push   $0x70
  jmp alltraps
8010708e:	e9 85 f5 ff ff       	jmp    80106618 <alltraps>

80107093 <vector113>:
.globl vector113
vector113:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $113
80107095:	6a 71                	push   $0x71
  jmp alltraps
80107097:	e9 7c f5 ff ff       	jmp    80106618 <alltraps>

8010709c <vector114>:
.globl vector114
vector114:
  pushl $0
8010709c:	6a 00                	push   $0x0
  pushl $114
8010709e:	6a 72                	push   $0x72
  jmp alltraps
801070a0:	e9 73 f5 ff ff       	jmp    80106618 <alltraps>

801070a5 <vector115>:
.globl vector115
vector115:
  pushl $0
801070a5:	6a 00                	push   $0x0
  pushl $115
801070a7:	6a 73                	push   $0x73
  jmp alltraps
801070a9:	e9 6a f5 ff ff       	jmp    80106618 <alltraps>

801070ae <vector116>:
.globl vector116
vector116:
  pushl $0
801070ae:	6a 00                	push   $0x0
  pushl $116
801070b0:	6a 74                	push   $0x74
  jmp alltraps
801070b2:	e9 61 f5 ff ff       	jmp    80106618 <alltraps>

801070b7 <vector117>:
.globl vector117
vector117:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $117
801070b9:	6a 75                	push   $0x75
  jmp alltraps
801070bb:	e9 58 f5 ff ff       	jmp    80106618 <alltraps>

801070c0 <vector118>:
.globl vector118
vector118:
  pushl $0
801070c0:	6a 00                	push   $0x0
  pushl $118
801070c2:	6a 76                	push   $0x76
  jmp alltraps
801070c4:	e9 4f f5 ff ff       	jmp    80106618 <alltraps>

801070c9 <vector119>:
.globl vector119
vector119:
  pushl $0
801070c9:	6a 00                	push   $0x0
  pushl $119
801070cb:	6a 77                	push   $0x77
  jmp alltraps
801070cd:	e9 46 f5 ff ff       	jmp    80106618 <alltraps>

801070d2 <vector120>:
.globl vector120
vector120:
  pushl $0
801070d2:	6a 00                	push   $0x0
  pushl $120
801070d4:	6a 78                	push   $0x78
  jmp alltraps
801070d6:	e9 3d f5 ff ff       	jmp    80106618 <alltraps>

801070db <vector121>:
.globl vector121
vector121:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $121
801070dd:	6a 79                	push   $0x79
  jmp alltraps
801070df:	e9 34 f5 ff ff       	jmp    80106618 <alltraps>

801070e4 <vector122>:
.globl vector122
vector122:
  pushl $0
801070e4:	6a 00                	push   $0x0
  pushl $122
801070e6:	6a 7a                	push   $0x7a
  jmp alltraps
801070e8:	e9 2b f5 ff ff       	jmp    80106618 <alltraps>

801070ed <vector123>:
.globl vector123
vector123:
  pushl $0
801070ed:	6a 00                	push   $0x0
  pushl $123
801070ef:	6a 7b                	push   $0x7b
  jmp alltraps
801070f1:	e9 22 f5 ff ff       	jmp    80106618 <alltraps>

801070f6 <vector124>:
.globl vector124
vector124:
  pushl $0
801070f6:	6a 00                	push   $0x0
  pushl $124
801070f8:	6a 7c                	push   $0x7c
  jmp alltraps
801070fa:	e9 19 f5 ff ff       	jmp    80106618 <alltraps>

801070ff <vector125>:
.globl vector125
vector125:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $125
80107101:	6a 7d                	push   $0x7d
  jmp alltraps
80107103:	e9 10 f5 ff ff       	jmp    80106618 <alltraps>

80107108 <vector126>:
.globl vector126
vector126:
  pushl $0
80107108:	6a 00                	push   $0x0
  pushl $126
8010710a:	6a 7e                	push   $0x7e
  jmp alltraps
8010710c:	e9 07 f5 ff ff       	jmp    80106618 <alltraps>

80107111 <vector127>:
.globl vector127
vector127:
  pushl $0
80107111:	6a 00                	push   $0x0
  pushl $127
80107113:	6a 7f                	push   $0x7f
  jmp alltraps
80107115:	e9 fe f4 ff ff       	jmp    80106618 <alltraps>

8010711a <vector128>:
.globl vector128
vector128:
  pushl $0
8010711a:	6a 00                	push   $0x0
  pushl $128
8010711c:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107121:	e9 f2 f4 ff ff       	jmp    80106618 <alltraps>

80107126 <vector129>:
.globl vector129
vector129:
  pushl $0
80107126:	6a 00                	push   $0x0
  pushl $129
80107128:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010712d:	e9 e6 f4 ff ff       	jmp    80106618 <alltraps>

80107132 <vector130>:
.globl vector130
vector130:
  pushl $0
80107132:	6a 00                	push   $0x0
  pushl $130
80107134:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107139:	e9 da f4 ff ff       	jmp    80106618 <alltraps>

8010713e <vector131>:
.globl vector131
vector131:
  pushl $0
8010713e:	6a 00                	push   $0x0
  pushl $131
80107140:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107145:	e9 ce f4 ff ff       	jmp    80106618 <alltraps>

8010714a <vector132>:
.globl vector132
vector132:
  pushl $0
8010714a:	6a 00                	push   $0x0
  pushl $132
8010714c:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107151:	e9 c2 f4 ff ff       	jmp    80106618 <alltraps>

80107156 <vector133>:
.globl vector133
vector133:
  pushl $0
80107156:	6a 00                	push   $0x0
  pushl $133
80107158:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010715d:	e9 b6 f4 ff ff       	jmp    80106618 <alltraps>

80107162 <vector134>:
.globl vector134
vector134:
  pushl $0
80107162:	6a 00                	push   $0x0
  pushl $134
80107164:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107169:	e9 aa f4 ff ff       	jmp    80106618 <alltraps>

8010716e <vector135>:
.globl vector135
vector135:
  pushl $0
8010716e:	6a 00                	push   $0x0
  pushl $135
80107170:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107175:	e9 9e f4 ff ff       	jmp    80106618 <alltraps>

8010717a <vector136>:
.globl vector136
vector136:
  pushl $0
8010717a:	6a 00                	push   $0x0
  pushl $136
8010717c:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107181:	e9 92 f4 ff ff       	jmp    80106618 <alltraps>

80107186 <vector137>:
.globl vector137
vector137:
  pushl $0
80107186:	6a 00                	push   $0x0
  pushl $137
80107188:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010718d:	e9 86 f4 ff ff       	jmp    80106618 <alltraps>

80107192 <vector138>:
.globl vector138
vector138:
  pushl $0
80107192:	6a 00                	push   $0x0
  pushl $138
80107194:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107199:	e9 7a f4 ff ff       	jmp    80106618 <alltraps>

8010719e <vector139>:
.globl vector139
vector139:
  pushl $0
8010719e:	6a 00                	push   $0x0
  pushl $139
801071a0:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801071a5:	e9 6e f4 ff ff       	jmp    80106618 <alltraps>

801071aa <vector140>:
.globl vector140
vector140:
  pushl $0
801071aa:	6a 00                	push   $0x0
  pushl $140
801071ac:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801071b1:	e9 62 f4 ff ff       	jmp    80106618 <alltraps>

801071b6 <vector141>:
.globl vector141
vector141:
  pushl $0
801071b6:	6a 00                	push   $0x0
  pushl $141
801071b8:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801071bd:	e9 56 f4 ff ff       	jmp    80106618 <alltraps>

801071c2 <vector142>:
.globl vector142
vector142:
  pushl $0
801071c2:	6a 00                	push   $0x0
  pushl $142
801071c4:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801071c9:	e9 4a f4 ff ff       	jmp    80106618 <alltraps>

801071ce <vector143>:
.globl vector143
vector143:
  pushl $0
801071ce:	6a 00                	push   $0x0
  pushl $143
801071d0:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801071d5:	e9 3e f4 ff ff       	jmp    80106618 <alltraps>

801071da <vector144>:
.globl vector144
vector144:
  pushl $0
801071da:	6a 00                	push   $0x0
  pushl $144
801071dc:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801071e1:	e9 32 f4 ff ff       	jmp    80106618 <alltraps>

801071e6 <vector145>:
.globl vector145
vector145:
  pushl $0
801071e6:	6a 00                	push   $0x0
  pushl $145
801071e8:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801071ed:	e9 26 f4 ff ff       	jmp    80106618 <alltraps>

801071f2 <vector146>:
.globl vector146
vector146:
  pushl $0
801071f2:	6a 00                	push   $0x0
  pushl $146
801071f4:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801071f9:	e9 1a f4 ff ff       	jmp    80106618 <alltraps>

801071fe <vector147>:
.globl vector147
vector147:
  pushl $0
801071fe:	6a 00                	push   $0x0
  pushl $147
80107200:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107205:	e9 0e f4 ff ff       	jmp    80106618 <alltraps>

8010720a <vector148>:
.globl vector148
vector148:
  pushl $0
8010720a:	6a 00                	push   $0x0
  pushl $148
8010720c:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107211:	e9 02 f4 ff ff       	jmp    80106618 <alltraps>

80107216 <vector149>:
.globl vector149
vector149:
  pushl $0
80107216:	6a 00                	push   $0x0
  pushl $149
80107218:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010721d:	e9 f6 f3 ff ff       	jmp    80106618 <alltraps>

80107222 <vector150>:
.globl vector150
vector150:
  pushl $0
80107222:	6a 00                	push   $0x0
  pushl $150
80107224:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107229:	e9 ea f3 ff ff       	jmp    80106618 <alltraps>

8010722e <vector151>:
.globl vector151
vector151:
  pushl $0
8010722e:	6a 00                	push   $0x0
  pushl $151
80107230:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107235:	e9 de f3 ff ff       	jmp    80106618 <alltraps>

8010723a <vector152>:
.globl vector152
vector152:
  pushl $0
8010723a:	6a 00                	push   $0x0
  pushl $152
8010723c:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107241:	e9 d2 f3 ff ff       	jmp    80106618 <alltraps>

80107246 <vector153>:
.globl vector153
vector153:
  pushl $0
80107246:	6a 00                	push   $0x0
  pushl $153
80107248:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010724d:	e9 c6 f3 ff ff       	jmp    80106618 <alltraps>

80107252 <vector154>:
.globl vector154
vector154:
  pushl $0
80107252:	6a 00                	push   $0x0
  pushl $154
80107254:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107259:	e9 ba f3 ff ff       	jmp    80106618 <alltraps>

8010725e <vector155>:
.globl vector155
vector155:
  pushl $0
8010725e:	6a 00                	push   $0x0
  pushl $155
80107260:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107265:	e9 ae f3 ff ff       	jmp    80106618 <alltraps>

8010726a <vector156>:
.globl vector156
vector156:
  pushl $0
8010726a:	6a 00                	push   $0x0
  pushl $156
8010726c:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107271:	e9 a2 f3 ff ff       	jmp    80106618 <alltraps>

80107276 <vector157>:
.globl vector157
vector157:
  pushl $0
80107276:	6a 00                	push   $0x0
  pushl $157
80107278:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010727d:	e9 96 f3 ff ff       	jmp    80106618 <alltraps>

80107282 <vector158>:
.globl vector158
vector158:
  pushl $0
80107282:	6a 00                	push   $0x0
  pushl $158
80107284:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107289:	e9 8a f3 ff ff       	jmp    80106618 <alltraps>

8010728e <vector159>:
.globl vector159
vector159:
  pushl $0
8010728e:	6a 00                	push   $0x0
  pushl $159
80107290:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107295:	e9 7e f3 ff ff       	jmp    80106618 <alltraps>

8010729a <vector160>:
.globl vector160
vector160:
  pushl $0
8010729a:	6a 00                	push   $0x0
  pushl $160
8010729c:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801072a1:	e9 72 f3 ff ff       	jmp    80106618 <alltraps>

801072a6 <vector161>:
.globl vector161
vector161:
  pushl $0
801072a6:	6a 00                	push   $0x0
  pushl $161
801072a8:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801072ad:	e9 66 f3 ff ff       	jmp    80106618 <alltraps>

801072b2 <vector162>:
.globl vector162
vector162:
  pushl $0
801072b2:	6a 00                	push   $0x0
  pushl $162
801072b4:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801072b9:	e9 5a f3 ff ff       	jmp    80106618 <alltraps>

801072be <vector163>:
.globl vector163
vector163:
  pushl $0
801072be:	6a 00                	push   $0x0
  pushl $163
801072c0:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801072c5:	e9 4e f3 ff ff       	jmp    80106618 <alltraps>

801072ca <vector164>:
.globl vector164
vector164:
  pushl $0
801072ca:	6a 00                	push   $0x0
  pushl $164
801072cc:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801072d1:	e9 42 f3 ff ff       	jmp    80106618 <alltraps>

801072d6 <vector165>:
.globl vector165
vector165:
  pushl $0
801072d6:	6a 00                	push   $0x0
  pushl $165
801072d8:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801072dd:	e9 36 f3 ff ff       	jmp    80106618 <alltraps>

801072e2 <vector166>:
.globl vector166
vector166:
  pushl $0
801072e2:	6a 00                	push   $0x0
  pushl $166
801072e4:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801072e9:	e9 2a f3 ff ff       	jmp    80106618 <alltraps>

801072ee <vector167>:
.globl vector167
vector167:
  pushl $0
801072ee:	6a 00                	push   $0x0
  pushl $167
801072f0:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801072f5:	e9 1e f3 ff ff       	jmp    80106618 <alltraps>

801072fa <vector168>:
.globl vector168
vector168:
  pushl $0
801072fa:	6a 00                	push   $0x0
  pushl $168
801072fc:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107301:	e9 12 f3 ff ff       	jmp    80106618 <alltraps>

80107306 <vector169>:
.globl vector169
vector169:
  pushl $0
80107306:	6a 00                	push   $0x0
  pushl $169
80107308:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010730d:	e9 06 f3 ff ff       	jmp    80106618 <alltraps>

80107312 <vector170>:
.globl vector170
vector170:
  pushl $0
80107312:	6a 00                	push   $0x0
  pushl $170
80107314:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107319:	e9 fa f2 ff ff       	jmp    80106618 <alltraps>

8010731e <vector171>:
.globl vector171
vector171:
  pushl $0
8010731e:	6a 00                	push   $0x0
  pushl $171
80107320:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107325:	e9 ee f2 ff ff       	jmp    80106618 <alltraps>

8010732a <vector172>:
.globl vector172
vector172:
  pushl $0
8010732a:	6a 00                	push   $0x0
  pushl $172
8010732c:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107331:	e9 e2 f2 ff ff       	jmp    80106618 <alltraps>

80107336 <vector173>:
.globl vector173
vector173:
  pushl $0
80107336:	6a 00                	push   $0x0
  pushl $173
80107338:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010733d:	e9 d6 f2 ff ff       	jmp    80106618 <alltraps>

80107342 <vector174>:
.globl vector174
vector174:
  pushl $0
80107342:	6a 00                	push   $0x0
  pushl $174
80107344:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107349:	e9 ca f2 ff ff       	jmp    80106618 <alltraps>

8010734e <vector175>:
.globl vector175
vector175:
  pushl $0
8010734e:	6a 00                	push   $0x0
  pushl $175
80107350:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107355:	e9 be f2 ff ff       	jmp    80106618 <alltraps>

8010735a <vector176>:
.globl vector176
vector176:
  pushl $0
8010735a:	6a 00                	push   $0x0
  pushl $176
8010735c:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107361:	e9 b2 f2 ff ff       	jmp    80106618 <alltraps>

80107366 <vector177>:
.globl vector177
vector177:
  pushl $0
80107366:	6a 00                	push   $0x0
  pushl $177
80107368:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010736d:	e9 a6 f2 ff ff       	jmp    80106618 <alltraps>

80107372 <vector178>:
.globl vector178
vector178:
  pushl $0
80107372:	6a 00                	push   $0x0
  pushl $178
80107374:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107379:	e9 9a f2 ff ff       	jmp    80106618 <alltraps>

8010737e <vector179>:
.globl vector179
vector179:
  pushl $0
8010737e:	6a 00                	push   $0x0
  pushl $179
80107380:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107385:	e9 8e f2 ff ff       	jmp    80106618 <alltraps>

8010738a <vector180>:
.globl vector180
vector180:
  pushl $0
8010738a:	6a 00                	push   $0x0
  pushl $180
8010738c:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107391:	e9 82 f2 ff ff       	jmp    80106618 <alltraps>

80107396 <vector181>:
.globl vector181
vector181:
  pushl $0
80107396:	6a 00                	push   $0x0
  pushl $181
80107398:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010739d:	e9 76 f2 ff ff       	jmp    80106618 <alltraps>

801073a2 <vector182>:
.globl vector182
vector182:
  pushl $0
801073a2:	6a 00                	push   $0x0
  pushl $182
801073a4:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801073a9:	e9 6a f2 ff ff       	jmp    80106618 <alltraps>

801073ae <vector183>:
.globl vector183
vector183:
  pushl $0
801073ae:	6a 00                	push   $0x0
  pushl $183
801073b0:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801073b5:	e9 5e f2 ff ff       	jmp    80106618 <alltraps>

801073ba <vector184>:
.globl vector184
vector184:
  pushl $0
801073ba:	6a 00                	push   $0x0
  pushl $184
801073bc:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801073c1:	e9 52 f2 ff ff       	jmp    80106618 <alltraps>

801073c6 <vector185>:
.globl vector185
vector185:
  pushl $0
801073c6:	6a 00                	push   $0x0
  pushl $185
801073c8:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801073cd:	e9 46 f2 ff ff       	jmp    80106618 <alltraps>

801073d2 <vector186>:
.globl vector186
vector186:
  pushl $0
801073d2:	6a 00                	push   $0x0
  pushl $186
801073d4:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801073d9:	e9 3a f2 ff ff       	jmp    80106618 <alltraps>

801073de <vector187>:
.globl vector187
vector187:
  pushl $0
801073de:	6a 00                	push   $0x0
  pushl $187
801073e0:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801073e5:	e9 2e f2 ff ff       	jmp    80106618 <alltraps>

801073ea <vector188>:
.globl vector188
vector188:
  pushl $0
801073ea:	6a 00                	push   $0x0
  pushl $188
801073ec:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801073f1:	e9 22 f2 ff ff       	jmp    80106618 <alltraps>

801073f6 <vector189>:
.globl vector189
vector189:
  pushl $0
801073f6:	6a 00                	push   $0x0
  pushl $189
801073f8:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801073fd:	e9 16 f2 ff ff       	jmp    80106618 <alltraps>

80107402 <vector190>:
.globl vector190
vector190:
  pushl $0
80107402:	6a 00                	push   $0x0
  pushl $190
80107404:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107409:	e9 0a f2 ff ff       	jmp    80106618 <alltraps>

8010740e <vector191>:
.globl vector191
vector191:
  pushl $0
8010740e:	6a 00                	push   $0x0
  pushl $191
80107410:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107415:	e9 fe f1 ff ff       	jmp    80106618 <alltraps>

8010741a <vector192>:
.globl vector192
vector192:
  pushl $0
8010741a:	6a 00                	push   $0x0
  pushl $192
8010741c:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107421:	e9 f2 f1 ff ff       	jmp    80106618 <alltraps>

80107426 <vector193>:
.globl vector193
vector193:
  pushl $0
80107426:	6a 00                	push   $0x0
  pushl $193
80107428:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010742d:	e9 e6 f1 ff ff       	jmp    80106618 <alltraps>

80107432 <vector194>:
.globl vector194
vector194:
  pushl $0
80107432:	6a 00                	push   $0x0
  pushl $194
80107434:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107439:	e9 da f1 ff ff       	jmp    80106618 <alltraps>

8010743e <vector195>:
.globl vector195
vector195:
  pushl $0
8010743e:	6a 00                	push   $0x0
  pushl $195
80107440:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107445:	e9 ce f1 ff ff       	jmp    80106618 <alltraps>

8010744a <vector196>:
.globl vector196
vector196:
  pushl $0
8010744a:	6a 00                	push   $0x0
  pushl $196
8010744c:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107451:	e9 c2 f1 ff ff       	jmp    80106618 <alltraps>

80107456 <vector197>:
.globl vector197
vector197:
  pushl $0
80107456:	6a 00                	push   $0x0
  pushl $197
80107458:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010745d:	e9 b6 f1 ff ff       	jmp    80106618 <alltraps>

80107462 <vector198>:
.globl vector198
vector198:
  pushl $0
80107462:	6a 00                	push   $0x0
  pushl $198
80107464:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107469:	e9 aa f1 ff ff       	jmp    80106618 <alltraps>

8010746e <vector199>:
.globl vector199
vector199:
  pushl $0
8010746e:	6a 00                	push   $0x0
  pushl $199
80107470:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107475:	e9 9e f1 ff ff       	jmp    80106618 <alltraps>

8010747a <vector200>:
.globl vector200
vector200:
  pushl $0
8010747a:	6a 00                	push   $0x0
  pushl $200
8010747c:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107481:	e9 92 f1 ff ff       	jmp    80106618 <alltraps>

80107486 <vector201>:
.globl vector201
vector201:
  pushl $0
80107486:	6a 00                	push   $0x0
  pushl $201
80107488:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010748d:	e9 86 f1 ff ff       	jmp    80106618 <alltraps>

80107492 <vector202>:
.globl vector202
vector202:
  pushl $0
80107492:	6a 00                	push   $0x0
  pushl $202
80107494:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107499:	e9 7a f1 ff ff       	jmp    80106618 <alltraps>

8010749e <vector203>:
.globl vector203
vector203:
  pushl $0
8010749e:	6a 00                	push   $0x0
  pushl $203
801074a0:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801074a5:	e9 6e f1 ff ff       	jmp    80106618 <alltraps>

801074aa <vector204>:
.globl vector204
vector204:
  pushl $0
801074aa:	6a 00                	push   $0x0
  pushl $204
801074ac:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801074b1:	e9 62 f1 ff ff       	jmp    80106618 <alltraps>

801074b6 <vector205>:
.globl vector205
vector205:
  pushl $0
801074b6:	6a 00                	push   $0x0
  pushl $205
801074b8:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801074bd:	e9 56 f1 ff ff       	jmp    80106618 <alltraps>

801074c2 <vector206>:
.globl vector206
vector206:
  pushl $0
801074c2:	6a 00                	push   $0x0
  pushl $206
801074c4:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801074c9:	e9 4a f1 ff ff       	jmp    80106618 <alltraps>

801074ce <vector207>:
.globl vector207
vector207:
  pushl $0
801074ce:	6a 00                	push   $0x0
  pushl $207
801074d0:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801074d5:	e9 3e f1 ff ff       	jmp    80106618 <alltraps>

801074da <vector208>:
.globl vector208
vector208:
  pushl $0
801074da:	6a 00                	push   $0x0
  pushl $208
801074dc:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801074e1:	e9 32 f1 ff ff       	jmp    80106618 <alltraps>

801074e6 <vector209>:
.globl vector209
vector209:
  pushl $0
801074e6:	6a 00                	push   $0x0
  pushl $209
801074e8:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801074ed:	e9 26 f1 ff ff       	jmp    80106618 <alltraps>

801074f2 <vector210>:
.globl vector210
vector210:
  pushl $0
801074f2:	6a 00                	push   $0x0
  pushl $210
801074f4:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801074f9:	e9 1a f1 ff ff       	jmp    80106618 <alltraps>

801074fe <vector211>:
.globl vector211
vector211:
  pushl $0
801074fe:	6a 00                	push   $0x0
  pushl $211
80107500:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107505:	e9 0e f1 ff ff       	jmp    80106618 <alltraps>

8010750a <vector212>:
.globl vector212
vector212:
  pushl $0
8010750a:	6a 00                	push   $0x0
  pushl $212
8010750c:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107511:	e9 02 f1 ff ff       	jmp    80106618 <alltraps>

80107516 <vector213>:
.globl vector213
vector213:
  pushl $0
80107516:	6a 00                	push   $0x0
  pushl $213
80107518:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010751d:	e9 f6 f0 ff ff       	jmp    80106618 <alltraps>

80107522 <vector214>:
.globl vector214
vector214:
  pushl $0
80107522:	6a 00                	push   $0x0
  pushl $214
80107524:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107529:	e9 ea f0 ff ff       	jmp    80106618 <alltraps>

8010752e <vector215>:
.globl vector215
vector215:
  pushl $0
8010752e:	6a 00                	push   $0x0
  pushl $215
80107530:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107535:	e9 de f0 ff ff       	jmp    80106618 <alltraps>

8010753a <vector216>:
.globl vector216
vector216:
  pushl $0
8010753a:	6a 00                	push   $0x0
  pushl $216
8010753c:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107541:	e9 d2 f0 ff ff       	jmp    80106618 <alltraps>

80107546 <vector217>:
.globl vector217
vector217:
  pushl $0
80107546:	6a 00                	push   $0x0
  pushl $217
80107548:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010754d:	e9 c6 f0 ff ff       	jmp    80106618 <alltraps>

80107552 <vector218>:
.globl vector218
vector218:
  pushl $0
80107552:	6a 00                	push   $0x0
  pushl $218
80107554:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107559:	e9 ba f0 ff ff       	jmp    80106618 <alltraps>

8010755e <vector219>:
.globl vector219
vector219:
  pushl $0
8010755e:	6a 00                	push   $0x0
  pushl $219
80107560:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107565:	e9 ae f0 ff ff       	jmp    80106618 <alltraps>

8010756a <vector220>:
.globl vector220
vector220:
  pushl $0
8010756a:	6a 00                	push   $0x0
  pushl $220
8010756c:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107571:	e9 a2 f0 ff ff       	jmp    80106618 <alltraps>

80107576 <vector221>:
.globl vector221
vector221:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $221
80107578:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010757d:	e9 96 f0 ff ff       	jmp    80106618 <alltraps>

80107582 <vector222>:
.globl vector222
vector222:
  pushl $0
80107582:	6a 00                	push   $0x0
  pushl $222
80107584:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107589:	e9 8a f0 ff ff       	jmp    80106618 <alltraps>

8010758e <vector223>:
.globl vector223
vector223:
  pushl $0
8010758e:	6a 00                	push   $0x0
  pushl $223
80107590:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107595:	e9 7e f0 ff ff       	jmp    80106618 <alltraps>

8010759a <vector224>:
.globl vector224
vector224:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $224
8010759c:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801075a1:	e9 72 f0 ff ff       	jmp    80106618 <alltraps>

801075a6 <vector225>:
.globl vector225
vector225:
  pushl $0
801075a6:	6a 00                	push   $0x0
  pushl $225
801075a8:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801075ad:	e9 66 f0 ff ff       	jmp    80106618 <alltraps>

801075b2 <vector226>:
.globl vector226
vector226:
  pushl $0
801075b2:	6a 00                	push   $0x0
  pushl $226
801075b4:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801075b9:	e9 5a f0 ff ff       	jmp    80106618 <alltraps>

801075be <vector227>:
.globl vector227
vector227:
  pushl $0
801075be:	6a 00                	push   $0x0
  pushl $227
801075c0:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801075c5:	e9 4e f0 ff ff       	jmp    80106618 <alltraps>

801075ca <vector228>:
.globl vector228
vector228:
  pushl $0
801075ca:	6a 00                	push   $0x0
  pushl $228
801075cc:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801075d1:	e9 42 f0 ff ff       	jmp    80106618 <alltraps>

801075d6 <vector229>:
.globl vector229
vector229:
  pushl $0
801075d6:	6a 00                	push   $0x0
  pushl $229
801075d8:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801075dd:	e9 36 f0 ff ff       	jmp    80106618 <alltraps>

801075e2 <vector230>:
.globl vector230
vector230:
  pushl $0
801075e2:	6a 00                	push   $0x0
  pushl $230
801075e4:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801075e9:	e9 2a f0 ff ff       	jmp    80106618 <alltraps>

801075ee <vector231>:
.globl vector231
vector231:
  pushl $0
801075ee:	6a 00                	push   $0x0
  pushl $231
801075f0:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801075f5:	e9 1e f0 ff ff       	jmp    80106618 <alltraps>

801075fa <vector232>:
.globl vector232
vector232:
  pushl $0
801075fa:	6a 00                	push   $0x0
  pushl $232
801075fc:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107601:	e9 12 f0 ff ff       	jmp    80106618 <alltraps>

80107606 <vector233>:
.globl vector233
vector233:
  pushl $0
80107606:	6a 00                	push   $0x0
  pushl $233
80107608:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010760d:	e9 06 f0 ff ff       	jmp    80106618 <alltraps>

80107612 <vector234>:
.globl vector234
vector234:
  pushl $0
80107612:	6a 00                	push   $0x0
  pushl $234
80107614:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107619:	e9 fa ef ff ff       	jmp    80106618 <alltraps>

8010761e <vector235>:
.globl vector235
vector235:
  pushl $0
8010761e:	6a 00                	push   $0x0
  pushl $235
80107620:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107625:	e9 ee ef ff ff       	jmp    80106618 <alltraps>

8010762a <vector236>:
.globl vector236
vector236:
  pushl $0
8010762a:	6a 00                	push   $0x0
  pushl $236
8010762c:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107631:	e9 e2 ef ff ff       	jmp    80106618 <alltraps>

80107636 <vector237>:
.globl vector237
vector237:
  pushl $0
80107636:	6a 00                	push   $0x0
  pushl $237
80107638:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010763d:	e9 d6 ef ff ff       	jmp    80106618 <alltraps>

80107642 <vector238>:
.globl vector238
vector238:
  pushl $0
80107642:	6a 00                	push   $0x0
  pushl $238
80107644:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107649:	e9 ca ef ff ff       	jmp    80106618 <alltraps>

8010764e <vector239>:
.globl vector239
vector239:
  pushl $0
8010764e:	6a 00                	push   $0x0
  pushl $239
80107650:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107655:	e9 be ef ff ff       	jmp    80106618 <alltraps>

8010765a <vector240>:
.globl vector240
vector240:
  pushl $0
8010765a:	6a 00                	push   $0x0
  pushl $240
8010765c:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107661:	e9 b2 ef ff ff       	jmp    80106618 <alltraps>

80107666 <vector241>:
.globl vector241
vector241:
  pushl $0
80107666:	6a 00                	push   $0x0
  pushl $241
80107668:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010766d:	e9 a6 ef ff ff       	jmp    80106618 <alltraps>

80107672 <vector242>:
.globl vector242
vector242:
  pushl $0
80107672:	6a 00                	push   $0x0
  pushl $242
80107674:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107679:	e9 9a ef ff ff       	jmp    80106618 <alltraps>

8010767e <vector243>:
.globl vector243
vector243:
  pushl $0
8010767e:	6a 00                	push   $0x0
  pushl $243
80107680:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107685:	e9 8e ef ff ff       	jmp    80106618 <alltraps>

8010768a <vector244>:
.globl vector244
vector244:
  pushl $0
8010768a:	6a 00                	push   $0x0
  pushl $244
8010768c:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107691:	e9 82 ef ff ff       	jmp    80106618 <alltraps>

80107696 <vector245>:
.globl vector245
vector245:
  pushl $0
80107696:	6a 00                	push   $0x0
  pushl $245
80107698:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010769d:	e9 76 ef ff ff       	jmp    80106618 <alltraps>

801076a2 <vector246>:
.globl vector246
vector246:
  pushl $0
801076a2:	6a 00                	push   $0x0
  pushl $246
801076a4:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801076a9:	e9 6a ef ff ff       	jmp    80106618 <alltraps>

801076ae <vector247>:
.globl vector247
vector247:
  pushl $0
801076ae:	6a 00                	push   $0x0
  pushl $247
801076b0:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801076b5:	e9 5e ef ff ff       	jmp    80106618 <alltraps>

801076ba <vector248>:
.globl vector248
vector248:
  pushl $0
801076ba:	6a 00                	push   $0x0
  pushl $248
801076bc:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801076c1:	e9 52 ef ff ff       	jmp    80106618 <alltraps>

801076c6 <vector249>:
.globl vector249
vector249:
  pushl $0
801076c6:	6a 00                	push   $0x0
  pushl $249
801076c8:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801076cd:	e9 46 ef ff ff       	jmp    80106618 <alltraps>

801076d2 <vector250>:
.globl vector250
vector250:
  pushl $0
801076d2:	6a 00                	push   $0x0
  pushl $250
801076d4:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801076d9:	e9 3a ef ff ff       	jmp    80106618 <alltraps>

801076de <vector251>:
.globl vector251
vector251:
  pushl $0
801076de:	6a 00                	push   $0x0
  pushl $251
801076e0:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801076e5:	e9 2e ef ff ff       	jmp    80106618 <alltraps>

801076ea <vector252>:
.globl vector252
vector252:
  pushl $0
801076ea:	6a 00                	push   $0x0
  pushl $252
801076ec:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801076f1:	e9 22 ef ff ff       	jmp    80106618 <alltraps>

801076f6 <vector253>:
.globl vector253
vector253:
  pushl $0
801076f6:	6a 00                	push   $0x0
  pushl $253
801076f8:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801076fd:	e9 16 ef ff ff       	jmp    80106618 <alltraps>

80107702 <vector254>:
.globl vector254
vector254:
  pushl $0
80107702:	6a 00                	push   $0x0
  pushl $254
80107704:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107709:	e9 0a ef ff ff       	jmp    80106618 <alltraps>

8010770e <vector255>:
.globl vector255
vector255:
  pushl $0
8010770e:	6a 00                	push   $0x0
  pushl $255
80107710:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107715:	e9 fe ee ff ff       	jmp    80106618 <alltraps>
	...

8010771c <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
8010771c:	55                   	push   %ebp
8010771d:	89 e5                	mov    %esp,%ebp
8010771f:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107722:	8b 45 0c             	mov    0xc(%ebp),%eax
80107725:	83 e8 01             	sub    $0x1,%eax
80107728:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010772c:	8b 45 08             	mov    0x8(%ebp),%eax
8010772f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107733:	8b 45 08             	mov    0x8(%ebp),%eax
80107736:	c1 e8 10             	shr    $0x10,%eax
80107739:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010773d:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107740:	0f 01 10             	lgdtl  (%eax)
}
80107743:	c9                   	leave  
80107744:	c3                   	ret    

80107745 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107745:	55                   	push   %ebp
80107746:	89 e5                	mov    %esp,%ebp
80107748:	83 ec 04             	sub    $0x4,%esp
8010774b:	8b 45 08             	mov    0x8(%ebp),%eax
8010774e:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107752:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107756:	0f 00 d8             	ltr    %ax
}
80107759:	c9                   	leave  
8010775a:	c3                   	ret    

8010775b <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
8010775b:	55                   	push   %ebp
8010775c:	89 e5                	mov    %esp,%ebp
8010775e:	83 ec 04             	sub    $0x4,%esp
80107761:	8b 45 08             	mov    0x8(%ebp),%eax
80107764:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107768:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010776c:	8e e8                	mov    %eax,%gs
}
8010776e:	c9                   	leave  
8010776f:	c3                   	ret    

80107770 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107773:	8b 45 08             	mov    0x8(%ebp),%eax
80107776:	0f 22 d8             	mov    %eax,%cr3
}
80107779:	5d                   	pop    %ebp
8010777a:	c3                   	ret    

8010777b <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
8010777b:	55                   	push   %ebp
8010777c:	89 e5                	mov    %esp,%ebp
8010777e:	8b 45 08             	mov    0x8(%ebp),%eax
80107781:	05 00 00 00 80       	add    $0x80000000,%eax
80107786:	5d                   	pop    %ebp
80107787:	c3                   	ret    

80107788 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107788:	55                   	push   %ebp
80107789:	89 e5                	mov    %esp,%ebp
8010778b:	8b 45 08             	mov    0x8(%ebp),%eax
8010778e:	05 00 00 00 80       	add    $0x80000000,%eax
80107793:	5d                   	pop    %ebp
80107794:	c3                   	ret    

80107795 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107795:	55                   	push   %ebp
80107796:	89 e5                	mov    %esp,%ebp
80107798:	53                   	push   %ebx
80107799:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
8010779c:	e8 1e b8 ff ff       	call   80102fbf <cpunum>
801077a1:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801077a7:	05 60 23 11 80       	add    $0x80112360,%eax
801077ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801077af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b2:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801077b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077bb:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801077c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c4:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801077c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077cb:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801077cf:	83 e2 f0             	and    $0xfffffff0,%edx
801077d2:	83 ca 0a             	or     $0xa,%edx
801077d5:	88 50 7d             	mov    %dl,0x7d(%eax)
801077d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077db:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801077df:	83 ca 10             	or     $0x10,%edx
801077e2:	88 50 7d             	mov    %dl,0x7d(%eax)
801077e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077e8:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801077ec:	83 e2 9f             	and    $0xffffff9f,%edx
801077ef:	88 50 7d             	mov    %dl,0x7d(%eax)
801077f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f5:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801077f9:	83 ca 80             	or     $0xffffff80,%edx
801077fc:	88 50 7d             	mov    %dl,0x7d(%eax)
801077ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107802:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107806:	83 ca 0f             	or     $0xf,%edx
80107809:	88 50 7e             	mov    %dl,0x7e(%eax)
8010780c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010780f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107813:	83 e2 ef             	and    $0xffffffef,%edx
80107816:	88 50 7e             	mov    %dl,0x7e(%eax)
80107819:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010781c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107820:	83 e2 df             	and    $0xffffffdf,%edx
80107823:	88 50 7e             	mov    %dl,0x7e(%eax)
80107826:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107829:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010782d:	83 ca 40             	or     $0x40,%edx
80107830:	88 50 7e             	mov    %dl,0x7e(%eax)
80107833:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107836:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010783a:	83 ca 80             	or     $0xffffff80,%edx
8010783d:	88 50 7e             	mov    %dl,0x7e(%eax)
80107840:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107843:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107847:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010784a:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107851:	ff ff 
80107853:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107856:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
8010785d:	00 00 
8010785f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107862:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107869:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786c:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107873:	83 e2 f0             	and    $0xfffffff0,%edx
80107876:	83 ca 02             	or     $0x2,%edx
80107879:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010787f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107882:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107889:	83 ca 10             	or     $0x10,%edx
8010788c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107892:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107895:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010789c:	83 e2 9f             	and    $0xffffff9f,%edx
8010789f:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a8:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078af:	83 ca 80             	or     $0xffffff80,%edx
801078b2:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078bb:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801078c2:	83 ca 0f             	or     $0xf,%edx
801078c5:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801078cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ce:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801078d5:	83 e2 ef             	and    $0xffffffef,%edx
801078d8:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801078de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e1:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801078e8:	83 e2 df             	and    $0xffffffdf,%edx
801078eb:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801078f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f4:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801078fb:	83 ca 40             	or     $0x40,%edx
801078fe:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107904:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107907:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010790e:	83 ca 80             	or     $0xffffff80,%edx
80107911:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107917:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010791a:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107921:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107924:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010792b:	ff ff 
8010792d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107930:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107937:	00 00 
80107939:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793c:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107943:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107946:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010794d:	83 e2 f0             	and    $0xfffffff0,%edx
80107950:	83 ca 0a             	or     $0xa,%edx
80107953:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107959:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010795c:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107963:	83 ca 10             	or     $0x10,%edx
80107966:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010796c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107976:	83 ca 60             	or     $0x60,%edx
80107979:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010797f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107982:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107989:	83 ca 80             	or     $0xffffff80,%edx
8010798c:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107992:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107995:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010799c:	83 ca 0f             	or     $0xf,%edx
8010799f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801079a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a8:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801079af:	83 e2 ef             	and    $0xffffffef,%edx
801079b2:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801079b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079bb:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801079c2:	83 e2 df             	and    $0xffffffdf,%edx
801079c5:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801079cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ce:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801079d5:	83 ca 40             	or     $0x40,%edx
801079d8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801079de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e1:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801079e8:	83 ca 80             	or     $0xffffff80,%edx
801079eb:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801079f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f4:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801079fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fe:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107a05:	ff ff 
80107a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a0a:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107a11:	00 00 
80107a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a16:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a20:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a27:	83 e2 f0             	and    $0xfffffff0,%edx
80107a2a:	83 ca 02             	or     $0x2,%edx
80107a2d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a36:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a3d:	83 ca 10             	or     $0x10,%edx
80107a40:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a49:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a50:	83 ca 60             	or     $0x60,%edx
80107a53:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a5c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a63:	83 ca 80             	or     $0xffffff80,%edx
80107a66:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6f:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107a76:	83 ca 0f             	or     $0xf,%edx
80107a79:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a82:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107a89:	83 e2 ef             	and    $0xffffffef,%edx
80107a8c:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a95:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107a9c:	83 e2 df             	and    $0xffffffdf,%edx
80107a9f:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107aaf:	83 ca 40             	or     $0x40,%edx
80107ab2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107abb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ac2:	83 ca 80             	or     $0xffffff80,%edx
80107ac5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ace:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ad8:	05 b4 00 00 00       	add    $0xb4,%eax
80107add:	89 c3                	mov    %eax,%ebx
80107adf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae2:	05 b4 00 00 00       	add    $0xb4,%eax
80107ae7:	c1 e8 10             	shr    $0x10,%eax
80107aea:	89 c1                	mov    %eax,%ecx
80107aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aef:	05 b4 00 00 00       	add    $0xb4,%eax
80107af4:	c1 e8 18             	shr    $0x18,%eax
80107af7:	89 c2                	mov    %eax,%edx
80107af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107afc:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107b03:	00 00 
80107b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b08:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b12:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b1b:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107b22:	83 e1 f0             	and    $0xfffffff0,%ecx
80107b25:	83 c9 02             	or     $0x2,%ecx
80107b28:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b31:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107b38:	83 c9 10             	or     $0x10,%ecx
80107b3b:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b44:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107b4b:	83 e1 9f             	and    $0xffffff9f,%ecx
80107b4e:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107b54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b57:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107b5e:	83 c9 80             	or     $0xffffff80,%ecx
80107b61:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6a:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107b71:	83 e1 f0             	and    $0xfffffff0,%ecx
80107b74:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b7d:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107b84:	83 e1 ef             	and    $0xffffffef,%ecx
80107b87:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b90:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107b97:	83 e1 df             	and    $0xffffffdf,%ecx
80107b9a:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba3:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107baa:	83 c9 40             	or     $0x40,%ecx
80107bad:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb6:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107bbd:	83 c9 80             	or     $0xffffff80,%ecx
80107bc0:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc9:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd2:	83 c0 70             	add    $0x70,%eax
80107bd5:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
80107bdc:	00 
80107bdd:	89 04 24             	mov    %eax,(%esp)
80107be0:	e8 37 fb ff ff       	call   8010771c <lgdt>
  loadgs(SEG_KCPU << 3);
80107be5:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
80107bec:	e8 6a fb ff ff       	call   8010775b <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
80107bf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bf4:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107bfa:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107c01:	00 00 00 00 
}
80107c05:	83 c4 24             	add    $0x24,%esp
80107c08:	5b                   	pop    %ebx
80107c09:	5d                   	pop    %ebp
80107c0a:	c3                   	ret    

80107c0b <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107c0b:	55                   	push   %ebp
80107c0c:	89 e5                	mov    %esp,%ebp
80107c0e:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107c11:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c14:	c1 e8 16             	shr    $0x16,%eax
80107c17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107c1e:	8b 45 08             	mov    0x8(%ebp),%eax
80107c21:	01 d0                	add    %edx,%eax
80107c23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107c26:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c29:	8b 00                	mov    (%eax),%eax
80107c2b:	83 e0 01             	and    $0x1,%eax
80107c2e:	85 c0                	test   %eax,%eax
80107c30:	74 17                	je     80107c49 <walkpgdir+0x3e>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c35:	8b 00                	mov    (%eax),%eax
80107c37:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c3c:	89 04 24             	mov    %eax,(%esp)
80107c3f:	e8 44 fb ff ff       	call   80107788 <p2v>
80107c44:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c47:	eb 4b                	jmp    80107c94 <walkpgdir+0x89>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107c49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107c4d:	74 0e                	je     80107c5d <walkpgdir+0x52>
80107c4f:	e8 af af ff ff       	call   80102c03 <kalloc>
80107c54:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c57:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107c5b:	75 07                	jne    80107c64 <walkpgdir+0x59>
      return 0;
80107c5d:	b8 00 00 00 00       	mov    $0x0,%eax
80107c62:	eb 47                	jmp    80107cab <walkpgdir+0xa0>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107c64:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107c6b:	00 
80107c6c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107c73:	00 
80107c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c77:	89 04 24             	mov    %eax,(%esp)
80107c7a:	e8 87 d5 ff ff       	call   80105206 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c82:	89 04 24             	mov    %eax,(%esp)
80107c85:	e8 f1 fa ff ff       	call   8010777b <v2p>
80107c8a:	89 c2                	mov    %eax,%edx
80107c8c:	83 ca 07             	or     $0x7,%edx
80107c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c92:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107c94:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c97:	c1 e8 0c             	shr    $0xc,%eax
80107c9a:	25 ff 03 00 00       	and    $0x3ff,%eax
80107c9f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca9:	01 d0                	add    %edx,%eax
}
80107cab:	c9                   	leave  
80107cac:	c3                   	ret    

80107cad <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107cad:	55                   	push   %ebp
80107cae:	89 e5                	mov    %esp,%ebp
80107cb0:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107cb6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107cbe:	8b 55 0c             	mov    0xc(%ebp),%edx
80107cc1:	8b 45 10             	mov    0x10(%ebp),%eax
80107cc4:	01 d0                	add    %edx,%eax
80107cc6:	83 e8 01             	sub    $0x1,%eax
80107cc9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107cd1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80107cd8:	00 
80107cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80107ce0:	8b 45 08             	mov    0x8(%ebp),%eax
80107ce3:	89 04 24             	mov    %eax,(%esp)
80107ce6:	e8 20 ff ff ff       	call   80107c0b <walkpgdir>
80107ceb:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107cee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107cf2:	75 07                	jne    80107cfb <mappages+0x4e>
      return -1;
80107cf4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107cf9:	eb 46                	jmp    80107d41 <mappages+0x94>
    if(*pte & PTE_P)
80107cfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107cfe:	8b 00                	mov    (%eax),%eax
80107d00:	83 e0 01             	and    $0x1,%eax
80107d03:	85 c0                	test   %eax,%eax
80107d05:	74 0c                	je     80107d13 <mappages+0x66>
      panic("remap");
80107d07:	c7 04 24 b8 8b 10 80 	movl   $0x80108bb8,(%esp)
80107d0e:	e8 33 88 ff ff       	call   80100546 <panic>
    *pte = pa | perm | PTE_P;
80107d13:	8b 45 18             	mov    0x18(%ebp),%eax
80107d16:	0b 45 14             	or     0x14(%ebp),%eax
80107d19:	89 c2                	mov    %eax,%edx
80107d1b:	83 ca 01             	or     $0x1,%edx
80107d1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d21:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107d23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d26:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107d29:	74 10                	je     80107d3b <mappages+0x8e>
      break;
    a += PGSIZE;
80107d2b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107d32:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107d39:	eb 96                	jmp    80107cd1 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107d3b:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107d3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107d41:	c9                   	leave  
80107d42:	c3                   	ret    

80107d43 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107d43:	55                   	push   %ebp
80107d44:	89 e5                	mov    %esp,%ebp
80107d46:	53                   	push   %ebx
80107d47:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107d4a:	e8 b4 ae ff ff       	call   80102c03 <kalloc>
80107d4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107d52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107d56:	75 0a                	jne    80107d62 <setupkvm+0x1f>
    return 0;
80107d58:	b8 00 00 00 00       	mov    $0x0,%eax
80107d5d:	e9 98 00 00 00       	jmp    80107dfa <setupkvm+0xb7>
  memset(pgdir, 0, PGSIZE);
80107d62:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107d69:	00 
80107d6a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107d71:	00 
80107d72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d75:	89 04 24             	mov    %eax,(%esp)
80107d78:	e8 89 d4 ff ff       	call   80105206 <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107d7d:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80107d84:	e8 ff f9 ff ff       	call   80107788 <p2v>
80107d89:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107d8e:	76 0c                	jbe    80107d9c <setupkvm+0x59>
    panic("PHYSTOP too high");
80107d90:	c7 04 24 be 8b 10 80 	movl   $0x80108bbe,(%esp)
80107d97:	e8 aa 87 ff ff       	call   80100546 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107d9c:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107da3:	eb 49                	jmp    80107dee <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
80107da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107da8:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107dae:	8b 50 04             	mov    0x4(%eax),%edx
80107db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db4:	8b 58 08             	mov    0x8(%eax),%ebx
80107db7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dba:	8b 40 04             	mov    0x4(%eax),%eax
80107dbd:	29 c3                	sub    %eax,%ebx
80107dbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc2:	8b 00                	mov    (%eax),%eax
80107dc4:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80107dc8:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107dcc:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107dd0:	89 44 24 04          	mov    %eax,0x4(%esp)
80107dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107dd7:	89 04 24             	mov    %eax,(%esp)
80107dda:	e8 ce fe ff ff       	call   80107cad <mappages>
80107ddf:	85 c0                	test   %eax,%eax
80107de1:	79 07                	jns    80107dea <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107de3:	b8 00 00 00 00       	mov    $0x0,%eax
80107de8:	eb 10                	jmp    80107dfa <setupkvm+0xb7>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107dea:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107dee:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107df5:	72 ae                	jb     80107da5 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107df7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107dfa:	83 c4 34             	add    $0x34,%esp
80107dfd:	5b                   	pop    %ebx
80107dfe:	5d                   	pop    %ebp
80107dff:	c3                   	ret    

80107e00 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107e00:	55                   	push   %ebp
80107e01:	89 e5                	mov    %esp,%ebp
80107e03:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107e06:	e8 38 ff ff ff       	call   80107d43 <setupkvm>
80107e0b:	a3 38 51 11 80       	mov    %eax,0x80115138
  switchkvm();
80107e10:	e8 02 00 00 00       	call   80107e17 <switchkvm>
}
80107e15:	c9                   	leave  
80107e16:	c3                   	ret    

80107e17 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107e17:	55                   	push   %ebp
80107e18:	89 e5                	mov    %esp,%ebp
80107e1a:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107e1d:	a1 38 51 11 80       	mov    0x80115138,%eax
80107e22:	89 04 24             	mov    %eax,(%esp)
80107e25:	e8 51 f9 ff ff       	call   8010777b <v2p>
80107e2a:	89 04 24             	mov    %eax,(%esp)
80107e2d:	e8 3e f9 ff ff       	call   80107770 <lcr3>
}
80107e32:	c9                   	leave  
80107e33:	c3                   	ret    

80107e34 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107e34:	55                   	push   %ebp
80107e35:	89 e5                	mov    %esp,%ebp
80107e37:	53                   	push   %ebx
80107e38:	83 ec 14             	sub    $0x14,%esp
  pushcli();
80107e3b:	e8 bf d2 ff ff       	call   801050ff <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107e40:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e46:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e4d:	83 c2 08             	add    $0x8,%edx
80107e50:	89 d3                	mov    %edx,%ebx
80107e52:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e59:	83 c2 08             	add    $0x8,%edx
80107e5c:	c1 ea 10             	shr    $0x10,%edx
80107e5f:	89 d1                	mov    %edx,%ecx
80107e61:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e68:	83 c2 08             	add    $0x8,%edx
80107e6b:	c1 ea 18             	shr    $0x18,%edx
80107e6e:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107e75:	67 00 
80107e77:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80107e7e:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107e84:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107e8b:	83 e1 f0             	and    $0xfffffff0,%ecx
80107e8e:	83 c9 09             	or     $0x9,%ecx
80107e91:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107e97:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107e9e:	83 c9 10             	or     $0x10,%ecx
80107ea1:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107ea7:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107eae:	83 e1 9f             	and    $0xffffff9f,%ecx
80107eb1:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107eb7:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107ebe:	83 c9 80             	or     $0xffffff80,%ecx
80107ec1:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107ec7:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107ece:	83 e1 f0             	and    $0xfffffff0,%ecx
80107ed1:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ed7:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107ede:	83 e1 ef             	and    $0xffffffef,%ecx
80107ee1:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ee7:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107eee:	83 e1 df             	and    $0xffffffdf,%ecx
80107ef1:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ef7:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107efe:	83 c9 40             	or     $0x40,%ecx
80107f01:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f07:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107f0e:	83 e1 7f             	and    $0x7f,%ecx
80107f11:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f17:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107f1d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f23:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f2a:	83 e2 ef             	and    $0xffffffef,%edx
80107f2d:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107f33:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f39:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107f3f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f45:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107f4c:	8b 52 08             	mov    0x8(%edx),%edx
80107f4f:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107f55:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107f58:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
80107f5f:	e8 e1 f7 ff ff       	call   80107745 <ltr>
  if(p->pgdir == 0)
80107f64:	8b 45 08             	mov    0x8(%ebp),%eax
80107f67:	8b 40 04             	mov    0x4(%eax),%eax
80107f6a:	85 c0                	test   %eax,%eax
80107f6c:	75 0c                	jne    80107f7a <switchuvm+0x146>
    panic("switchuvm: no pgdir");
80107f6e:	c7 04 24 cf 8b 10 80 	movl   $0x80108bcf,(%esp)
80107f75:	e8 cc 85 ff ff       	call   80100546 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107f7a:	8b 45 08             	mov    0x8(%ebp),%eax
80107f7d:	8b 40 04             	mov    0x4(%eax),%eax
80107f80:	89 04 24             	mov    %eax,(%esp)
80107f83:	e8 f3 f7 ff ff       	call   8010777b <v2p>
80107f88:	89 04 24             	mov    %eax,(%esp)
80107f8b:	e8 e0 f7 ff ff       	call   80107770 <lcr3>
  popcli();
80107f90:	e8 b2 d1 ff ff       	call   80105147 <popcli>
}
80107f95:	83 c4 14             	add    $0x14,%esp
80107f98:	5b                   	pop    %ebx
80107f99:	5d                   	pop    %ebp
80107f9a:	c3                   	ret    

80107f9b <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107f9b:	55                   	push   %ebp
80107f9c:	89 e5                	mov    %esp,%ebp
80107f9e:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107fa1:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107fa8:	76 0c                	jbe    80107fb6 <inituvm+0x1b>
    panic("inituvm: more than a page");
80107faa:	c7 04 24 e3 8b 10 80 	movl   $0x80108be3,(%esp)
80107fb1:	e8 90 85 ff ff       	call   80100546 <panic>
  mem = kalloc();
80107fb6:	e8 48 ac ff ff       	call   80102c03 <kalloc>
80107fbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107fbe:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107fc5:	00 
80107fc6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107fcd:	00 
80107fce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd1:	89 04 24             	mov    %eax,(%esp)
80107fd4:	e8 2d d2 ff ff       	call   80105206 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107fd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fdc:	89 04 24             	mov    %eax,(%esp)
80107fdf:	e8 97 f7 ff ff       	call   8010777b <v2p>
80107fe4:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80107feb:	00 
80107fec:	89 44 24 0c          	mov    %eax,0xc(%esp)
80107ff0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107ff7:	00 
80107ff8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107fff:	00 
80108000:	8b 45 08             	mov    0x8(%ebp),%eax
80108003:	89 04 24             	mov    %eax,(%esp)
80108006:	e8 a2 fc ff ff       	call   80107cad <mappages>
  memmove(mem, init, sz);
8010800b:	8b 45 10             	mov    0x10(%ebp),%eax
8010800e:	89 44 24 08          	mov    %eax,0x8(%esp)
80108012:	8b 45 0c             	mov    0xc(%ebp),%eax
80108015:	89 44 24 04          	mov    %eax,0x4(%esp)
80108019:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010801c:	89 04 24             	mov    %eax,(%esp)
8010801f:	e8 b5 d2 ff ff       	call   801052d9 <memmove>
}
80108024:	c9                   	leave  
80108025:	c3                   	ret    

80108026 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108026:	55                   	push   %ebp
80108027:	89 e5                	mov    %esp,%ebp
80108029:	53                   	push   %ebx
8010802a:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
8010802d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108030:	25 ff 0f 00 00       	and    $0xfff,%eax
80108035:	85 c0                	test   %eax,%eax
80108037:	74 0c                	je     80108045 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80108039:	c7 04 24 00 8c 10 80 	movl   $0x80108c00,(%esp)
80108040:	e8 01 85 ff ff       	call   80100546 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80108045:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010804c:	e9 ad 00 00 00       	jmp    801080fe <loaduvm+0xd8>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108051:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108054:	8b 55 0c             	mov    0xc(%ebp),%edx
80108057:	01 d0                	add    %edx,%eax
80108059:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108060:	00 
80108061:	89 44 24 04          	mov    %eax,0x4(%esp)
80108065:	8b 45 08             	mov    0x8(%ebp),%eax
80108068:	89 04 24             	mov    %eax,(%esp)
8010806b:	e8 9b fb ff ff       	call   80107c0b <walkpgdir>
80108070:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108073:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108077:	75 0c                	jne    80108085 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80108079:	c7 04 24 23 8c 10 80 	movl   $0x80108c23,(%esp)
80108080:	e8 c1 84 ff ff       	call   80100546 <panic>
    pa = PTE_ADDR(*pte);
80108085:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108088:	8b 00                	mov    (%eax),%eax
8010808a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010808f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108092:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108095:	8b 55 18             	mov    0x18(%ebp),%edx
80108098:	89 d1                	mov    %edx,%ecx
8010809a:	29 c1                	sub    %eax,%ecx
8010809c:	89 c8                	mov    %ecx,%eax
8010809e:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801080a3:	77 11                	ja     801080b6 <loaduvm+0x90>
      n = sz - i;
801080a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a8:	8b 55 18             	mov    0x18(%ebp),%edx
801080ab:	89 d1                	mov    %edx,%ecx
801080ad:	29 c1                	sub    %eax,%ecx
801080af:	89 c8                	mov    %ecx,%eax
801080b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801080b4:	eb 07                	jmp    801080bd <loaduvm+0x97>
    else
      n = PGSIZE;
801080b6:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
801080bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080c0:	8b 55 14             	mov    0x14(%ebp),%edx
801080c3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801080c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801080c9:	89 04 24             	mov    %eax,(%esp)
801080cc:	e8 b7 f6 ff ff       	call   80107788 <p2v>
801080d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801080d4:	89 54 24 0c          	mov    %edx,0xc(%esp)
801080d8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801080dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801080e0:	8b 45 10             	mov    0x10(%ebp),%eax
801080e3:	89 04 24             	mov    %eax,(%esp)
801080e6:	e8 4c 9d ff ff       	call   80101e37 <readi>
801080eb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801080ee:	74 07                	je     801080f7 <loaduvm+0xd1>
      return -1;
801080f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801080f5:	eb 18                	jmp    8010810f <loaduvm+0xe9>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801080f7:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801080fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108101:	3b 45 18             	cmp    0x18(%ebp),%eax
80108104:	0f 82 47 ff ff ff    	jb     80108051 <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010810a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010810f:	83 c4 24             	add    $0x24,%esp
80108112:	5b                   	pop    %ebx
80108113:	5d                   	pop    %ebp
80108114:	c3                   	ret    

80108115 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108115:	55                   	push   %ebp
80108116:	89 e5                	mov    %esp,%ebp
80108118:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010811b:	8b 45 10             	mov    0x10(%ebp),%eax
8010811e:	85 c0                	test   %eax,%eax
80108120:	79 0a                	jns    8010812c <allocuvm+0x17>
    return 0;
80108122:	b8 00 00 00 00       	mov    $0x0,%eax
80108127:	e9 c1 00 00 00       	jmp    801081ed <allocuvm+0xd8>
  if(newsz < oldsz)
8010812c:	8b 45 10             	mov    0x10(%ebp),%eax
8010812f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108132:	73 08                	jae    8010813c <allocuvm+0x27>
    return oldsz;
80108134:	8b 45 0c             	mov    0xc(%ebp),%eax
80108137:	e9 b1 00 00 00       	jmp    801081ed <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
8010813c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010813f:	05 ff 0f 00 00       	add    $0xfff,%eax
80108144:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108149:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010814c:	e9 8d 00 00 00       	jmp    801081de <allocuvm+0xc9>
    mem = kalloc();
80108151:	e8 ad aa ff ff       	call   80102c03 <kalloc>
80108156:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108159:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010815d:	75 2c                	jne    8010818b <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
8010815f:	c7 04 24 41 8c 10 80 	movl   $0x80108c41,(%esp)
80108166:	e8 3f 82 ff ff       	call   801003aa <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
8010816b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010816e:	89 44 24 08          	mov    %eax,0x8(%esp)
80108172:	8b 45 10             	mov    0x10(%ebp),%eax
80108175:	89 44 24 04          	mov    %eax,0x4(%esp)
80108179:	8b 45 08             	mov    0x8(%ebp),%eax
8010817c:	89 04 24             	mov    %eax,(%esp)
8010817f:	e8 6b 00 00 00       	call   801081ef <deallocuvm>
      return 0;
80108184:	b8 00 00 00 00       	mov    $0x0,%eax
80108189:	eb 62                	jmp    801081ed <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
8010818b:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108192:	00 
80108193:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010819a:	00 
8010819b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010819e:	89 04 24             	mov    %eax,(%esp)
801081a1:	e8 60 d0 ff ff       	call   80105206 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
801081a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081a9:	89 04 24             	mov    %eax,(%esp)
801081ac:	e8 ca f5 ff ff       	call   8010777b <v2p>
801081b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801081b4:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
801081bb:	00 
801081bc:	89 44 24 0c          	mov    %eax,0xc(%esp)
801081c0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801081c7:	00 
801081c8:	89 54 24 04          	mov    %edx,0x4(%esp)
801081cc:	8b 45 08             	mov    0x8(%ebp),%eax
801081cf:	89 04 24             	mov    %eax,(%esp)
801081d2:	e8 d6 fa ff ff       	call   80107cad <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801081d7:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801081de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081e1:	3b 45 10             	cmp    0x10(%ebp),%eax
801081e4:	0f 82 67 ff ff ff    	jb     80108151 <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
801081ea:	8b 45 10             	mov    0x10(%ebp),%eax
}
801081ed:	c9                   	leave  
801081ee:	c3                   	ret    

801081ef <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801081ef:	55                   	push   %ebp
801081f0:	89 e5                	mov    %esp,%ebp
801081f2:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801081f5:	8b 45 10             	mov    0x10(%ebp),%eax
801081f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
801081fb:	72 08                	jb     80108205 <deallocuvm+0x16>
    return oldsz;
801081fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80108200:	e9 a4 00 00 00       	jmp    801082a9 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
80108205:	8b 45 10             	mov    0x10(%ebp),%eax
80108208:	05 ff 0f 00 00       	add    $0xfff,%eax
8010820d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108212:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108215:	e9 80 00 00 00       	jmp    8010829a <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010821a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010821d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108224:	00 
80108225:	89 44 24 04          	mov    %eax,0x4(%esp)
80108229:	8b 45 08             	mov    0x8(%ebp),%eax
8010822c:	89 04 24             	mov    %eax,(%esp)
8010822f:	e8 d7 f9 ff ff       	call   80107c0b <walkpgdir>
80108234:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108237:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010823b:	75 09                	jne    80108246 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
8010823d:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108244:	eb 4d                	jmp    80108293 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80108246:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108249:	8b 00                	mov    (%eax),%eax
8010824b:	83 e0 01             	and    $0x1,%eax
8010824e:	85 c0                	test   %eax,%eax
80108250:	74 41                	je     80108293 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
80108252:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108255:	8b 00                	mov    (%eax),%eax
80108257:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010825c:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010825f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108263:	75 0c                	jne    80108271 <deallocuvm+0x82>
        panic("kfree");
80108265:	c7 04 24 59 8c 10 80 	movl   $0x80108c59,(%esp)
8010826c:	e8 d5 82 ff ff       	call   80100546 <panic>
      char *v = p2v(pa);
80108271:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108274:	89 04 24             	mov    %eax,(%esp)
80108277:	e8 0c f5 ff ff       	call   80107788 <p2v>
8010827c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010827f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108282:	89 04 24             	mov    %eax,(%esp)
80108285:	e8 e0 a8 ff ff       	call   80102b6a <kfree>
      *pte = 0;
8010828a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010828d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108293:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010829a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010829d:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082a0:	0f 82 74 ff ff ff    	jb     8010821a <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801082a6:	8b 45 10             	mov    0x10(%ebp),%eax
}
801082a9:	c9                   	leave  
801082aa:	c3                   	ret    

801082ab <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801082ab:	55                   	push   %ebp
801082ac:	89 e5                	mov    %esp,%ebp
801082ae:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
801082b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801082b5:	75 0c                	jne    801082c3 <freevm+0x18>
    panic("freevm: no pgdir");
801082b7:	c7 04 24 5f 8c 10 80 	movl   $0x80108c5f,(%esp)
801082be:	e8 83 82 ff ff       	call   80100546 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801082c3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801082ca:	00 
801082cb:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
801082d2:	80 
801082d3:	8b 45 08             	mov    0x8(%ebp),%eax
801082d6:	89 04 24             	mov    %eax,(%esp)
801082d9:	e8 11 ff ff ff       	call   801081ef <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
801082de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801082e5:	eb 48                	jmp    8010832f <freevm+0x84>
    if(pgdir[i] & PTE_P){
801082e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801082f1:	8b 45 08             	mov    0x8(%ebp),%eax
801082f4:	01 d0                	add    %edx,%eax
801082f6:	8b 00                	mov    (%eax),%eax
801082f8:	83 e0 01             	and    $0x1,%eax
801082fb:	85 c0                	test   %eax,%eax
801082fd:	74 2c                	je     8010832b <freevm+0x80>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801082ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108302:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108309:	8b 45 08             	mov    0x8(%ebp),%eax
8010830c:	01 d0                	add    %edx,%eax
8010830e:	8b 00                	mov    (%eax),%eax
80108310:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108315:	89 04 24             	mov    %eax,(%esp)
80108318:	e8 6b f4 ff ff       	call   80107788 <p2v>
8010831d:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108320:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108323:	89 04 24             	mov    %eax,(%esp)
80108326:	e8 3f a8 ff ff       	call   80102b6a <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010832b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010832f:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108336:	76 af                	jbe    801082e7 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108338:	8b 45 08             	mov    0x8(%ebp),%eax
8010833b:	89 04 24             	mov    %eax,(%esp)
8010833e:	e8 27 a8 ff ff       	call   80102b6a <kfree>
}
80108343:	c9                   	leave  
80108344:	c3                   	ret    

80108345 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108345:	55                   	push   %ebp
80108346:	89 e5                	mov    %esp,%ebp
80108348:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010834b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108352:	00 
80108353:	8b 45 0c             	mov    0xc(%ebp),%eax
80108356:	89 44 24 04          	mov    %eax,0x4(%esp)
8010835a:	8b 45 08             	mov    0x8(%ebp),%eax
8010835d:	89 04 24             	mov    %eax,(%esp)
80108360:	e8 a6 f8 ff ff       	call   80107c0b <walkpgdir>
80108365:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108368:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010836c:	75 0c                	jne    8010837a <clearpteu+0x35>
    panic("clearpteu");
8010836e:	c7 04 24 70 8c 10 80 	movl   $0x80108c70,(%esp)
80108375:	e8 cc 81 ff ff       	call   80100546 <panic>
  *pte &= ~PTE_U;
8010837a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010837d:	8b 00                	mov    (%eax),%eax
8010837f:	89 c2                	mov    %eax,%edx
80108381:	83 e2 fb             	and    $0xfffffffb,%edx
80108384:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108387:	89 10                	mov    %edx,(%eax)
}
80108389:	c9                   	leave  
8010838a:	c3                   	ret    

8010838b <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010838b:	55                   	push   %ebp
8010838c:	89 e5                	mov    %esp,%ebp
8010838e:	53                   	push   %ebx
8010838f:	83 ec 44             	sub    $0x44,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108392:	e8 ac f9 ff ff       	call   80107d43 <setupkvm>
80108397:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010839a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010839e:	75 0a                	jne    801083aa <copyuvm+0x1f>
    return 0;
801083a0:	b8 00 00 00 00       	mov    $0x0,%eax
801083a5:	e9 fd 00 00 00       	jmp    801084a7 <copyuvm+0x11c>
  for(i = 0; i < sz; i += PGSIZE){
801083aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801083b1:	e9 cc 00 00 00       	jmp    80108482 <copyuvm+0xf7>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801083b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083b9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801083c0:	00 
801083c1:	89 44 24 04          	mov    %eax,0x4(%esp)
801083c5:	8b 45 08             	mov    0x8(%ebp),%eax
801083c8:	89 04 24             	mov    %eax,(%esp)
801083cb:	e8 3b f8 ff ff       	call   80107c0b <walkpgdir>
801083d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801083d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801083d7:	75 0c                	jne    801083e5 <copyuvm+0x5a>
      panic("copyuvm: pte should exist");
801083d9:	c7 04 24 7a 8c 10 80 	movl   $0x80108c7a,(%esp)
801083e0:	e8 61 81 ff ff       	call   80100546 <panic>
    if(!(*pte & PTE_P))
801083e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801083e8:	8b 00                	mov    (%eax),%eax
801083ea:	83 e0 01             	and    $0x1,%eax
801083ed:	85 c0                	test   %eax,%eax
801083ef:	75 0c                	jne    801083fd <copyuvm+0x72>
      panic("copyuvm: page not present");
801083f1:	c7 04 24 94 8c 10 80 	movl   $0x80108c94,(%esp)
801083f8:	e8 49 81 ff ff       	call   80100546 <panic>
    pa = PTE_ADDR(*pte);
801083fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108400:	8b 00                	mov    (%eax),%eax
80108402:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108407:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
8010840a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010840d:	8b 00                	mov    (%eax),%eax
8010840f:	25 ff 0f 00 00       	and    $0xfff,%eax
80108414:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108417:	e8 e7 a7 ff ff       	call   80102c03 <kalloc>
8010841c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010841f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108423:	74 6e                	je     80108493 <copyuvm+0x108>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108425:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108428:	89 04 24             	mov    %eax,(%esp)
8010842b:	e8 58 f3 ff ff       	call   80107788 <p2v>
80108430:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108437:	00 
80108438:	89 44 24 04          	mov    %eax,0x4(%esp)
8010843c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010843f:	89 04 24             	mov    %eax,(%esp)
80108442:	e8 92 ce ff ff       	call   801052d9 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
80108447:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010844a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010844d:	89 04 24             	mov    %eax,(%esp)
80108450:	e8 26 f3 ff ff       	call   8010777b <v2p>
80108455:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108458:	89 5c 24 10          	mov    %ebx,0x10(%esp)
8010845c:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108460:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108467:	00 
80108468:	89 54 24 04          	mov    %edx,0x4(%esp)
8010846c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010846f:	89 04 24             	mov    %eax,(%esp)
80108472:	e8 36 f8 ff ff       	call   80107cad <mappages>
80108477:	85 c0                	test   %eax,%eax
80108479:	78 1b                	js     80108496 <copyuvm+0x10b>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010847b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108482:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108485:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108488:	0f 82 28 ff ff ff    	jb     801083b6 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
8010848e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108491:	eb 14                	jmp    801084a7 <copyuvm+0x11c>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108493:	90                   	nop
80108494:	eb 01                	jmp    80108497 <copyuvm+0x10c>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
80108496:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108497:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010849a:	89 04 24             	mov    %eax,(%esp)
8010849d:	e8 09 fe ff ff       	call   801082ab <freevm>
  return 0;
801084a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801084a7:	83 c4 44             	add    $0x44,%esp
801084aa:	5b                   	pop    %ebx
801084ab:	5d                   	pop    %ebp
801084ac:	c3                   	ret    

801084ad <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801084ad:	55                   	push   %ebp
801084ae:	89 e5                	mov    %esp,%ebp
801084b0:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084b3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801084ba:	00 
801084bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801084be:	89 44 24 04          	mov    %eax,0x4(%esp)
801084c2:	8b 45 08             	mov    0x8(%ebp),%eax
801084c5:	89 04 24             	mov    %eax,(%esp)
801084c8:	e8 3e f7 ff ff       	call   80107c0b <walkpgdir>
801084cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801084d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084d3:	8b 00                	mov    (%eax),%eax
801084d5:	83 e0 01             	and    $0x1,%eax
801084d8:	85 c0                	test   %eax,%eax
801084da:	75 07                	jne    801084e3 <uva2ka+0x36>
    return 0;
801084dc:	b8 00 00 00 00       	mov    $0x0,%eax
801084e1:	eb 25                	jmp    80108508 <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
801084e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084e6:	8b 00                	mov    (%eax),%eax
801084e8:	83 e0 04             	and    $0x4,%eax
801084eb:	85 c0                	test   %eax,%eax
801084ed:	75 07                	jne    801084f6 <uva2ka+0x49>
    return 0;
801084ef:	b8 00 00 00 00       	mov    $0x0,%eax
801084f4:	eb 12                	jmp    80108508 <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
801084f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084f9:	8b 00                	mov    (%eax),%eax
801084fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108500:	89 04 24             	mov    %eax,(%esp)
80108503:	e8 80 f2 ff ff       	call   80107788 <p2v>
}
80108508:	c9                   	leave  
80108509:	c3                   	ret    

8010850a <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
8010850a:	55                   	push   %ebp
8010850b:	89 e5                	mov    %esp,%ebp
8010850d:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108510:	8b 45 10             	mov    0x10(%ebp),%eax
80108513:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108516:	e9 89 00 00 00       	jmp    801085a4 <copyout+0x9a>
    va0 = (uint)PGROUNDDOWN(va);
8010851b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010851e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108523:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108526:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108529:	89 44 24 04          	mov    %eax,0x4(%esp)
8010852d:	8b 45 08             	mov    0x8(%ebp),%eax
80108530:	89 04 24             	mov    %eax,(%esp)
80108533:	e8 75 ff ff ff       	call   801084ad <uva2ka>
80108538:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010853b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010853f:	75 07                	jne    80108548 <copyout+0x3e>
      return -1;
80108541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108546:	eb 6b                	jmp    801085b3 <copyout+0xa9>
    n = PGSIZE - (va - va0);
80108548:	8b 45 0c             	mov    0xc(%ebp),%eax
8010854b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010854e:	89 d1                	mov    %edx,%ecx
80108550:	29 c1                	sub    %eax,%ecx
80108552:	89 c8                	mov    %ecx,%eax
80108554:	05 00 10 00 00       	add    $0x1000,%eax
80108559:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010855c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010855f:	3b 45 14             	cmp    0x14(%ebp),%eax
80108562:	76 06                	jbe    8010856a <copyout+0x60>
      n = len;
80108564:	8b 45 14             	mov    0x14(%ebp),%eax
80108567:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010856a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010856d:	8b 55 0c             	mov    0xc(%ebp),%edx
80108570:	29 c2                	sub    %eax,%edx
80108572:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108575:	01 c2                	add    %eax,%edx
80108577:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010857a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010857e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108581:	89 44 24 04          	mov    %eax,0x4(%esp)
80108585:	89 14 24             	mov    %edx,(%esp)
80108588:	e8 4c cd ff ff       	call   801052d9 <memmove>
    len -= n;
8010858d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108590:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108593:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108596:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108599:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010859c:	05 00 10 00 00       	add    $0x1000,%eax
801085a1:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801085a4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801085a8:	0f 85 6d ff ff ff    	jne    8010851b <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801085ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
801085b3:	c9                   	leave  
801085b4:	c3                   	ret    
