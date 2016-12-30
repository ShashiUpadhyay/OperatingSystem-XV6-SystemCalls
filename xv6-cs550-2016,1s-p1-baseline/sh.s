	.file	"sh.c"
	.text
.Ltext0:
	.section	.rodata
.LC0:
	.string	"runcmd"
.LC1:
	.string	"exec %s failed\n"
.LC2:
	.string	"open %s failed\n"
.LC3:
	.string	"pipe"
	.text
	.globl	runcmd
	.type	runcmd, @function
runcmd:
.LFB0:
	.file 1 "sh.c"
	.loc 1 59 0
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
	.loc 1 67 0
	cmpl	$0, 8(%ebp)
	jne	.L2
	.loc 1 68 0
	call	exit
.LVL1:
.L2:
	.loc 1 70 0
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$5, %eax
	ja	.L3
	movl	.L9(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L9:
	.long	.L3
	.long	.L4
	.long	.L5
	.long	.L6
	.long	.L7
	.long	.L8
	.text
.L3:
	.loc 1 72 0
	movl	$.LC0, (%esp)
	call	panic
.LVL2:
.L4:
	.loc 1 75 0
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
.LVL3:
	.loc 1 76 0
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
.LVL4:
	testl	%eax, %eax
	jne	.L10
	.loc 1 77 0
	call	exit
.LVL5:
.L10:
	.loc 1 78 0
	movl	-12(%ebp), %eax
	leal	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	exec
.LVL6:
	.loc 1 79 0
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 8(%esp)
	movl	$.LC1, 4(%esp)
	movl	$2, (%esp)
	call	printf
.LVL7:
	.loc 1 80 0
	jmp	.L11
.LVL8:
.L5:
	.loc 1 83 0
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
.LVL9:
	.loc 1 84 0
	movl	-16(%ebp), %eax
	movl	20(%eax), %eax
.LVL10:
	movl	%eax, (%esp)
	call	close
.LVL11:
	.loc 1 85 0
	movl	-16(%ebp), %eax
	movl	16(%eax), %edx
	movl	-16(%ebp), %eax
	movl	8(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	open
.LVL12:
	testl	%eax, %eax
	jns	.L12
	.loc 1 86 0
	movl	-16(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, 8(%esp)
	movl	$.LC2, 4(%esp)
	movl	$2, (%esp)
	call	printf
.LVL13:
	.loc 1 87 0
	call	exit
.LVL14:
.L12:
	.loc 1 89 0
	movl	-16(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	runcmd
.LVL15:
	.loc 1 90 0
	jmp	.L11
.LVL16:
.L7:
	.loc 1 93 0
	movl	8(%ebp), %eax
	movl	%eax, -20(%ebp)
.LVL17:
	.loc 1 94 0
	call	fork1
.LVL18:
	testl	%eax, %eax
	jne	.L13
	.loc 1 95 0
	movl	-20(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	runcmd
.LVL19:
.L13:
	.loc 1 96 0
	call	wait
.LVL20:
	.loc 1 97 0
	movl	-20(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, (%esp)
	call	runcmd
.LVL21:
	.loc 1 98 0
	jmp	.L11
.LVL22:
.L6:
	.loc 1 101 0
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
.LVL23:
	.loc 1 102 0
	leal	-36(%ebp), %eax
.LVL24:
	movl	%eax, (%esp)
	call	pipe
.LVL25:
	testl	%eax, %eax
	jns	.L14
	.loc 1 103 0
	movl	$.LC3, (%esp)
	call	panic
.LVL26:
.L14:
	.loc 1 104 0
	call	fork1
.LVL27:
	testl	%eax, %eax
	jne	.L15
	.loc 1 105 0
	movl	$1, (%esp)
	call	close
.LVL28:
	.loc 1 106 0
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	dup
.LVL29:
	.loc 1 107 0
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	close
.LVL30:
	.loc 1 108 0
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	close
.LVL31:
	.loc 1 109 0
	movl	-24(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	runcmd
.LVL32:
.L15:
	.loc 1 111 0
	call	fork1
.LVL33:
	testl	%eax, %eax
	jne	.L16
	.loc 1 112 0
	movl	$0, (%esp)
	call	close
.LVL34:
	.loc 1 113 0
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	dup
.LVL35:
	.loc 1 114 0
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	close
.LVL36:
	.loc 1 115 0
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	close
.LVL37:
	.loc 1 116 0
	movl	-24(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, (%esp)
	call	runcmd
.LVL38:
.L16:
	.loc 1 118 0
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	close
.LVL39:
	.loc 1 119 0
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	close
.LVL40:
	.loc 1 120 0
	call	wait
.LVL41:
	.loc 1 121 0
	call	wait
.LVL42:
	.loc 1 122 0
	jmp	.L11
.LVL43:
.L8:
	.loc 1 125 0
	movl	8(%ebp), %eax
	movl	%eax, -28(%ebp)
.LVL44:
	.loc 1 126 0
	call	fork1
.LVL45:
	testl	%eax, %eax
	jne	.L18
	.loc 1 127 0
	movl	-28(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	runcmd
.LVL46:
.L18:
	.loc 1 128 0
	nop
.LVL47:
.L11:
	.loc 1 130 0
	call	exit
.LVL48:
	.cfi_endproc
.LFE0:
	.size	runcmd, .-runcmd
	.section	.rodata
.LC4:
	.string	"$ "
	.text
	.globl	getcmd
	.type	getcmd, @function
getcmd:
.LFB1:
	.loc 1 135 0
	.cfi_startproc
.LVL49:
	pushl	%ebp
.LCFI2:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI3:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 1 136 0
	movl	$.LC4, 4(%esp)
	movl	$2, (%esp)
	call	printf
.LVL50:
	.loc 1 137 0
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	memset
.LVL51:
	.loc 1 138 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gets
.LVL52:
	.loc 1 139 0
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L20
	.loc 1 140 0
	movl	$-1, %eax
	jmp	.L21
.L20:
	.loc 1 141 0
	movl	$0, %eax
.L21:
	.loc 1 142 0
	leave
.LCFI4:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	getcmd, .-getcmd
	.section	.rodata
.LC5:
	.string	"console"
.LC6:
	.string	"cannot cd %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.loc 1 146 0
	.cfi_startproc
	pushl	%ebp
.LCFI5:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI6:
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$32, %esp
	.loc 1 151 0
	jmp	.L23
.LVL53:
.L25:
	.loc 1 152 0
	cmpl	$2, 28(%esp)
	jle	.L23
	.loc 1 153 0
	movl	28(%esp), %eax
.LVL54:
	movl	%eax, (%esp)
	call	close
.LVL55:
	.loc 1 154 0
	nop
	.loc 1 159 0
	jmp	.L26
.LVL56:
.L23:
	.loc 1 151 0 discriminator 1
	movl	$2, 4(%esp)
	movl	$.LC5, (%esp)
	call	open
.LVL57:
	movl	%eax, 28(%esp)
.LVL58:
	cmpl	$0, 28(%esp)
	jns	.L25
	.loc 1 159 0
	jmp	.L26
.LVL59:
.L30:
	.loc 1 160 0
	movzbl	buf.1055, %eax
	cmpb	$99, %al
	jne	.L27
	.loc 1 160 0 is_stmt 0 discriminator 1
	movzbl	buf.1055+1, %eax
	cmpb	$100, %al
	jne	.L27
	movzbl	buf.1055+2, %eax
	cmpb	$32, %al
	jne	.L27
	.loc 1 163 0 is_stmt 1
	movl	$buf.1055, (%esp)
	call	strlen
.LVL60:
	subl	$1, %eax
	movb	$0, buf.1055(%eax)
	.loc 1 164 0
	movl	$buf.1055+3, (%esp)
	call	chdir
.LVL61:
	testl	%eax, %eax
	jns	.L31
	.loc 1 165 0
	movl	$buf.1055+3, 8(%esp)
	movl	$.LC6, 4(%esp)
	movl	$2, (%esp)
	call	printf
.LVL62:
	.loc 1 166 0
	jmp	.L31
.L27:
	.loc 1 168 0
	call	fork1
.LVL63:
	testl	%eax, %eax
	jne	.L29
	.loc 1 169 0
	movl	$buf.1055, (%esp)
	call	parsecmd
.LVL64:
	movl	%eax, (%esp)
	call	runcmd
.LVL65:
.L29:
	.loc 1 170 0
	call	wait
.LVL66:
	jmp	.L26
.L31:
	.loc 1 166 0
	nop
.L26:
	.loc 1 159 0 discriminator 1
	movl	$100, 4(%esp)
	movl	$buf.1055, (%esp)
	call	getcmd
.LVL67:
	testl	%eax, %eax
	jns	.L30
	.loc 1 172 0
	call	exit
.LVL68:
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
.LC7:
	.string	"%s\n"
	.text
	.globl	panic
	.type	panic, @function
panic:
.LFB3:
	.loc 1 177 0
	.cfi_startproc
.LVL69:
	pushl	%ebp
.LCFI7:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI8:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 1 178 0
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC7, 4(%esp)
	movl	$2, (%esp)
	call	printf
.LVL70:
	.loc 1 179 0
	call	exit
.LVL71:
	.cfi_endproc
.LFE3:
	.size	panic, .-panic
	.section	.rodata
.LC8:
	.string	"fork"
	.text
	.globl	fork1
	.type	fork1, @function
fork1:
.LFB4:
	.loc 1 184 0
	.cfi_startproc
	pushl	%ebp
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI10:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 187 0
	call	fork
.LVL72:
	movl	%eax, -12(%ebp)
.LVL73:
	.loc 1 188 0
	cmpl	$-1, -12(%ebp)
	jne	.L34
	.loc 1 189 0
	movl	$.LC8, (%esp)
	call	panic
.LVL74:
.L34:
	.loc 1 190 0
	movl	-12(%ebp), %eax
	.loc 1 191 0
	leave
.LCFI11:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	fork1, .-fork1
	.globl	execcmd
	.type	execcmd, @function
execcmd:
.LFB5:
	.loc 1 198 0
	.cfi_startproc
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI13:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 201 0
	movl	$84, (%esp)
	call	malloc
.LVL75:
	movl	%eax, -12(%ebp)
.LVL76:
	.loc 1 202 0
	movl	$84, 8(%esp)
	movl	$0, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	memset
.LVL77:
	.loc 1 203 0
	movl	-12(%ebp), %eax
	movl	$1, (%eax)
	.loc 1 204 0
	movl	-12(%ebp), %eax
	.loc 1 205 0
	leave
.LCFI14:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	execcmd, .-execcmd
	.globl	redircmd
	.type	redircmd, @function
redircmd:
.LFB6:
	.loc 1 209 0
	.cfi_startproc
.LVL78:
	pushl	%ebp
.LCFI15:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI16:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 212 0
	movl	$24, (%esp)
	call	malloc
.LVL79:
	movl	%eax, -12(%ebp)
.LVL80:
	.loc 1 213 0
	movl	$24, 8(%esp)
	movl	$0, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	memset
.LVL81:
	.loc 1 214 0
	movl	-12(%ebp), %eax
	movl	$2, (%eax)
	.loc 1 215 0
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%eax)
	.loc 1 216 0
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%eax)
	.loc 1 217 0
	movl	-12(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, 12(%eax)
	.loc 1 218 0
	movl	-12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	%edx, 16(%eax)
	.loc 1 219 0
	movl	-12(%ebp), %eax
	movl	24(%ebp), %edx
	movl	%edx, 20(%eax)
	.loc 1 220 0
	movl	-12(%ebp), %eax
	.loc 1 221 0
	leave
.LCFI17:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	redircmd, .-redircmd
	.globl	pipecmd
	.type	pipecmd, @function
pipecmd:
.LFB7:
	.loc 1 225 0
	.cfi_startproc
.LVL82:
	pushl	%ebp
.LCFI18:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI19:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 228 0
	movl	$12, (%esp)
	call	malloc
.LVL83:
	movl	%eax, -12(%ebp)
.LVL84:
	.loc 1 229 0
	movl	$12, 8(%esp)
	movl	$0, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	memset
.LVL85:
	.loc 1 230 0
	movl	-12(%ebp), %eax
	movl	$3, (%eax)
	.loc 1 231 0
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%eax)
	.loc 1 232 0
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%eax)
	.loc 1 233 0
	movl	-12(%ebp), %eax
	.loc 1 234 0
	leave
.LCFI20:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	pipecmd, .-pipecmd
	.globl	listcmd
	.type	listcmd, @function
listcmd:
.LFB8:
	.loc 1 238 0
	.cfi_startproc
.LVL86:
	pushl	%ebp
.LCFI21:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI22:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 241 0
	movl	$12, (%esp)
	call	malloc
.LVL87:
	movl	%eax, -12(%ebp)
.LVL88:
	.loc 1 242 0
	movl	$12, 8(%esp)
	movl	$0, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	memset
.LVL89:
	.loc 1 243 0
	movl	-12(%ebp), %eax
	movl	$4, (%eax)
	.loc 1 244 0
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%eax)
	.loc 1 245 0
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%eax)
	.loc 1 246 0
	movl	-12(%ebp), %eax
	.loc 1 247 0
	leave
.LCFI23:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	listcmd, .-listcmd
	.globl	backcmd
	.type	backcmd, @function
backcmd:
.LFB9:
	.loc 1 251 0
	.cfi_startproc
.LVL90:
	pushl	%ebp
.LCFI24:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI25:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 254 0
	movl	$8, (%esp)
	call	malloc
.LVL91:
	movl	%eax, -12(%ebp)
.LVL92:
	.loc 1 255 0
	movl	$8, 8(%esp)
	movl	$0, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	memset
.LVL93:
	.loc 1 256 0
	movl	-12(%ebp), %eax
	movl	$5, (%eax)
	.loc 1 257 0
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%eax)
	.loc 1 258 0
	movl	-12(%ebp), %eax
	.loc 1 259 0
	leave
.LCFI26:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	backcmd, .-backcmd
	.globl	whitespace
	.data
	.type	whitespace, @object
	.size	whitespace, 6
whitespace:
	.string	" \t\r\n\013"
	.globl	symbols
	.type	symbols, @object
	.size	symbols, 8
symbols:
	.string	"<|>&;()"
	.text
	.globl	gettoken
	.type	gettoken, @function
gettoken:
.LFB10:
	.loc 1 268 0
	.cfi_startproc
.LVL94:
	pushl	%ebp
.LCFI27:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI28:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 272 0
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
.LVL95:
	.loc 1 273 0
	jmp	.L47
.LVL96:
.L49:
	.loc 1 274 0
	addl	$1, -12(%ebp)
.L47:
	.loc 1 273 0 discriminator 1
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	.L48
	.loc 1 273 0 is_stmt 0 discriminator 2
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$whitespace, (%esp)
	call	strchr
.LVL97:
	testl	%eax, %eax
	jne	.L49
.L48:
	.loc 1 275 0 is_stmt 1
	cmpl	$0, 16(%ebp)
	je	.L50
	.loc 1 276 0
	movl	16(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, (%eax)
.L50:
	.loc 1 277 0
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, -16(%ebp)
.LVL98:
	.loc 1 278 0
	movl	-12(%ebp), %eax
.LVL99:
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	$60, %eax
	jg	.L55
	cmpl	$59, %eax
	jge	.L53
	cmpl	$41, %eax
	jg	.L51
	cmpl	$40, %eax
	jge	.L53
	testl	%eax, %eax
	je	.L66
	cmpl	$38, %eax
	je	.L53
	jmp	.L51
.L55:
	cmpl	$62, %eax
	je	.L54
	cmpl	$124, %eax
	jne	.L51
.LVL100:
.L53:
	.loc 1 287 0
	addl	$1, -12(%ebp)
	.loc 1 288 0
	jmp	.L56
.L54:
	.loc 1 290 0
	addl	$1, -12(%ebp)
	.loc 1 291 0
	movl	-12(%ebp), %eax
.LVL101:
	movzbl	(%eax), %eax
	cmpb	$62, %al
	jne	.L67
	.loc 1 292 0
	movl	$43, -16(%ebp)
	.loc 1 293 0
	addl	$1, -12(%ebp)
	.loc 1 295 0
	jmp	.L67
.LVL102:
.L51:
	.loc 1 297 0
	movl	$97, -16(%ebp)
.LVL103:
	.loc 1 298 0
	jmp	.L58
.L60:
	.loc 1 299 0
	addl	$1, -12(%ebp)
.L58:
	.loc 1 298 0 discriminator 1
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	.L68
	.loc 1 298 0 is_stmt 0 discriminator 2
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$whitespace, (%esp)
	call	strchr
.LVL104:
	testl	%eax, %eax
	jne	.L68
	.loc 1 298 0 discriminator 1
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$symbols, (%esp)
	call	strchr
.LVL105:
	testl	%eax, %eax
	je	.L60
	.loc 1 300 0 is_stmt 1
	jmp	.L68
.LVL106:
.L66:
	.loc 1 280 0
	nop
	jmp	.L56
.LVL107:
.L67:
	.loc 1 295 0
	nop
	jmp	.L56
.L68:
	.loc 1 300 0
	nop
.L56:
	.loc 1 302 0
	cmpl	$0, 20(%ebp)
	je	.L62
	.loc 1 303 0
	movl	20(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, (%eax)
	.loc 1 305 0
	jmp	.L62
.L64:
	.loc 1 306 0
	addl	$1, -12(%ebp)
.L62:
	.loc 1 305 0 discriminator 1
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	.L63
	.loc 1 305 0 is_stmt 0 discriminator 2
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$whitespace, (%esp)
	call	strchr
.LVL108:
	testl	%eax, %eax
	jne	.L64
.L63:
	.loc 1 307 0 is_stmt 1
	movl	8(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, (%eax)
	.loc 1 308 0
	movl	-16(%ebp), %eax
	.loc 1 309 0
	leave
.LCFI29:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	gettoken, .-gettoken
	.globl	peek
	.type	peek, @function
peek:
.LFB11:
	.loc 1 313 0
	.cfi_startproc
.LVL109:
	pushl	%ebp
.LCFI30:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI31:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 316 0
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
.LVL110:
	.loc 1 317 0
	jmp	.L70
.LVL111:
.L72:
	.loc 1 318 0
	addl	$1, -12(%ebp)
.L70:
	.loc 1 317 0 discriminator 1
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	.L71
	.loc 1 317 0 is_stmt 0 discriminator 2
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$whitespace, (%esp)
	call	strchr
.LVL112:
	testl	%eax, %eax
	jne	.L72
.L71:
	.loc 1 319 0 is_stmt 1
	movl	8(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, (%eax)
	.loc 1 320 0
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	.L73
	.loc 1 320 0 is_stmt 0 discriminator 1
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	strchr
.LVL113:
	testl	%eax, %eax
	je	.L73
	.loc 1 320 0 discriminator 3
	movl	$1, %eax
	jmp	.L74
.L73:
	.loc 1 320 0 discriminator 2
	movl	$0, %eax
.L74:
	.loc 1 321 0 is_stmt 1 discriminator 4
	leave
.LCFI32:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE11:
	.size	peek, .-peek
	.section	.rodata
.LC9:
	.string	""
.LC10:
	.string	"leftovers: %s\n"
.LC11:
	.string	"syntax"
	.text
	.globl	parsecmd
	.type	parsecmd, @function
parsecmd:
.LFB12:
	.loc 1 330 0
	.cfi_startproc
.LVL114:
	pushl	%ebp
.LCFI33:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI34:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$36, %esp
	.cfi_offset 3, -12
	.loc 1 334 0
	movl	8(%ebp), %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
.LVL115:
	addl	%ebx, %eax
	movl	%eax, -12(%ebp)
.LVL116:
	.loc 1 335 0
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	8(%ebp), %eax
.LVL117:
	movl	%eax, (%esp)
	call	parseline
.LVL118:
	movl	%eax, -16(%ebp)
.LVL119:
	.loc 1 336 0
	movl	$.LC9, 8(%esp)
	movl	-12(%ebp), %eax
.LVL120:
	movl	%eax, 4(%esp)
	leal	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL121:
	.loc 1 337 0
	movl	8(%ebp), %eax
	cmpl	-12(%ebp), %eax
	je	.L77
	.loc 1 338 0
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC10, 4(%esp)
	movl	$2, (%esp)
	call	printf
.LVL122:
	.loc 1 339 0
	movl	$.LC11, (%esp)
	call	panic
.LVL123:
.L77:
	.loc 1 341 0
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	nulterminate
.LVL124:
	.loc 1 342 0
	movl	-16(%ebp), %eax
	.loc 1 343 0
	addl	$36, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
.LCFI35:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE12:
	.size	parsecmd, .-parsecmd
	.section	.rodata
.LC12:
	.string	"&"
.LC13:
	.string	";"
	.text
	.globl	parseline
	.type	parseline, @function
parseline:
.LFB13:
	.loc 1 347 0
	.cfi_startproc
.LVL125:
	pushl	%ebp
.LCFI36:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI37:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 350 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	parsepipe
.LVL126:
	movl	%eax, -12(%ebp)
.LVL127:
	.loc 1 351 0
	jmp	.L80
.LVL128:
.L81:
	.loc 1 352 0
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL129:
	.loc 1 353 0
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	backcmd
.LVL130:
	movl	%eax, -12(%ebp)
.LVL131:
.L80:
	.loc 1 351 0 discriminator 1
	movl	$.LC12, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL132:
	testl	%eax, %eax
	jne	.L81
	.loc 1 355 0
	movl	$.LC13, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL133:
	testl	%eax, %eax
	je	.L82
	.loc 1 356 0
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL134:
	.loc 1 357 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	parseline
.LVL135:
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	listcmd
.LVL136:
	movl	%eax, -12(%ebp)
.LVL137:
.L82:
	.loc 1 359 0
	movl	-12(%ebp), %eax
	.loc 1 360 0
	leave
.LCFI38:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE13:
	.size	parseline, .-parseline
	.section	.rodata
.LC14:
	.string	"|"
	.text
	.globl	parsepipe
	.type	parsepipe, @function
parsepipe:
.LFB14:
	.loc 1 364 0
	.cfi_startproc
.LVL138:
	pushl	%ebp
.LCFI39:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI40:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 367 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	parseexec
.LVL139:
	movl	%eax, -12(%ebp)
.LVL140:
	.loc 1 368 0
	movl	$.LC14, 8(%esp)
	movl	12(%ebp), %eax
.LVL141:
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL142:
	testl	%eax, %eax
	je	.L85
	.loc 1 369 0
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL143:
	.loc 1 370 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	parsepipe
.LVL144:
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	pipecmd
.LVL145:
	movl	%eax, -12(%ebp)
.LVL146:
.L85:
	.loc 1 372 0
	movl	-12(%ebp), %eax
	.loc 1 373 0
	leave
.LCFI41:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	parsepipe, .-parsepipe
	.section	.rodata
.LC15:
	.string	"missing file for redirection"
.LC16:
	.string	"<>"
	.text
	.globl	parseredirs
	.type	parseredirs, @function
parseredirs:
.LFB15:
	.loc 1 377 0
	.cfi_startproc
.LVL147:
	pushl	%ebp
.LCFI42:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI43:
	.cfi_def_cfa_register 5
	subl	$56, %esp
	.loc 1 381 0
	jmp	.L88
.LVL148:
.L93:
	.loc 1 382 0
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL149:
	movl	%eax, -12(%ebp)
.LVL150:
	.loc 1 383 0
	leal	-20(%ebp), %eax
.LVL151:
	movl	%eax, 12(%esp)
	leal	-16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL152:
	cmpl	$97, %eax
	je	.L89
	.loc 1 384 0
	movl	$.LC15, (%esp)
	call	panic
.LVL153:
.L89:
	.loc 1 385 0
	movl	-12(%ebp), %eax
	cmpl	$60, %eax
	je	.L91
	cmpl	$62, %eax
	je	.L92
	cmpl	$43, %eax
	je	.L90
	jmp	.L88
.L91:
	.loc 1 387 0
	movl	-20(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	$0, 16(%esp)
	movl	$0, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	redircmd
.LVL154:
	movl	%eax, 8(%ebp)
.LVL155:
	.loc 1 388 0
	jmp	.L88
.LVL156:
.L92:
	.loc 1 390 0
	movl	-20(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	$1, 16(%esp)
	movl	$513, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	redircmd
.LVL157:
	movl	%eax, 8(%ebp)
.LVL158:
	.loc 1 391 0
	jmp	.L88
.LVL159:
.L90:
	.loc 1 393 0
	movl	-20(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	$1, 16(%esp)
	movl	$513, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	redircmd
.LVL160:
	movl	%eax, 8(%ebp)
.LVL161:
	.loc 1 394 0
	nop
.LVL162:
.L88:
	.loc 1 381 0 discriminator 1
	movl	$.LC16, 8(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL163:
	testl	%eax, %eax
	jne	.L93
	.loc 1 397 0
	movl	8(%ebp), %eax
	.loc 1 398 0
	leave
.LCFI44:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE15:
	.size	parseredirs, .-parseredirs
	.section	.rodata
.LC17:
	.string	"("
.LC18:
	.string	"parseblock"
.LC19:
	.string	")"
.LC20:
	.string	"syntax - missing )"
	.text
	.globl	parseblock
	.type	parseblock, @function
parseblock:
.LFB16:
	.loc 1 402 0
	.cfi_startproc
.LVL164:
	pushl	%ebp
.LCFI45:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI46:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 405 0
	movl	$.LC17, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL165:
	testl	%eax, %eax
	jne	.L96
	.loc 1 406 0
	movl	$.LC18, (%esp)
	call	panic
.LVL166:
.L96:
	.loc 1 407 0
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL167:
	.loc 1 408 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	parseline
.LVL168:
	movl	%eax, -12(%ebp)
.LVL169:
	.loc 1 409 0
	movl	$.LC19, 8(%esp)
	movl	12(%ebp), %eax
.LVL170:
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL171:
	testl	%eax, %eax
	jne	.L97
	.loc 1 410 0
	movl	$.LC20, (%esp)
	call	panic
.LVL172:
.L97:
	.loc 1 411 0
	movl	$0, 12(%esp)
	movl	$0, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL173:
	.loc 1 412 0
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	parseredirs
.LVL174:
	movl	%eax, -12(%ebp)
.LVL175:
	.loc 1 413 0
	movl	-12(%ebp), %eax
	.loc 1 414 0
	leave
.LCFI47:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE16:
	.size	parseblock, .-parseblock
	.section	.rodata
.LC21:
	.string	"too many args"
.LC22:
	.string	"|)&;"
	.text
	.globl	parseexec
	.type	parseexec, @function
parseexec:
.LFB17:
	.loc 1 418 0
	.cfi_startproc
.LVL176:
	pushl	%ebp
.LCFI48:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI49:
	.cfi_def_cfa_register 5
	subl	$56, %esp
	.loc 1 424 0
	movl	$.LC17, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL177:
	testl	%eax, %eax
	je	.L100
	.loc 1 425 0
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	parseblock
.LVL178:
	jmp	.L108
.L100:
	.loc 1 427 0
	call	execcmd
.LVL179:
	movl	%eax, -16(%ebp)
.LVL180:
	.loc 1 428 0
	movl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
.LVL181:
	.loc 1 430 0
	movl	$0, -12(%ebp)
.LVL182:
	.loc 1 431 0
	movl	12(%ebp), %eax
.LVL183:
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	parseredirs
.LVL184:
	movl	%eax, -16(%ebp)
.LVL185:
	.loc 1 432 0
	jmp	.L102
.LVL186:
.L107:
	.loc 1 433 0
	leal	-32(%ebp), %eax
	movl	%eax, 12(%esp)
	leal	-28(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	gettoken
.LVL187:
	movl	%eax, -24(%ebp)
.LVL188:
	cmpl	$0, -24(%ebp)
	je	.L109
.L103:
	.loc 1 435 0
	cmpl	$97, -24(%ebp)
	je	.L105
	.loc 1 436 0
	movl	$.LC11, (%esp)
	call	panic
.LVL189:
.L105:
	.loc 1 437 0
	movl	-28(%ebp), %ecx
	movl	-20(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%ecx, 4(%eax,%edx,4)
	.loc 1 438 0
	movl	-32(%ebp), %edx
	movl	-20(%ebp), %eax
	movl	-12(%ebp), %ecx
	addl	$8, %ecx
	movl	%edx, 12(%eax,%ecx,4)
	.loc 1 439 0
	addl	$1, -12(%ebp)
	.loc 1 440 0
	cmpl	$9, -12(%ebp)
	jle	.L106
	.loc 1 441 0
	movl	$.LC21, (%esp)
	call	panic
.LVL190:
.L106:
	.loc 1 442 0
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	parseredirs
.LVL191:
	movl	%eax, -16(%ebp)
.LVL192:
.L102:
	.loc 1 432 0 discriminator 1
	movl	$.LC22, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	peek
.LVL193:
	testl	%eax, %eax
	je	.L107
	jmp	.L104
.LVL194:
.L109:
	.loc 1 434 0
	nop
.LVL195:
.L104:
	.loc 1 444 0
	movl	-20(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	$0, 4(%eax,%edx,4)
	.loc 1 445 0
	movl	-20(%ebp), %eax
	movl	-12(%ebp), %edx
	addl	$8, %edx
	movl	$0, 12(%eax,%edx,4)
	.loc 1 446 0
	movl	-16(%ebp), %eax
.LVL196:
.L108:
	.loc 1 447 0
	leave
.LCFI50:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE17:
	.size	parseexec, .-parseexec
	.globl	nulterminate
	.type	nulterminate, @function
nulterminate:
.LFB18:
	.loc 1 452 0
	.cfi_startproc
.LVL197:
	pushl	%ebp
.LCFI51:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI52:
	.cfi_def_cfa_register 5
	subl	$56, %esp
	.loc 1 460 0
	cmpl	$0, 8(%ebp)
	jne	.L111
	.loc 1 461 0
	movl	$0, %eax
	jmp	.L112
.L111:
	.loc 1 463 0
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$5, %eax
	ja	.L113
	movl	.L119(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L119:
	.long	.L113
	.long	.L114
	.long	.L115
	.long	.L116
	.long	.L117
	.long	.L118
	.text
.L114:
	.loc 1 465 0
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
.LVL198:
	.loc 1 466 0
	movl	$0, -12(%ebp)
.LVL199:
	jmp	.L120
.LVL200:
.L121:
	.loc 1 467 0 discriminator 2
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
.LVL201:
	addl	$8, %edx
	movl	12(%eax,%edx,4), %eax
	movb	$0, (%eax)
	.loc 1 466 0 discriminator 2
	addl	$1, -12(%ebp)
.L120:
	.loc 1 466 0 is_stmt 0 discriminator 1
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	4(%eax,%edx,4), %eax
	testl	%eax, %eax
	jne	.L121
	.loc 1 468 0 is_stmt 1
	jmp	.L113
.LVL202:
.L115:
	.loc 1 471 0
	movl	8(%ebp), %eax
	movl	%eax, -20(%ebp)
.LVL203:
	.loc 1 472 0
	movl	-20(%ebp), %eax
	movl	4(%eax), %eax
.LVL204:
	movl	%eax, (%esp)
	call	nulterminate
.LVL205:
	.loc 1 473 0
	movl	-20(%ebp), %eax
	movl	12(%eax), %eax
	movb	$0, (%eax)
	.loc 1 474 0
	jmp	.L113
.LVL206:
.L116:
	.loc 1 477 0
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
.LVL207:
	.loc 1 478 0
	movl	-24(%ebp), %eax
	movl	4(%eax), %eax
.LVL208:
	movl	%eax, (%esp)
	call	nulterminate
.LVL209:
	.loc 1 479 0
	movl	-24(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, (%esp)
	call	nulterminate
.LVL210:
	.loc 1 480 0
	jmp	.L113
.LVL211:
.L117:
	.loc 1 483 0
	movl	8(%ebp), %eax
	movl	%eax, -28(%ebp)
.LVL212:
	.loc 1 484 0
	movl	-28(%ebp), %eax
	movl	4(%eax), %eax
.LVL213:
	movl	%eax, (%esp)
	call	nulterminate
.LVL214:
	.loc 1 485 0
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, (%esp)
	call	nulterminate
.LVL215:
	.loc 1 486 0
	jmp	.L113
.LVL216:
.L118:
	.loc 1 489 0
	movl	8(%ebp), %eax
	movl	%eax, -32(%ebp)
.LVL217:
	.loc 1 490 0
	movl	-32(%ebp), %eax
	movl	4(%eax), %eax
.LVL218:
	movl	%eax, (%esp)
	call	nulterminate
.LVL219:
	.loc 1 491 0
	nop
.LVL220:
.L113:
	.loc 1 493 0
	movl	8(%ebp), %eax
.L112:
	.loc 1 494 0
	leave
.LCFI53:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	nulterminate, .-nulterminate
	.local	buf.1055
	.comm	buf.1055,100,32
.Letext0:
	.file 2 "user.h"
	.file 3 "types.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x148a
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF56
	.byte	0x1
	.long	.LASF57
	.long	.LASF58
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF59
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
	.uleb128 0x4
	.string	"cmd"
	.byte	0x4
	.byte	0x1
	.byte	0x10
	.long	0x60
	.uleb128 0x5
	.long	.LASF4
	.byte	0x1
	.byte	0x11
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x7
	.long	.LASF3
	.byte	0x54
	.byte	0x1
	.byte	0x14
	.long	0x9e
	.uleb128 0x5
	.long	.LASF4
	.byte	0x1
	.byte	0x15
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF5
	.byte	0x1
	.byte	0x16
	.long	0x9e
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF6
	.byte	0x1
	.byte	0x17
	.long	0x9e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.byte	0
	.uleb128 0x8
	.long	0xb5
	.long	0xae
	.uleb128 0x9
	.long	0xae
	.byte	0x9
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF7
	.uleb128 0xa
	.byte	0x4
	.long	0xbb
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF8
	.uleb128 0x7
	.long	.LASF9
	.byte	0x18
	.byte	0x1
	.byte	0x1a
	.long	0x122
	.uleb128 0x5
	.long	.LASF4
	.byte	0x1
	.byte	0x1b
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xb
	.string	"cmd"
	.byte	0x1
	.byte	0x1c
	.long	0x122
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF10
	.byte	0x1
	.byte	0x1d
	.long	0xb5
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.long	.LASF11
	.byte	0x1
	.byte	0x1e
	.long	0xb5
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.long	.LASF12
	.byte	0x1
	.byte	0x1f
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xb
	.string	"fd"
	.byte	0x1
	.byte	0x20
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.long	0x45
	.uleb128 0x7
	.long	.LASF13
	.byte	0xc
	.byte	0x1
	.byte	0x23
	.long	0x15f
	.uleb128 0x5
	.long	.LASF4
	.byte	0x1
	.byte	0x24
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF14
	.byte	0x1
	.byte	0x25
	.long	0x122
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF15
	.byte	0x1
	.byte	0x26
	.long	0x122
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0
	.uleb128 0x7
	.long	.LASF16
	.byte	0xc
	.byte	0x1
	.byte	0x29
	.long	0x196
	.uleb128 0x5
	.long	.LASF4
	.byte	0x1
	.byte	0x2a
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.long	.LASF14
	.byte	0x1
	.byte	0x2b
	.long	0x122
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.long	.LASF15
	.byte	0x1
	.byte	0x2c
	.long	0x122
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0
	.uleb128 0x7
	.long	.LASF17
	.byte	0x8
	.byte	0x1
	.byte	0x2f
	.long	0x1bf
	.uleb128 0x5
	.long	.LASF4
	.byte	0x1
	.byte	0x30
	.long	0x60
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xb
	.string	"cmd"
	.byte	0x1
	.byte	0x31
	.long	0x122
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0
	.uleb128 0xc
	.byte	0x1
	.long	.LASF26
	.byte	0x1
	.byte	0x3a
	.byte	0x1
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.byte	0x1
	.long	0x3f3
	.uleb128 0xd
	.string	"cmd"
	.byte	0x1
	.byte	0x3a
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xe
	.string	"p"
	.byte	0x1
	.byte	0x3c
	.long	0x3f3
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0xf
	.long	.LASF18
	.byte	0x1
	.byte	0x3d
	.long	0x403
	.long	.LLST1
	.uleb128 0xf
	.long	.LASF19
	.byte	0x1
	.byte	0x3e
	.long	0x409
	.long	.LLST2
	.uleb128 0xf
	.long	.LASF20
	.byte	0x1
	.byte	0x3f
	.long	0x40f
	.long	.LLST3
	.uleb128 0xf
	.long	.LASF21
	.byte	0x1
	.byte	0x40
	.long	0x415
	.long	.LLST4
	.uleb128 0xf
	.long	.LASF22
	.byte	0x1
	.byte	0x41
	.long	0x41b
	.long	.LLST5
	.uleb128 0x10
	.long	.LVL1
	.long	0x1310
	.uleb128 0x11
	.long	.LVL2
	.long	0x5ed
	.long	0x25f
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC0
	.byte	0
	.uleb128 0x10
	.long	.LVL5
	.long	0x1310
	.uleb128 0x11
	.long	.LVL6
	.long	0x131e
	.long	0x280
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0x23
	.uleb128 0x4
	.byte	0
	.uleb128 0x11
	.long	.LVL7
	.long	0x133b
	.long	0x29e
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x32
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC1
	.byte	0
	.uleb128 0x10
	.long	.LVL11
	.long	0x1355
	.uleb128 0x10
	.long	.LVL12
	.long	0x136d
	.uleb128 0x11
	.long	.LVL13
	.long	0x133b
	.long	0x2ce
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x32
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC2
	.byte	0
	.uleb128 0x10
	.long	.LVL14
	.long	0x1310
	.uleb128 0x10
	.long	.LVL15
	.long	0x1bf
	.uleb128 0x10
	.long	.LVL18
	.long	0x643
	.uleb128 0x10
	.long	.LVL19
	.long	0x1bf
	.uleb128 0x10
	.long	.LVL20
	.long	0x138a
	.uleb128 0x10
	.long	.LVL21
	.long	0x1bf
	.uleb128 0x11
	.long	.LVL25
	.long	0x1398
	.long	0x319
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.uleb128 0x11
	.long	.LVL26
	.long	0x5ed
	.long	0x331
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC3
	.byte	0
	.uleb128 0x10
	.long	.LVL27
	.long	0x643
	.uleb128 0x11
	.long	.LVL28
	.long	0x1355
	.long	0x34e
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x31
	.byte	0
	.uleb128 0x10
	.long	.LVL29
	.long	0x13b6
	.uleb128 0x10
	.long	.LVL30
	.long	0x1355
	.uleb128 0x10
	.long	.LVL31
	.long	0x1355
	.uleb128 0x10
	.long	.LVL32
	.long	0x1bf
	.uleb128 0x10
	.long	.LVL33
	.long	0x643
	.uleb128 0x11
	.long	.LVL34
	.long	0x1355
	.long	0x38f
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x10
	.long	.LVL35
	.long	0x13b6
	.uleb128 0x10
	.long	.LVL36
	.long	0x1355
	.uleb128 0x10
	.long	.LVL37
	.long	0x1355
	.uleb128 0x10
	.long	.LVL38
	.long	0x1bf
	.uleb128 0x10
	.long	.LVL39
	.long	0x1355
	.uleb128 0x10
	.long	.LVL40
	.long	0x1355
	.uleb128 0x10
	.long	.LVL41
	.long	0x138a
	.uleb128 0x10
	.long	.LVL42
	.long	0x138a
	.uleb128 0x10
	.long	.LVL45
	.long	0x643
	.uleb128 0x10
	.long	.LVL46
	.long	0x1bf
	.uleb128 0x10
	.long	.LVL48
	.long	0x1310
	.byte	0
	.uleb128 0x8
	.long	0x60
	.long	0x403
	.uleb128 0x9
	.long	0xae
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.long	0x196
	.uleb128 0xa
	.byte	0x4
	.long	0x67
	.uleb128 0xa
	.byte	0x4
	.long	0x15f
	.uleb128 0xa
	.byte	0x4
	.long	0x128
	.uleb128 0xa
	.byte	0x4
	.long	0xc2
	.uleb128 0x13
	.byte	0x1
	.long	.LASF24
	.byte	0x1
	.byte	0x86
	.byte	0x1
	.long	0x60
	.long	.LFB1
	.long	.LFE1
	.long	.LLST6
	.byte	0x1
	.long	0x4b8
	.uleb128 0xd
	.string	"buf"
	.byte	0x1
	.byte	0x86
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x14
	.long	.LASF23
	.byte	0x1
	.byte	0x86
	.long	0x60
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x11
	.long	.LVL50
	.long	0x133b
	.long	0x479
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x32
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC4
	.byte	0
	.uleb128 0x11
	.long	.LVL51
	.long	0x13ce
	.long	0x49d
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x15
	.long	.LVL52
	.long	0x13f2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF25
	.byte	0x1
	.byte	0x91
	.byte	0x1
	.long	0x60
	.long	.LFB2
	.long	.LFE2
	.long	.LLST7
	.byte	0x1
	.long	0x5dd
	.uleb128 0xe
	.string	"buf"
	.byte	0x1
	.byte	0x93
	.long	0x5dd
	.byte	0x5
	.byte	0x3
	.long	buf.1055
	.uleb128 0x16
	.string	"fd"
	.byte	0x1
	.byte	0x94
	.long	0x60
	.long	.LLST8
	.uleb128 0x11
	.long	.LVL55
	.long	0x1355
	.long	0x50b
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x74
	.sleb128 28
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL57
	.long	0x136d
	.long	0x529
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC5
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x32
	.byte	0
	.uleb128 0x11
	.long	.LVL60
	.long	0x140f
	.long	0x541
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	buf.1055
	.byte	0
	.uleb128 0x11
	.long	.LVL61
	.long	0x1427
	.long	0x559
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	buf.1055+3
	.byte	0
	.uleb128 0x11
	.long	.LVL62
	.long	0x133b
	.long	0x581
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x32
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	buf.1055+3
	.byte	0
	.uleb128 0x10
	.long	.LVL63
	.long	0x643
	.uleb128 0x11
	.long	.LVL64
	.long	0xa55
	.long	0x5a2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	buf.1055
	.byte	0
	.uleb128 0x10
	.long	.LVL65
	.long	0x1bf
	.uleb128 0x10
	.long	.LVL66
	.long	0x138a
	.uleb128 0x11
	.long	.LVL67
	.long	0x421
	.long	0x5d3
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	buf.1055
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x8
	.byte	0x64
	.byte	0
	.uleb128 0x10
	.long	.LVL68
	.long	0x1310
	.byte	0
	.uleb128 0x8
	.long	0xbb
	.long	0x5ed
	.uleb128 0x9
	.long	0xae
	.byte	0x63
	.byte	0
	.uleb128 0xc
	.byte	0x1
	.long	.LASF27
	.byte	0x1
	.byte	0xb0
	.byte	0x1
	.long	.LFB3
	.long	.LFE3
	.long	.LLST9
	.byte	0x1
	.long	0x643
	.uleb128 0xd
	.string	"s"
	.byte	0x1
	.byte	0xb0
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.long	.LVL70
	.long	0x133b
	.long	0x639
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x32
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC7
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL71
	.long	0x1310
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF28
	.byte	0x1
	.byte	0xb7
	.byte	0x1
	.long	0x60
	.long	.LFB4
	.long	.LFE4
	.long	.LLST10
	.byte	0x1
	.long	0x68e
	.uleb128 0x16
	.string	"pid"
	.byte	0x1
	.byte	0xb9
	.long	0x60
	.long	.LLST11
	.uleb128 0x10
	.long	.LVL72
	.long	0x143f
	.uleb128 0x15
	.long	.LVL74
	.long	0x5ed
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC8
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF3
	.byte	0x1
	.byte	0xc5
	.byte	0x1
	.long	0x122
	.long	.LFB5
	.long	.LFE5
	.long	.LLST12
	.byte	0x1
	.long	0x6f0
	.uleb128 0x16
	.string	"cmd"
	.byte	0x1
	.byte	0xc7
	.long	0x409
	.long	.LLST13
	.uleb128 0x11
	.long	.LVL75
	.long	0x144d
	.long	0x6d0
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x8
	.byte	0x54
	.byte	0
	.uleb128 0x15
	.long	.LVL77
	.long	0x13ce
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x2
	.byte	0x8
	.byte	0x54
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF9
	.byte	0x1
	.byte	0xd0
	.byte	0x1
	.long	0x122
	.long	.LFB6
	.long	.LFE6
	.long	.LLST14
	.byte	0x1
	.long	0x795
	.uleb128 0x14
	.long	.LASF29
	.byte	0x1
	.byte	0xd0
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x14
	.long	.LASF10
	.byte	0x1
	.byte	0xd0
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x14
	.long	.LASF11
	.byte	0x1
	.byte	0xd0
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x14
	.long	.LASF12
	.byte	0x1
	.byte	0xd0
	.long	0x60
	.byte	0x2
	.byte	0x91
	.sleb128 12
	.uleb128 0xd
	.string	"fd"
	.byte	0x1
	.byte	0xd0
	.long	0x60
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x16
	.string	"cmd"
	.byte	0x1
	.byte	0xd2
	.long	0x41b
	.long	.LLST15
	.uleb128 0x11
	.long	.LVL79
	.long	0x144d
	.long	0x776
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x48
	.byte	0
	.uleb128 0x15
	.long	.LVL81
	.long	0x13ce
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x48
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF13
	.byte	0x1
	.byte	0xe0
	.byte	0x1
	.long	0x122
	.long	.LFB7
	.long	.LFE7
	.long	.LLST16
	.byte	0x1
	.long	0x811
	.uleb128 0x14
	.long	.LASF14
	.byte	0x1
	.byte	0xe0
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x14
	.long	.LASF15
	.byte	0x1
	.byte	0xe0
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x16
	.string	"cmd"
	.byte	0x1
	.byte	0xe2
	.long	0x415
	.long	.LLST17
	.uleb128 0x11
	.long	.LVL83
	.long	0x144d
	.long	0x7f2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x3c
	.byte	0
	.uleb128 0x15
	.long	.LVL85
	.long	0x13ce
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x3c
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF16
	.byte	0x1
	.byte	0xed
	.byte	0x1
	.long	0x122
	.long	.LFB8
	.long	.LFE8
	.long	.LLST18
	.byte	0x1
	.long	0x88d
	.uleb128 0x14
	.long	.LASF14
	.byte	0x1
	.byte	0xed
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x14
	.long	.LASF15
	.byte	0x1
	.byte	0xed
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x16
	.string	"cmd"
	.byte	0x1
	.byte	0xef
	.long	0x40f
	.long	.LLST19
	.uleb128 0x11
	.long	.LVL87
	.long	0x144d
	.long	0x86e
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x3c
	.byte	0
	.uleb128 0x15
	.long	.LVL89
	.long	0x13ce
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x3c
	.byte	0
	.byte	0
	.uleb128 0x13
	.byte	0x1
	.long	.LASF17
	.byte	0x1
	.byte	0xfa
	.byte	0x1
	.long	0x122
	.long	.LFB9
	.long	.LFE9
	.long	.LLST20
	.byte	0x1
	.long	0x8fb
	.uleb128 0x14
	.long	.LASF29
	.byte	0x1
	.byte	0xfa
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x16
	.string	"cmd"
	.byte	0x1
	.byte	0xfc
	.long	0x403
	.long	.LLST21
	.uleb128 0x11
	.long	.LVL91
	.long	0x144d
	.long	0x8dc
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x38
	.byte	0
	.uleb128 0x15
	.long	.LVL93
	.long	0x13ce
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x38
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF30
	.byte	0x1
	.value	0x10b
	.byte	0x1
	.long	0x60
	.long	.LFB10
	.long	.LFE10
	.long	.LLST22
	.byte	0x1
	.long	0x9cc
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x10b
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x10b
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x18
	.string	"q"
	.byte	0x1
	.value	0x10b
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.string	"eq"
	.byte	0x1
	.value	0x10b
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 12
	.uleb128 0x19
	.string	"s"
	.byte	0x1
	.value	0x10d
	.long	0xb5
	.long	.LLST23
	.uleb128 0x19
	.string	"ret"
	.byte	0x1
	.value	0x10e
	.long	0x60
	.long	.LLST24
	.uleb128 0x11
	.long	.LVL97
	.long	0x1465
	.long	0x987
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	whitespace
	.byte	0
	.uleb128 0x11
	.long	.LVL104
	.long	0x1465
	.long	0x99f
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	whitespace
	.byte	0
	.uleb128 0x11
	.long	.LVL105
	.long	0x1465
	.long	0x9b7
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	symbols
	.byte	0
	.uleb128 0x15
	.long	.LVL108
	.long	0x1465
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	whitespace
	.byte	0
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.long	0xb5
	.uleb128 0x17
	.byte	0x1
	.long	.LASF31
	.byte	0x1
	.value	0x138
	.byte	0x1
	.long	0x60
	.long	.LFB11
	.long	.LFE11
	.long	.LLST25
	.byte	0x1
	.long	0xa55
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x138
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x138
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x1a
	.long	.LASF32
	.byte	0x1
	.value	0x138
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.string	"s"
	.byte	0x1
	.value	0x13a
	.long	0xb5
	.long	.LLST26
	.uleb128 0x11
	.long	.LVL112
	.long	0x1465
	.long	0xa42
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	whitespace
	.byte	0
	.uleb128 0x15
	.long	.LVL113
	.long	0x1465
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF33
	.byte	0x1
	.value	0x149
	.byte	0x1
	.long	0x122
	.long	.LFB12
	.long	.LFE12
	.long	.LLST27
	.byte	0x1
	.long	0xb42
	.uleb128 0x18
	.string	"s"
	.byte	0x1
	.value	0x149
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.string	"es"
	.byte	0x1
	.value	0x14b
	.long	0xb5
	.long	.LLST28
	.uleb128 0x19
	.string	"cmd"
	.byte	0x1
	.value	0x14c
	.long	0x122
	.long	.LLST29
	.uleb128 0x11
	.long	.LVL115
	.long	0x140f
	.long	0xab5
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.long	.LVL118
	.long	0xb42
	.long	0xad2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL121
	.long	0x9d2
	.long	0xaf9
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC9
	.byte	0
	.uleb128 0x11
	.long	.LVL122
	.long	0x133b
	.long	0xb17
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x32
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x5
	.byte	0x3
	.long	.LC10
	.byte	0
	.uleb128 0x11
	.long	.LVL123
	.long	0x5ed
	.long	0xb2f
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC11
	.byte	0
	.uleb128 0x15
	.long	.LVL124
	.long	0x1207
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF34
	.byte	0x1
	.value	0x15a
	.byte	0x1
	.long	0x122
	.long	.LFB13
	.long	.LFE13
	.long	.LLST30
	.byte	0x1
	.long	0xc96
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x15a
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x15a
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x19
	.string	"cmd"
	.byte	0x1
	.value	0x15c
	.long	0x122
	.long	.LLST31
	.uleb128 0x11
	.long	.LVL126
	.long	0xc96
	.long	0xbab
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL129
	.long	0x8fb
	.long	0xbd5
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x11
	.long	.LVL130
	.long	0x88d
	.long	0xbeb
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL132
	.long	0x9d2
	.long	0xc13
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC12
	.byte	0
	.uleb128 0x11
	.long	.LVL133
	.long	0x9d2
	.long	0xc3b
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC13
	.byte	0
	.uleb128 0x11
	.long	.LVL134
	.long	0x8fb
	.long	0xc65
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x11
	.long	.LVL135
	.long	0xb42
	.long	0xc83
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x15
	.long	.LVL136
	.long	0x811
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF35
	.byte	0x1
	.value	0x16b
	.byte	0x1
	.long	0x122
	.long	.LFB14
	.long	.LFE14
	.long	.LLST32
	.byte	0x1
	.long	0xd82
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x16b
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x16b
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x19
	.string	"cmd"
	.byte	0x1
	.value	0x16d
	.long	0x122
	.long	.LLST33
	.uleb128 0x11
	.long	.LVL139
	.long	0x1055
	.long	0xcff
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL142
	.long	0x9d2
	.long	0xd27
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC14
	.byte	0
	.uleb128 0x11
	.long	.LVL143
	.long	0x8fb
	.long	0xd51
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x11
	.long	.LVL144
	.long	0xc96
	.long	0xd6f
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x15
	.long	.LVL145
	.long	0x795
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF36
	.byte	0x1
	.value	0x178
	.byte	0x1
	.long	0x122
	.long	.LFB15
	.long	.LFE15
	.long	.LLST34
	.byte	0x1
	.long	0xef5
	.uleb128 0x1b
	.string	"cmd"
	.byte	0x1
	.value	0x178
	.long	0x122
	.long	.LLST35
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x178
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x178
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.string	"tok"
	.byte	0x1
	.value	0x17a
	.long	0x60
	.long	.LLST36
	.uleb128 0x1c
	.string	"q"
	.byte	0x1
	.value	0x17b
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1c
	.string	"eq"
	.byte	0x1
	.value	0x17b
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x11
	.long	.LVL149
	.long	0x8fb
	.long	0xe22
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x11
	.long	.LVL152
	.long	0x8fb
	.long	0xe4e
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0x11
	.long	.LVL153
	.long	0x5ed
	.long	0xe66
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC15
	.byte	0
	.uleb128 0x11
	.long	.LVL154
	.long	0x6f0
	.long	0xe88
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 16
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x11
	.long	.LVL157
	.long	0x6f0
	.long	0xeac
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x3
	.byte	0xa
	.value	0x201
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 16
	.byte	0x1
	.byte	0x31
	.byte	0
	.uleb128 0x11
	.long	.LVL160
	.long	0x6f0
	.long	0xed0
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x3
	.byte	0xa
	.value	0x201
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 16
	.byte	0x1
	.byte	0x31
	.byte	0
	.uleb128 0x15
	.long	.LVL163
	.long	0x9d2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 8
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC16
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF37
	.byte	0x1
	.value	0x191
	.byte	0x1
	.long	0x122
	.long	.LFB16
	.long	.LFE16
	.long	.LLST37
	.byte	0x1
	.long	0x1055
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x191
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x191
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x19
	.string	"cmd"
	.byte	0x1
	.value	0x193
	.long	0x122
	.long	.LLST38
	.uleb128 0x11
	.long	.LVL165
	.long	0x9d2
	.long	0xf68
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC17
	.byte	0
	.uleb128 0x11
	.long	.LVL166
	.long	0x5ed
	.long	0xf80
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC18
	.byte	0
	.uleb128 0x11
	.long	.LVL167
	.long	0x8fb
	.long	0xfaa
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x11
	.long	.LVL168
	.long	0xb42
	.long	0xfc8
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL171
	.long	0x9d2
	.long	0xff0
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC19
	.byte	0
	.uleb128 0x11
	.long	.LVL172
	.long	0x5ed
	.long	0x1008
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC20
	.byte	0
	.uleb128 0x11
	.long	.LVL173
	.long	0x8fb
	.long	0x1032
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x30
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x1
	.byte	0x30
	.byte	0
	.uleb128 0x15
	.long	.LVL174
	.long	0xd82
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -20
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF38
	.byte	0x1
	.value	0x1a1
	.byte	0x1
	.long	0x122
	.long	.LFB17
	.long	.LFE17
	.long	.LLST39
	.byte	0x1
	.long	0x1207
	.uleb128 0x18
	.string	"ps"
	.byte	0x1
	.value	0x1a1
	.long	0x9cc
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"es"
	.byte	0x1
	.value	0x1a1
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x1c
	.string	"q"
	.byte	0x1
	.value	0x1a3
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1c
	.string	"eq"
	.byte	0x1
	.value	0x1a3
	.long	0xb5
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.string	"tok"
	.byte	0x1
	.value	0x1a4
	.long	0x60
	.long	.LLST40
	.uleb128 0x1d
	.long	.LASF39
	.byte	0x1
	.value	0x1a4
	.long	0x60
	.long	.LLST41
	.uleb128 0x19
	.string	"cmd"
	.byte	0x1
	.value	0x1a5
	.long	0x409
	.long	.LLST42
	.uleb128 0x19
	.string	"ret"
	.byte	0x1
	.value	0x1a6
	.long	0x122
	.long	.LLST43
	.uleb128 0x11
	.long	.LVL177
	.long	0x9d2
	.long	0x1113
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC17
	.byte	0
	.uleb128 0x11
	.long	.LVL178
	.long	0xef5
	.long	0x1131
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x10
	.long	.LVL179
	.long	0x68e
	.uleb128 0x11
	.long	.LVL184
	.long	0xd82
	.long	0x1160
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x11
	.long	.LVL187
	.long	0x8fb
	.long	0x118c
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 12
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x11
	.long	.LVL189
	.long	0x5ed
	.long	0x11a4
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC11
	.byte	0
	.uleb128 0x11
	.long	.LVL190
	.long	0x5ed
	.long	0x11bc
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x5
	.byte	0x3
	.long	.LC21
	.byte	0
	.uleb128 0x11
	.long	.LVL191
	.long	0xd82
	.long	0x11e2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 -24
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0
	.uleb128 0x15
	.long	.LVL193
	.long	0x9d2
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x3
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.uleb128 0x12
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x5
	.byte	0x3
	.long	.LC22
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.long	.LASF40
	.byte	0x1
	.value	0x1c3
	.byte	0x1
	.long	0x122
	.long	.LFB18
	.long	.LFE18
	.long	.LLST44
	.byte	0x1
	.long	0x12ca
	.uleb128 0x18
	.string	"cmd"
	.byte	0x1
	.value	0x1c3
	.long	0x122
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.string	"i"
	.byte	0x1
	.value	0x1c5
	.long	0x60
	.long	.LLST45
	.uleb128 0x1d
	.long	.LASF18
	.byte	0x1
	.value	0x1c6
	.long	0x403
	.long	.LLST46
	.uleb128 0x1d
	.long	.LASF19
	.byte	0x1
	.value	0x1c7
	.long	0x409
	.long	.LLST47
	.uleb128 0x1d
	.long	.LASF20
	.byte	0x1
	.value	0x1c8
	.long	0x40f
	.long	.LLST48
	.uleb128 0x1d
	.long	.LASF21
	.byte	0x1
	.value	0x1c9
	.long	0x415
	.long	.LLST49
	.uleb128 0x1d
	.long	.LASF22
	.byte	0x1
	.value	0x1ca
	.long	0x41b
	.long	.LLST50
	.uleb128 0x10
	.long	.LVL205
	.long	0x1207
	.uleb128 0x10
	.long	.LVL209
	.long	0x1207
	.uleb128 0x10
	.long	.LVL210
	.long	0x1207
	.uleb128 0x10
	.long	.LVL214
	.long	0x1207
	.uleb128 0x10
	.long	.LVL215
	.long	0x1207
	.uleb128 0x10
	.long	.LVL219
	.long	0x1207
	.byte	0
	.uleb128 0x8
	.long	0xbb
	.long	0x12da
	.uleb128 0x9
	.long	0xae
	.byte	0x5
	.byte	0
	.uleb128 0x1e
	.long	.LASF41
	.byte	0x1
	.value	0x107
	.long	0x12ca
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	whitespace
	.uleb128 0x8
	.long	0xbb
	.long	0x12fd
	.uleb128 0x9
	.long	0xae
	.byte	0x7
	.byte	0
	.uleb128 0x1e
	.long	.LASF42
	.byte	0x1
	.value	0x108
	.long	0x12ed
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	symbols
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF46
	.byte	0x2
	.byte	0x6
	.byte	0x1
	.long	0x60
	.byte	0x1
	.uleb128 0x20
	.byte	0x1
	.long	.LASF43
	.byte	0x2
	.byte	0xd
	.byte	0x1
	.long	0x60
	.byte	0x1
	.long	0x133b
	.uleb128 0x21
	.long	0xb5
	.uleb128 0x21
	.long	0x9cc
	.byte	0
	.uleb128 0x22
	.byte	0x1
	.long	.LASF60
	.byte	0x2
	.byte	0x21
	.byte	0x1
	.byte	0x1
	.long	0x1355
	.uleb128 0x21
	.long	0x60
	.uleb128 0x21
	.long	0xb5
	.uleb128 0x23
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF44
	.byte	0x2
	.byte	0xb
	.byte	0x1
	.long	0x60
	.byte	0x1
	.long	0x136d
	.uleb128 0x21
	.long	0x60
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF45
	.byte	0x2
	.byte	0xe
	.byte	0x1
	.long	0x60
	.byte	0x1
	.long	0x138a
	.uleb128 0x21
	.long	0xb5
	.uleb128 0x21
	.long	0x60
	.byte	0
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF47
	.byte	0x2
	.byte	0x7
	.byte	0x1
	.long	0x60
	.byte	0x1
	.uleb128 0x20
	.byte	0x1
	.long	.LASF48
	.byte	0x2
	.byte	0x8
	.byte	0x1
	.long	0x60
	.byte	0x1
	.long	0x13b0
	.uleb128 0x21
	.long	0x13b0
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.long	0x60
	.uleb128 0x24
	.byte	0x1
	.string	"dup"
	.byte	0x2
	.byte	0x15
	.byte	0x1
	.long	0x60
	.byte	0x1
	.long	0x13ce
	.uleb128 0x21
	.long	0x60
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF49
	.byte	0x2
	.byte	0x24
	.byte	0x1
	.long	0x13f0
	.byte	0x1
	.long	0x13f0
	.uleb128 0x21
	.long	0x13f0
	.uleb128 0x21
	.long	0x60
	.uleb128 0x21
	.long	0x25
	.byte	0
	.uleb128 0x25
	.byte	0x4
	.uleb128 0x20
	.byte	0x1
	.long	.LASF50
	.byte	0x2
	.byte	0x22
	.byte	0x1
	.long	0xb5
	.byte	0x1
	.long	0x140f
	.uleb128 0x21
	.long	0xb5
	.uleb128 0x21
	.long	0x60
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF51
	.byte	0x2
	.byte	0x23
	.byte	0x1
	.long	0x25
	.byte	0x1
	.long	0x1427
	.uleb128 0x21
	.long	0xb5
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF52
	.byte	0x2
	.byte	0x14
	.byte	0x1
	.long	0x60
	.byte	0x1
	.long	0x143f
	.uleb128 0x21
	.long	0xb5
	.byte	0
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF53
	.byte	0x2
	.byte	0x5
	.byte	0x1
	.long	0x60
	.byte	0x1
	.uleb128 0x20
	.byte	0x1
	.long	.LASF54
	.byte	0x2
	.byte	0x25
	.byte	0x1
	.long	0x13f0
	.byte	0x1
	.long	0x1465
	.uleb128 0x21
	.long	0x25
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF55
	.byte	0x2
	.byte	0x1f
	.byte	0x1
	.long	0xb5
	.byte	0x1
	.long	0x1482
	.uleb128 0x21
	.long	0x1482
	.uleb128 0x21
	.long	0xbb
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.long	0x1488
	.uleb128 0x26
	.long	0xbb
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
	.uleb128 0x7
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
	.uleb128 0x8
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
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
	.uleb128 0x15
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0x1b
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
	.uleb128 0x6
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
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
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.long	.LVL44-.Ltext0
	.long	.LVL45-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL45-1-.Ltext0
	.long	.LVL47-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -36
	.long	0
	.long	0
.LLST2:
	.long	.LVL3-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL4-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST3:
	.long	.LVL17-.Ltext0
	.long	.LVL18-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL18-1-.Ltext0
	.long	.LVL22-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.long	0
	.long	0
.LLST4:
	.long	.LVL23-.Ltext0
	.long	.LVL24-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL24-.Ltext0
	.long	.LVL43-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST5:
	.long	.LVL9-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL10-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST6:
	.long	.LFB1-.Ltext0
	.long	.LCFI2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI2-.Ltext0
	.long	.LCFI3-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI3-.Ltext0
	.long	.LCFI4-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI4-.Ltext0
	.long	.LFE1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST7:
	.long	.LFB2-.Ltext0
	.long	.LCFI5-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI5-.Ltext0
	.long	.LCFI6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI6-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0
	.long	0
.LLST8:
	.long	.LVL53-.Ltext0
	.long	.LVL54-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL54-.Ltext0
	.long	.LVL56-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 28
	.long	.LVL58-.Ltext0
	.long	.LVL59-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL59-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 28
	.long	0
	.long	0
.LLST9:
	.long	.LFB3-.Ltext0
	.long	.LCFI7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI7-.Ltext0
	.long	.LCFI8-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI8-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0
	.long	0
.LLST10:
	.long	.LFB4-.Ltext0
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
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST11:
	.long	.LVL73-.Ltext0
	.long	.LVL74-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL74-1-.Ltext0
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST12:
	.long	.LFB5-.Ltext0
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
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LVL76-.Ltext0
	.long	.LVL77-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL77-1-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST14:
	.long	.LFB6-.Ltext0
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
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST15:
	.long	.LVL80-.Ltext0
	.long	.LVL81-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL81-1-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST16:
	.long	.LFB7-.Ltext0
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
	.long	.LFE7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST17:
	.long	.LVL84-.Ltext0
	.long	.LVL85-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL85-1-.Ltext0
	.long	.LFE7-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST18:
	.long	.LFB8-.Ltext0
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
	.long	.LFE8-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST19:
	.long	.LVL88-.Ltext0
	.long	.LVL89-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL89-1-.Ltext0
	.long	.LFE8-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST20:
	.long	.LFB9-.Ltext0
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
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST21:
	.long	.LVL92-.Ltext0
	.long	.LVL93-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL93-1-.Ltext0
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST22:
	.long	.LFB10-.Ltext0
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
	.long	.LFE10-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST23:
	.long	.LVL95-.Ltext0
	.long	.LVL96-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL96-.Ltext0
	.long	.LFE10-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST24:
	.long	.LVL98-.Ltext0
	.long	.LVL99-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL99-.Ltext0
	.long	.LVL100-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL100-.Ltext0
	.long	.LVL101-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL101-.Ltext0
	.long	.LVL102-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL102-.Ltext0
	.long	.LVL103-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL103-.Ltext0
	.long	.LVL106-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL106-.Ltext0
	.long	.LVL107-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL107-.Ltext0
	.long	.LFE10-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST25:
	.long	.LFB11-.Ltext0
	.long	.LCFI30-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI30-.Ltext0
	.long	.LCFI31-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI31-.Ltext0
	.long	.LCFI32-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI32-.Ltext0
	.long	.LFE11-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST26:
	.long	.LVL110-.Ltext0
	.long	.LVL111-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL111-.Ltext0
	.long	.LFE11-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST27:
	.long	.LFB12-.Ltext0
	.long	.LCFI33-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI33-.Ltext0
	.long	.LCFI34-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI34-.Ltext0
	.long	.LCFI35-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI35-.Ltext0
	.long	.LFE12-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST28:
	.long	.LVL116-.Ltext0
	.long	.LVL117-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL117-.Ltext0
	.long	.LVL118-1-.Ltext0
	.value	0x2
	.byte	0x70
	.sleb128 -20
	.long	.LVL118-1-.Ltext0
	.long	.LFE12-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST29:
	.long	.LVL119-.Ltext0
	.long	.LVL120-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL120-.Ltext0
	.long	.LFE12-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST30:
	.long	.LFB13-.Ltext0
	.long	.LCFI36-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI36-.Ltext0
	.long	.LCFI37-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI37-.Ltext0
	.long	.LCFI38-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI38-.Ltext0
	.long	.LFE13-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST31:
	.long	.LVL127-.Ltext0
	.long	.LVL128-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL128-.Ltext0
	.long	.LFE13-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST32:
	.long	.LFB14-.Ltext0
	.long	.LCFI39-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI39-.Ltext0
	.long	.LCFI40-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI40-.Ltext0
	.long	.LCFI41-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI41-.Ltext0
	.long	.LFE14-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST33:
	.long	.LVL140-.Ltext0
	.long	.LVL141-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL141-.Ltext0
	.long	.LFE14-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST34:
	.long	.LFB15-.Ltext0
	.long	.LCFI42-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI42-.Ltext0
	.long	.LCFI43-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI43-.Ltext0
	.long	.LCFI44-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI44-.Ltext0
	.long	.LFE15-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST35:
	.long	.LVL147-.Ltext0
	.long	.LVL155-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL155-.Ltext0
	.long	.LVL156-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL156-.Ltext0
	.long	.LVL158-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL158-.Ltext0
	.long	.LVL159-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL159-.Ltext0
	.long	.LVL161-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL161-.Ltext0
	.long	.LVL162-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL162-.Ltext0
	.long	.LFE15-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST36:
	.long	.LVL150-.Ltext0
	.long	.LVL151-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL151-.Ltext0
	.long	.LVL162-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST37:
	.long	.LFB16-.Ltext0
	.long	.LCFI45-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI45-.Ltext0
	.long	.LCFI46-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI46-.Ltext0
	.long	.LCFI47-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI47-.Ltext0
	.long	.LFE16-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST38:
	.long	.LVL169-.Ltext0
	.long	.LVL170-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL170-.Ltext0
	.long	.LVL175-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	.LVL175-.Ltext0
	.long	.LFE16-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST39:
	.long	.LFB17-.Ltext0
	.long	.LCFI48-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI48-.Ltext0
	.long	.LCFI49-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI49-.Ltext0
	.long	.LCFI50-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI50-.Ltext0
	.long	.LFE17-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST40:
	.long	.LVL188-.Ltext0
	.long	.LVL189-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL189-1-.Ltext0
	.long	.LVL192-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -32
	.long	.LVL194-.Ltext0
	.long	.LVL195-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST41:
	.long	.LVL182-.Ltext0
	.long	.LVL196-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST42:
	.long	.LVL181-.Ltext0
	.long	.LVL183-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL183-.Ltext0
	.long	.LVL196-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST43:
	.long	.LVL180-.Ltext0
	.long	.LVL183-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL183-.Ltext0
	.long	.LVL185-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	.LVL185-.Ltext0
	.long	.LVL186-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL186-.Ltext0
	.long	.LVL196-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -24
	.long	0
	.long	0
.LLST44:
	.long	.LFB18-.Ltext0
	.long	.LCFI51-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI51-.Ltext0
	.long	.LCFI52-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI52-.Ltext0
	.long	.LCFI53-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI53-.Ltext0
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST45:
	.long	.LVL199-.Ltext0
	.long	.LVL200-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	.LVL200-.Ltext0
	.long	.LVL201-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL201-.Ltext0
	.long	.LVL202-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST46:
	.long	.LVL217-.Ltext0
	.long	.LVL218-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL218-.Ltext0
	.long	.LVL220-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST47:
	.long	.LVL198-.Ltext0
	.long	.LVL200-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL200-.Ltext0
	.long	.LVL202-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST48:
	.long	.LVL212-.Ltext0
	.long	.LVL213-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL213-.Ltext0
	.long	.LVL216-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST49:
	.long	.LVL207-.Ltext0
	.long	.LVL208-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL208-.Ltext0
	.long	.LVL211-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST50:
	.long	.LVL203-.Ltext0
	.long	.LVL204-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL204-.Ltext0
	.long	.LVL206-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
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
.LASF20:
	.string	"lcmd"
.LASF26:
	.string	"runcmd"
.LASF17:
	.string	"backcmd"
.LASF36:
	.string	"parseredirs"
.LASF41:
	.string	"whitespace"
.LASF52:
	.string	"chdir"
.LASF32:
	.string	"toks"
.LASF21:
	.string	"pcmd"
.LASF27:
	.string	"panic"
.LASF14:
	.string	"left"
.LASF16:
	.string	"listcmd"
.LASF22:
	.string	"rcmd"
.LASF33:
	.string	"parsecmd"
.LASF55:
	.string	"strchr"
.LASF3:
	.string	"execcmd"
.LASF51:
	.string	"strlen"
.LASF10:
	.string	"file"
.LASF42:
	.string	"symbols"
.LASF45:
	.string	"open"
.LASF2:
	.string	"unsigned char"
.LASF23:
	.string	"nbuf"
.LASF53:
	.string	"fork"
.LASF11:
	.string	"efile"
.LASF44:
	.string	"close"
.LASF1:
	.string	"short unsigned int"
.LASF31:
	.string	"peek"
.LASF28:
	.string	"fork1"
.LASF37:
	.string	"parseblock"
.LASF29:
	.string	"subcmd"
.LASF49:
	.string	"memset"
.LASF58:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF50:
	.string	"gets"
.LASF25:
	.string	"main"
.LASF19:
	.string	"ecmd"
.LASF59:
	.string	"uint"
.LASF47:
	.string	"wait"
.LASF43:
	.string	"exec"
.LASF0:
	.string	"unsigned int"
.LASF15:
	.string	"right"
.LASF13:
	.string	"pipecmd"
.LASF8:
	.string	"char"
.LASF24:
	.string	"getcmd"
.LASF12:
	.string	"mode"
.LASF30:
	.string	"gettoken"
.LASF39:
	.string	"argc"
.LASF7:
	.string	"sizetype"
.LASF56:
	.string	"GNU C 4.7.2"
.LASF60:
	.string	"printf"
.LASF4:
	.string	"type"
.LASF46:
	.string	"exit"
.LASF40:
	.string	"nulterminate"
.LASF5:
	.string	"argv"
.LASF57:
	.string	"sh.c"
.LASF48:
	.string	"pipe"
.LASF35:
	.string	"parsepipe"
.LASF18:
	.string	"bcmd"
.LASF6:
	.string	"eargv"
.LASF9:
	.string	"redircmd"
.LASF38:
	.string	"parseexec"
.LASF54:
	.string	"malloc"
.LASF34:
	.string	"parseline"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
