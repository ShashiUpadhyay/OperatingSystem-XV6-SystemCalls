	.file	"date.c"
	.text
.Ltext0:
	.section	.rodata
.LC0:
	.string	"Too many arguments!\n"
	.align 4
.LC1:
	.string	"Year:%d, Month:%d,Day:%d Time %d-%d-%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.file 1 "date.c"
	.loc 1 11 0
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
	pushl	%esi
	pushl	%ebx
	andl	$-16, %esp
	subl	$64, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	.loc 1 14 0
	cmpl	$1, 8(%ebp)
	jle	.L2
	.loc 1 15 0
	movl	$.LC0, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL1:
	jmp	.L3
.L2:
	.loc 1 18 0
	leal	40(%esp), %eax
	movl	%eax, (%esp)
	call	date
.LVL2:
	.loc 1 19 0
	movl	40(%esp), %edi
	movl	44(%esp), %esi
	movl	48(%esp), %ebx
	movl	52(%esp), %ecx
	movl	56(%esp), %edx
	movl	60(%esp), %eax
	movl	%edi, 28(%esp)
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	$.LC1, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL3:
.L3:
	.loc 1 21 0
	call	exit
.LVL4:
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.file 2 "date.h"
	.file 3 "types.h"
	.file 4 "user.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x1c0
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
	.byte	0xa
	.byte	0x1
	.long	0x4c
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.byte	0x1
	.long	0x16a
	.uleb128 0x9
	.long	.LASF9
	.byte	0x1
	.byte	0xa
	.long	0x4c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x9
	.long	.LASF10
	.byte	0x1
	.byte	0xa
	.long	0x16a
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xa
	.string	"r"
	.byte	0x1
	.byte	0xd
	.long	0x53
	.byte	0x2
	.byte	0x74
	.sleb128 40
	.uleb128 0xb
	.long	.LVL1
	.long	0x17d
	.long	0x118
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC0
	.byte	0
	.uleb128 0xb
	.long	.LVL2
	.long	0x197
	.long	0x12d
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x74
	.sleb128 40
	.byte	0
	.uleb128 0xb
	.long	.LVL3
	.long	0x17d
	.long	0x160
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC1
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 20
	.byte	0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 24
	.byte	0x2
	.byte	0x76
	.sleb128 0
	.uleb128 0xc
	.byte	0x2
	.byte	0x74
	.sleb128 28
	.byte	0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0xd
	.long	.LVL4
	.long	0x1b5
	.byte	0
	.uleb128 0xe
	.byte	0x4
	.long	0x170
	.uleb128 0xe
	.byte	0x4
	.long	0x176
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF11
	.uleb128 0xf
	.byte	0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x41
	.byte	0x1
	.byte	0x1
	.long	0x197
	.uleb128 0x10
	.long	0x4c
	.uleb128 0x10
	.long	0x170
	.uleb128 0x11
	.byte	0
	.uleb128 0x12
	.byte	0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x1b
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.long	0x1af
	.uleb128 0x10
	.long	0x1af
	.byte	0
	.uleb128 0xe
	.byte	0x4
	.long	0x53
	.uleb128 0x13
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
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x18
	.byte	0
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
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
.LASF13:
	.string	"date.c"
.LASF6:
	.string	"hour"
.LASF20:
	.string	"exit"
.LASF2:
	.string	"unsigned char"
.LASF17:
	.string	"main"
.LASF19:
	.string	"date"
.LASF14:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF8:
	.string	"year"
.LASF1:
	.string	"short unsigned int"
.LASF18:
	.string	"printf"
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
