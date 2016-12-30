	.file	"echo.c"
	.text
.Ltext0:
	.section	.rodata
.LC0:
	.string	"%d, %d"
.LC1:
	.string	" "
.LC2:
	.string	"\n"
.LC3:
	.string	"%s%s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.file 1 "echo.c"
	.loc 1 8 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$48, %esp
	.loc 1 11 0
	leal	20(%esp), %eax
	movl	%eax, (%esp)
	call	date
.LVL1:
	.loc 1 12 0
	movl	36(%esp), %edx
	movl	40(%esp), %eax
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	$.LC0, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL2:
	.loc 1 15 0
	movl	$1, 44(%esp)
.LVL3:
	jmp	.L2
.LVL4:
.L5:
	.loc 1 16 0
	movl	44(%esp), %eax
.LVL5:
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L3
	.loc 1 16 0 is_stmt 0 discriminator 1
	movl	$.LC1, %eax
	jmp	.L4
.L3:
	.loc 1 16 0 discriminator 2
	movl	$.LC2, %eax
.L4:
	.loc 1 16 0 discriminator 3
	movl	44(%esp), %edx
	leal	0(,%edx,4), %ecx
	movl	12(%ebp), %edx
	addl	%ecx, %edx
	movl	(%edx), %edx
	movl	%eax, 12(%esp)
	movl	%edx, 8(%esp)
	movl	$.LC3, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL6:
	.loc 1 15 0 is_stmt 1 discriminator 3
	addl	$1, 44(%esp)
.LVL7:
.L2:
	.loc 1 15 0 is_stmt 0 discriminator 1
	movl	44(%esp), %eax
	cmpl	8(%ebp), %eax
	jl	.L5
	.loc 1 17 0 is_stmt 1
	call	exit
.LVL8:
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.file 2 "date.h"
	.file 3 "types.h"
	.file 4 "user.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x1ba
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF12
	.byte	0x1
	.long	.LASF13
	.long	.LASF14
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF15
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
	.long	.LASF16
	.byte	0x18
	.byte	0x2
	.byte	0x1
	.long	0xb4
	.uleb128 0x6
	.long	.LASF4
	.byte	0x2
	.byte	0x2
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.long	.LASF5
	.byte	0x2
	.byte	0x3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.long	.LASF6
	.byte	0x2
	.byte	0x4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x7
	.string	"day"
	.byte	0x2
	.byte	0x5
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.long	.LASF7
	.byte	0x2
	.byte	0x6
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x6
	.long	.LASF8
	.byte	0x2
	.byte	0x7
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.byte	0
	.uleb128 0x8
	.byte	0x1
	.long	.LASF17
	.byte	0x1
	.byte	0x7
	.byte	0x1
	.long	0x4c
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.byte	0x1
	.long	0x164
	.uleb128 0x9
	.long	.LASF9
	.byte	0x1
	.byte	0x7
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x9
	.long	.LASF10
	.byte	0x1
	.byte	0x7
	.long	0x164
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xa
	.string	"i"
	.byte	0x1
	.byte	0x9
	.long	0x4c
	.long	.LLST1
	.uleb128 0xb
	.string	"r"
	.byte	0x1
	.byte	0xa
	.long	0x53
	.byte	0x2
	.byte	0x74
	.sleb128 20
	.uleb128 0xc
	.long	.LVL1
	.long	0x177
	.long	0x11c
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x74
	.sleb128 20
	.byte	0
	.uleb128 0xc
	.long	.LVL2
	.long	0x195
	.long	0x13a
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC0
	.byte	0
	.uleb128 0xc
	.long	.LVL6
	.long	0x195
	.long	0x15a
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x74
	.sleb128 44
	.byte	0x6
	.uleb128 0xd
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC3
	.byte	0
	.uleb128 0xe
	.long	.LVL8
	.long	0x1af
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.long	0x16a
	.uleb128 0xf
	.byte	0x4
	.long	0x170
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF11
	.uleb128 0x10
	.byte	0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x1b
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.long	0x18f
	.uleb128 0x11
	.long	0x18f
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.long	0x53
	.uleb128 0x12
	.byte	0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x41
	.byte	0x1
	.byte	0x1
	.long	0x1af
	.uleb128 0x11
	.long	0x4c
	.uleb128 0x11
	.long	0x16a
	.uleb128 0x13
	.byte	0
	.uleb128 0x14
	.byte	0x1
	.long	.LASF20
	.byte	0x4
	.byte	0x6
	.byte	0x1
	.long	0x4c
	.byte	0x1
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
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
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
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0
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
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0
	.long	0
.LLST1:
	.long	.LVL3-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 44
	.long	.LVL4-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL5-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 44
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
.LASF5:
	.string	"minute"
.LASF9:
	.string	"argc"
.LASF15:
	.string	"uint"
.LASF12:
	.string	"GNU C 4.7.2"
.LASF7:
	.string	"month"
.LASF6:
	.string	"hour"
.LASF20:
	.string	"exit"
.LASF2:
	.string	"unsigned char"
.LASF17:
	.string	"main"
.LASF18:
	.string	"date"
.LASF19:
	.string	"printf"
.LASF14:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF8:
	.string	"year"
.LASF1:
	.string	"short unsigned int"
.LASF13:
	.string	"echo.c"
.LASF4:
	.string	"second"
.LASF10:
	.string	"argv"
.LASF16:
	.string	"rtcdate"
.LASF3:
	.string	"short int"
.LASF11:
	.string	"char"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
