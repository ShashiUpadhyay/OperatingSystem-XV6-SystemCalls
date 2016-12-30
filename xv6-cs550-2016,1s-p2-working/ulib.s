	.file	"ulib.c"
	.text
.Ltext0:
	.type	stosb, @function
stosb:
.LFB5:
	.file 1 "x86.h"
	.loc 1 44 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%ebx
	.cfi_offset 7, -12
	.cfi_offset 3, -16
	.loc 1 45 0
	movl	8(%ebp), %ecx
	movl	16(%ebp), %edx
	movl	12(%ebp), %eax
	movl	%ecx, %ebx
	movl	%ebx, %edi
	movl	%edx, %ecx
#APP
# 45 "x86.h" 1
	cld; rep stosb
# 0 "" 2
#NO_APP
	movl	%ecx, %edx
	movl	%edi, %ebx
	movl	%ebx, 8(%ebp)
	movl	%edx, 16(%ebp)
.LVL1:
	.loc 1 49 0
	popl	%ebx
	.cfi_restore 3
.LVL2:
	popl	%edi
	.cfi_restore 7
.LVL3:
	popl	%ebp
.LCFI2:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	stosb, .-stosb
	.globl	strcpy
	.type	strcpy, @function
strcpy:
.LFB18:
	.file 2 "ulib.c"
	.loc 2 9 0
	.cfi_startproc
.LVL4:
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 12 0
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.LVL5:
	.loc 2 13 0
	nop
.LVL6:
.L3:
	.loc 2 13 0 is_stmt 0 discriminator 1
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	setne	%al
	addl	$1, 8(%ebp)
	addl	$1, 12(%ebp)
	testb	%al, %al
	jne	.L3
	.loc 2 15 0 is_stmt 1
	movl	-4(%ebp), %eax
	.loc 2 16 0
	leave
.LCFI5:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	strcpy, .-strcpy
	.globl	strcmp
	.type	strcmp, @function
strcmp:
.LFB19:
	.loc 2 20 0
	.cfi_startproc
.LVL7:
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	.loc 2 21 0
	jmp	.L6
.L8:
	.loc 2 22 0
	addl	$1, 8(%ebp)
	addl	$1, 12(%ebp)
.LVL8:
.L6:
	.loc 2 21 0 discriminator 1
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	.L7
	.loc 2 21 0 is_stmt 0 discriminator 2
	movl	8(%ebp), %eax
	movzbl	(%eax), %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	je	.L8
.L7:
	.loc 2 23 0 is_stmt 1
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	.loc 2 24 0
	popl	%ebp
.LCFI8:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE19:
	.size	strcmp, .-strcmp
	.globl	strlen
	.type	strlen, @function
strlen:
.LFB20:
	.loc 2 28 0
	.cfi_startproc
.LVL9:
	pushl	%ebp
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI10:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 31 0
	movl	$0, -4(%ebp)
.LVL10:
	jmp	.L11
.LVL11:
.L12:
	.loc 2 31 0 is_stmt 0 discriminator 2
	addl	$1, -4(%ebp)
.LVL12:
.L11:
	.loc 2 31 0 discriminator 1
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L12
	.loc 2 33 0 is_stmt 1
	movl	-4(%ebp), %eax
	.loc 2 34 0
	leave
.LCFI11:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	strlen, .-strlen
	.globl	memset
	.type	memset, @function
memset:
.LFB21:
	.loc 2 38 0
	.cfi_startproc
.LVL13:
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI13:
	.cfi_def_cfa_register 5
	subl	$12, %esp
	.loc 2 39 0
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	stosb
.LVL14:
	.loc 2 40 0
	movl	8(%ebp), %eax
	.loc 2 41 0
	leave
.LCFI14:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	memset, .-memset
	.globl	strchr
	.type	strchr, @function
strchr:
.LFB22:
	.loc 2 45 0
	.cfi_startproc
.LVL15:
	pushl	%ebp
.LCFI15:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI16:
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	12(%ebp), %eax
	movb	%al, -4(%ebp)
	.loc 2 46 0
	jmp	.L17
.L20:
	.loc 2 47 0
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-4(%ebp), %al
	jne	.L18
	.loc 2 48 0
	movl	8(%ebp), %eax
	jmp	.L19
.L18:
	.loc 2 46 0
	addl	$1, 8(%ebp)
.LVL16:
.L17:
	.loc 2 46 0 is_stmt 0 discriminator 1
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L20
	.loc 2 49 0 is_stmt 1
	movl	$0, %eax
.L19:
	.loc 2 50 0
	leave
.LCFI17:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	strchr, .-strchr
	.globl	gets
	.type	gets, @function
gets:
.LFB23:
	.loc 2 54 0
	.cfi_startproc
.LVL17:
	pushl	%ebp
.LCFI18:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI19:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 2 58 0
	movl	$0, -12(%ebp)
.LVL18:
	jmp	.L22
.LVL19:
.L25:
	.loc 2 59 0
	movl	$1, 8(%esp)
	leal	-17(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	read
.LVL20:
	movl	%eax, -16(%ebp)
.LVL21:
	.loc 2 60 0
	cmpl	$0, -16(%ebp)
	jle	.L27
.L23:
	.loc 2 62 0
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
.LVL22:
	addl	%eax, %edx
	movzbl	-17(%ebp), %eax
	movb	%al, (%edx)
	addl	$1, -12(%ebp)
	.loc 2 63 0
	movzbl	-17(%ebp), %eax
	cmpb	$10, %al
	je	.L24
	.loc 2 63 0 is_stmt 0 discriminator 1
	movzbl	-17(%ebp), %eax
	cmpb	$13, %al
	je	.L24
.LVL23:
.L22:
	.loc 2 58 0 is_stmt 1 discriminator 1
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	12(%ebp), %eax
	jl	.L25
	jmp	.L24
.LVL24:
.L27:
	.loc 2 61 0
	nop
.LVL25:
.L24:
	.loc 2 66 0
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	.loc 2 67 0
	movl	8(%ebp), %eax
	.loc 2 68 0
	leave
.LCFI20:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	gets, .-gets
	.globl	stat
	.type	stat, @function
stat:
.LFB24:
	.loc 2 72 0
	.cfi_startproc
.LVL26:
	pushl	%ebp
.LCFI21:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI22:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 2 76 0
	movl	$0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	open
.LVL27:
	movl	%eax, -12(%ebp)
.LVL28:
	.loc 2 77 0
	cmpl	$0, -12(%ebp)
	jns	.L29
	.loc 2 78 0
	movl	$-1, %eax
.LVL29:
	jmp	.L30
.LVL30:
.L29:
	.loc 2 79 0
	movl	12(%ebp), %eax
.LVL31:
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	fstat
.LVL32:
	movl	%eax, -16(%ebp)
.LVL33:
	.loc 2 80 0
	movl	-12(%ebp), %eax
.LVL34:
	movl	%eax, (%esp)
	call	close
.LVL35:
	.loc 2 81 0
	movl	-16(%ebp), %eax
.LVL36:
.L30:
	.loc 2 82 0
	leave
.LCFI23:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	stat, .-stat
	.globl	atoi
	.type	atoi, @function
atoi:
.LFB25:
	.loc 2 86 0
	.cfi_startproc
.LVL37:
	pushl	%ebp
.LCFI24:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI25:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 89 0
	movl	$0, -4(%ebp)
.LVL38:
	.loc 2 90 0
	jmp	.L32
.L34:
	.loc 2 91 0
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	addl	%edx, %eax
	subl	$48, %eax
	movl	%eax, -4(%ebp)
.LVL39:
	addl	$1, 8(%ebp)
.LVL40:
.L32:
	.loc 2 90 0 discriminator 1
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	jle	.L33
	.loc 2 90 0 is_stmt 0 discriminator 2
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$57, %al
	jle	.L34
.L33:
	.loc 2 92 0 is_stmt 1
	movl	-4(%ebp), %eax
	.loc 2 93 0
	leave
.LCFI26:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	atoi, .-atoi
	.globl	memmove
	.type	memmove, @function
memmove:
.LFB26:
	.loc 2 97 0
	.cfi_startproc
.LVL41:
	pushl	%ebp
.LCFI27:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI28:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 100 0
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.LVL42:
	.loc 2 101 0
	movl	12(%ebp), %eax
.LVL43:
	movl	%eax, -8(%ebp)
.LVL44:
	.loc 2 102 0
	jmp	.L37
.LVL45:
.L38:
	.loc 2 103 0
	movl	-8(%ebp), %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %eax
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
	addl	$1, -8(%ebp)
.LVL46:
.L37:
	.loc 2 102 0 discriminator 1
	cmpl	$0, 16(%ebp)
	setg	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L38
	.loc 2 104 0
	movl	8(%ebp), %eax
	.loc 2 105 0
	leave
.LCFI29:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	memmove, .-memmove
.Letext0:
	.file 3 "types.h"
	.file 4 "stat.h"
	.file 5 "user.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x499
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF26
	.byte	0x1
	.long	.LASF27
	.long	.LASF28
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF2
	.byte	0x3
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
	.uleb128 0x2
	.long	.LASF3
	.byte	0x3
	.byte	0x3
	.long	0x49
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x4
	.long	.LASF18
	.byte	0x14
	.byte	0x4
	.byte	0x5
	.long	0xa3
	.uleb128 0x5
	.long	.LASF5
	.byte	0x4
	.byte	0x6
	.long	0xa3
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.string	"dev"
	.byte	0x4
	.byte	0x7
	.long	0xaa
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"ino"
	.byte	0x4
	.byte	0x8
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF6
	.byte	0x4
	.byte	0x9
	.long	0xa3
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.long	.LASF7
	.byte	0x4
	.byte	0xa
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF8
	.uleb128 0x7
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x8
	.long	.LASF29
	.byte	0x1
	.byte	0x2b
	.byte	0x1
	.long	.LFB5
	.long	.LFE5
	.long	.LLST0
	.byte	0x1
	.long	0xf7
	.uleb128 0x9
	.long	.LASF9
	.byte	0x1
	.byte	0x2b
	.long	0xf7
	.long	.LLST1
	.uleb128 0xa
	.long	.LASF10
	.byte	0x1
	.byte	0x2b
	.long	0xaa
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xb
	.string	"cnt"
	.byte	0x1
	.byte	0x2b
	.long	0xaa
	.long	.LLST2
	.byte	0
	.uleb128 0xc
	.byte	0x4
	.uleb128 0xd
	.byte	0x1
	.long	.LASF12
	.byte	0x2
	.byte	0x8
	.byte	0x1
	.long	0x140
	.long	.LFB18
	.long	.LFE18
	.long	.LLST3
	.byte	0x1
	.long	0x140
	.uleb128 0xb
	.string	"s"
	.byte	0x2
	.byte	0x8
	.long	0x140
	.long	.LLST4
	.uleb128 0xb
	.string	"t"
	.byte	0x2
	.byte	0x8
	.long	0x140
	.long	.LLST5
	.uleb128 0xe
	.string	"os"
	.byte	0x2
	.byte	0xa
	.long	0x140
	.long	.LLST6
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.long	0x146
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF11
	.uleb128 0xd
	.byte	0x1
	.long	.LASF13
	.byte	0x2
	.byte	0x13
	.byte	0x1
	.long	0xaa
	.long	.LFB19
	.long	.LFE19
	.long	.LLST7
	.byte	0x1
	.long	0x186
	.uleb128 0xb
	.string	"p"
	.byte	0x2
	.byte	0x13
	.long	0x186
	.long	.LLST8
	.uleb128 0xb
	.string	"q"
	.byte	0x2
	.byte	0x13
	.long	0x186
	.long	.LLST9
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.long	0x18c
	.uleb128 0x10
	.long	0x146
	.uleb128 0xd
	.byte	0x1
	.long	.LASF14
	.byte	0x2
	.byte	0x1b
	.byte	0x1
	.long	0x25
	.long	.LFB20
	.long	.LFE20
	.long	.LLST10
	.byte	0x1
	.long	0x1c9
	.uleb128 0x11
	.string	"s"
	.byte	0x2
	.byte	0x1b
	.long	0x140
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xe
	.string	"n"
	.byte	0x2
	.byte	0x1d
	.long	0xaa
	.long	.LLST11
	.byte	0
	.uleb128 0xd
	.byte	0x1
	.long	.LASF15
	.byte	0x2
	.byte	0x25
	.byte	0x1
	.long	0xf7
	.long	.LFB21
	.long	.LFE21
	.long	.LLST12
	.byte	0x1
	.long	0x230
	.uleb128 0x11
	.string	"dst"
	.byte	0x2
	.byte	0x25
	.long	0xf7
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.string	"c"
	.byte	0x2
	.byte	0x25
	.long	0xaa
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x11
	.string	"n"
	.byte	0x2
	.byte	0x25
	.long	0x25
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.long	.LVL14
	.long	0xb1
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0xd
	.byte	0x1
	.long	.LASF16
	.byte	0x2
	.byte	0x2c
	.byte	0x1
	.long	0x140
	.long	.LFB22
	.long	.LFE22
	.long	.LLST13
	.byte	0x1
	.long	0x268
	.uleb128 0xb
	.string	"s"
	.byte	0x2
	.byte	0x2c
	.long	0x186
	.long	.LLST14
	.uleb128 0x11
	.string	"c"
	.byte	0x2
	.byte	0x2c
	.long	0x146
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0xd
	.byte	0x1
	.long	.LASF17
	.byte	0x2
	.byte	0x35
	.byte	0x1
	.long	0x140
	.long	.LFB23
	.long	.LFE23
	.long	.LLST15
	.byte	0x1
	.long	0x2e8
	.uleb128 0x11
	.string	"buf"
	.byte	0x2
	.byte	0x35
	.long	0x140
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.string	"max"
	.byte	0x2
	.byte	0x35
	.long	0xaa
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x14
	.string	"i"
	.byte	0x2
	.byte	0x37
	.long	0xaa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0xe
	.string	"cc"
	.byte	0x2
	.byte	0x37
	.long	0xaa
	.long	.LLST16
	.uleb128 0x14
	.string	"c"
	.byte	0x2
	.byte	0x38
	.long	0x146
	.byte	0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x12
	.long	.LVL20
	.long	0x42c
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0xd
	.byte	0x1
	.long	.LASF18
	.byte	0x2
	.byte	0x47
	.byte	0x1
	.long	0xaa
	.long	.LFB24
	.long	.LFE24
	.long	.LLST17
	.byte	0x1
	.long	0x387
	.uleb128 0x11
	.string	"n"
	.byte	0x2
	.byte	0x47
	.long	0x140
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.string	"st"
	.byte	0x2
	.byte	0x47
	.long	0x387
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xe
	.string	"fd"
	.byte	0x2
	.byte	0x49
	.long	0xaa
	.long	.LLST18
	.uleb128 0xe
	.string	"r"
	.byte	0x2
	.byte	0x4a
	.long	0xaa
	.long	.LLST19
	.uleb128 0x15
	.long	.LVL27
	.long	0x44e
	.long	0x356
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x15
	.long	.LVL32
	.long	0x46b
	.long	0x374
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.long	.LVL35
	.long	0x488
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.long	0x50
	.uleb128 0xd
	.byte	0x1
	.long	.LASF19
	.byte	0x2
	.byte	0x55
	.byte	0x1
	.long	0xaa
	.long	.LFB25
	.long	.LFE25
	.long	.LLST20
	.byte	0x1
	.long	0x3c6
	.uleb128 0xb
	.string	"s"
	.byte	0x2
	.byte	0x55
	.long	0x186
	.long	.LLST21
	.uleb128 0xe
	.string	"n"
	.byte	0x2
	.byte	0x57
	.long	0xaa
	.long	.LLST22
	.byte	0
	.uleb128 0xd
	.byte	0x1
	.long	.LASF20
	.byte	0x2
	.byte	0x60
	.byte	0x1
	.long	0xf7
	.long	.LFB26
	.long	.LFE26
	.long	.LLST23
	.byte	0x1
	.long	0x42c
	.uleb128 0xa
	.long	.LASF21
	.byte	0x2
	.byte	0x60
	.long	0xf7
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xa
	.long	.LASF22
	.byte	0x2
	.byte	0x60
	.long	0xf7
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xb
	.string	"n"
	.byte	0x2
	.byte	0x60
	.long	0xaa
	.long	.LLST24
	.uleb128 0xe
	.string	"dst"
	.byte	0x2
	.byte	0x62
	.long	0x140
	.long	.LLST25
	.uleb128 0xe
	.string	"src"
	.byte	0x2
	.byte	0x62
	.long	0x140
	.long	.LLST26
	.byte	0
	.uleb128 0x16
	.byte	0x1
	.long	.LASF23
	.byte	0x5
	.byte	0xa
	.byte	0x1
	.long	0xaa
	.byte	0x1
	.long	0x44e
	.uleb128 0x17
	.long	0xaa
	.uleb128 0x17
	.long	0xf7
	.uleb128 0x17
	.long	0xaa
	.byte	0
	.uleb128 0x16
	.byte	0x1
	.long	.LASF24
	.byte	0x5
	.byte	0xe
	.byte	0x1
	.long	0xaa
	.byte	0x1
	.long	0x46b
	.uleb128 0x17
	.long	0x140
	.uleb128 0x17
	.long	0xaa
	.byte	0
	.uleb128 0x16
	.byte	0x1
	.long	.LASF25
	.byte	0x5
	.byte	0x11
	.byte	0x1
	.long	0xaa
	.byte	0x1
	.long	0x488
	.uleb128 0x17
	.long	0xaa
	.uleb128 0x17
	.long	0x387
	.byte	0
	.uleb128 0x18
	.byte	0x1
	.long	.LASF30
	.byte	0x5
	.byte	0xb
	.byte	0x1
	.long	0xaa
	.byte	0x1
	.uleb128 0x17
	.long	0xaa
	.byte	0
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
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0x6
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
	.uleb128 0xc
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0xf
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
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
	.uleb128 0x12
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
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
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB5-.Ltext0
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
	.long	.LFE5-.Ltext0
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
	.sleb128 0
	.long	.LVL1-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL2-.Ltext0
	.long	.LVL3-.Ltext0
	.value	0x1
	.byte	0x57
	.long	.LVL3-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST2:
	.long	.LVL0-.Ltext0
	.long	.LVL1-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL1-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST3:
	.long	.LFB18-.Ltext0
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
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST4:
	.long	.LVL4-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL6-.Ltext0
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST5:
	.long	.LVL4-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL6-.Ltext0
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST6:
	.long	.LVL5-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL6-.Ltext0
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST7:
	.long	.LFB19-.Ltext0
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
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST8:
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL8-.Ltext0
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST9:
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL8-.Ltext0
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST10:
	.long	.LFB20-.Ltext0
	.long	.LCFI9-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI9-.Ltext0
	.long	.LCFI10-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI10-.Ltext0
	.long	.LCFI11-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI11-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST11:
	.long	.LVL10-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	.LVL11-.Ltext0
	.long	.LVL12-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL12-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	0
	.long	0
.LLST12:
	.long	.LFB21-.Ltext0
	.long	.LCFI12-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI12-.Ltext0
	.long	.LCFI13-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI13-.Ltext0
	.long	.LCFI14-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI14-.Ltext0
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LFB22-.Ltext0
	.long	.LCFI15-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI15-.Ltext0
	.long	.LCFI16-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI16-.Ltext0
	.long	.LCFI17-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI17-.Ltext0
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST14:
	.long	.LVL15-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL16-.Ltext0
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST15:
	.long	.LFB23-.Ltext0
	.long	.LCFI18-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI18-.Ltext0
	.long	.LCFI19-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI19-.Ltext0
	.long	.LCFI20-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI20-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST16:
	.long	.LVL21-.Ltext0
	.long	.LVL22-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL22-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL24-.Ltext0
	.long	.LVL25-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST17:
	.long	.LFB24-.Ltext0
	.long	.LCFI21-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI21-.Ltext0
	.long	.LCFI22-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI22-.Ltext0
	.long	.LCFI23-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI23-.Ltext0
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST18:
	.long	.LVL28-.Ltext0
	.long	.LVL29-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL29-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	.LVL30-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL31-.Ltext0
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST19:
	.long	.LVL33-.Ltext0
	.long	.LVL34-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL34-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST20:
	.long	.LFB25-.Ltext0
	.long	.LCFI24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI24-.Ltext0
	.long	.LCFI25-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI25-.Ltext0
	.long	.LCFI26-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI26-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST21:
	.long	.LVL37-.Ltext0
	.long	.LVL40-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL40-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST22:
	.long	.LVL38-.Ltext0
	.long	.LVL39-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	.LVL39-.Ltext0
	.long	.LVL40-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL40-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	0
	.long	0
.LLST23:
	.long	.LFB26-.Ltext0
	.long	.LCFI27-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI27-.Ltext0
	.long	.LCFI28-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI28-.Ltext0
	.long	.LCFI29-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI29-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST24:
	.long	.LVL41-.Ltext0
	.long	.LVL46-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL46-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST25:
	.long	.LVL42-.Ltext0
	.long	.LVL43-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL43-.Ltext0
	.long	.LVL45-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL45-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	0
	.long	0
.LLST26:
	.long	.LVL44-.Ltext0
	.long	.LVL45-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL45-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -16
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
.LASF18:
	.string	"stat"
.LASF16:
	.string	"strchr"
.LASF3:
	.string	"uchar"
.LASF20:
	.string	"memmove"
.LASF22:
	.string	"vsrc"
.LASF9:
	.string	"addr"
.LASF14:
	.string	"strlen"
.LASF10:
	.string	"data"
.LASF4:
	.string	"unsigned char"
.LASF12:
	.string	"strcpy"
.LASF1:
	.string	"short unsigned int"
.LASF15:
	.string	"memset"
.LASF28:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF17:
	.string	"gets"
.LASF25:
	.string	"fstat"
.LASF23:
	.string	"read"
.LASF2:
	.string	"uint"
.LASF0:
	.string	"unsigned int"
.LASF24:
	.string	"open"
.LASF11:
	.string	"char"
.LASF21:
	.string	"vdst"
.LASF19:
	.string	"atoi"
.LASF13:
	.string	"strcmp"
.LASF27:
	.string	"ulib.c"
.LASF29:
	.string	"stosb"
.LASF26:
	.string	"GNU C 4.7.2"
.LASF5:
	.string	"type"
.LASF8:
	.string	"short int"
.LASF30:
	.string	"close"
.LASF6:
	.string	"nlink"
.LASF7:
	.string	"size"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
