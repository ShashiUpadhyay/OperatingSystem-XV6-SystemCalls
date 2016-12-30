	.file	"printf.c"
	.text
.Ltext0:
	.type	putc, @function
putc:
.LFB0:
	.file 1 "printf.c"
	.loc 1 7 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	12(%ebp), %eax
	movb	%al, -12(%ebp)
.LVL1:
	.loc 1 8 0
	movl	$1, 8(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	write
.LVL2:
	.loc 1 9 0
	leave
.LCFI2:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	putc, .-putc
	.type	printint, @function
printint:
.LFB1:
	.loc 1 13 0
	.cfi_startproc
.LVL3:
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	subl	$72, %esp
	.loc 1 19 0
	movl	$0, -16(%ebp)
.LVL4:
	.loc 1 20 0
	cmpl	$0, 20(%ebp)
	je	.L3
	.loc 1 20 0 is_stmt 0 discriminator 1
	cmpl	$0, 12(%ebp)
	jns	.L3
	.loc 1 21 0 is_stmt 1
	movl	$1, -16(%ebp)
	.loc 1 22 0
	movl	12(%ebp), %eax
	negl	%eax
	movl	%eax, -20(%ebp)
.LVL5:
	jmp	.L4
.LVL6:
.L3:
	.loc 1 24 0
	movl	12(%ebp), %eax
	movl	%eax, -20(%ebp)
.LVL7:
.L4:
	.loc 1 27 0
	movl	$0, -12(%ebp)
.LVL8:
.L5:
	.loc 1 29 0 discriminator 1
	movl	16(%ebp), %ecx
	movl	-20(%ebp), %eax
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movzbl	digits.1079(%eax), %eax
	leal	-36(%ebp), %ecx
	movl	-12(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	addl	$1, -12(%ebp)
	.loc 1 30 0 discriminator 1
	movl	16(%ebp), %edx
	movl	%edx, -44(%ebp)
	movl	-20(%ebp), %eax
	movl	$0, %edx
	divl	-44(%ebp)
	movl	%eax, -20(%ebp)
.LVL9:
	cmpl	$0, -20(%ebp)
	jne	.L5
	.loc 1 31 0
	cmpl	$0, -16(%ebp)
	je	.L7
	.loc 1 32 0
	leal	-36(%ebp), %edx
	movl	-12(%ebp), %eax
.LVL10:
	addl	%edx, %eax
	movb	$45, (%eax)
	addl	$1, -12(%ebp)
	.loc 1 34 0
	jmp	.L7
.L8:
	.loc 1 35 0
	leal	-36(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	putc
.LVL11:
.L7:
	.loc 1 34 0 discriminator 1
	subl	$1, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jns	.L8
	.loc 1 36 0
	leave
.LCFI5:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	printint, .-printint
	.section	.rodata
.LC0:
	.string	"(null)"
	.text
	.globl	printf
	.type	printf, @function
printf:
.LFB2:
	.loc 1 41 0
	.cfi_startproc
.LVL12:
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	subl	$56, %esp
	.loc 1 46 0
	movl	$0, -20(%ebp)
.LVL13:
	.loc 1 47 0
	leal	12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, -24(%ebp)
.LVL14:
	.loc 1 48 0
	movl	$0, -16(%ebp)
.LVL15:
	jmp	.L10
.LVL16:
.L24:
	.loc 1 49 0
	movl	12(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	andl	$255, %eax
	movl	%eax, -28(%ebp)
.LVL17:
	.loc 1 50 0
	cmpl	$0, -20(%ebp)
	jne	.L11
	.loc 1 51 0
	cmpl	$37, -28(%ebp)
	jne	.L12
	.loc 1 52 0
	movl	$37, -20(%ebp)
	jmp	.L13
.L12:
	.loc 1 54 0
	movl	-28(%ebp), %eax
.LVL18:
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	putc
.LVL19:
	jmp	.L13
.LVL20:
.L11:
	.loc 1 56 0
	cmpl	$37, -20(%ebp)
	jne	.L13
	.loc 1 57 0
	cmpl	$100, -28(%ebp)
	jne	.L14
	.loc 1 58 0
	movl	-24(%ebp), %eax
.LVL21:
	movl	(%eax), %eax
	movl	$1, 12(%esp)
	movl	$10, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	printint
.LVL22:
	.loc 1 59 0
	addl	$4, -24(%ebp)
	jmp	.L15
.LVL23:
.L14:
	.loc 1 60 0
	cmpl	$120, -28(%ebp)
	je	.L16
	.loc 1 60 0 is_stmt 0 discriminator 1
	cmpl	$112, -28(%ebp)
	jne	.L17
.L16:
	.loc 1 61 0 is_stmt 1
	movl	-24(%ebp), %eax
.LVL24:
	movl	(%eax), %eax
	movl	$0, 12(%esp)
	movl	$16, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	printint
.LVL25:
	.loc 1 62 0
	addl	$4, -24(%ebp)
	jmp	.L15
.LVL26:
.L17:
	.loc 1 63 0
	cmpl	$115, -28(%ebp)
	jne	.L18
	.loc 1 64 0
	movl	-24(%ebp), %eax
.LVL27:
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
.LVL28:
	.loc 1 65 0
	addl	$4, -24(%ebp)
	.loc 1 66 0
	cmpl	$0, -12(%ebp)
	jne	.L25
	.loc 1 67 0
	movl	$.LC0, -12(%ebp)
.LVL29:
	.loc 1 68 0
	jmp	.L25
.L21:
	.loc 1 69 0
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	putc
.LVL30:
	.loc 1 70 0
	addl	$1, -12(%ebp)
	jmp	.L20
.L25:
	.loc 1 68 0
	nop
.L20:
	.loc 1 68 0 is_stmt 0 discriminator 1
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L21
	.loc 1 68 0
	jmp	.L15
.LVL31:
.L18:
	.loc 1 72 0 is_stmt 1
	cmpl	$99, -28(%ebp)
	jne	.L22
	.loc 1 73 0
	movl	-24(%ebp), %eax
.LVL32:
	movl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	putc
.LVL33:
	.loc 1 74 0
	addl	$4, -24(%ebp)
	jmp	.L15
.LVL34:
.L22:
	.loc 1 75 0
	cmpl	$37, -28(%ebp)
	jne	.L23
	.loc 1 76 0
	movl	-28(%ebp), %eax
.LVL35:
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	putc
.LVL36:
	jmp	.L15
.LVL37:
.L23:
	.loc 1 79 0
	movl	$37, 4(%esp)
	movl	8(%ebp), %eax
.LVL38:
	movl	%eax, (%esp)
	call	putc
.LVL39:
	.loc 1 80 0
	movl	-28(%ebp), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	putc
.LVL40:
.L15:
	.loc 1 82 0
	movl	$0, -20(%ebp)
.L13:
	.loc 1 48 0
	addl	$1, -16(%ebp)
.LVL41:
.L10:
	.loc 1 48 0 is_stmt 0 discriminator 1
	movl	12(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L24
	.loc 1 85 0 is_stmt 1
	leave
.LCFI8:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	printf, .-printf
	.data
	.type	digits.1079, @object
	.size	digits.1079, 17
digits.1079:
	.string	"0123456789ABCDEF"
	.text
.Letext0:
	.file 2 "types.h"
	.file 3 "user.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x317
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF11
	.byte	0x1
	.long	.LASF12
	.long	.LASF13
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF14
	.byte	0x2
	.byte	0x1
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF1
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF3
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x5
	.long	.LASF5
	.byte	0x1
	.byte	0x6
	.byte	0x1
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.byte	0x1
	.long	0xa6
	.uleb128 0x6
	.string	"fd"
	.byte	0x1
	.byte	0x6
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x7
	.string	"c"
	.byte	0x1
	.byte	0x6
	.long	0xa6
	.long	.LLST1
	.uleb128 0x8
	.long	.LVL2
	.long	0x2f6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x5
	.long	.LASF6
	.byte	0x1
	.byte	0xc
	.byte	0x1
	.long	.LFB1
	.long	.LFE1
	.long	.LLST2
	.byte	0x1
	.long	0x155
	.uleb128 0x6
	.string	"fd"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x6
	.string	"xx"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xa
	.long	.LASF7
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x6
	.string	"sgn"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 12
	.uleb128 0xb
	.long	.LASF8
	.byte	0x1
	.byte	0xe
	.long	0x155
	.byte	0x5
	.byte	0x3
	.long	digits.1079
	.uleb128 0xc
	.string	"buf"
	.byte	0x1
	.byte	0xf
	.long	0x16c
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0xc
	.string	"i"
	.byte	0x1
	.byte	0x10
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0xc
	.string	"neg"
	.byte	0x1
	.byte	0x10
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0xd
	.string	"x"
	.byte	0x1
	.byte	0x11
	.long	0x25
	.long	.LLST3
	.uleb128 0x8
	.long	.LVL11
	.long	0x53
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0xe
	.long	0xa6
	.long	0x165
	.uleb128 0xf
	.long	0x165
	.byte	0x10
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF9
	.uleb128 0xe
	.long	0xa6
	.long	0x17c
	.uleb128 0xf
	.long	0x165
	.byte	0xf
	.byte	0
	.uleb128 0x10
	.byte	0x1
	.long	.LASF15
	.byte	0x1
	.byte	0x28
	.byte	0x1
	.long	.LFB2
	.long	.LFE2
	.long	.LLST4
	.byte	0x1
	.long	0x2ea
	.uleb128 0x6
	.string	"fd"
	.byte	0x1
	.byte	0x28
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x6
	.string	"fmt"
	.byte	0x1
	.byte	0x28
	.long	0x2ea
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x11
	.uleb128 0xd
	.string	"s"
	.byte	0x1
	.byte	0x2a
	.long	0x2ea
	.long	.LLST5
	.uleb128 0xd
	.string	"c"
	.byte	0x1
	.byte	0x2b
	.long	0x4c
	.long	.LLST6
	.uleb128 0xd
	.string	"i"
	.byte	0x1
	.byte	0x2b
	.long	0x4c
	.long	.LLST7
	.uleb128 0xb
	.long	.LASF10
	.byte	0x1
	.byte	0x2b
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0xd
	.string	"ap"
	.byte	0x1
	.byte	0x2c
	.long	0x2f0
	.long	.LLST8
	.uleb128 0x12
	.long	.LVL19
	.long	0x53
	.long	0x218
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x8
	.byte	0x91
	.sleb128 -36
	.byte	0x94
	.byte	0x1
	.byte	0x48
	.byte	0x24
	.byte	0x48
	.byte	0x26
	.byte	0
	.uleb128 0x12
	.long	.LVL22
	.long	0xad
	.long	0x23a
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x3a
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x31
	.byte	0
	.uleb128 0x12
	.long	.LVL25
	.long	0xad
	.long	0x25e
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x40
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x3
	.byte	0x91
	.sleb128 -28
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.long	.LVL30
	.long	0x53
	.long	0x274
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.long	.LVL33
	.long	0x53
	.long	0x28a
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.long	.LVL36
	.long	0x53
	.long	0x2ad
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x8
	.byte	0x91
	.sleb128 -36
	.byte	0x94
	.byte	0x1
	.byte	0x48
	.byte	0x24
	.byte	0x48
	.byte	0x26
	.byte	0
	.uleb128 0x12
	.long	.LVL39
	.long	0x53
	.long	0x2ca
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x8
	.byte	0x25
	.byte	0
	.uleb128 0x8
	.long	.LVL40
	.long	0x53
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x9
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x8
	.byte	0x91
	.sleb128 -36
	.byte	0x94
	.byte	0x1
	.byte	0x48
	.byte	0x24
	.byte	0x48
	.byte	0x26
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x4
	.long	0xa6
	.uleb128 0x13
	.byte	0x4
	.long	0x25
	.uleb128 0x14
	.byte	0x1
	.long	.LASF16
	.byte	0x3
	.byte	0x9
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.long	0x318
	.uleb128 0x15
	.long	0x4c
	.uleb128 0x15
	.long	0x318
	.uleb128 0x15
	.long	0x4c
	.byte	0
	.uleb128 0x16
	.byte	0x4
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB0-.Ltext0
	.long	.LCFI0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI0-.Ltext0
	.long	.LCFI1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI1-.Ltext0
	.long	.LCFI2-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI2-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST1:
	.long	.LVL0-.Ltext0
	.long	.LVL1-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL1-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST2:
	.long	.LFB1-.Ltext0
	.long	.LCFI3-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI3-.Ltext0
	.long	.LCFI4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI4-.Ltext0
	.long	.LCFI5-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI5-.Ltext0
	.long	.LFE1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST3:
	.long	.LVL5-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL7-.Ltext0
	.long	.LVL9-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	.LVL9-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL10-.Ltext0
	.long	.LFE1-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	0
	.long	0
.LLST4:
	.long	.LFB2-.Ltext0
	.long	.LCFI6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI6-.Ltext0
	.long	.LCFI7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI7-.Ltext0
	.long	.LCFI8-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI8-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST5:
	.long	.LVL28-.Ltext0
	.long	.LVL29-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL29-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST6:
	.long	.LVL17-.Ltext0
	.long	.LVL18-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL18-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL20-.Ltext0
	.long	.LVL21-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL21-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL23-.Ltext0
	.long	.LVL24-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL24-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL26-.Ltext0
	.long	.LVL27-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL27-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL31-.Ltext0
	.long	.LVL32-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL32-.Ltext0
	.long	.LVL34-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL34-.Ltext0
	.long	.LVL35-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL35-.Ltext0
	.long	.LVL37-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL37-.Ltext0
	.long	.LVL38-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL38-.Ltext0
	.long	.LVL41-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	0
	.long	0
.LLST7:
	.long	.LVL15-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	.LVL16-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST8:
	.long	.LVL14-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL16-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -32
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF0:
	.string	"unsigned int"
.LASF12:
	.string	"printf.c"
.LASF14:
	.string	"uint"
.LASF11:
	.string	"GNU C 4.7.2"
.LASF7:
	.string	"base"
.LASF16:
	.string	"write"
.LASF2:
	.string	"unsigned char"
.LASF4:
	.string	"char"
.LASF6:
	.string	"printint"
.LASF15:
	.string	"printf"
.LASF13:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF1:
	.string	"short unsigned int"
.LASF8:
	.string	"digits"
.LASF10:
	.string	"state"
.LASF5:
	.string	"putc"
.LASF3:
	.string	"short int"
.LASF9:
	.string	"sizetype"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
