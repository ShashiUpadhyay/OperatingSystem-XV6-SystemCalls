	.file	"log.c"
	.text
.Ltext0:
	.comm	log,196,32
	.section	.rodata
.LC0:
	.string	"log"
	.text
	.globl	initlog
	.type	initlog, @function
initlog:
.LFB0:
	.file 1 "log.c"
	.loc 1 54 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	subl	$56, %esp
	.loc 1 59 0
	movl	$.LC0, 4(%esp)
	movl	$log, (%esp)
	call	initlock
.LVL1:
	.loc 1 60 0
	leal	-36(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	readsb
.LVL2:
	.loc 1 61 0
	movl	-20(%ebp), %eax
	movl	%eax, log+52
	.loc 1 62 0
	movl	-24(%ebp), %eax
	movl	%eax, log+56
	.loc 1 63 0
	movl	8(%ebp), %eax
	movl	%eax, log+68
	.loc 1 64 0
	call	recover_from_log
.LVL3:
	.loc 1 65 0
	leave
.LCFI2:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	initlog, .-initlog
	.type	install_trans, @function
install_trans:
.LFB1:
	.loc 1 70 0
	.cfi_startproc
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 73 0
	movl	$0, -12(%ebp)
.LVL4:
	jmp	.L3
.L4:
.LBB2:
	.loc 1 74 0 discriminator 2
	movl	log+52, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %edx
	movl	log+68, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bread
.LVL5:
	movl	%eax, -16(%ebp)
.LVL6:
	.loc 1 75 0 discriminator 2
	movl	-12(%ebp), %eax
.LVL7:
	addl	$16, %eax
	movl	log+12(,%eax,4), %eax
	movl	%eax, %edx
	movl	log+68, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bread
.LVL8:
	movl	%eax, -20(%ebp)
.LVL9:
	.loc 1 76 0 discriminator 2
	movl	-16(%ebp), %eax
.LVL10:
	leal	24(%eax), %edx
	movl	-20(%ebp), %eax
	addl	$24, %eax
	movl	$512, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	memmove
.LVL11:
	.loc 1 77 0 discriminator 2
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	bwrite
.LVL12:
	.loc 1 78 0 discriminator 2
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	brelse
.LVL13:
	.loc 1 79 0 discriminator 2
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	brelse
.LVL14:
.LBE2:
	.loc 1 73 0 discriminator 2
	addl	$1, -12(%ebp)
.LVL15:
.L3:
	.loc 1 73 0 is_stmt 0 discriminator 1
	movl	log+72, %eax
	cmpl	-12(%ebp), %eax
	jg	.L4
	.loc 1 81 0 is_stmt 1
	leave
.LCFI5:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	install_trans, .-install_trans
	.type	read_head, @function
read_head:
.LFB2:
	.loc 1 86 0
	.cfi_startproc
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 87 0
	movl	log+52, %eax
	movl	%eax, %edx
	movl	log+68, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bread
.LVL16:
	movl	%eax, -16(%ebp)
.LVL17:
	.loc 1 88 0
	movl	-16(%ebp), %eax
	addl	$24, %eax
.LVL18:
	movl	%eax, -20(%ebp)
.LVL19:
	.loc 1 90 0
	movl	-20(%ebp), %eax
	movl	(%eax), %eax
.LVL20:
	movl	%eax, log+72
	.loc 1 91 0
	movl	$0, -12(%ebp)
.LVL21:
	jmp	.L6
.L7:
	.loc 1 92 0 discriminator 2
	movl	-20(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	4(%eax,%edx,4), %eax
	movl	-12(%ebp), %edx
	addl	$16, %edx
	movl	%eax, log+12(,%edx,4)
	.loc 1 91 0 discriminator 2
	addl	$1, -12(%ebp)
.L6:
	.loc 1 91 0 is_stmt 0 discriminator 1
	movl	log+72, %eax
	cmpl	-12(%ebp), %eax
	jg	.L7
	.loc 1 94 0 is_stmt 1
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	brelse
.LVL22:
	.loc 1 95 0
	leave
.LCFI8:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	read_head, .-read_head
	.type	write_head, @function
write_head:
.LFB3:
	.loc 1 102 0
	.cfi_startproc
	pushl	%ebp
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI10:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 103 0
	movl	log+52, %eax
	movl	%eax, %edx
	movl	log+68, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bread
.LVL23:
	movl	%eax, -16(%ebp)
.LVL24:
	.loc 1 104 0
	movl	-16(%ebp), %eax
	addl	$24, %eax
.LVL25:
	movl	%eax, -20(%ebp)
.LVL26:
	.loc 1 106 0
	movl	log+72, %edx
	movl	-20(%ebp), %eax
	movl	%edx, (%eax)
	.loc 1 107 0
	movl	$0, -12(%ebp)
.LVL27:
	jmp	.L9
.LVL28:
.L10:
	.loc 1 108 0 discriminator 2
	movl	-12(%ebp), %eax
	addl	$16, %eax
	movl	log+12(,%eax,4), %ecx
	movl	-20(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%ecx, 4(%eax,%edx,4)
	.loc 1 107 0 discriminator 2
	addl	$1, -12(%ebp)
.L9:
	.loc 1 107 0 is_stmt 0 discriminator 1
	movl	log+72, %eax
	cmpl	-12(%ebp), %eax
	jg	.L10
	.loc 1 110 0 is_stmt 1
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	bwrite
.LVL29:
	.loc 1 111 0
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	brelse
.LVL30:
	.loc 1 112 0
	leave
.LCFI11:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	write_head, .-write_head
	.type	recover_from_log, @function
recover_from_log:
.LFB4:
	.loc 1 116 0
	.cfi_startproc
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI13:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 117 0
	call	read_head
.LVL31:
	.loc 1 118 0
	call	install_trans
.LVL32:
	.loc 1 119 0
	movl	$0, log+72
	.loc 1 120 0
	call	write_head
.LVL33:
	.loc 1 121 0
	leave
.LCFI14:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	recover_from_log, .-recover_from_log
	.globl	begin_op
	.type	begin_op, @function
begin_op:
.LFB5:
	.loc 1 126 0
	.cfi_startproc
	pushl	%ebp
.LCFI15:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI16:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 1 127 0
	movl	$log, (%esp)
	call	acquire
.LVL34:
.L17:
	.loc 1 129 0
	movl	log+64, %eax
	testl	%eax, %eax
	je	.L13
	.loc 1 130 0
	movl	$log, 4(%esp)
	movl	$log, (%esp)
	call	sleep
.LVL35:
	.loc 1 139 0
	jmp	.L17
.L13:
	.loc 1 131 0
	movl	log+72, %ecx
	movl	log+60, %eax
	leal	1(%eax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	cmpl	$30, %eax
	jle	.L15
	.loc 1 133 0
	movl	$log, 4(%esp)
	movl	$log, (%esp)
	call	sleep
.LVL36:
	.loc 1 139 0
	jmp	.L17
.L15:
	.loc 1 135 0
	movl	log+60, %eax
	addl	$1, %eax
	movl	%eax, log+60
	.loc 1 136 0
	movl	$log, (%esp)
	call	release
.LVL37:
	.loc 1 137 0
	nop
	.loc 1 140 0
	leave
.LCFI17:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	begin_op, .-begin_op
	.section	.rodata
.LC1:
	.string	"log.committing"
	.text
	.globl	end_op
	.type	end_op, @function
end_op:
.LFB6:
	.loc 1 146 0
	.cfi_startproc
	pushl	%ebp
.LCFI18:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI19:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 147 0
	movl	$0, -12(%ebp)
.LVL38:
	.loc 1 149 0
	movl	$log, (%esp)
	call	acquire
.LVL39:
	.loc 1 150 0
	movl	log+60, %eax
	subl	$1, %eax
	movl	%eax, log+60
	.loc 1 151 0
	movl	log+64, %eax
	testl	%eax, %eax
	je	.L19
	.loc 1 152 0
	movl	$.LC1, (%esp)
	call	panic
.LVL40:
.L19:
	.loc 1 153 0
	movl	log+60, %eax
	testl	%eax, %eax
	jne	.L20
	.loc 1 154 0
	movl	$1, -12(%ebp)
	.loc 1 155 0
	movl	$1, log+64
	jmp	.L21
.L20:
	.loc 1 158 0
	movl	$log, (%esp)
	call	wakeup
.LVL41:
.L21:
	.loc 1 160 0
	movl	$log, (%esp)
	call	release
.LVL42:
	.loc 1 162 0
	cmpl	$0, -12(%ebp)
	je	.L18
	.loc 1 165 0
	call	commit
.LVL43:
	.loc 1 166 0
	movl	$log, (%esp)
	call	acquire
.LVL44:
	.loc 1 167 0
	movl	$0, log+64
	.loc 1 168 0
	movl	$log, (%esp)
	call	wakeup
.LVL45:
	.loc 1 169 0
	movl	$log, (%esp)
	call	release
.LVL46:
.L18:
	.loc 1 171 0
	leave
.LCFI20:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	end_op, .-end_op
	.type	write_log, @function
write_log:
.LFB7:
	.loc 1 176 0
	.cfi_startproc
	pushl	%ebp
.LCFI21:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI22:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 179 0
	movl	$0, -12(%ebp)
.LVL47:
	jmp	.L24
.L25:
.LBB3:
	.loc 1 180 0 discriminator 2
	movl	log+52, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %edx
	movl	log+68, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bread
.LVL48:
	movl	%eax, -16(%ebp)
.LVL49:
	.loc 1 181 0 discriminator 2
	movl	-12(%ebp), %eax
.LVL50:
	addl	$16, %eax
	movl	log+12(,%eax,4), %eax
	movl	%eax, %edx
	movl	log+68, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bread
.LVL51:
	movl	%eax, -20(%ebp)
.LVL52:
	.loc 1 182 0 discriminator 2
	movl	-20(%ebp), %eax
	leal	24(%eax), %edx
	movl	-16(%ebp), %eax
.LVL53:
	addl	$24, %eax
	movl	$512, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	memmove
.LVL54:
	.loc 1 183 0 discriminator 2
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	bwrite
.LVL55:
	.loc 1 184 0 discriminator 2
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	brelse
.LVL56:
	.loc 1 185 0 discriminator 2
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	brelse
.LVL57:
.LBE3:
	.loc 1 179 0 discriminator 2
	addl	$1, -12(%ebp)
.LVL58:
.L24:
	.loc 1 179 0 is_stmt 0 discriminator 1
	movl	log+72, %eax
	cmpl	-12(%ebp), %eax
	jg	.L25
	.loc 1 187 0 is_stmt 1
	leave
.LCFI23:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	write_log, .-write_log
	.type	commit, @function
commit:
.LFB8:
	.loc 1 191 0
	.cfi_startproc
	pushl	%ebp
.LCFI24:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI25:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 192 0
	movl	log+72, %eax
	testl	%eax, %eax
	jle	.L26
	.loc 1 193 0
	call	write_log
.LVL59:
	.loc 1 194 0
	call	write_head
.LVL60:
	.loc 1 195 0
	call	install_trans
.LVL61:
	.loc 1 196 0
	movl	$0, log+72
	.loc 1 197 0
	call	write_head
.LVL62:
.L26:
	.loc 1 199 0
	leave
.LCFI26:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	commit, .-commit
	.section	.rodata
.LC2:
	.string	"too big a transaction"
.LC3:
	.string	"log_write outside of trans"
	.text
	.globl	log_write
	.type	log_write, @function
log_write:
.LFB9:
	.loc 1 212 0
	.cfi_startproc
.LVL63:
	pushl	%ebp
.LCFI27:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI28:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 215 0
	movl	log+72, %eax
	cmpl	$29, %eax
	jg	.L29
	.loc 1 215 0 is_stmt 0 discriminator 1
	movl	log+72, %eax
	movl	log+56, %edx
	subl	$1, %edx
	cmpl	%edx, %eax
	jl	.L30
.L29:
	.loc 1 216 0 is_stmt 1
	movl	$.LC2, (%esp)
	call	panic
.LVL64:
.L30:
	.loc 1 217 0
	movl	log+60, %eax
	testl	%eax, %eax
	jg	.L31
	.loc 1 218 0
	movl	$.LC3, (%esp)
	call	panic
.LVL65:
.L31:
	.loc 1 220 0
	movl	$log, (%esp)
	call	acquire
.LVL66:
	.loc 1 221 0
	movl	$0, -12(%ebp)
.LVL67:
	jmp	.L32
.L35:
	.loc 1 222 0
	movl	-12(%ebp), %eax
	addl	$16, %eax
	movl	log+12(,%eax,4), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	cmpl	%eax, %edx
	je	.L37
.L33:
	.loc 1 221 0
	addl	$1, -12(%ebp)
.L32:
	.loc 1 221 0 is_stmt 0 discriminator 1
	movl	log+72, %eax
	cmpl	-12(%ebp), %eax
	jg	.L35
	jmp	.L34
.L37:
	.loc 1 223 0 is_stmt 1
	nop
.L34:
	.loc 1 225 0
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	-12(%ebp), %edx
	addl	$16, %edx
	movl	%eax, log+12(,%edx,4)
	.loc 1 226 0
	movl	log+72, %eax
	cmpl	-12(%ebp), %eax
	jne	.L36
	.loc 1 227 0
	movl	log+72, %eax
	addl	$1, %eax
	movl	%eax, log+72
.L36:
	.loc 1 228 0
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	orl	$4, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	.loc 1 229 0
	movl	$log, (%esp)
	call	release
.LVL68:
	.loc 1 230 0
	leave
.LCFI29:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	log_write, .-log_write
.Letext0:
	.file 2 "types.h"
	.file 3 "spinlock.h"
	.file 4 "fs.h"
	.file 5 "buf.h"
	.file 6 "defs.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x8db
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF55
	.byte	0x1
	.long	.LASF56
	.long	.LASF57
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF2
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
	.uleb128 0x2
	.long	.LASF3
	.byte	0x2
	.byte	0x3
	.long	0x49
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x4
	.long	.LASF9
	.byte	0x34
	.byte	0x3
	.byte	0x2
	.long	0x95
	.uleb128 0x5
	.long	.LASF5
	.byte	0x3
	.byte	0x3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF6
	.byte	0x3
	.byte	0x6
	.long	0x95
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"cpu"
	.byte	0x3
	.byte	0x7
	.long	0xa8
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.string	"pcs"
	.byte	0x3
	.byte	0x8
	.long	0xae
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x9b
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF7
	.uleb128 0x8
	.string	"cpu"
	.byte	0x1
	.uleb128 0x7
	.byte	0x4
	.long	0xa2
	.uleb128 0x9
	.long	0x25
	.long	0xbe
	.uleb128 0xa
	.long	0xbe
	.byte	0x9
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF8
	.uleb128 0x4
	.long	.LASF10
	.byte	0x1c
	.byte	0x4
	.byte	0xd
	.long	0x134
	.uleb128 0x5
	.long	.LASF11
	.byte	0x4
	.byte	0xe
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF12
	.byte	0x4
	.byte	0xf
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF13
	.byte	0x4
	.byte	0x10
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF14
	.byte	0x4
	.byte	0x11
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.long	.LASF15
	.byte	0x4
	.byte	0x12
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x5
	.long	.LASF16
	.byte	0x4
	.byte	0x13
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x5
	.long	.LASF17
	.byte	0x4
	.byte	0x14
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.byte	0
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF18
	.uleb128 0xb
	.string	"buf"
	.value	0x218
	.byte	0x5
	.byte	0x1
	.long	0x1ab
	.uleb128 0x5
	.long	.LASF19
	.byte	0x5
	.byte	0x2
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.string	"dev"
	.byte	0x5
	.byte	0x3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF20
	.byte	0x5
	.byte	0x4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF21
	.byte	0x5
	.byte	0x5
	.long	0x1b2
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.long	.LASF22
	.byte	0x5
	.byte	0x6
	.long	0x1b2
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x5
	.long	.LASF23
	.byte	0x5
	.byte	0x7
	.long	0x1b2
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x5
	.long	.LASF24
	.byte	0x5
	.byte	0x8
	.long	0x1b8
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.byte	0
	.uleb128 0xc
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x7
	.byte	0x4
	.long	0x13b
	.uleb128 0x9
	.long	0x3e
	.long	0x1c9
	.uleb128 0xd
	.long	0xbe
	.value	0x1ff
	.byte	0
	.uleb128 0x4
	.long	.LASF25
	.byte	0x7c
	.byte	0x1
	.byte	0x21
	.long	0x1f0
	.uleb128 0x6
	.string	"n"
	.byte	0x1
	.byte	0x22
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF26
	.byte	0x1
	.byte	0x23
	.long	0x1f0
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0
	.uleb128 0x9
	.long	0x1ab
	.long	0x200
	.uleb128 0xa
	.long	0xbe
	.byte	0x1d
	.byte	0
	.uleb128 0xe
	.string	"log"
	.byte	0xc4
	.byte	0x1
	.byte	0x26
	.long	0x26e
	.uleb128 0x5
	.long	.LASF27
	.byte	0x1
	.byte	0x27
	.long	0x50
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF28
	.byte	0x1
	.byte	0x28
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0x5
	.long	.LASF11
	.byte	0x1
	.byte	0x29
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x5
	.long	.LASF29
	.byte	0x1
	.byte	0x2a
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x3c
	.uleb128 0x5
	.long	.LASF30
	.byte	0x1
	.byte	0x2b
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0x6
	.string	"dev"
	.byte	0x1
	.byte	0x2c
	.long	0x1ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x44
	.uleb128 0x6
	.string	"lh"
	.byte	0x1
	.byte	0x2d
	.long	0x1c9
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF38
	.byte	0x1
	.byte	0x35
	.byte	0x1
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.byte	0x1
	.long	0x2ec
	.uleb128 0x10
	.string	"dev"
	.byte	0x1
	.byte	0x35
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.string	"sb"
	.byte	0x1
	.byte	0x3a
	.long	0xc5
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x12
	.long	.LVL1
	.long	0x7cb
	.long	0x2c5
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC0
	.byte	0
	.uleb128 0x12
	.long	.LVL2
	.long	0x7ea
	.long	0x2e2
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
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.uleb128 0x14
	.long	.LVL3
	.long	0x48e
	.byte	0
	.uleb128 0x15
	.long	.LASF34
	.byte	0x1
	.byte	0x45
	.byte	0x1
	.long	.LFB1
	.long	.LFE1
	.long	.LLST1
	.byte	0x1
	.long	0x3b6
	.uleb128 0x16
	.long	.LASF31
	.byte	0x1
	.byte	0x47
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x17
	.long	.LBB2
	.long	.LBE2
	.uleb128 0x18
	.long	.LASF32
	.byte	0x1
	.byte	0x4a
	.long	0x1b2
	.long	.LLST2
	.uleb128 0x18
	.long	.LASF33
	.byte	0x1
	.byte	0x4b
	.long	0x1b2
	.long	.LLST3
	.uleb128 0x14
	.long	.LVL5
	.long	0x809
	.uleb128 0x14
	.long	.LVL8
	.long	0x809
	.uleb128 0x12
	.long	.LVL11
	.long	0x826
	.long	0x376
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x91
	.sleb128 -28
	.byte	0x6
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0xa
	.value	0x200
	.byte	0
	.uleb128 0x12
	.long	.LVL12
	.long	0x851
	.long	0x38c
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -28
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.long	.LVL13
	.long	0x865
	.long	0x3a2
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.uleb128 0x19
	.long	.LVL14
	.long	0x865
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -28
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.long	.LASF35
	.byte	0x1
	.byte	0x55
	.byte	0x1
	.long	.LFB2
	.long	.LFE2
	.long	.LLST4
	.byte	0x1
	.long	0x414
	.uleb128 0x1a
	.string	"buf"
	.byte	0x1
	.byte	0x57
	.long	0x1b2
	.long	.LLST5
	.uleb128 0x1a
	.string	"lh"
	.byte	0x1
	.byte	0x58
	.long	0x414
	.long	.LLST6
	.uleb128 0x11
	.string	"i"
	.byte	0x1
	.byte	0x59
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x14
	.long	.LVL16
	.long	0x809
	.uleb128 0x19
	.long	.LVL22
	.long	0x865
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x1c9
	.uleb128 0x15
	.long	.LASF36
	.byte	0x1
	.byte	0x65
	.byte	0x1
	.long	.LFB3
	.long	.LFE3
	.long	.LLST7
	.byte	0x1
	.long	0x48e
	.uleb128 0x1a
	.string	"buf"
	.byte	0x1
	.byte	0x67
	.long	0x1b2
	.long	.LLST8
	.uleb128 0x1a
	.string	"hb"
	.byte	0x1
	.byte	0x68
	.long	0x414
	.long	.LLST9
	.uleb128 0x11
	.string	"i"
	.byte	0x1
	.byte	0x69
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x14
	.long	.LVL23
	.long	0x809
	.uleb128 0x12
	.long	.LVL29
	.long	0x851
	.long	0x47b
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.uleb128 0x19
	.long	.LVL30
	.long	0x865
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x15
	.long	.LASF37
	.byte	0x1
	.byte	0x73
	.byte	0x1
	.long	.LFB4
	.long	.LFE4
	.long	.LLST10
	.byte	0x1
	.long	0x4c3
	.uleb128 0x14
	.long	.LVL31
	.long	0x3b6
	.uleb128 0x14
	.long	.LVL32
	.long	0x2ec
	.uleb128 0x14
	.long	.LVL33
	.long	0x41a
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF39
	.byte	0x1
	.byte	0x7d
	.byte	0x1
	.long	.LFB5
	.long	.LFE5
	.long	.LLST11
	.byte	0x1
	.long	0x54e
	.uleb128 0x12
	.long	.LVL34
	.long	0x879
	.long	0x4f5
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x12
	.long	.LVL35
	.long	0x88d
	.long	0x517
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x12
	.long	.LVL36
	.long	0x88d
	.long	0x539
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x19
	.long	.LVL37
	.long	0x8a6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF40
	.byte	0x1
	.byte	0x91
	.byte	0x1
	.long	.LFB6
	.long	.LFE6
	.long	.LLST12
	.byte	0x1
	.long	0x624
	.uleb128 0x16
	.long	.LASF41
	.byte	0x1
	.byte	0x93
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x12
	.long	.LVL39
	.long	0x879
	.long	0x58e
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x12
	.long	.LVL40
	.long	0x8ba
	.long	0x5a6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC1
	.byte	0
	.uleb128 0x12
	.long	.LVL41
	.long	0x8ce
	.long	0x5be
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x12
	.long	.LVL42
	.long	0x8a6
	.long	0x5d6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x14
	.long	.LVL43
	.long	0x6ed
	.uleb128 0x12
	.long	.LVL44
	.long	0x879
	.long	0x5f7
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x12
	.long	.LVL45
	.long	0x8ce
	.long	0x60f
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x19
	.long	.LVL46
	.long	0x8a6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.byte	0
	.uleb128 0x15
	.long	.LASF42
	.byte	0x1
	.byte	0xaf
	.byte	0x1
	.long	.LFB7
	.long	.LFE7
	.long	.LLST13
	.byte	0x1
	.long	0x6ed
	.uleb128 0x16
	.long	.LASF31
	.byte	0x1
	.byte	0xb1
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x17
	.long	.LBB3
	.long	.LBE3
	.uleb128 0x1a
	.string	"to"
	.byte	0x1
	.byte	0xb4
	.long	0x1b2
	.long	.LLST14
	.uleb128 0x18
	.long	.LASF43
	.byte	0x1
	.byte	0xb5
	.long	0x1b2
	.long	.LLST15
	.uleb128 0x14
	.long	.LVL48
	.long	0x809
	.uleb128 0x14
	.long	.LVL51
	.long	0x809
	.uleb128 0x12
	.long	.LVL54
	.long	0x826
	.long	0x6ad
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x91
	.sleb128 -28
	.byte	0x6
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0xa
	.value	0x200
	.byte	0
	.uleb128 0x12
	.long	.LVL55
	.long	0x851
	.long	0x6c3
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.long	.LVL56
	.long	0x865
	.long	0x6d9
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -28
	.byte	0x6
	.byte	0
	.uleb128 0x19
	.long	.LVL57
	.long	0x865
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF58
	.byte	0x1
	.byte	0xbe
	.long	.LFB8
	.long	.LFE8
	.long	.LLST16
	.byte	0x1
	.long	0x72a
	.uleb128 0x14
	.long	.LVL59
	.long	0x624
	.uleb128 0x14
	.long	.LVL60
	.long	0x41a
	.uleb128 0x14
	.long	.LVL61
	.long	0x2ec
	.uleb128 0x14
	.long	.LVL62
	.long	0x41a
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF44
	.byte	0x1
	.byte	0xd3
	.byte	0x1
	.long	.LFB9
	.long	.LFE9
	.long	.LLST17
	.byte	0x1
	.long	0x7b9
	.uleb128 0x10
	.string	"b"
	.byte	0x1
	.byte	0xd3
	.long	0x1b2
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.string	"i"
	.byte	0x1
	.byte	0xd5
	.long	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x12
	.long	.LVL64
	.long	0x8ba
	.long	0x774
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC2
	.byte	0
	.uleb128 0x12
	.long	.LVL65
	.long	0x8ba
	.long	0x78c
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC3
	.byte	0
	.uleb128 0x12
	.long	.LVL66
	.long	0x879
	.long	0x7a4
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.uleb128 0x19
	.long	.LVL68
	.long	0x8a6
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	log
	.byte	0
	.byte	0
	.uleb128 0x1c
	.string	"log"
	.byte	0x1
	.byte	0x2f
	.long	0x200
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	log
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF45
	.byte	0x6
	.byte	0x81
	.byte	0x1
	.byte	0x1
	.long	0x7e4
	.uleb128 0x1e
	.long	0x7e4
	.uleb128 0x1e
	.long	0x95
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x50
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF46
	.byte	0x6
	.byte	0x25
	.byte	0x1
	.byte	0x1
	.long	0x803
	.uleb128 0x1e
	.long	0x1ab
	.uleb128 0x1e
	.long	0x803
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0xc5
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF47
	.byte	0x6
	.byte	0xe
	.byte	0x1
	.long	0x1b2
	.byte	0x1
	.long	0x826
	.uleb128 0x1e
	.long	0x25
	.uleb128 0x1e
	.long	0x25
	.byte	0
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF48
	.byte	0x6
	.byte	0x88
	.byte	0x1
	.long	0x848
	.byte	0x1
	.long	0x848
	.uleb128 0x1e
	.long	0x848
	.uleb128 0x1e
	.long	0x84a
	.uleb128 0x1e
	.long	0x25
	.byte	0
	.uleb128 0x20
	.byte	0x4
	.uleb128 0x7
	.byte	0x4
	.long	0x850
	.uleb128 0x21
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF49
	.byte	0x6
	.byte	0x10
	.byte	0x1
	.byte	0x1
	.long	0x865
	.uleb128 0x1e
	.long	0x1b2
	.byte	0
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF50
	.byte	0x6
	.byte	0xf
	.byte	0x1
	.byte	0x1
	.long	0x879
	.uleb128 0x1e
	.long	0x1b2
	.byte	0
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF51
	.byte	0x6
	.byte	0x7e
	.byte	0x1
	.byte	0x1
	.long	0x88d
	.uleb128 0x1e
	.long	0x7e4
	.byte	0
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF52
	.byte	0x6
	.byte	0x74
	.byte	0x1
	.byte	0x1
	.long	0x8a6
	.uleb128 0x1e
	.long	0x848
	.uleb128 0x1e
	.long	0x7e4
	.byte	0
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF53
	.byte	0x6
	.byte	0x82
	.byte	0x1
	.byte	0x1
	.long	0x8ba
	.uleb128 0x1e
	.long	0x7e4
	.byte	0
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF54
	.byte	0x6
	.byte	0x16
	.byte	0x1
	.byte	0x1
	.long	0x8ce
	.uleb128 0x1e
	.long	0x95
	.byte	0
	.uleb128 0x22
	.byte	0x1
	.long	.LASF59
	.byte	0x6
	.byte	0x77
	.byte	0x1
	.byte	0x1
	.uleb128 0x1e
	.long	0x848
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
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
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x18
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
	.uleb128 0x19
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
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
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
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
	.uleb128 0x1c
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1d
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
	.uleb128 0x1e
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
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
	.uleb128 0x20
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x22
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
.LLST2:
	.long	.LVL6-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL7-.Ltext0
	.long	.LVL15-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST3:
	.long	.LVL9-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL10-.Ltext0
	.long	.LVL15-.Ltext0
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
	.long	.LVL17-.Ltext0
	.long	.LVL18-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL18-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST6:
	.long	.LVL19-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL20-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	0
	.long	0
.LLST7:
	.long	.LFB3-.Ltext0
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
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST8:
	.long	.LVL24-.Ltext0
	.long	.LVL25-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL25-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST9:
	.long	.LVL26-.Ltext0
	.long	.LVL28-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL28-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	0
	.long	0
.LLST10:
	.long	.LFB4-.Ltext0
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
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST11:
	.long	.LFB5-.Ltext0
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
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST12:
	.long	.LFB6-.Ltext0
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
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LFB7-.Ltext0
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
	.long	.LFE7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST14:
	.long	.LVL49-.Ltext0
	.long	.LVL50-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL50-.Ltext0
	.long	.LVL58-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST15:
	.long	.LVL52-.Ltext0
	.long	.LVL53-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL53-.Ltext0
	.long	.LVL58-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	0
	.long	0
.LLST16:
	.long	.LFB8-.Ltext0
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
	.long	.LFE8-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST17:
	.long	.LFB9-.Ltext0
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
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
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
	.string	"log_write"
.LASF48:
	.string	"memmove"
.LASF20:
	.string	"blockno"
.LASF3:
	.string	"uchar"
.LASF54:
	.string	"panic"
.LASF30:
	.string	"committing"
.LASF43:
	.string	"from"
.LASF28:
	.string	"start"
.LASF52:
	.string	"sleep"
.LASF41:
	.string	"do_commit"
.LASF9:
	.string	"spinlock"
.LASF29:
	.string	"outstanding"
.LASF26:
	.string	"block"
.LASF50:
	.string	"brelse"
.LASF35:
	.string	"read_head"
.LASF38:
	.string	"initlog"
.LASF24:
	.string	"data"
.LASF13:
	.string	"ninodes"
.LASF4:
	.string	"unsigned char"
.LASF45:
	.string	"initlock"
.LASF1:
	.string	"short unsigned int"
.LASF12:
	.string	"nblocks"
.LASF34:
	.string	"install_trans"
.LASF17:
	.string	"bmapstart"
.LASF57:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF40:
	.string	"end_op"
.LASF46:
	.string	"readsb"
.LASF5:
	.string	"locked"
.LASF2:
	.string	"uint"
.LASF37:
	.string	"recover_from_log"
.LASF56:
	.string	"log.c"
.LASF0:
	.string	"unsigned int"
.LASF19:
	.string	"flags"
.LASF33:
	.string	"dbuf"
.LASF51:
	.string	"acquire"
.LASF7:
	.string	"char"
.LASF59:
	.string	"wakeup"
.LASF14:
	.string	"nlog"
.LASF25:
	.string	"logheader"
.LASF36:
	.string	"write_head"
.LASF16:
	.string	"inodestart"
.LASF8:
	.string	"sizetype"
.LASF49:
	.string	"bwrite"
.LASF6:
	.string	"name"
.LASF58:
	.string	"commit"
.LASF55:
	.string	"GNU C 4.7.2"
.LASF15:
	.string	"logstart"
.LASF39:
	.string	"begin_op"
.LASF18:
	.string	"short int"
.LASF23:
	.string	"qnext"
.LASF42:
	.string	"write_log"
.LASF31:
	.string	"tail"
.LASF32:
	.string	"lbuf"
.LASF10:
	.string	"superblock"
.LASF22:
	.string	"next"
.LASF27:
	.string	"lock"
.LASF11:
	.string	"size"
.LASF21:
	.string	"prev"
.LASF47:
	.string	"bread"
.LASF53:
	.string	"release"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
