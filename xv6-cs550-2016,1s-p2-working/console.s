	.file	"console.c"
	.text
.Ltext0:
	.type	inb, @function
inb:
.LFB2:
	.file 1 "x86.h"
	.loc 1 5 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %eax
	movw	%ax, -24(%ebp)
	.loc 1 8 0
	movzwl	-24(%ebp), %edx
	movw	%dx, -22(%ebp)
	movzwl	-22(%ebp), %edx
#APP
# 8 "x86.h" 1
	in %dx,%al
# 0 "" 2
#NO_APP
	movl	%eax, %ebx
	movb	%bl, -5(%ebp)
.LVL1:
	.loc 1 9 0
	movzbl	-5(%ebp), %eax
	.loc 1 10 0
	addl	$20, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
.LCFI2:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	inb, .-inb
	.type	outb, @function
outb:
.LFB4:
	.loc 1 23 0
	.cfi_startproc
.LVL2:
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movw	%dx, -4(%ebp)
	movb	%al, -8(%ebp)
	.loc 1 24 0
	movzbl	-8(%ebp), %eax
	movzwl	-4(%ebp), %edx
#APP
# 24 "x86.h" 1
	out %al,%dx
# 0 "" 2
	.loc 1 25 0
#NO_APP
	leave
.LCFI5:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	outb, .-outb
	.type	cli, @function
cli:
.LFB14:
	.loc 1 110 0
	.cfi_startproc
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	.loc 1 111 0
#APP
# 111 "x86.h" 1
	cli
# 0 "" 2
	.loc 1 112 0
#NO_APP
	popl	%ebp
.LCFI8:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	cli, .-cli
	.local	panicked
	.comm	panicked,4,4
	.local	cons
	.comm	cons,56,32
	.type	printint, @function
printint:
.LFB20:
	.file 2 "console.c"
	.loc 2 28 0
	.cfi_startproc
.LVL3:
	pushl	%ebp
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI10:
	.cfi_def_cfa_register 5
	subl	$72, %esp
	.loc 2 34 0
	cmpl	$0, 16(%ebp)
	je	.L6
	.loc 2 34 0 is_stmt 0 discriminator 1
	movl	8(%ebp), %eax
	shrl	$31, %eax
	movzbl	%al, %eax
	movl	%eax, 16(%ebp)
.LVL4:
	cmpl	$0, 16(%ebp)
	je	.L6
	.loc 2 35 0 is_stmt 1
	movl	8(%ebp), %eax
.LVL5:
	negl	%eax
	movl	%eax, -16(%ebp)
.LVL6:
	jmp	.L7
.LVL7:
.L6:
	.loc 2 37 0
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
.LVL8:
.L7:
	.loc 2 39 0
	movl	$0, -12(%ebp)
.LVL9:
.L8:
	.loc 2 41 0 discriminator 1
	movl	12(%ebp), %ecx
	movl	-16(%ebp), %eax
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movzbl	digits.1508(%eax), %eax
	leal	-32(%ebp), %ecx
	movl	-12(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	addl	$1, -12(%ebp)
	.loc 2 42 0 discriminator 1
	movl	12(%ebp), %edx
	movl	%edx, -44(%ebp)
	movl	-16(%ebp), %eax
	movl	$0, %edx
	divl	-44(%ebp)
	movl	%eax, -16(%ebp)
.LVL10:
	cmpl	$0, -16(%ebp)
	jne	.L8
	.loc 2 44 0
	cmpl	$0, 16(%ebp)
	je	.L10
	.loc 2 45 0
	leal	-32(%ebp), %edx
	movl	-12(%ebp), %eax
.LVL11:
	addl	%edx, %eax
	movb	$45, (%eax)
	addl	$1, -12(%ebp)
	.loc 2 47 0
	jmp	.L10
.L11:
	.loc 2 48 0
	leal	-32(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	consputc
.LVL12:
.L10:
	.loc 2 47 0 discriminator 1
	subl	$1, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jns	.L11
	.loc 2 49 0
	leave
.LCFI11:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	printint, .-printint
	.section	.rodata
.LC0:
	.string	"null fmt"
.LC1:
	.string	"(null)"
	.text
	.globl	cprintf
	.type	cprintf, @function
cprintf:
.LFB21:
	.loc 2 55 0
	.cfi_startproc
.LVL13:
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI13:
	.cfi_def_cfa_register 5
	subl	$56, %esp
	.loc 2 60 0
	movl	cons+52, %eax
	movl	%eax, -24(%ebp)
.LVL14:
	.loc 2 61 0
	cmpl	$0, -24(%ebp)
	je	.L13
	.loc 2 62 0
	movl	$cons, (%esp)
	call	acquire
.LVL15:
.L13:
	.loc 2 64 0
	movl	8(%ebp), %eax
	testl	%eax, %eax
	jne	.L14
	.loc 2 65 0
	movl	$.LC0, (%esp)
	call	panic
.LVL16:
.L14:
	.loc 2 67 0
	leal	12(%ebp), %eax
	movl	%eax, -16(%ebp)
.LVL17:
	.loc 2 68 0
	movl	$0, -12(%ebp)
.LVL18:
	jmp	.L15
.LVL19:
.L29:
	.loc 2 69 0
	cmpl	$37, -28(%ebp)
	je	.L16
	.loc 2 70 0
	movl	-28(%ebp), %eax
.LVL20:
	movl	%eax, (%esp)
	call	consputc
.LVL21:
	.loc 2 71 0
	jmp	.L17
.LVL22:
.L16:
	.loc 2 73 0
	movl	8(%ebp), %edx
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
.LVL23:
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	andl	$255, %eax
	movl	%eax, -28(%ebp)
.LVL24:
	.loc 2 74 0
	cmpl	$0, -28(%ebp)
	je	.L31
.L18:
	.loc 2 76 0
	movl	-28(%ebp), %eax
	cmpl	$112, %eax
	je	.L23
	cmpl	$112, %eax
	jg	.L25
	cmpl	$37, %eax
	je	.L21
	cmpl	$100, %eax
	je	.L22
	jmp	.L20
.L25:
	cmpl	$115, %eax
	je	.L24
	cmpl	$120, %eax
	je	.L23
	jmp	.L20
.L22:
	.loc 2 78 0
	movl	-16(%ebp), %eax
.LVL25:
	movl	(%eax), %eax
	addl	$4, -16(%ebp)
	movl	$1, 8(%esp)
	movl	$10, 4(%esp)
	movl	%eax, (%esp)
	call	printint
.LVL26:
	.loc 2 79 0
	jmp	.L17
.LVL27:
.L23:
	.loc 2 82 0
	movl	-16(%ebp), %eax
.LVL28:
	movl	(%eax), %eax
	addl	$4, -16(%ebp)
	movl	$0, 8(%esp)
	movl	$16, 4(%esp)
	movl	%eax, (%esp)
	call	printint
.LVL29:
	.loc 2 83 0
	jmp	.L17
.LVL30:
.L24:
	.loc 2 85 0
	movl	-16(%ebp), %eax
.LVL31:
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
.LVL32:
	cmpl	$0, -20(%ebp)
	sete	%al
.LVL33:
	addl	$4, -16(%ebp)
	testb	%al, %al
	je	.L32
	.loc 2 86 0
	movl	$.LC1, -20(%ebp)
.LVL34:
	.loc 2 87 0
	jmp	.L32
.L28:
	.loc 2 88 0 discriminator 2
	movl	-20(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	consputc
.LVL35:
	.loc 2 87 0 discriminator 2
	addl	$1, -20(%ebp)
	jmp	.L27
.L32:
	.loc 2 87 0 is_stmt 0
	nop
.L27:
	.loc 2 87 0 discriminator 1
	movl	-20(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L28
	.loc 2 89 0 is_stmt 1
	jmp	.L17
.LVL36:
.L21:
	.loc 2 91 0
	movl	$37, (%esp)
	call	consputc
.LVL37:
	.loc 2 92 0
	jmp	.L17
.LVL38:
.L20:
	.loc 2 95 0
	movl	$37, (%esp)
	call	consputc
.LVL39:
	.loc 2 96 0
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	consputc
.LVL40:
	.loc 2 97 0
	nop
.L17:
	.loc 2 68 0
	addl	$1, -12(%ebp)
.LVL41:
.L15:
	.loc 2 68 0 is_stmt 0 discriminator 1
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	andl	$255, %eax
	movl	%eax, -28(%ebp)
.LVL42:
	cmpl	$0, -28(%ebp)
	jne	.L29
	jmp	.L19
.L31:
	.loc 2 75 0 is_stmt 1
	nop
.L19:
	.loc 2 101 0
	cmpl	$0, -24(%ebp)
	je	.L12
	.loc 2 102 0
	movl	$cons, (%esp)
	call	release
.LVL43:
.L12:
	.loc 2 103 0
	leave
.LCFI14:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	cprintf, .-cprintf
	.section	.rodata
.LC2:
	.string	"cpu%d: panic: "
.LC3:
	.string	"\n"
.LC4:
	.string	" %p"
	.text
	.globl	panic
	.type	panic, @function
panic:
.LFB22:
	.loc 2 107 0
	.cfi_startproc
.LVL44:
	pushl	%ebp
.LCFI15:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI16:
	.cfi_def_cfa_register 5
	subl	$72, %esp
	.loc 2 111 0
	call	cli
.LVL45:
	.loc 2 112 0
	movl	$0, cons+52
	.loc 2 113 0
	movl	%gs:0, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	cprintf
.LVL46:
	.loc 2 114 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	cprintf
.LVL47:
	.loc 2 115 0
	movl	$.LC3, (%esp)
	call	cprintf
.LVL48:
	.loc 2 116 0
	leal	-52(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	8(%ebp), %eax
	movl	%eax, (%esp)
	call	getcallerpcs
.LVL49:
	.loc 2 117 0
	movl	$0, -12(%ebp)
.LVL50:
	jmp	.L34
.L35:
	.loc 2 118 0 discriminator 2
	movl	-12(%ebp), %eax
	movl	-52(%ebp,%eax,4), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	cprintf
.LVL51:
	.loc 2 117 0 discriminator 2
	addl	$1, -12(%ebp)
.L34:
	.loc 2 117 0 is_stmt 0 discriminator 1
	cmpl	$9, -12(%ebp)
	jle	.L35
	.loc 2 119 0 is_stmt 1
	movl	$1, panicked
.L36:
	.loc 2 121 0 discriminator 1
	jmp	.L36
	.cfi_endproc
.LFE22:
	.size	panic, .-panic
	.data
	.align 4
	.type	crt, @object
	.size	crt, 4
crt:
	.long	-2146729984
	.section	.rodata
.LC5:
	.string	"pos under/overflow"
	.text
	.type	cgaputc, @function
cgaputc:
.LFB23:
	.loc 2 131 0
	.cfi_startproc
.LVL52:
	pushl	%ebp
.LCFI17:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI18:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 2 135 0
	movl	$14, 4(%esp)
	movl	$980, (%esp)
	call	outb
.LVL53:
	.loc 2 136 0
	movl	$981, (%esp)
	call	inb
.LVL54:
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, -12(%ebp)
.LVL55:
	.loc 2 137 0
	movl	$15, 4(%esp)
	movl	$980, (%esp)
	call	outb
.LVL56:
	.loc 2 138 0
	movl	$981, (%esp)
	call	inb
.LVL57:
	movzbl	%al, %eax
	orl	%eax, -12(%ebp)
	.loc 2 140 0
	cmpl	$10, 8(%ebp)
	jne	.L38
	.loc 2 141 0
	movl	-12(%ebp), %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$5, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%ecx, %edx
	subl	%eax, %edx
	movl	$80, %eax
	subl	%edx, %eax
	addl	%eax, -12(%ebp)
	jmp	.L39
.L38:
	.loc 2 142 0
	cmpl	$256, 8(%ebp)
	jne	.L40
	.loc 2 143 0
	cmpl	$0, -12(%ebp)
	jle	.L39
	.loc 2 143 0 is_stmt 0 discriminator 1
	subl	$1, -12(%ebp)
	jmp	.L39
.L40:
	.loc 2 145 0 is_stmt 1
	movl	crt, %eax
	movl	-12(%ebp), %edx
	addl	%edx, %edx
	addl	%eax, %edx
	movl	8(%ebp), %eax
	andw	$255, %ax
	orb	$7, %ah
	movw	%ax, (%edx)
	addl	$1, -12(%ebp)
.L39:
	.loc 2 147 0
	cmpl	$0, -12(%ebp)
	js	.L41
	.loc 2 147 0 is_stmt 0 discriminator 1
	cmpl	$2000, -12(%ebp)
	jle	.L42
.L41:
	.loc 2 148 0 is_stmt 1
	movl	$.LC5, (%esp)
	call	panic
.LVL58:
.L42:
	.loc 2 150 0
	cmpl	$1919, -12(%ebp)
	jle	.L43
	.loc 2 151 0
	movl	crt, %eax
	leal	160(%eax), %edx
	movl	crt, %eax
	movl	$3680, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	memmove
.LVL59:
	.loc 2 152 0
	subl	$80, -12(%ebp)
	.loc 2 153 0
	movl	$1920, %eax
	subl	-12(%ebp), %eax
	addl	%eax, %eax
	movl	crt, %edx
	movl	-12(%ebp), %ecx
	addl	%ecx, %ecx
	addl	%ecx, %edx
	movl	%eax, 8(%esp)
	movl	$0, 4(%esp)
	movl	%edx, (%esp)
	call	memset
.LVL60:
.L43:
	.loc 2 156 0
	movl	$14, 4(%esp)
	movl	$980, (%esp)
	call	outb
.LVL61:
	.loc 2 157 0
	movl	-12(%ebp), %eax
	sarl	$8, %eax
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$981, (%esp)
	call	outb
.LVL62:
	.loc 2 158 0
	movl	$15, 4(%esp)
	movl	$980, (%esp)
	call	outb
.LVL63:
	.loc 2 159 0
	movl	-12(%ebp), %eax
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$981, (%esp)
	call	outb
.LVL64:
	.loc 2 160 0
	movl	crt, %eax
	movl	-12(%ebp), %edx
	addl	%edx, %edx
	addl	%edx, %eax
	movw	$1824, (%eax)
	.loc 2 161 0
	leave
.LCFI19:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	cgaputc, .-cgaputc
	.type	consputc, @function
consputc:
.LFB24:
	.loc 2 165 0
	.cfi_startproc
.LVL65:
	pushl	%ebp
.LCFI20:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI21:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 2 166 0
	movl	panicked, %eax
	testl	%eax, %eax
	je	.L45
	.loc 2 167 0
	call	cli
.LVL66:
.L46:
	.loc 2 169 0 discriminator 1
	jmp	.L46
.L45:
	.loc 2 172 0
	cmpl	$256, 8(%ebp)
	jne	.L47
	.loc 2 173 0
	movl	$8, (%esp)
	call	uartputc
.LVL67:
	movl	$32, (%esp)
	call	uartputc
.LVL68:
	movl	$8, (%esp)
	call	uartputc
.LVL69:
	jmp	.L48
.L47:
	.loc 2 175 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	uartputc
.LVL70:
.L48:
	.loc 2 176 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	cgaputc
.LVL71:
	.loc 2 177 0
	leave
.LCFI22:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	consputc, .-consputc
	.comm	input,140,32
	.globl	consoleintr
	.type	consoleintr, @function
consoleintr:
.LFB25:
	.loc 2 191 0
	.cfi_startproc
.LVL72:
	pushl	%ebp
.LCFI23:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI24:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 2 192 0
	movl	$0, -12(%ebp)
.LVL73:
	.loc 2 194 0
	movl	$cons, (%esp)
	call	acquire
.LVL74:
	.loc 2 195 0
	jmp	.L50
.LVL75:
.L64:
	.loc 2 196 0
	movl	-16(%ebp), %eax
.LVL76:
	cmpl	$16, %eax
	je	.L53
	cmpl	$16, %eax
	jg	.L55
	cmpl	$8, %eax
	je	.L52
	jmp	.L51
.L55:
	cmpl	$21, %eax
	je	.L66
	cmpl	$127, %eax
	je	.L52
	jmp	.L51
.L53:
	.loc 2 198 0
	movl	$1, -12(%ebp)
	.loc 2 199 0
	jmp	.L50
.L58:
	.loc 2 203 0
	movl	input+136, %eax
	subl	$1, %eax
	movl	%eax, input+136
	.loc 2 204 0
	movl	$256, (%esp)
	call	consputc
.LVL77:
	jmp	.L56
.L66:
	.loc 2 201 0
	nop
.L56:
	.loc 2 201 0 is_stmt 0 discriminator 1
	movl	input+136, %edx
	movl	input+132, %eax
	cmpl	%eax, %edx
	je	.L67
	.loc 2 202 0 is_stmt 1 discriminator 2
	movl	input+136, %eax
	subl	$1, %eax
	andl	$127, %eax
	movzbl	input(%eax), %eax
	.loc 2 201 0 discriminator 2
	cmpb	$10, %al
	jne	.L58
	.loc 2 206 0
	jmp	.L67
.L52:
	.loc 2 208 0
	movl	input+136, %edx
	movl	input+132, %eax
	cmpl	%eax, %edx
	je	.L68
	.loc 2 209 0
	movl	input+136, %eax
	subl	$1, %eax
	movl	%eax, input+136
	.loc 2 210 0
	movl	$256, (%esp)
	call	consputc
.LVL78:
	.loc 2 212 0
	jmp	.L68
.L51:
	.loc 2 214 0
	cmpl	$0, -16(%ebp)
	je	.L69
	.loc 2 214 0 is_stmt 0 discriminator 1
	movl	input+136, %edx
	movl	input+128, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	cmpl	$127, %eax
	ja	.L69
	.loc 2 215 0 is_stmt 1
	cmpl	$13, -16(%ebp)
	je	.L61
	.loc 2 215 0 is_stmt 0 discriminator 1
	movl	-16(%ebp), %eax
	jmp	.L62
.L61:
	.loc 2 215 0 discriminator 2
	movl	$10, %eax
.L62:
	.loc 2 215 0 discriminator 3
	movl	%eax, -16(%ebp)
.LVL79:
	.loc 2 216 0 is_stmt 1 discriminator 3
	movl	input+136, %eax
.LVL80:
	movl	%eax, %ecx
	andl	$127, %ecx
	movl	-16(%ebp), %edx
	movb	%dl, input(%ecx)
	addl	$1, %eax
	movl	%eax, input+136
	.loc 2 217 0 discriminator 3
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	consputc
.LVL81:
	.loc 2 218 0 discriminator 3
	cmpl	$10, -16(%ebp)
	je	.L63
	.loc 2 218 0 is_stmt 0 discriminator 1
	cmpl	$4, -16(%ebp)
	je	.L63
	movl	input+136, %eax
	movl	input+128, %edx
	subl	$-128, %edx
	cmpl	%edx, %eax
	jne	.L69
.L63:
	.loc 2 219 0 is_stmt 1
	movl	input+136, %eax
	movl	%eax, input+132
	.loc 2 220 0
	movl	$input+128, (%esp)
	call	wakeup
.LVL82:
	.loc 2 223 0
	jmp	.L69
.L67:
	.loc 2 206 0
	nop
	jmp	.L50
.L68:
	.loc 2 212 0
	nop
	jmp	.L50
.L69:
	.loc 2 223 0
	nop
.LVL83:
.L50:
	.loc 2 195 0 discriminator 1
	movl	8(%ebp), %eax
	call	*%eax
.LVL84:
	movl	%eax, -16(%ebp)
.LVL85:
	cmpl	$0, -16(%ebp)
	jns	.L64
	.loc 2 226 0
	movl	$cons, (%esp)
	call	release
.LVL86:
	.loc 2 227 0
	cmpl	$0, -12(%ebp)
	je	.L49
	.loc 2 228 0
	call	procdump
.LVL87:
.L49:
	.loc 2 230 0
	leave
.LCFI25:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	consoleintr, .-consoleintr
	.globl	consoleread
	.type	consoleread, @function
consoleread:
.LFB26:
	.loc 2 234 0
	.cfi_startproc
.LVL88:
	pushl	%ebp
.LCFI26:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI27:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 2 238 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	iunlock
.LVL89:
	.loc 2 239 0
	movl	16(%ebp), %eax
	movl	%eax, -12(%ebp)
.LVL90:
	.loc 2 240 0
	movl	$cons, (%esp)
	call	acquire
.LVL91:
	.loc 2 241 0
	jmp	.L71
.L75:
	.loc 2 243 0
	movl	%gs:4, %eax
	movl	36(%eax), %eax
	testl	%eax, %eax
	je	.L73
	.loc 2 244 0
	movl	$cons, (%esp)
	call	release
.LVL92:
	.loc 2 245 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	ilock
.LVL93:
	.loc 2 246 0
	movl	$-1, %eax
	jmp	.L74
.L73:
	.loc 2 248 0
	movl	$cons, 4(%esp)
	movl	$input+128, (%esp)
	call	sleep
.LVL94:
	jmp	.L72
.L82:
	.loc 2 242 0
	nop
.L72:
	.loc 2 242 0 is_stmt 0 discriminator 1
	movl	input+128, %edx
	movl	input+132, %eax
	cmpl	%eax, %edx
	je	.L75
	.loc 2 250 0 is_stmt 1
	movl	input+128, %eax
	movl	%eax, %edx
	andl	$127, %edx
	movzbl	input(%edx), %edx
	movsbl	%dl, %edx
	movl	%edx, -16(%ebp)
.LVL95:
	addl	$1, %eax
	movl	%eax, input+128
	.loc 2 251 0
	cmpl	$4, -16(%ebp)
	jne	.L76
	.loc 2 252 0
	movl	16(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jae	.L80
	.loc 2 255 0
	movl	input+128, %eax
	subl	$1, %eax
	movl	%eax, input+128
	.loc 2 257 0
	jmp	.L80
.L76:
	.loc 2 259 0
	movl	-16(%ebp), %eax
	movl	%eax, %edx
.LVL96:
	movl	12(%ebp), %eax
	movb	%dl, (%eax)
	addl	$1, 12(%ebp)
	.loc 2 260 0
	subl	$1, 16(%ebp)
	.loc 2 261 0
	cmpl	$10, -16(%ebp)
	je	.L81
.LVL97:
.L71:
	.loc 2 241 0 discriminator 1
	cmpl	$0, 16(%ebp)
	jg	.L82
	jmp	.L78
.LVL98:
.L80:
	.loc 2 257 0
	nop
	jmp	.L78
.LVL99:
.L81:
	.loc 2 262 0
	nop
.LVL100:
.L78:
	.loc 2 264 0
	movl	$cons, (%esp)
	call	release
.LVL101:
	.loc 2 265 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	ilock
.LVL102:
	.loc 2 267 0
	movl	16(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
.L74:
	.loc 2 268 0
	leave
.LCFI28:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	consoleread, .-consoleread
	.globl	consolewrite
	.type	consolewrite, @function
consolewrite:
.LFB27:
	.loc 2 272 0
	.cfi_startproc
.LVL103:
	pushl	%ebp
.LCFI29:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI30:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 2 275 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	iunlock
.LVL104:
	.loc 2 276 0
	movl	$cons, (%esp)
	call	acquire
.LVL105:
	.loc 2 277 0
	movl	$0, -12(%ebp)
.LVL106:
	jmp	.L84
.LVL107:
.L85:
	.loc 2 278 0 discriminator 2
	movl	-12(%ebp), %edx
	movl	12(%ebp), %eax
.LVL108:
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	andl	$255, %eax
	movl	%eax, (%esp)
	call	consputc
.LVL109:
	.loc 2 277 0 discriminator 2
	addl	$1, -12(%ebp)
.L84:
	.loc 2 277 0 is_stmt 0 discriminator 1
	movl	-12(%ebp), %eax
	cmpl	16(%ebp), %eax
	jl	.L85
	.loc 2 279 0 is_stmt 1
	movl	$cons, (%esp)
	call	release
.LVL110:
	.loc 2 280 0
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	ilock
.LVL111:
	.loc 2 282 0
	movl	16(%ebp), %eax
	.loc 2 283 0
	leave
.LCFI31:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE27:
	.size	consolewrite, .-consolewrite
	.section	.rodata
.LC6:
	.string	"console"
	.text
	.globl	consoleinit
	.type	consoleinit, @function
consoleinit:
.LFB28:
	.loc 2 287 0
	.cfi_startproc
	pushl	%ebp
.LCFI32:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI33:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 2 288 0
	movl	$.LC6, 4(%esp)
	movl	$cons, (%esp)
	call	initlock
.LVL112:
	.loc 2 290 0
	movl	$consolewrite, devsw+12
	.loc 2 291 0
	movl	$consoleread, devsw+8
	.loc 2 292 0
	movl	$1, cons+52
	.loc 2 294 0
	movl	$1, (%esp)
	call	picenable
.LVL113:
	.loc 2 295 0
	movl	$0, 4(%esp)
	movl	$1, (%esp)
	call	ioapicenable
.LVL114:
	.loc 2 296 0
	leave
.LCFI34:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE28:
	.size	consoleinit, .-consoleinit
	.data
	.type	digits.1508, @object
	.size	digits.1508, 17
digits.1508:
	.string	"0123456789abcdef"
	.text
.Letext0:
	.file 3 "types.h"
	.file 4 "spinlock.h"
	.file 5 "proc.h"
	.file 6 "file.h"
	.file 7 "mmu.h"
	.file 8 "defs.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x134e
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF114
	.byte	0x1
	.long	.LASF115
	.long	.LASF116
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF0
	.byte	0x3
	.byte	0x1
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.long	.LASF1
	.byte	0x3
	.byte	0x2
	.long	0x42
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x2
	.long	.LASF4
	.byte	0x3
	.byte	0x3
	.long	0x54
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF5
	.uleb128 0x2
	.long	.LASF6
	.byte	0x3
	.byte	0x4
	.long	0x25
	.uleb128 0x4
	.long	.LASF10
	.byte	0x34
	.byte	0x4
	.byte	0x2
	.long	0xab
	.uleb128 0x5
	.long	.LASF7
	.byte	0x4
	.byte	0x3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF8
	.byte	0x4
	.byte	0x6
	.long	0xab
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"cpu"
	.byte	0x4
	.byte	0x7
	.long	0x146
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.string	"pcs"
	.byte	0x4
	.byte	0x8
	.long	0x14c
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0xb1
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF9
	.uleb128 0x8
	.string	"cpu"
	.byte	0xbc
	.byte	0x5
	.byte	0x5
	.long	0x146
	.uleb128 0x6
	.string	"id"
	.byte	0x5
	.byte	0x6
	.long	0x49
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF11
	.byte	0x5
	.byte	0x7
	.long	0x647
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"ts"
	.byte	0x5
	.byte	0x8
	.long	0x3e1
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.string	"gdt"
	.byte	0x5
	.byte	0x9
	.long	0x64d
	.byte	0x2
	.byte	0x23
	.uleb128 0x70
	.uleb128 0x5
	.long	.LASF12
	.byte	0x5
	.byte	0xa
	.long	0x65d
	.byte	0x3
	.byte	0x23
	.uleb128 0xa8
	.uleb128 0x5
	.long	.LASF13
	.byte	0x5
	.byte	0xb
	.long	0x203
	.byte	0x3
	.byte	0x23
	.uleb128 0xac
	.uleb128 0x5
	.long	.LASF14
	.byte	0x5
	.byte	0xc
	.long	0x203
	.byte	0x3
	.byte	0x23
	.uleb128 0xb0
	.uleb128 0x6
	.string	"cpu"
	.byte	0x5
	.byte	0xf
	.long	0x146
	.byte	0x3
	.byte	0x23
	.uleb128 0xb4
	.uleb128 0x5
	.long	.LASF15
	.byte	0x5
	.byte	0x10
	.long	0x723
	.byte	0x3
	.byte	0x23
	.uleb128 0xb8
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0xb8
	.uleb128 0x9
	.long	0x25
	.long	0x15c
	.uleb128 0xa
	.long	0x15c
	.byte	0x9
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF16
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF17
	.uleb128 0x9
	.long	0x25
	.long	0x17a
	.uleb128 0xa
	.long	0x15c
	.byte	0xc
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.byte	0x6
	.byte	0x2
	.long	0x195
	.uleb128 0xc
	.long	.LASF18
	.sleb128 0
	.uleb128 0xc
	.long	.LASF19
	.sleb128 1
	.uleb128 0xc
	.long	.LASF20
	.sleb128 2
	.byte	0
	.uleb128 0x4
	.long	.LASF21
	.byte	0x18
	.byte	0x6
	.byte	0x1
	.long	0x203
	.uleb128 0x5
	.long	.LASF22
	.byte	0x6
	.byte	0x2
	.long	0x17a
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.string	"ref"
	.byte	0x6
	.byte	0x3
	.long	0x203
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF23
	.byte	0x6
	.byte	0x4
	.long	0xb1
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF24
	.byte	0x6
	.byte	0x5
	.long	0xb1
	.byte	0x2
	.byte	0x23
	.uleb128 0x9
	.uleb128 0x5
	.long	.LASF25
	.byte	0x6
	.byte	0x6
	.long	0x210
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.string	"ip"
	.byte	0x6
	.byte	0x7
	.long	0x2af
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x6
	.string	"off"
	.byte	0x6
	.byte	0x8
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.byte	0
	.uleb128 0xd
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0xe
	.long	.LASF25
	.byte	0x1
	.uleb128 0x7
	.byte	0x4
	.long	0x20a
	.uleb128 0x4
	.long	.LASF26
	.byte	0x50
	.byte	0x6
	.byte	0xd
	.long	0x2af
	.uleb128 0x6
	.string	"dev"
	.byte	0x6
	.byte	0xe
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF27
	.byte	0x6
	.byte	0xf
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"ref"
	.byte	0x6
	.byte	0x10
	.long	0x203
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF28
	.byte	0x6
	.byte	0x11
	.long	0x203
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.long	.LASF22
	.byte	0x6
	.byte	0x13
	.long	0x163
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x5
	.long	.LASF29
	.byte	0x6
	.byte	0x14
	.long	0x163
	.byte	0x2
	.byte	0x23
	.uleb128 0x12
	.uleb128 0x5
	.long	.LASF30
	.byte	0x6
	.byte	0x15
	.long	0x163
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x5
	.long	.LASF31
	.byte	0x6
	.byte	0x16
	.long	0x163
	.byte	0x2
	.byte	0x23
	.uleb128 0x16
	.uleb128 0x5
	.long	.LASF32
	.byte	0x6
	.byte	0x17
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x5
	.long	.LASF33
	.byte	0x6
	.byte	0x18
	.long	0x16a
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x216
	.uleb128 0x4
	.long	.LASF34
	.byte	0x8
	.byte	0x6
	.byte	0x1f
	.long	0x2de
	.uleb128 0x5
	.long	.LASF35
	.byte	0x6
	.byte	0x20
	.long	0x2f8
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF36
	.byte	0x6
	.byte	0x21
	.long	0x2f8
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	0x203
	.long	0x2f8
	.uleb128 0x10
	.long	0x2af
	.uleb128 0x10
	.long	0xab
	.uleb128 0x10
	.long	0x203
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x2de
	.uleb128 0x4
	.long	.LASF37
	.byte	0x8
	.byte	0x7
	.byte	0x34
	.long	0x3e1
	.uleb128 0x11
	.long	.LASF38
	.byte	0x7
	.byte	0x35
	.long	0x25
	.byte	0x4
	.byte	0x10
	.byte	0x10
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x11
	.long	.LASF39
	.byte	0x7
	.byte	0x36
	.long	0x25
	.byte	0x4
	.byte	0x10
	.byte	0
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x11
	.long	.LASF40
	.byte	0x7
	.byte	0x37
	.long	0x25
	.byte	0x4
	.byte	0x8
	.byte	0x18
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x11
	.long	.LASF22
	.byte	0x7
	.byte	0x38
	.long	0x25
	.byte	0x4
	.byte	0x4
	.byte	0x14
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x12
	.string	"s"
	.byte	0x7
	.byte	0x39
	.long	0x25
	.byte	0x4
	.byte	0x1
	.byte	0x13
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x12
	.string	"dpl"
	.byte	0x7
	.byte	0x3a
	.long	0x25
	.byte	0x4
	.byte	0x2
	.byte	0x11
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x12
	.string	"p"
	.byte	0x7
	.byte	0x3b
	.long	0x25
	.byte	0x4
	.byte	0x1
	.byte	0x10
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x11
	.long	.LASF41
	.byte	0x7
	.byte	0x3c
	.long	0x25
	.byte	0x4
	.byte	0x4
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x12
	.string	"avl"
	.byte	0x7
	.byte	0x3d
	.long	0x25
	.byte	0x4
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x11
	.long	.LASF42
	.byte	0x7
	.byte	0x3e
	.long	0x25
	.byte	0x4
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x12
	.string	"db"
	.byte	0x7
	.byte	0x3f
	.long	0x25
	.byte	0x4
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x12
	.string	"g"
	.byte	0x7
	.byte	0x40
	.long	0x25
	.byte	0x4
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x11
	.long	.LASF43
	.byte	0x7
	.byte	0x41
	.long	0x25
	.byte	0x4
	.byte	0x8
	.byte	0
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0
	.uleb128 0x4
	.long	.LASF44
	.byte	0x68
	.byte	0x7
	.byte	0x97
	.long	0x5ec
	.uleb128 0x5
	.long	.LASF45
	.byte	0x7
	.byte	0x98
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF46
	.byte	0x7
	.byte	0x99
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"ss0"
	.byte	0x7
	.byte	0x9a
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF47
	.byte	0x7
	.byte	0x9b
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0xa
	.uleb128 0x5
	.long	.LASF48
	.byte	0x7
	.byte	0x9c
	.long	0x5ec
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.string	"ss1"
	.byte	0x7
	.byte	0x9d
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x5
	.long	.LASF49
	.byte	0x7
	.byte	0x9e
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x12
	.uleb128 0x5
	.long	.LASF50
	.byte	0x7
	.byte	0x9f
	.long	0x5ec
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x6
	.string	"ss2"
	.byte	0x7
	.byte	0xa0
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x5
	.long	.LASF51
	.byte	0x7
	.byte	0xa1
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x1a
	.uleb128 0x6
	.string	"cr3"
	.byte	0x7
	.byte	0xa2
	.long	0x5f2
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x6
	.string	"eip"
	.byte	0x7
	.byte	0xa3
	.long	0x5ec
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x5
	.long	.LASF52
	.byte	0x7
	.byte	0xa4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x6
	.string	"eax"
	.byte	0x7
	.byte	0xa5
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x6
	.string	"ecx"
	.byte	0x7
	.byte	0xa6
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.uleb128 0x6
	.string	"edx"
	.byte	0x7
	.byte	0xa7
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x6
	.string	"ebx"
	.byte	0x7
	.byte	0xa8
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0x6
	.string	"esp"
	.byte	0x7
	.byte	0xa9
	.long	0x5ec
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x6
	.string	"ebp"
	.byte	0x7
	.byte	0xaa
	.long	0x5ec
	.byte	0x2
	.byte	0x23
	.uleb128 0x3c
	.uleb128 0x6
	.string	"esi"
	.byte	0x7
	.byte	0xab
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0x6
	.string	"edi"
	.byte	0x7
	.byte	0xac
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x44
	.uleb128 0x6
	.string	"es"
	.byte	0x7
	.byte	0xad
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x5
	.long	.LASF53
	.byte	0x7
	.byte	0xae
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x4a
	.uleb128 0x6
	.string	"cs"
	.byte	0x7
	.byte	0xaf
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x4c
	.uleb128 0x5
	.long	.LASF54
	.byte	0x7
	.byte	0xb0
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x4e
	.uleb128 0x6
	.string	"ss"
	.byte	0x7
	.byte	0xb1
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x50
	.uleb128 0x5
	.long	.LASF55
	.byte	0x7
	.byte	0xb2
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x52
	.uleb128 0x6
	.string	"ds"
	.byte	0x7
	.byte	0xb3
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x54
	.uleb128 0x5
	.long	.LASF56
	.byte	0x7
	.byte	0xb4
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x56
	.uleb128 0x6
	.string	"fs"
	.byte	0x7
	.byte	0xb5
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x58
	.uleb128 0x5
	.long	.LASF57
	.byte	0x7
	.byte	0xb6
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x5a
	.uleb128 0x6
	.string	"gs"
	.byte	0x7
	.byte	0xb7
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x5c
	.uleb128 0x5
	.long	.LASF58
	.byte	0x7
	.byte	0xb8
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x5e
	.uleb128 0x6
	.string	"ldt"
	.byte	0x7
	.byte	0xb9
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x60
	.uleb128 0x5
	.long	.LASF59
	.byte	0x7
	.byte	0xba
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x62
	.uleb128 0x6
	.string	"t"
	.byte	0x7
	.byte	0xbb
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x64
	.uleb128 0x5
	.long	.LASF60
	.byte	0x7
	.byte	0xbc
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x66
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x25
	.uleb128 0x13
	.byte	0x4
	.uleb128 0x4
	.long	.LASF61
	.byte	0x14
	.byte	0x5
	.byte	0x2c
	.long	0x647
	.uleb128 0x6
	.string	"edi"
	.byte	0x5
	.byte	0x2d
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.string	"esi"
	.byte	0x5
	.byte	0x2e
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"ebx"
	.byte	0x5
	.byte	0x2f
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.string	"ebp"
	.byte	0x5
	.byte	0x30
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.string	"eip"
	.byte	0x5
	.byte	0x31
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x5f4
	.uleb128 0x9
	.long	0x2fe
	.long	0x65d
	.uleb128 0xa
	.long	0x15c
	.byte	0x6
	.byte	0
	.uleb128 0x14
	.long	0x25
	.uleb128 0x4
	.long	.LASF15
	.byte	0x7c
	.byte	0x5
	.byte	0x37
	.long	0x723
	.uleb128 0x6
	.string	"sz"
	.byte	0x5
	.byte	0x38
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF62
	.byte	0x5
	.byte	0x39
	.long	0x75a
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF63
	.byte	0x5
	.byte	0x3a
	.long	0xab
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF64
	.byte	0x5
	.byte	0x3b
	.long	0x729
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.string	"pid"
	.byte	0x5
	.byte	0x3c
	.long	0x203
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x5
	.long	.LASF65
	.byte	0x5
	.byte	0x3d
	.long	0x723
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x6
	.string	"tf"
	.byte	0x5
	.byte	0x3e
	.long	0x8c5
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x5
	.long	.LASF61
	.byte	0x5
	.byte	0x3f
	.long	0x647
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x5
	.long	.LASF66
	.byte	0x5
	.byte	0x40
	.long	0x5f2
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x5
	.long	.LASF67
	.byte	0x5
	.byte	0x41
	.long	0x203
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x5
	.long	.LASF68
	.byte	0x5
	.byte	0x42
	.long	0x8cb
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x6
	.string	"cwd"
	.byte	0x5
	.byte	0x43
	.long	0x2af
	.byte	0x2
	.byte	0x23
	.uleb128 0x68
	.uleb128 0x5
	.long	.LASF8
	.byte	0x5
	.byte	0x44
	.long	0x8e1
	.byte	0x2
	.byte	0x23
	.uleb128 0x6c
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x662
	.uleb128 0x15
	.long	.LASF117
	.byte	0x4
	.byte	0x5
	.byte	0x34
	.long	0x75a
	.uleb128 0xc
	.long	.LASF69
	.sleb128 0
	.uleb128 0xc
	.long	.LASF70
	.sleb128 1
	.uleb128 0xc
	.long	.LASF71
	.sleb128 2
	.uleb128 0xc
	.long	.LASF72
	.sleb128 3
	.uleb128 0xc
	.long	.LASF73
	.sleb128 4
	.uleb128 0xc
	.long	.LASF74
	.sleb128 5
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x5b
	.uleb128 0x4
	.long	.LASF75
	.byte	0x4c
	.byte	0x1
	.byte	0x9c
	.long	0x8c5
	.uleb128 0x6
	.string	"edi"
	.byte	0x1
	.byte	0x9e
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.string	"esi"
	.byte	0x1
	.byte	0x9f
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.string	"ebp"
	.byte	0x1
	.byte	0xa0
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF76
	.byte	0x1
	.byte	0xa1
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.string	"ebx"
	.byte	0x1
	.byte	0xa2
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x6
	.string	"edx"
	.byte	0x1
	.byte	0xa3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x6
	.string	"ecx"
	.byte	0x1
	.byte	0xa4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x6
	.string	"eax"
	.byte	0x1
	.byte	0xa5
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x6
	.string	"gs"
	.byte	0x1
	.byte	0xa8
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x5
	.long	.LASF47
	.byte	0x1
	.byte	0xa9
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x22
	.uleb128 0x6
	.string	"fs"
	.byte	0x1
	.byte	0xaa
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x5
	.long	.LASF49
	.byte	0x1
	.byte	0xab
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x26
	.uleb128 0x6
	.string	"es"
	.byte	0x1
	.byte	0xac
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x5
	.long	.LASF51
	.byte	0x1
	.byte	0xad
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x2a
	.uleb128 0x6
	.string	"ds"
	.byte	0x1
	.byte	0xae
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.uleb128 0x5
	.long	.LASF53
	.byte	0x1
	.byte	0xaf
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x2e
	.uleb128 0x5
	.long	.LASF77
	.byte	0x1
	.byte	0xb0
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x6
	.string	"err"
	.byte	0x1
	.byte	0xb3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0x6
	.string	"eip"
	.byte	0x1
	.byte	0xb4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x6
	.string	"cs"
	.byte	0x1
	.byte	0xb5
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x3c
	.uleb128 0x5
	.long	.LASF54
	.byte	0x1
	.byte	0xb6
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x3e
	.uleb128 0x5
	.long	.LASF52
	.byte	0x1
	.byte	0xb7
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0x6
	.string	"esp"
	.byte	0x1
	.byte	0xba
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x44
	.uleb128 0x6
	.string	"ss"
	.byte	0x1
	.byte	0xbb
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x5
	.long	.LASF55
	.byte	0x1
	.byte	0xbc
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x4a
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x760
	.uleb128 0x9
	.long	0x8db
	.long	0x8db
	.uleb128 0xa
	.long	0x15c
	.byte	0xf
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x195
	.uleb128 0x9
	.long	0xb1
	.long	0x8f1
	.uleb128 0xa
	.long	0x15c
	.byte	0xf
	.byte	0
	.uleb128 0x16
	.byte	0x38
	.byte	0x2
	.byte	0x15
	.long	0x916
	.uleb128 0x5
	.long	.LASF78
	.byte	0x2
	.byte	0x16
	.long	0x66
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF79
	.byte	0x2
	.byte	0x17
	.long	0x203
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x16
	.byte	0x8c
	.byte	0x2
	.byte	0xb4
	.long	0x954
	.uleb128 0x6
	.string	"buf"
	.byte	0x2
	.byte	0xb5
	.long	0x954
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.string	"r"
	.byte	0x2
	.byte	0xb6
	.long	0x25
	.byte	0x3
	.byte	0x23
	.uleb128 0x80
	.uleb128 0x6
	.string	"w"
	.byte	0x2
	.byte	0xb7
	.long	0x25
	.byte	0x3
	.byte	0x23
	.uleb128 0x84
	.uleb128 0x6
	.string	"e"
	.byte	0x2
	.byte	0xb8
	.long	0x25
	.byte	0x3
	.byte	0x23
	.uleb128 0x88
	.byte	0
	.uleb128 0x9
	.long	0xb1
	.long	0x964
	.uleb128 0xa
	.long	0x15c
	.byte	0x7f
	.byte	0
	.uleb128 0x17
	.string	"inb"
	.byte	0x1
	.byte	0x4
	.byte	0x1
	.long	0x49
	.long	.LFB2
	.long	.LFE2
	.long	.LLST0
	.byte	0x1
	.long	0x99d
	.uleb128 0x18
	.long	.LASF80
	.byte	0x1
	.byte	0x4
	.long	0x37
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.long	.LASF81
	.byte	0x1
	.byte	0x6
	.long	0x49
	.byte	0x1
	.byte	0x50
	.byte	0
	.uleb128 0x1a
	.long	.LASF82
	.byte	0x1
	.byte	0x16
	.byte	0x1
	.long	.LFB4
	.long	.LFE4
	.long	.LLST1
	.byte	0x1
	.long	0x9d3
	.uleb128 0x18
	.long	.LASF80
	.byte	0x1
	.byte	0x16
	.long	0x37
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.long	.LASF81
	.byte	0x1
	.byte	0x16
	.long	0x49
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0x1b
	.string	"cli"
	.byte	0x1
	.byte	0x6d
	.byte	0x1
	.long	.LFB14
	.long	.LFE14
	.long	.LLST2
	.byte	0x1
	.uleb128 0x1a
	.long	.LASF83
	.byte	0x2
	.byte	0x1b
	.byte	0x1
	.long	.LFB20
	.long	.LFE20
	.long	.LLST3
	.byte	0x1
	.long	0xa6d
	.uleb128 0x1c
	.string	"xx"
	.byte	0x2
	.byte	0x1b
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.long	.LASF84
	.byte	0x2
	.byte	0x1b
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x1d
	.long	.LASF85
	.byte	0x2
	.byte	0x1b
	.long	0x203
	.long	.LLST4
	.uleb128 0x19
	.long	.LASF86
	.byte	0x2
	.byte	0x1d
	.long	0xa6d
	.byte	0x5
	.byte	0x3
	.long	digits.1508
	.uleb128 0x1e
	.string	"buf"
	.byte	0x2
	.byte	0x1e
	.long	0x8e1
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1e
	.string	"i"
	.byte	0x2
	.byte	0x1f
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1f
	.string	"x"
	.byte	0x2
	.byte	0x20
	.long	0x25
	.long	.LLST5
	.uleb128 0x20
	.long	.LVL12
	.long	0xdd8
	.byte	0
	.uleb128 0x9
	.long	0xb1
	.long	0xa7d
	.uleb128 0xa
	.long	0x15c
	.byte	0x10
	.byte	0
	.uleb128 0x21
	.byte	0x1
	.long	.LASF88
	.byte	0x2
	.byte	0x36
	.byte	0x1
	.long	.LFB21
	.long	.LFE21
	.long	.LLST6
	.byte	0x1
	.long	0xbc4
	.uleb128 0x1c
	.string	"fmt"
	.byte	0x2
	.byte	0x36
	.long	0xab
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1e
	.string	"i"
	.byte	0x2
	.byte	0x38
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1f
	.string	"c"
	.byte	0x2
	.byte	0x38
	.long	0x203
	.long	.LLST7
	.uleb128 0x23
	.long	.LASF79
	.byte	0x2
	.byte	0x38
	.long	0x203
	.long	.LLST8
	.uleb128 0x23
	.long	.LASF87
	.byte	0x2
	.byte	0x39
	.long	0x5ec
	.long	.LLST9
	.uleb128 0x1f
	.string	"s"
	.byte	0x2
	.byte	0x3a
	.long	0xab
	.long	.LLST10
	.uleb128 0x24
	.long	.LVL15
	.long	0x120a
	.long	0xb02
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x24
	.long	.LVL16
	.long	0xbc4
	.long	0xb1a
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC0
	.byte	0
	.uleb128 0x24
	.long	.LVL21
	.long	0xdd8
	.long	0xb30
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -36
	.byte	0x6
	.byte	0
	.uleb128 0x24
	.long	.LVL26
	.long	0x9e8
	.long	0xb4a
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x3a
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x31
	.byte	0
	.uleb128 0x24
	.long	.LVL29
	.long	0x9e8
	.long	0xb66
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x40
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0
	.uleb128 0x20
	.long	.LVL35
	.long	0xdd8
	.uleb128 0x24
	.long	.LVL37
	.long	0xdd8
	.long	0xb84
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x8
	.byte	0x25
	.byte	0
	.uleb128 0x24
	.long	.LVL39
	.long	0xdd8
	.long	0xb99
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x8
	.byte	0x25
	.byte	0
	.uleb128 0x24
	.long	.LVL40
	.long	0xdd8
	.long	0xbaf
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -36
	.byte	0x6
	.byte	0
	.uleb128 0x26
	.long	.LVL43
	.long	0x1224
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.byte	0
	.uleb128 0x21
	.byte	0x1
	.long	.LASF89
	.byte	0x2
	.byte	0x6a
	.byte	0x1
	.long	.LFB22
	.long	.LFE22
	.long	.LLST11
	.byte	0x1
	.long	0xc77
	.uleb128 0x1c
	.string	"s"
	.byte	0x2
	.byte	0x6a
	.long	0xab
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.string	"i"
	.byte	0x2
	.byte	0x6c
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.string	"pcs"
	.byte	0x2
	.byte	0x6d
	.long	0x14c
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x20
	.long	.LVL45
	.long	0x9d3
	.uleb128 0x24
	.long	.LVL46
	.long	0xa7d
	.long	0xc25
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC2
	.byte	0
	.uleb128 0x20
	.long	.LVL47
	.long	0xa7d
	.uleb128 0x24
	.long	.LVL48
	.long	0xa7d
	.long	0xc46
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC3
	.byte	0
	.uleb128 0x24
	.long	.LVL49
	.long	0x1238
	.long	0xc62
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.byte	0
	.uleb128 0x26
	.long	.LVL51
	.long	0xa7d
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	.LASF90
	.byte	0x2
	.byte	0x82
	.byte	0x1
	.long	.LFB23
	.long	.LFE23
	.long	.LLST12
	.byte	0x1
	.long	0xdd8
	.uleb128 0x1c
	.string	"c"
	.byte	0x2
	.byte	0x82
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.string	"pos"
	.byte	0x2
	.byte	0x84
	.long	0x203
	.long	.LLST13
	.uleb128 0x24
	.long	.LVL53
	.long	0x99d
	.long	0xcc7
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d4
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x3e
	.byte	0
	.uleb128 0x24
	.long	.LVL54
	.long	0x964
	.long	0xcdd
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d5
	.byte	0
	.uleb128 0x24
	.long	.LVL56
	.long	0x99d
	.long	0xcf9
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d4
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x3f
	.byte	0
	.uleb128 0x24
	.long	.LVL57
	.long	0x964
	.long	0xd0f
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d5
	.byte	0
	.uleb128 0x24
	.long	.LVL58
	.long	0xbc4
	.long	0xd27
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC5
	.byte	0
	.uleb128 0x24
	.long	.LVL59
	.long	0x1251
	.long	0xd3d
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0xa
	.value	0xe60
	.byte	0
	.uleb128 0x24
	.long	.LVL60
	.long	0x127a
	.long	0xd5f
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x9
	.byte	0xa
	.value	0x780
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0x1c
	.byte	0x31
	.byte	0x24
	.byte	0
	.uleb128 0x24
	.long	.LVL61
	.long	0x99d
	.long	0xd7b
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d4
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x3e
	.byte	0
	.uleb128 0x24
	.long	.LVL62
	.long	0x99d
	.long	0xd9d
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d5
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x7
	.byte	0x91
	.sleb128 -19
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0
	.uleb128 0x24
	.long	.LVL63
	.long	0x99d
	.long	0xdb9
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d4
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x3f
	.byte	0
	.uleb128 0x26
	.long	.LVL64
	.long	0x99d
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x3d5
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x7
	.byte	0x91
	.sleb128 -20
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	.LASF91
	.byte	0x2
	.byte	0xa4
	.byte	0x1
	.long	.LFB24
	.long	.LFE24
	.long	.LLST14
	.byte	0x1
	.long	0xe6c
	.uleb128 0x1c
	.string	"c"
	.byte	0x2
	.byte	0xa4
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.long	.LVL66
	.long	0x9d3
	.uleb128 0x24
	.long	.LVL67
	.long	0x129c
	.long	0xe1a
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x38
	.byte	0
	.uleb128 0x24
	.long	.LVL68
	.long	0x129c
	.long	0xe2f
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x8
	.byte	0x20
	.byte	0
	.uleb128 0x24
	.long	.LVL69
	.long	0x129c
	.long	0xe43
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x38
	.byte	0
	.uleb128 0x24
	.long	.LVL70
	.long	0x129c
	.long	0xe59
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x26
	.long	.LVL71
	.long	0xc77
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x21
	.byte	0x1
	.long	.LASF92
	.byte	0x2
	.byte	0xbe
	.byte	0x1
	.long	.LFB25
	.long	.LFE25
	.long	.LLST15
	.byte	0x1
	.long	0xf4c
	.uleb128 0x18
	.long	.LASF93
	.byte	0x2
	.byte	0xbe
	.long	0xf52
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.string	"c"
	.byte	0x2
	.byte	0xc0
	.long	0x203
	.long	.LLST16
	.uleb128 0x19
	.long	.LASF94
	.byte	0x2
	.byte	0xc0
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x24
	.long	.LVL74
	.long	0x120a
	.long	0xec7
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x24
	.long	.LVL77
	.long	0xdd8
	.long	0xedd
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x100
	.byte	0
	.uleb128 0x24
	.long	.LVL78
	.long	0xdd8
	.long	0xef3
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0xa
	.value	0x100
	.byte	0
	.uleb128 0x24
	.long	.LVL81
	.long	0xdd8
	.long	0xf09
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.uleb128 0x24
	.long	.LVL82
	.long	0x12b0
	.long	0xf21
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	input+128
	.byte	0
	.uleb128 0x27
	.long	.LVL84
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x24
	.long	.LVL86
	.long	0x1224
	.long	0xf42
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x20
	.long	.LVL87
	.long	0x12c4
	.byte	0
	.uleb128 0x28
	.byte	0x1
	.long	0x203
	.uleb128 0x7
	.byte	0x4
	.long	0xf4c
	.uleb128 0x29
	.byte	0x1
	.long	.LASF96
	.byte	0x2
	.byte	0xe9
	.byte	0x1
	.long	0x203
	.long	.LFB26
	.long	.LFE26
	.long	.LLST17
	.byte	0x1
	.long	0x1064
	.uleb128 0x1c
	.string	"ip"
	.byte	0x2
	.byte	0xe9
	.long	0x2af
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x2a
	.string	"dst"
	.byte	0x2
	.byte	0xe9
	.long	0xab
	.long	.LLST18
	.uleb128 0x2a
	.string	"n"
	.byte	0x2
	.byte	0xe9
	.long	0x203
	.long	.LLST19
	.uleb128 0x23
	.long	.LASF95
	.byte	0x2
	.byte	0xeb
	.long	0x25
	.long	.LLST20
	.uleb128 0x1f
	.string	"c"
	.byte	0x2
	.byte	0xec
	.long	0x203
	.long	.LLST21
	.uleb128 0x24
	.long	.LVL89
	.long	0x12ce
	.long	0xfd1
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x24
	.long	.LVL91
	.long	0x120a
	.long	0xfe9
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x24
	.long	.LVL92
	.long	0x1224
	.long	0x1001
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x24
	.long	.LVL93
	.long	0x12e2
	.long	0x1017
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x24
	.long	.LVL94
	.long	0x12f6
	.long	0x1039
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	input+128
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x24
	.long	.LVL101
	.long	0x1224
	.long	0x1051
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x26
	.long	.LVL102
	.long	0x12e2
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x2b
	.byte	0x1
	.long	.LASF97
	.byte	0x2
	.value	0x10f
	.byte	0x1
	.long	0x203
	.long	.LFB27
	.long	.LFE27
	.long	.LLST22
	.byte	0x1
	.long	0x111d
	.uleb128 0x2c
	.string	"ip"
	.byte	0x2
	.value	0x10f
	.long	0x2af
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x2c
	.string	"buf"
	.byte	0x2
	.value	0x10f
	.long	0xab
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x2c
	.string	"n"
	.byte	0x2
	.value	0x10f
	.long	0x203
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x2d
	.string	"i"
	.byte	0x2
	.value	0x111
	.long	0x203
	.long	.LLST23
	.uleb128 0x24
	.long	.LVL104
	.long	0x12ce
	.long	0x10d1
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x24
	.long	.LVL105
	.long	0x120a
	.long	0x10e9
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x20
	.long	.LVL109
	.long	0xdd8
	.uleb128 0x24
	.long	.LVL110
	.long	0x1224
	.long	0x110a
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.byte	0
	.uleb128 0x26
	.long	.LVL111
	.long	0x12e2
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x2e
	.byte	0x1
	.long	.LASF98
	.byte	0x2
	.value	0x11e
	.byte	0x1
	.long	.LFB28
	.long	.LFE28
	.long	.LLST24
	.byte	0x1
	.long	0x1185
	.uleb128 0x24
	.long	.LVL112
	.long	0x130f
	.long	0x115a
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	cons
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC6
	.byte	0
	.uleb128 0x24
	.long	.LVL113
	.long	0x1328
	.long	0x116e
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.byte	0
	.uleb128 0x26
	.long	.LVL114
	.long	0x133c
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.uleb128 0x25
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.byte	0
	.byte	0
	.uleb128 0x19
	.long	.LASF99
	.byte	0x2
	.byte	0x13
	.long	0x203
	.byte	0x5
	.byte	0x3
	.long	panicked
	.uleb128 0x19
	.long	.LASF100
	.byte	0x2
	.byte	0x18
	.long	0x8f1
	.byte	0x5
	.byte	0x3
	.long	cons
	.uleb128 0x1e
	.string	"crt"
	.byte	0x2
	.byte	0x7f
	.long	0x11b8
	.byte	0x5
	.byte	0x3
	.long	crt
	.uleb128 0x7
	.byte	0x4
	.long	0x37
	.uleb128 0x9
	.long	0x2b5
	.long	0x11c9
	.uleb128 0x2f
	.byte	0
	.uleb128 0x30
	.long	.LASF34
	.byte	0x6
	.byte	0x24
	.long	0x11be
	.byte	0x1
	.byte	0x1
	.uleb128 0x31
	.string	"cpu"
	.byte	0x5
	.byte	0x1e
	.long	.LASF118
	.long	0x146
	.byte	0x1
	.byte	0x1
	.uleb128 0x32
	.long	.LASF15
	.byte	0x5
	.byte	0x1f
	.long	.LASF119
	.long	0x723
	.byte	0x1
	.byte	0x1
	.uleb128 0x33
	.long	.LASF101
	.byte	0x2
	.byte	0xb9
	.long	0x916
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	input
	.uleb128 0x34
	.byte	0x1
	.long	.LASF102
	.byte	0x8
	.byte	0x7e
	.byte	0x1
	.byte	0x1
	.long	0x121e
	.uleb128 0x10
	.long	0x121e
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x66
	.uleb128 0x34
	.byte	0x1
	.long	.LASF103
	.byte	0x8
	.byte	0x82
	.byte	0x1
	.byte	0x1
	.long	0x1238
	.uleb128 0x10
	.long	0x121e
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF104
	.byte	0x8
	.byte	0x7f
	.byte	0x1
	.byte	0x1
	.long	0x1251
	.uleb128 0x10
	.long	0x5f2
	.uleb128 0x10
	.long	0x5ec
	.byte	0
	.uleb128 0x35
	.byte	0x1
	.long	.LASF105
	.byte	0x8
	.byte	0x88
	.byte	0x1
	.long	0x5f2
	.byte	0x1
	.long	0x1273
	.uleb128 0x10
	.long	0x5f2
	.uleb128 0x10
	.long	0x1273
	.uleb128 0x10
	.long	0x25
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x1279
	.uleb128 0x36
	.uleb128 0x35
	.byte	0x1
	.long	.LASF106
	.byte	0x8
	.byte	0x89
	.byte	0x1
	.long	0x5f2
	.byte	0x1
	.long	0x129c
	.uleb128 0x10
	.long	0x5f2
	.uleb128 0x10
	.long	0x203
	.uleb128 0x10
	.long	0x25
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF107
	.byte	0x8
	.byte	0xa4
	.byte	0x1
	.byte	0x1
	.long	0x12b0
	.uleb128 0x10
	.long	0x203
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF108
	.byte	0x8
	.byte	0x77
	.byte	0x1
	.byte	0x1
	.long	0x12c4
	.uleb128 0x10
	.long	0x5f2
	.byte	0
	.uleb128 0x37
	.byte	0x1
	.long	.LASF120
	.byte	0x8
	.byte	0x71
	.byte	0x1
	.byte	0x1
	.uleb128 0x34
	.byte	0x1
	.long	.LASF109
	.byte	0x8
	.byte	0x2d
	.byte	0x1
	.byte	0x1
	.long	0x12e2
	.uleb128 0x10
	.long	0x2af
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF110
	.byte	0x8
	.byte	0x2b
	.byte	0x1
	.byte	0x1
	.long	0x12f6
	.uleb128 0x10
	.long	0x2af
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF111
	.byte	0x8
	.byte	0x74
	.byte	0x1
	.byte	0x1
	.long	0x130f
	.uleb128 0x10
	.long	0x5f2
	.uleb128 0x10
	.long	0x121e
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF112
	.byte	0x8
	.byte	0x81
	.byte	0x1
	.byte	0x1
	.long	0x1328
	.uleb128 0x10
	.long	0x121e
	.uleb128 0x10
	.long	0xab
	.byte	0
	.uleb128 0x34
	.byte	0x1
	.long	.LASF113
	.byte	0x8
	.byte	0x60
	.byte	0x1
	.byte	0x1
	.long	0x133c
	.uleb128 0x10
	.long	0x203
	.byte	0
	.uleb128 0x38
	.byte	0x1
	.long	.LASF121
	.byte	0x8
	.byte	0x3d
	.byte	0x1
	.byte	0x1
	.uleb128 0x10
	.long	0x203
	.uleb128 0x10
	.long	0x203
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
	.uleb128 0x4
	.byte	0x1
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
	.uleb128 0xc
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x4
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
	.uleb128 0x16
	.uleb128 0x13
	.byte	0x1
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
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
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
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.uleb128 0x20
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
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
	.uleb128 0x22
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x23
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
	.uleb128 0x24
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
	.uleb128 0x25
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2113
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
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
	.uleb128 0x2a
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
	.uleb128 0x2b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x2c
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x2f
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x30
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x33
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x34
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
	.uleb128 0x35
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
	.uleb128 0x36
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x37
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
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x38
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
	.long	.LFB2-.Ltext0
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
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST1:
	.long	.LFB4-.Ltext0
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
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST2:
	.long	.LFB14-.Ltext0
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
	.long	.LFE14-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST3:
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
.LLST4:
	.long	.LVL3-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL4-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL5-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST5:
	.long	.LVL6-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL8-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL10-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL11-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST6:
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
.LLST7:
	.long	.LVL19-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL20-.Ltext0
	.long	.LVL22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL22-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL23-.Ltext0
	.long	.LVL24-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL24-.Ltext0
	.long	.LVL25-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL25-.Ltext0
	.long	.LVL27-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL27-.Ltext0
	.long	.LVL28-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL28-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL30-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL31-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL36-.Ltext0
	.long	.LVL37-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL37-1-.Ltext0
	.long	.LVL38-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL38-.Ltext0
	.long	.LVL39-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL39-1-.Ltext0
	.long	.LVL41-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	.LVL42-.Ltext0
	.long	.LVL43-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL43-1-.Ltext0
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	0
	.long	0
.LLST8:
	.long	.LVL14-.Ltext0
	.long	.LVL15-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL15-1-.Ltext0
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -32
	.long	0
	.long	0
.LLST9:
	.long	.LVL17-.Ltext0
	.long	.LVL19-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL19-.Ltext0
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST10:
	.long	.LVL32-.Ltext0
	.long	.LVL33-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL33-.Ltext0
	.long	.LVL34-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.long	.LVL34-.Ltext0
	.long	.LVL36-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	0
	.long	0
.LLST11:
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
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0
	.long	0
.LLST12:
	.long	.LFB23-.Ltext0
	.long	.LCFI17-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI17-.Ltext0
	.long	.LCFI18-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI18-.Ltext0
	.long	.LCFI19-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI19-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LVL55-.Ltext0
	.long	.LVL56-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL56-1-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST14:
	.long	.LFB24-.Ltext0
	.long	.LCFI20-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI20-.Ltext0
	.long	.LCFI21-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI21-.Ltext0
	.long	.LCFI22-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI22-.Ltext0
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST15:
	.long	.LFB25-.Ltext0
	.long	.LCFI23-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI23-.Ltext0
	.long	.LCFI24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI24-.Ltext0
	.long	.LCFI25-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI25-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST16:
	.long	.LVL75-.Ltext0
	.long	.LVL76-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL76-.Ltext0
	.long	.LVL79-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL79-.Ltext0
	.long	.LVL80-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL80-.Ltext0
	.long	.LVL83-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL85-.Ltext0
	.long	.LVL86-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL86-1-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST17:
	.long	.LFB26-.Ltext0
	.long	.LCFI26-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI26-.Ltext0
	.long	.LCFI27-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI27-.Ltext0
	.long	.LCFI28-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI28-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST18:
	.long	.LVL88-.Ltext0
	.long	.LVL97-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL97-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST19:
	.long	.LVL88-.Ltext0
	.long	.LVL97-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL97-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST20:
	.long	.LVL90-.Ltext0
	.long	.LVL91-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL91-1-.Ltext0
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST21:
	.long	.LVL95-.Ltext0
	.long	.LVL96-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL96-.Ltext0
	.long	.LVL97-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL98-.Ltext0
	.long	.LVL99-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL99-.Ltext0
	.long	.LVL100-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST22:
	.long	.LFB27-.Ltext0
	.long	.LCFI29-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI29-.Ltext0
	.long	.LCFI30-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI30-.Ltext0
	.long	.LCFI31-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI31-.Ltext0
	.long	.LFE27-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST23:
	.long	.LVL106-.Ltext0
	.long	.LVL107-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	.LVL107-.Ltext0
	.long	.LVL108-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL108-.Ltext0
	.long	.LFE27-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST24:
	.long	.LFB28-.Ltext0
	.long	.LCFI32-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI32-.Ltext0
	.long	.LCFI33-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI33-.Ltext0
	.long	.LCFI34-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI34-.Ltext0
	.long	.LFE28-.Ltext0
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
.LASF70:
	.string	"EMBRYO"
.LASF11:
	.string	"scheduler"
.LASF98:
	.string	"consoleinit"
.LASF42:
	.string	"rsv1"
.LASF22:
	.string	"type"
.LASF38:
	.string	"lim_15_0"
.LASF12:
	.string	"started"
.LASF48:
	.string	"esp1"
.LASF50:
	.string	"esp2"
.LASF25:
	.string	"pipe"
.LASF81:
	.string	"data"
.LASF71:
	.string	"SLEEPING"
.LASF103:
	.string	"release"
.LASF116:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF10:
	.string	"spinlock"
.LASF65:
	.string	"parent"
.LASF64:
	.string	"state"
.LASF97:
	.string	"consolewrite"
.LASF100:
	.string	"cons"
.LASF34:
	.string	"devsw"
.LASF117:
	.string	"procstate"
.LASF18:
	.string	"FD_NONE"
.LASF20:
	.string	"FD_INODE"
.LASF43:
	.string	"base_31_24"
.LASF45:
	.string	"link"
.LASF118:
	.string	"%gs:0"
.LASF89:
	.string	"panic"
.LASF119:
	.string	"%gs:4"
.LASF6:
	.string	"pde_t"
.LASF80:
	.string	"port"
.LASF2:
	.string	"unsigned int"
.LASF108:
	.string	"wakeup"
.LASF93:
	.string	"getc"
.LASF15:
	.string	"proc"
.LASF30:
	.string	"minor"
.LASF76:
	.string	"oesp"
.LASF19:
	.string	"FD_PIPE"
.LASF102:
	.string	"acquire"
.LASF121:
	.string	"ioapicenable"
.LASF8:
	.string	"name"
.LASF23:
	.string	"readable"
.LASF72:
	.string	"RUNNABLE"
.LASF60:
	.string	"iomb"
.LASF32:
	.string	"size"
.LASF3:
	.string	"short unsigned int"
.LASF111:
	.string	"sleep"
.LASF46:
	.string	"esp0"
.LASF31:
	.string	"nlink"
.LASF68:
	.string	"ofile"
.LASF104:
	.string	"getcallerpcs"
.LASF39:
	.string	"base_15_0"
.LASF95:
	.string	"target"
.LASF62:
	.string	"pgdir"
.LASF69:
	.string	"UNUSED"
.LASF47:
	.string	"padding1"
.LASF36:
	.string	"write"
.LASF53:
	.string	"padding4"
.LASF54:
	.string	"padding5"
.LASF55:
	.string	"padding6"
.LASF56:
	.string	"padding7"
.LASF57:
	.string	"padding8"
.LASF58:
	.string	"padding9"
.LASF75:
	.string	"trapframe"
.LASF16:
	.string	"sizetype"
.LASF77:
	.string	"trapno"
.LASF74:
	.string	"ZOMBIE"
.LASF1:
	.string	"ushort"
.LASF109:
	.string	"iunlock"
.LASF52:
	.string	"eflags"
.LASF7:
	.string	"locked"
.LASF33:
	.string	"addrs"
.LASF82:
	.string	"outb"
.LASF114:
	.string	"GNU C 4.7.2"
.LASF44:
	.string	"taskstate"
.LASF4:
	.string	"uchar"
.LASF96:
	.string	"consoleread"
.LASF94:
	.string	"doprocdump"
.LASF88:
	.string	"cprintf"
.LASF0:
	.string	"uint"
.LASF26:
	.string	"inode"
.LASF49:
	.string	"padding2"
.LASF63:
	.string	"kstack"
.LASF51:
	.string	"padding3"
.LASF84:
	.string	"base"
.LASF112:
	.string	"initlock"
.LASF113:
	.string	"picenable"
.LASF27:
	.string	"inum"
.LASF41:
	.string	"lim_19_16"
.LASF5:
	.string	"unsigned char"
.LASF120:
	.string	"procdump"
.LASF17:
	.string	"short int"
.LASF21:
	.string	"file"
.LASF14:
	.string	"intena"
.LASF40:
	.string	"base_23_16"
.LASF73:
	.string	"RUNNING"
.LASF107:
	.string	"uartputc"
.LASF101:
	.string	"input"
.LASF110:
	.string	"ilock"
.LASF99:
	.string	"panicked"
.LASF66:
	.string	"chan"
.LASF90:
	.string	"cgaputc"
.LASF9:
	.string	"char"
.LASF83:
	.string	"printint"
.LASF92:
	.string	"consoleintr"
.LASF24:
	.string	"writable"
.LASF86:
	.string	"digits"
.LASF61:
	.string	"context"
.LASF115:
	.string	"console.c"
.LASF79:
	.string	"locking"
.LASF59:
	.string	"padding10"
.LASF106:
	.string	"memset"
.LASF13:
	.string	"ncli"
.LASF105:
	.string	"memmove"
.LASF85:
	.string	"sign"
.LASF37:
	.string	"segdesc"
.LASF28:
	.string	"flags"
.LASF35:
	.string	"read"
.LASF91:
	.string	"consputc"
.LASF29:
	.string	"major"
.LASF67:
	.string	"killed"
.LASF87:
	.string	"argp"
.LASF78:
	.string	"lock"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
