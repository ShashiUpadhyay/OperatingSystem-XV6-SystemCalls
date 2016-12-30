	.file	"string.c"
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
	.type	stosl, @function
stosl:
.LFB6:
	.loc 1 53 0
	.cfi_startproc
.LVL4:
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%ebx
	.cfi_offset 7, -12
	.cfi_offset 3, -16
	.loc 1 54 0
	movl	8(%ebp), %ecx
	movl	16(%ebp), %edx
	movl	12(%ebp), %eax
	movl	%ecx, %ebx
	movl	%ebx, %edi
	movl	%edx, %ecx
#APP
# 54 "x86.h" 1
	cld; rep stosl
# 0 "" 2
#NO_APP
	movl	%ecx, %edx
	movl	%edi, %ebx
	movl	%ebx, 8(%ebp)
	movl	%edx, 16(%ebp)
.LVL5:
	.loc 1 58 0
	popl	%ebx
	.cfi_restore 3
.LVL6:
	popl	%edi
	.cfi_restore 7
.LVL7:
	popl	%ebp
.LCFI5:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	stosl, .-stosl
	.globl	memset
	.type	memset, @function
memset:
.LFB18:
	.file 2 "string.c"
	.loc 2 6 0
	.cfi_startproc
.LVL8:
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	subl	$12, %esp
	.loc 2 7 0
	movl	8(%ebp), %eax
	andl	$3, %eax
	testl	%eax, %eax
	jne	.L4
	.loc 2 7 0 is_stmt 0 discriminator 1
	movl	16(%ebp), %eax
	andl	$3, %eax
	testl	%eax, %eax
	jne	.L4
	.loc 2 8 0 is_stmt 1
	andl	$255, 12(%ebp)
	.loc 2 9 0
	movl	16(%ebp), %eax
	shrl	$2, %eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	sall	$24, %ecx
	movl	12(%ebp), %eax
	sall	$16, %eax
	orl	%eax, %ecx
	movl	12(%ebp), %eax
	sall	$8, %eax
	orl	%ecx, %eax
	orl	12(%ebp), %eax
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	stosl
.LVL9:
	jmp	.L5
.L4:
	.loc 2 11 0
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	stosb
.LVL10:
.L5:
	.loc 2 12 0
	movl	8(%ebp), %eax
	.loc 2 13 0
	leave
.LCFI8:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	memset, .-memset
	.globl	memcmp
	.type	memcmp, @function
memcmp:
.LFB19:
	.loc 2 17 0
	.cfi_startproc
.LVL11:
	pushl	%ebp
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI10:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 20 0
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.LVL12:
	.loc 2 21 0
	movl	12(%ebp), %eax
.LVL13:
	movl	%eax, -8(%ebp)
.LVL14:
	.loc 2 22 0
	jmp	.L8
.LVL15:
.L11:
	.loc 2 23 0
	movl	-4(%ebp), %eax
	movzbl	(%eax), %edx
	movl	-8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	je	.L9
	.loc 2 24 0
	movl	-4(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %edx
	movl	-8(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	jmp	.L10
.L9:
	.loc 2 25 0
	addl	$1, -4(%ebp)
	addl	$1, -8(%ebp)
.LVL16:
.L8:
	.loc 2 22 0 discriminator 1
	cmpl	$0, 16(%ebp)
	setne	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L11
	.loc 2 28 0
	movl	$0, %eax
.L10:
	.loc 2 29 0
	leave
.LCFI11:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE19:
	.size	memcmp, .-memcmp
	.globl	memmove
	.type	memmove, @function
memmove:
.LFB20:
	.loc 2 33 0
	.cfi_startproc
.LVL17:
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI13:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 37 0
	movl	12(%ebp), %eax
	movl	%eax, -4(%ebp)
.LVL18:
	.loc 2 38 0
	movl	8(%ebp), %eax
.LVL19:
	movl	%eax, -8(%ebp)
.LVL20:
	.loc 2 39 0
	movl	-4(%ebp), %eax
.LVL21:
	cmpl	-8(%ebp), %eax
	jae	.L20
	.loc 2 39 0 is_stmt 0 discriminator 1
	movl	16(%ebp), %eax
	movl	-4(%ebp), %edx
	addl	%edx, %eax
	cmpl	-8(%ebp), %eax
	jbe	.L20
	.loc 2 40 0 is_stmt 1
	movl	16(%ebp), %eax
	addl	%eax, -4(%ebp)
.LVL22:
	.loc 2 41 0
	movl	16(%ebp), %eax
	addl	%eax, -8(%ebp)
.LVL23:
	.loc 2 42 0
	jmp	.L14
.L15:
	.loc 2 43 0
	subl	$1, -8(%ebp)
	subl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	movzbl	(%eax), %edx
	movl	-8(%ebp), %eax
	movb	%dl, (%eax)
.LVL24:
.L14:
	.loc 2 42 0 discriminator 1
	cmpl	$0, 16(%ebp)
	setne	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L15
	.loc 2 39 0
	jmp	.L16
.L18:
	.loc 2 46 0
	movl	-4(%ebp), %eax
	movzbl	(%eax), %edx
	movl	-8(%ebp), %eax
	movb	%dl, (%eax)
	addl	$1, -8(%ebp)
	addl	$1, -4(%ebp)
	jmp	.L17
.LVL25:
.L20:
	.loc 2 45 0
	nop
.LVL26:
.L17:
	.loc 2 45 0 is_stmt 0 discriminator 1
	cmpl	$0, 16(%ebp)
	setne	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L18
.L16:
	.loc 2 48 0 is_stmt 1
	movl	8(%ebp), %eax
	.loc 2 49 0
	leave
.LCFI14:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	memmove, .-memmove
	.globl	memcpy
	.type	memcpy, @function
memcpy:
.LFB21:
	.loc 2 54 0
	.cfi_startproc
.LVL27:
	pushl	%ebp
.LCFI15:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI16:
	.cfi_def_cfa_register 5
	subl	$12, %esp
	.loc 2 55 0
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	memmove
.LVL28:
	.loc 2 56 0
	leave
.LCFI17:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	memcpy, .-memcpy
	.globl	strncmp
	.type	strncmp, @function
strncmp:
.LFB22:
	.loc 2 60 0
	.cfi_startproc
.LVL29:
	pushl	%ebp
.LCFI18:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI19:
	.cfi_def_cfa_register 5
	.loc 2 61 0
	jmp	.L24
.L26:
	.loc 2 62 0
	subl	$1, 16(%ebp)
	addl	$1, 8(%ebp)
	addl	$1, 12(%ebp)
.LVL30:
.L24:
	.loc 2 61 0 discriminator 1
	cmpl	$0, 16(%ebp)
	je	.L25
	.loc 2 61 0 is_stmt 0 discriminator 2
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	.L25
	.loc 2 61 0 discriminator 1
	movl	8(%ebp), %eax
	movzbl	(%eax), %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	je	.L26
.L25:
	.loc 2 63 0 is_stmt 1
	cmpl	$0, 16(%ebp)
	jne	.L27
	.loc 2 64 0
	movl	$0, %eax
	jmp	.L28
.L27:
	.loc 2 65 0
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
.L28:
	.loc 2 66 0
	popl	%ebp
.LCFI20:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	strncmp, .-strncmp
	.globl	strncpy
	.type	strncpy, @function
strncpy:
.LFB23:
	.loc 2 70 0
	.cfi_startproc
.LVL31:
	pushl	%ebp
.LCFI21:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI22:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 73 0
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.LVL32:
	.loc 2 74 0
	nop
.LVL33:
.L31:
	.loc 2 74 0 is_stmt 0 discriminator 1
	cmpl	$0, 16(%ebp)
	setg	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	je	.L35
	.loc 2 74 0 discriminator 2
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
	jne	.L31
	.loc 2 76 0 is_stmt 1
	jmp	.L35
.L33:
	.loc 2 77 0
	movl	8(%ebp), %eax
	movb	$0, (%eax)
	addl	$1, 8(%ebp)
	jmp	.L32
.L35:
	.loc 2 76 0
	nop
.L32:
	.loc 2 76 0 is_stmt 0 discriminator 1
	cmpl	$0, 16(%ebp)
	setg	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L33
	.loc 2 78 0 is_stmt 1
	movl	-4(%ebp), %eax
	.loc 2 79 0
	leave
.LCFI23:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	strncpy, .-strncpy
	.globl	safestrcpy
	.type	safestrcpy, @function
safestrcpy:
.LFB24:
	.loc 2 84 0
	.cfi_startproc
.LVL34:
	pushl	%ebp
.LCFI24:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI25:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 87 0
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.LVL35:
	.loc 2 88 0
	cmpl	$0, 16(%ebp)
	jg	.L40
	.loc 2 89 0
	movl	-4(%ebp), %eax
	jmp	.L38
.LVL36:
.L40:
	.loc 2 90 0 discriminator 1
	subl	$1, 16(%ebp)
	cmpl	$0, 16(%ebp)
	jle	.L39
	.loc 2 90 0 is_stmt 0 discriminator 2
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
	jne	.L40
.L39:
	.loc 2 92 0 is_stmt 1
	movl	8(%ebp), %eax
	movb	$0, (%eax)
	.loc 2 93 0
	movl	-4(%ebp), %eax
.LVL37:
.L38:
	.loc 2 94 0
	leave
.LCFI26:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	safestrcpy, .-safestrcpy
	.globl	strlen
	.type	strlen, @function
strlen:
.LFB25:
	.loc 2 98 0
	.cfi_startproc
.LVL38:
	pushl	%ebp
.LCFI27:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI28:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 2 101 0
	movl	$0, -4(%ebp)
.LVL39:
	jmp	.L42
.LVL40:
.L43:
	.loc 2 101 0 is_stmt 0 discriminator 2
	addl	$1, -4(%ebp)
.LVL41:
.L42:
	.loc 2 101 0 discriminator 1
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L43
	.loc 2 103 0 is_stmt 1
	movl	-4(%ebp), %eax
	.loc 2 104 0
	leave
.LCFI29:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	strlen, .-strlen
.Letext0:
	.file 3 "types.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x3fd
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF17
	.byte	0x1
	.long	.LASF18
	.long	.LASF19
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
	.long	.LASF7
	.byte	0x1
	.byte	0x2b
	.byte	0x1
	.long	.LFB5
	.long	.LFE5
	.long	.LLST0
	.byte	0x1
	.long	0x96
	.uleb128 0x5
	.long	.LASF5
	.byte	0x1
	.byte	0x2b
	.long	0x96
	.long	.LLST1
	.uleb128 0x6
	.long	.LASF6
	.byte	0x1
	.byte	0x2b
	.long	0x98
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x7
	.string	"cnt"
	.byte	0x1
	.byte	0x2b
	.long	0x98
	.long	.LLST2
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.uleb128 0x9
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x4
	.long	.LASF8
	.byte	0x1
	.byte	0x34
	.byte	0x1
	.long	.LFB6
	.long	.LFE6
	.long	.LLST3
	.byte	0x1
	.long	0xe5
	.uleb128 0x5
	.long	.LASF5
	.byte	0x1
	.byte	0x34
	.long	0x96
	.long	.LLST4
	.uleb128 0x6
	.long	.LASF6
	.byte	0x1
	.byte	0x34
	.long	0x98
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x7
	.string	"cnt"
	.byte	0x1
	.byte	0x34
	.long	0x98
	.long	.LLST5
	.byte	0
	.uleb128 0xa
	.byte	0x1
	.long	.LASF9
	.byte	0x2
	.byte	0x5
	.byte	0x1
	.long	0x96
	.long	.LFB18
	.long	.LFE18
	.long	.LLST6
	.byte	0x1
	.long	0x187
	.uleb128 0xb
	.string	"dst"
	.byte	0x2
	.byte	0x5
	.long	0x96
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x7
	.string	"c"
	.byte	0x2
	.byte	0x5
	.long	0x98
	.long	.LLST7
	.uleb128 0xb
	.string	"n"
	.byte	0x2
	.byte	0x5
	.long	0x25
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0xc
	.long	.LVL9
	.long	0x9f
	.long	0x164
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x15
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0x48
	.byte	0x24
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0x40
	.byte	0x24
	.byte	0x21
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0x38
	.byte	0x24
	.byte	0x21
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0x21
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.byte	0x32
	.byte	0x25
	.byte	0
	.uleb128 0xe
	.long	.LVL10
	.long	0x50
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0xa
	.byte	0x1
	.long	.LASF10
	.byte	0x2
	.byte	0x10
	.byte	0x1
	.long	0x98
	.long	.LFB19
	.long	.LFE19
	.long	.LLST8
	.byte	0x1
	.long	0x1e9
	.uleb128 0xb
	.string	"v1"
	.byte	0x2
	.byte	0x10
	.long	0x1e9
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xb
	.string	"v2"
	.byte	0x2
	.byte	0x10
	.long	0x1e9
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x7
	.string	"n"
	.byte	0x2
	.byte	0x10
	.long	0x25
	.long	.LLST9
	.uleb128 0xf
	.string	"s1"
	.byte	0x2
	.byte	0x12
	.long	0x1f0
	.long	.LLST10
	.uleb128 0xf
	.string	"s2"
	.byte	0x2
	.byte	0x12
	.long	0x1f0
	.long	.LLST11
	.byte	0
	.uleb128 0x10
	.byte	0x4
	.long	0x1ef
	.uleb128 0x11
	.uleb128 0x10
	.byte	0x4
	.long	0x1f6
	.uleb128 0x12
	.long	0x3e
	.uleb128 0xa
	.byte	0x1
	.long	.LASF11
	.byte	0x2
	.byte	0x20
	.byte	0x1
	.long	0x96
	.long	.LFB20
	.long	.LFE20
	.long	.LLST12
	.byte	0x1
	.long	0x25d
	.uleb128 0xb
	.string	"dst"
	.byte	0x2
	.byte	0x20
	.long	0x96
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xb
	.string	"src"
	.byte	0x2
	.byte	0x20
	.long	0x1e9
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x7
	.string	"n"
	.byte	0x2
	.byte	0x20
	.long	0x25
	.long	.LLST13
	.uleb128 0xf
	.string	"s"
	.byte	0x2
	.byte	0x22
	.long	0x25d
	.long	.LLST14
	.uleb128 0xf
	.string	"d"
	.byte	0x2
	.byte	0x23
	.long	0x26f
	.long	.LLST15
	.byte	0
	.uleb128 0x10
	.byte	0x4
	.long	0x263
	.uleb128 0x12
	.long	0x268
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0x10
	.byte	0x4
	.long	0x268
	.uleb128 0xa
	.byte	0x1
	.long	.LASF13
	.byte	0x2
	.byte	0x35
	.byte	0x1
	.long	0x96
	.long	.LFB21
	.long	.LFE21
	.long	.LLST16
	.byte	0x1
	.long	0x2de
	.uleb128 0xb
	.string	"dst"
	.byte	0x2
	.byte	0x35
	.long	0x96
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xb
	.string	"src"
	.byte	0x2
	.byte	0x35
	.long	0x1e9
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xb
	.string	"n"
	.byte	0x2
	.byte	0x35
	.long	0x25
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0xe
	.long	.LVL28
	.long	0x1fb
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0xa
	.byte	0x1
	.long	.LASF14
	.byte	0x2
	.byte	0x3b
	.byte	0x1
	.long	0x98
	.long	.LFB22
	.long	.LFE22
	.long	.LLST17
	.byte	0x1
	.long	0x324
	.uleb128 0x7
	.string	"p"
	.byte	0x2
	.byte	0x3b
	.long	0x25d
	.long	.LLST18
	.uleb128 0x7
	.string	"q"
	.byte	0x2
	.byte	0x3b
	.long	0x25d
	.long	.LLST19
	.uleb128 0x7
	.string	"n"
	.byte	0x2
	.byte	0x3b
	.long	0x25
	.long	.LLST20
	.byte	0
	.uleb128 0xa
	.byte	0x1
	.long	.LASF15
	.byte	0x2
	.byte	0x45
	.byte	0x1
	.long	0x26f
	.long	.LFB23
	.long	.LFE23
	.long	.LLST21
	.byte	0x1
	.long	0x378
	.uleb128 0x7
	.string	"s"
	.byte	0x2
	.byte	0x45
	.long	0x26f
	.long	.LLST22
	.uleb128 0x7
	.string	"t"
	.byte	0x2
	.byte	0x45
	.long	0x25d
	.long	.LLST23
	.uleb128 0x7
	.string	"n"
	.byte	0x2
	.byte	0x45
	.long	0x98
	.long	.LLST24
	.uleb128 0xf
	.string	"os"
	.byte	0x2
	.byte	0x47
	.long	0x26f
	.long	.LLST25
	.byte	0
	.uleb128 0xa
	.byte	0x1
	.long	.LASF16
	.byte	0x2
	.byte	0x53
	.byte	0x1
	.long	0x26f
	.long	.LFB24
	.long	.LFE24
	.long	.LLST26
	.byte	0x1
	.long	0x3cc
	.uleb128 0x7
	.string	"s"
	.byte	0x2
	.byte	0x53
	.long	0x26f
	.long	.LLST27
	.uleb128 0x7
	.string	"t"
	.byte	0x2
	.byte	0x53
	.long	0x25d
	.long	.LLST28
	.uleb128 0x7
	.string	"n"
	.byte	0x2
	.byte	0x53
	.long	0x98
	.long	.LLST29
	.uleb128 0xf
	.string	"os"
	.byte	0x2
	.byte	0x55
	.long	0x26f
	.long	.LLST30
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF20
	.byte	0x2
	.byte	0x61
	.byte	0x1
	.long	0x98
	.long	.LFB25
	.long	.LFE25
	.long	.LLST31
	.byte	0x1
	.uleb128 0xb
	.string	"s"
	.byte	0x2
	.byte	0x61
	.long	0x25d
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xf
	.string	"n"
	.byte	0x2
	.byte	0x63
	.long	0x98
	.long	.LLST32
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
	.uleb128 0x5
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
	.uleb128 0x6
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xc
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
	.uleb128 0xd
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
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
	.long	.LFB6-.Ltext0
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
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST4:
	.long	.LVL4-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL5-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL6-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x57
	.long	.LVL7-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST5:
	.long	.LVL4-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL5-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST6:
	.long	.LFB18-.Ltext0
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
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST7:
	.long	.LVL8-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST8:
	.long	.LFB19-.Ltext0
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
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST9:
	.long	.LVL11-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL16-.Ltext0
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST10:
	.long	.LVL12-.Ltext0
	.long	.LVL13-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL13-.Ltext0
	.long	.LVL15-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL15-.Ltext0
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	0
	.long	0
.LLST11:
	.long	.LVL14-.Ltext0
	.long	.LVL15-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL15-.Ltext0
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -16
	.long	0
	.long	0
.LLST12:
	.long	.LFB20-.Ltext0
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
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LVL17-.Ltext0
	.long	.LVL24-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL24-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST14:
	.long	.LVL18-.Ltext0
	.long	.LVL19-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL19-.Ltext0
	.long	.LVL22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL22-.Ltext0
	.long	.LVL25-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	.LVL25-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL26-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	0
	.long	0
.LLST15:
	.long	.LVL20-.Ltext0
	.long	.LVL21-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL21-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL23-.Ltext0
	.long	.LVL25-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -16
	.long	.LVL25-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL26-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -16
	.long	0
	.long	0
.LLST16:
	.long	.LFB21-.Ltext0
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
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST17:
	.long	.LFB22-.Ltext0
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
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST18:
	.long	.LVL29-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL30-.Ltext0
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST19:
	.long	.LVL29-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL30-.Ltext0
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST20:
	.long	.LVL29-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL30-.Ltext0
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST21:
	.long	.LFB23-.Ltext0
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
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST22:
	.long	.LVL31-.Ltext0
	.long	.LVL33-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL33-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST23:
	.long	.LVL31-.Ltext0
	.long	.LVL33-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL33-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST24:
	.long	.LVL31-.Ltext0
	.long	.LVL33-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL33-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST25:
	.long	.LVL32-.Ltext0
	.long	.LVL33-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL33-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST26:
	.long	.LFB24-.Ltext0
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
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST27:
	.long	.LVL34-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL36-.Ltext0
	.long	.LVL37-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST28:
	.long	.LVL34-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL36-.Ltext0
	.long	.LVL37-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST29:
	.long	.LVL34-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL36-.Ltext0
	.long	.LVL37-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST30:
	.long	.LVL35-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL36-.Ltext0
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST31:
	.long	.LFB25-.Ltext0
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
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST32:
	.long	.LVL39-.Ltext0
	.long	.LVL40-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
	.long	.LVL40-.Ltext0
	.long	.LVL41-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL41-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -12
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
.LASF11:
	.string	"memmove"
.LASF3:
	.string	"uchar"
.LASF5:
	.string	"addr"
.LASF20:
	.string	"strlen"
.LASF6:
	.string	"data"
.LASF4:
	.string	"unsigned char"
.LASF1:
	.string	"short unsigned int"
.LASF15:
	.string	"strncpy"
.LASF9:
	.string	"memset"
.LASF19:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF2:
	.string	"uint"
.LASF0:
	.string	"unsigned int"
.LASF12:
	.string	"char"
.LASF13:
	.string	"memcpy"
.LASF7:
	.string	"stosb"
.LASF17:
	.string	"GNU C 4.7.2"
.LASF18:
	.string	"string.c"
.LASF10:
	.string	"memcmp"
.LASF16:
	.string	"safestrcpy"
.LASF8:
	.string	"stosl"
.LASF14:
	.string	"strncmp"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
