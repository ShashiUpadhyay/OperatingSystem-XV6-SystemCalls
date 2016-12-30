	.file	"cs550_user.c"
	.text
.Ltext0:
	.section	.rodata
	.align 4
.LC0:
	.string	"Error as argument exceeds the permissible limit!\n"
.LC1:
	.string	"Displaying Time \n"
	.align 4
.LC2:
	.string	"Year : %d | Month : %d | Day : %d | Hour : %d | Minute : %d | Second : %d \n"
.LC3:
	.string	"Linear Hashing \n"
.LC4:
	.string	"%d\t"
.LC5:
	.string	"%d\n"
	.align 4
.LC6:
	.string	"\n Time taken for 1000000 ls calls %d ticks \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.file 1 "cs550_user.c"
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
	subl	$80, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	.loc 1 13 0
	movl	$0, 72(%esp)
.LVL1:
	.loc 1 14 0
	cmpl	$1, 8(%ebp)
	jle	.L2
	.loc 1 15 0
	movl	$.LC0, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL2:
	jmp	.L3
.L2:
.LBB2:
	.loc 1 20 0
	leal	32(%esp), %eax
	movl	%eax, (%esp)
	call	date
.LVL3:
	.loc 1 21 0
	movl	$.LC1, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL4:
	.loc 1 22 0
	movl	32(%esp), %edi
	movl	36(%esp), %esi
	movl	40(%esp), %ebx
	movl	44(%esp), %ecx
	movl	48(%esp), %edx
	movl	52(%esp), %eax
	movl	%edi, 28(%esp)
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	$.LC2, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL5:
	.loc 1 25 0
	movl	$.LC3, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL6:
	.loc 1 26 0
	call	ls_call01
.LVL7:
	movl	%eax, 72(%esp)
.LVL8:
	.loc 1 27 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL9:
	.loc 1 28 0
	call	ls_call02
.LVL10:
	movl	%eax, 72(%esp)
.LVL11:
	.loc 1 29 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL12:
	.loc 1 30 0
	call	ls_call03
.LVL13:
	movl	%eax, 72(%esp)
.LVL14:
	.loc 1 31 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL15:
	.loc 1 32 0
	call	ls_call04
.LVL16:
	movl	%eax, 72(%esp)
.LVL17:
	.loc 1 33 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL18:
	.loc 1 34 0
	call	ls_call05
.LVL19:
	movl	%eax, 72(%esp)
.LVL20:
	.loc 1 35 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL21:
	.loc 1 36 0
	call	ls_call06
.LVL22:
	movl	%eax, 72(%esp)
.LVL23:
	.loc 1 37 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC5, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL24:
	.loc 1 38 0
	call	ls_call07
.LVL25:
	movl	%eax, 72(%esp)
.LVL26:
	.loc 1 39 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL27:
	.loc 1 40 0
	call	ls_call08
.LVL28:
	movl	%eax, 72(%esp)
.LVL29:
	.loc 1 41 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL30:
	.loc 1 42 0
	call	ls_call09
.LVL31:
	movl	%eax, 72(%esp)
.LVL32:
	.loc 1 43 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL33:
	.loc 1 44 0
	call	ls_call10
.LVL34:
	movl	%eax, 72(%esp)
.LVL35:
	.loc 1 45 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL36:
	.loc 1 46 0
	call	ls_call11
.LVL37:
	movl	%eax, 72(%esp)
.LVL38:
	.loc 1 47 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL39:
	.loc 1 48 0
	call	ls_call12
.LVL40:
	movl	%eax, 72(%esp)
.LVL41:
	.loc 1 49 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC5, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL42:
	.loc 1 50 0
	call	ls_call13
.LVL43:
	movl	%eax, 72(%esp)
.LVL44:
	.loc 1 51 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL45:
	.loc 1 52 0
	call	ls_call14
.LVL46:
	movl	%eax, 72(%esp)
.LVL47:
	.loc 1 53 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL48:
	.loc 1 54 0
	call	ls_call15
.LVL49:
	movl	%eax, 72(%esp)
.LVL50:
	.loc 1 55 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL51:
	.loc 1 56 0
	call	ls_call16
.LVL52:
	movl	%eax, 72(%esp)
.LVL53:
	.loc 1 57 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL54:
	.loc 1 58 0
	call	ls_call17
.LVL55:
	movl	%eax, 72(%esp)
.LVL56:
	.loc 1 59 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL57:
	.loc 1 60 0
	call	ls_call18
.LVL58:
	movl	%eax, 72(%esp)
.LVL59:
	.loc 1 61 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC5, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL60:
	.loc 1 62 0
	call	ls_call19
.LVL61:
	movl	%eax, 72(%esp)
.LVL62:
	.loc 1 63 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL63:
	.loc 1 64 0
	call	ls_call20
.LVL64:
	movl	%eax, 72(%esp)
.LVL65:
	.loc 1 65 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL66:
	.loc 1 66 0
	call	ls_call21
.LVL67:
	movl	%eax, 72(%esp)
.LVL68:
	.loc 1 67 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL69:
	.loc 1 68 0
	call	ls_call22
.LVL70:
	movl	%eax, 72(%esp)
.LVL71:
	.loc 1 69 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL72:
	.loc 1 70 0
	call	ls_call23
.LVL73:
	movl	%eax, 72(%esp)
.LVL74:
	.loc 1 71 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL75:
	.loc 1 72 0
	call	ls_call24
.LVL76:
	movl	%eax, 72(%esp)
.LVL77:
	.loc 1 73 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC5, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL78:
	.loc 1 74 0
	call	ls_call25
.LVL79:
	movl	%eax, 72(%esp)
.LVL80:
	.loc 1 75 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL81:
	.loc 1 76 0
	call	ls_call26
.LVL82:
	movl	%eax, 72(%esp)
.LVL83:
	.loc 1 77 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL84:
	.loc 1 78 0
	call	ls_call27
.LVL85:
	movl	%eax, 72(%esp)
.LVL86:
	.loc 1 79 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL87:
	.loc 1 80 0
	call	ls_call28
.LVL88:
	movl	%eax, 72(%esp)
.LVL89:
	.loc 1 81 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL90:
	.loc 1 82 0
	call	ls_call29
.LVL91:
	movl	%eax, 72(%esp)
.LVL92:
	.loc 1 83 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL93:
	.loc 1 84 0
	call	ls_call30
.LVL94:
	movl	%eax, 72(%esp)
.LVL95:
	.loc 1 85 0
	movl	72(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC4, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL96:
.L3:
.LBE2:
	.loc 1 88 0
	call	uptime
.LVL97:
	movl	%eax, 68(%esp)
.LVL98:
	.loc 1 89 0
	movl	$0, 76(%esp)
.LVL99:
	jmp	.L4
.LVL100:
.L5:
	.loc 1 91 0 discriminator 2
	call	ls_call01
.LVL101:
	.loc 1 89 0 discriminator 2
	addl	$1, 76(%esp)
.LVL102:
.L4:
	.loc 1 89 0 is_stmt 0 discriminator 1
	cmpl	$999999, 76(%esp)
	jle	.L5
	.loc 1 94 0 is_stmt 1
	call	uptime
.LVL103:
	movl	%eax, 64(%esp)
.LVL104:
	.loc 1 95 0
	movl	68(%esp), %eax
.LVL105:
	movl	64(%esp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, 8(%esp)
	movl	$.LC6, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL106:
	.loc 1 97 0
	call	uptime
.LVL107:
	movl	%eax, 60(%esp)
.LVL108:
	.loc 1 98 0
	movl	$0, 76(%esp)
.LVL109:
	jmp	.L6
.LVL110:
.L7:
	.loc 1 100 0 discriminator 2
	call	getpid
.LVL111:
	.loc 1 98 0 discriminator 2
	addl	$1, 76(%esp)
.LVL112:
.L6:
	.loc 1 98 0 is_stmt 0 discriminator 1
	cmpl	$999999, 76(%esp)
	jle	.L7
	.loc 1 102 0 is_stmt 1
	call	uptime
.LVL113:
	movl	%eax, 56(%esp)
.LVL114:
	.loc 1 103 0
	movl	60(%esp), %eax
.LVL115:
	movl	56(%esp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, 8(%esp)
	movl	$.LC6, 4(%esp)
	movl	$1, (%esp)
	call	printf
.LVL116:
	.loc 1 104 0
	call	exit
.LVL117:
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.file 2 "date.h"
	.file 3 "user.h"
	.file 4 "types.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xa46
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF46
	.byte	0x1
	.long	.LASF47
	.long	.LASF48
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF49
	.byte	0x4
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
	.long	.LASF50
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
	.long	.LASF51
	.byte	0x1
	.byte	0xa
	.byte	0x1
	.long	0x4c
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.byte	0x1
	.long	0x830
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
	.long	0x830
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xa
	.string	"i"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.long	.LLST1
	.uleb128 0xa
	.string	"t1"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.long	.LLST2
	.uleb128 0xa
	.string	"t2"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.long	.LLST3
	.uleb128 0xa
	.string	"t3"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.long	.LLST4
	.uleb128 0xa
	.string	"t4"
	.byte	0x1
	.byte	0xc
	.long	0x4c
	.long	.LLST5
	.uleb128 0xb
	.long	.LASF11
	.byte	0x1
	.byte	0xd
	.long	0x4c
	.long	.LLST6
	.uleb128 0xc
	.long	.LBB2
	.long	.LBE2
	.long	0x77c
	.uleb128 0xd
	.string	"r"
	.byte	0x1
	.byte	0x13
	.long	0x53
	.byte	0x2
	.byte	0x74
	.sleb128 32
	.uleb128 0xe
	.long	.LVL3
	.long	0x843
	.long	0x170
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x74
	.sleb128 32
	.byte	0
	.uleb128 0xe
	.long	.LVL4
	.long	0x861
	.long	0x18e
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC1
	.byte	0
	.uleb128 0xe
	.long	.LVL5
	.long	0x861
	.long	0x1c1
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC2
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 20
	.byte	0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 24
	.byte	0x2
	.byte	0x76
	.sleb128 0
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 28
	.byte	0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0xe
	.long	.LVL6
	.long	0x861
	.long	0x1df
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC3
	.byte	0
	.uleb128 0x10
	.long	.LVL7
	.long	0x87b
	.uleb128 0xe
	.long	.LVL9
	.long	0x861
	.long	0x20f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL10
	.long	0x889
	.uleb128 0xe
	.long	.LVL12
	.long	0x861
	.long	0x23f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL13
	.long	0x897
	.uleb128 0xe
	.long	.LVL15
	.long	0x861
	.long	0x26f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL16
	.long	0x8a5
	.uleb128 0xe
	.long	.LVL18
	.long	0x861
	.long	0x29f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL19
	.long	0x8b3
	.uleb128 0xe
	.long	.LVL21
	.long	0x861
	.long	0x2cf
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL22
	.long	0x8c1
	.uleb128 0xe
	.long	.LVL24
	.long	0x861
	.long	0x2ff
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC5
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL25
	.long	0x8cf
	.uleb128 0xe
	.long	.LVL27
	.long	0x861
	.long	0x32f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL28
	.long	0x8dd
	.uleb128 0xe
	.long	.LVL30
	.long	0x861
	.long	0x35f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL31
	.long	0x8eb
	.uleb128 0xe
	.long	.LVL33
	.long	0x861
	.long	0x38f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL34
	.long	0x8f9
	.uleb128 0xe
	.long	.LVL36
	.long	0x861
	.long	0x3bf
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL37
	.long	0x907
	.uleb128 0xe
	.long	.LVL39
	.long	0x861
	.long	0x3ef
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL40
	.long	0x915
	.uleb128 0xe
	.long	.LVL42
	.long	0x861
	.long	0x41f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC5
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL43
	.long	0x923
	.uleb128 0xe
	.long	.LVL45
	.long	0x861
	.long	0x44f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL46
	.long	0x931
	.uleb128 0xe
	.long	.LVL48
	.long	0x861
	.long	0x47f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL49
	.long	0x93f
	.uleb128 0xe
	.long	.LVL51
	.long	0x861
	.long	0x4af
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL52
	.long	0x94d
	.uleb128 0xe
	.long	.LVL54
	.long	0x861
	.long	0x4df
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL55
	.long	0x95b
	.uleb128 0xe
	.long	.LVL57
	.long	0x861
	.long	0x50f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL58
	.long	0x969
	.uleb128 0xe
	.long	.LVL60
	.long	0x861
	.long	0x53f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC5
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL61
	.long	0x977
	.uleb128 0xe
	.long	.LVL63
	.long	0x861
	.long	0x56f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL64
	.long	0x985
	.uleb128 0xe
	.long	.LVL66
	.long	0x861
	.long	0x59f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL67
	.long	0x993
	.uleb128 0xe
	.long	.LVL69
	.long	0x861
	.long	0x5cf
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL70
	.long	0x9a1
	.uleb128 0xe
	.long	.LVL72
	.long	0x861
	.long	0x5ff
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL73
	.long	0x9af
	.uleb128 0xe
	.long	.LVL75
	.long	0x861
	.long	0x62f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL76
	.long	0x9bd
	.uleb128 0xe
	.long	.LVL78
	.long	0x861
	.long	0x65f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC5
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL79
	.long	0x9cb
	.uleb128 0xe
	.long	.LVL81
	.long	0x861
	.long	0x68f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL82
	.long	0x9d9
	.uleb128 0xe
	.long	.LVL84
	.long	0x861
	.long	0x6bf
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL85
	.long	0x9e7
	.uleb128 0xe
	.long	.LVL87
	.long	0x861
	.long	0x6ef
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL88
	.long	0x9f5
	.uleb128 0xe
	.long	.LVL90
	.long	0x861
	.long	0x71f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL91
	.long	0xa03
	.uleb128 0xe
	.long	.LVL93
	.long	0x861
	.long	0x74f
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL94
	.long	0xa11
	.uleb128 0x11
	.long	.LVL96
	.long	0x861
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x4
	.byte	0x74
	.sleb128 72
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0xe
	.long	.LVL2
	.long	0x861
	.long	0x79a
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC0
	.byte	0
	.uleb128 0x10
	.long	.LVL97
	.long	0xa1f
	.uleb128 0x10
	.long	.LVL101
	.long	0x87b
	.uleb128 0x10
	.long	.LVL103
	.long	0xa1f
	.uleb128 0xe
	.long	.LVL106
	.long	0x861
	.long	0x7e1
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC6
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x9
	.byte	0x74
	.sleb128 64
	.byte	0x6
	.byte	0x74
	.sleb128 68
	.byte	0x6
	.byte	0x1c
	.byte	0
	.uleb128 0x10
	.long	.LVL107
	.long	0xa1f
	.uleb128 0x10
	.long	.LVL111
	.long	0xa2d
	.uleb128 0x10
	.long	.LVL113
	.long	0xa1f
	.uleb128 0xe
	.long	.LVL116
	.long	0x861
	.long	0x826
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC6
	.uleb128 0xf
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x7
	.byte	0x74
	.sleb128 56
	.byte	0x6
	.byte	0x74
	.sleb128 60
	.byte	0x6
	.byte	0x1c
	.byte	0
	.uleb128 0x10
	.long	.LVL117
	.long	0xa3b
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.long	0x836
	.uleb128 0x12
	.byte	0x4
	.long	0x83c
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0x13
	.byte	0x1
	.long	.LASF52
	.byte	0x3
	.byte	0x1b
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.long	0x85b
	.uleb128 0x14
	.long	0x85b
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.long	0x53
	.uleb128 0x15
	.byte	0x1
	.long	.LASF53
	.byte	0x3
	.byte	0x41
	.byte	0x1
	.byte	0x1
	.long	0x87b
	.uleb128 0x14
	.long	0x4c
	.uleb128 0x14
	.long	0x836
	.uleb128 0x16
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF13
	.byte	0x3
	.byte	0x1c
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF14
	.byte	0x3
	.byte	0x1d
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF15
	.byte	0x3
	.byte	0x1e
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF16
	.byte	0x3
	.byte	0x1f
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF17
	.byte	0x3
	.byte	0x20
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF18
	.byte	0x3
	.byte	0x21
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF19
	.byte	0x3
	.byte	0x22
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF20
	.byte	0x3
	.byte	0x23
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF21
	.byte	0x3
	.byte	0x24
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF22
	.byte	0x3
	.byte	0x25
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF23
	.byte	0x3
	.byte	0x26
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF24
	.byte	0x3
	.byte	0x27
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF25
	.byte	0x3
	.byte	0x28
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF26
	.byte	0x3
	.byte	0x29
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF27
	.byte	0x3
	.byte	0x2a
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF28
	.byte	0x3
	.byte	0x2b
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF29
	.byte	0x3
	.byte	0x2c
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF30
	.byte	0x3
	.byte	0x2d
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF31
	.byte	0x3
	.byte	0x2e
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF32
	.byte	0x3
	.byte	0x2f
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF33
	.byte	0x3
	.byte	0x30
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF34
	.byte	0x3
	.byte	0x31
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF35
	.byte	0x3
	.byte	0x32
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF36
	.byte	0x3
	.byte	0x33
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF37
	.byte	0x3
	.byte	0x34
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF38
	.byte	0x3
	.byte	0x35
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF39
	.byte	0x3
	.byte	0x36
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF40
	.byte	0x3
	.byte	0x37
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF41
	.byte	0x3
	.byte	0x38
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF42
	.byte	0x3
	.byte	0x39
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF43
	.byte	0x3
	.byte	0x19
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF44
	.byte	0x3
	.byte	0x16
	.byte	0x1
	.long	0x4c
	.byte	0x1
	.uleb128 0x17
	.byte	0x1
	.long	.LASF45
	.byte	0x3
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
	.uleb128 0xc
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
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
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x16
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x17
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
	.long	.LVL99-.Ltext0
	.long	.LVL100-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL100-.Ltext0
	.long	.LVL109-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 76
	.long	.LVL109-.Ltext0
	.long	.LVL110-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL110-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 76
	.long	0
	.long	0
.LLST2:
	.long	.LVL98-.Ltext0
	.long	.LVL100-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL100-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 68
	.long	0
	.long	0
.LLST3:
	.long	.LVL104-.Ltext0
	.long	.LVL105-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL105-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 64
	.long	0
	.long	0
.LLST4:
	.long	.LVL108-.Ltext0
	.long	.LVL110-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL110-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 60
	.long	0
	.long	0
.LLST5:
	.long	.LVL114-.Ltext0
	.long	.LVL115-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL115-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 56
	.long	0
	.long	0
.LLST6:
	.long	.LVL1-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL8-.Ltext0
	.long	.LVL9-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL9-1-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL11-.Ltext0
	.long	.LVL12-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL12-1-.Ltext0
	.long	.LVL14-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL14-.Ltext0
	.long	.LVL15-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL15-1-.Ltext0
	.long	.LVL17-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL17-.Ltext0
	.long	.LVL18-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL18-1-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL20-.Ltext0
	.long	.LVL21-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL21-1-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL23-.Ltext0
	.long	.LVL24-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL24-1-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL26-.Ltext0
	.long	.LVL27-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL27-1-.Ltext0
	.long	.LVL29-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL29-.Ltext0
	.long	.LVL30-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL30-1-.Ltext0
	.long	.LVL32-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL32-.Ltext0
	.long	.LVL33-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL33-1-.Ltext0
	.long	.LVL35-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL35-.Ltext0
	.long	.LVL36-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL36-1-.Ltext0
	.long	.LVL38-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL38-.Ltext0
	.long	.LVL39-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL39-1-.Ltext0
	.long	.LVL41-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL41-.Ltext0
	.long	.LVL42-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL42-1-.Ltext0
	.long	.LVL44-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL44-.Ltext0
	.long	.LVL45-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL45-1-.Ltext0
	.long	.LVL47-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL47-.Ltext0
	.long	.LVL48-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL48-1-.Ltext0
	.long	.LVL50-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL50-.Ltext0
	.long	.LVL51-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL51-1-.Ltext0
	.long	.LVL53-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL53-.Ltext0
	.long	.LVL54-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL54-1-.Ltext0
	.long	.LVL56-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL56-.Ltext0
	.long	.LVL57-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL57-1-.Ltext0
	.long	.LVL59-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL59-.Ltext0
	.long	.LVL60-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL60-1-.Ltext0
	.long	.LVL62-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL62-.Ltext0
	.long	.LVL63-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL63-1-.Ltext0
	.long	.LVL65-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL65-.Ltext0
	.long	.LVL66-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL66-1-.Ltext0
	.long	.LVL68-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL68-.Ltext0
	.long	.LVL69-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL69-1-.Ltext0
	.long	.LVL71-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL71-.Ltext0
	.long	.LVL72-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL72-1-.Ltext0
	.long	.LVL74-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL74-.Ltext0
	.long	.LVL75-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL75-1-.Ltext0
	.long	.LVL77-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL77-.Ltext0
	.long	.LVL78-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL78-1-.Ltext0
	.long	.LVL80-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL80-.Ltext0
	.long	.LVL81-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL81-1-.Ltext0
	.long	.LVL83-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL83-.Ltext0
	.long	.LVL84-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL84-1-.Ltext0
	.long	.LVL86-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL86-.Ltext0
	.long	.LVL87-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL87-1-.Ltext0
	.long	.LVL89-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL89-.Ltext0
	.long	.LVL90-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL90-1-.Ltext0
	.long	.LVL92-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL92-.Ltext0
	.long	.LVL93-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL93-1-.Ltext0
	.long	.LVL95-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
	.long	.LVL95-.Ltext0
	.long	.LVL96-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL96-1-.Ltext0
	.long	.LVL96-.Ltext0
	.value	0x3
	.byte	0x74
	.sleb128 72
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
.LASF44:
	.string	"getpid"
.LASF45:
	.string	"exit"
.LASF8:
	.string	"year"
.LASF5:
	.string	"minute"
.LASF47:
	.string	"cs550_user.c"
.LASF7:
	.string	"month"
.LASF52:
	.string	"date"
.LASF34:
	.string	"ls_call22"
.LASF33:
	.string	"ls_call21"
.LASF32:
	.string	"ls_call20"
.LASF2:
	.string	"unsigned char"
.LASF19:
	.string	"ls_call07"
.LASF13:
	.string	"ls_call01"
.LASF14:
	.string	"ls_call02"
.LASF15:
	.string	"ls_call03"
.LASF16:
	.string	"ls_call04"
.LASF17:
	.string	"ls_call05"
.LASF18:
	.string	"ls_call06"
.LASF1:
	.string	"short unsigned int"
.LASF20:
	.string	"ls_call08"
.LASF21:
	.string	"ls_call09"
.LASF35:
	.string	"ls_call23"
.LASF36:
	.string	"ls_call24"
.LASF37:
	.string	"ls_call25"
.LASF38:
	.string	"ls_call26"
.LASF4:
	.string	"second"
.LASF40:
	.string	"ls_call28"
.LASF41:
	.string	"ls_call29"
.LASF48:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF39:
	.string	"ls_call27"
.LASF51:
	.string	"main"
.LASF49:
	.string	"uint"
.LASF0:
	.string	"unsigned int"
.LASF12:
	.string	"char"
.LASF6:
	.string	"hour"
.LASF9:
	.string	"argc"
.LASF43:
	.string	"uptime"
.LASF46:
	.string	"GNU C 4.7.2"
.LASF53:
	.string	"printf"
.LASF11:
	.string	"count"
.LASF3:
	.string	"short int"
.LASF10:
	.string	"argv"
.LASF22:
	.string	"ls_call10"
.LASF23:
	.string	"ls_call11"
.LASF24:
	.string	"ls_call12"
.LASF25:
	.string	"ls_call13"
.LASF26:
	.string	"ls_call14"
.LASF27:
	.string	"ls_call15"
.LASF28:
	.string	"ls_call16"
.LASF29:
	.string	"ls_call17"
.LASF30:
	.string	"ls_call18"
.LASF31:
	.string	"ls_call19"
.LASF50:
	.string	"rtcdate"
.LASF42:
	.string	"ls_call30"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
