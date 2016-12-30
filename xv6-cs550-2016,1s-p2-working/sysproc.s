	.file	"sysproc.c"
	.text
.Ltext0:
	.globl	sys_fork
	.type	sys_fork, @function
sys_fork:
.LFB20:
	.file 1 "sysproc.c"
	.loc 1 12 0
	.cfi_startproc
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 13 0
	call	fork
.LVL0:
	.loc 1 14 0
	leave
.LCFI2:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	sys_fork, .-sys_fork
	.globl	sys_exit
	.type	sys_exit, @function
sys_exit:
.LFB21:
	.loc 1 18 0
	.cfi_startproc
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 19 0
	call	exit
.LVL1:
	.loc 1 20 0
	movl	$0, %eax
	.loc 1 21 0
	leave
.LCFI5:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	sys_exit, .-sys_exit
	.globl	sys_wait
	.type	sys_wait, @function
sys_wait:
.LFB22:
	.loc 1 25 0
	.cfi_startproc
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 26 0
	call	wait
.LVL2:
	.loc 1 27 0
	leave
.LCFI8:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	sys_wait, .-sys_wait
	.globl	sys_kill
	.type	sys_kill, @function
sys_kill:
.LFB23:
	.loc 1 31 0
	.cfi_startproc
	pushl	%ebp
.LCFI9:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI10:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 34 0
	leal	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	argint
.LVL3:
	testl	%eax, %eax
	jns	.L8
	.loc 1 35 0
	movl	$-1, %eax
	jmp	.L10
.L8:
.LVL4:
	.loc 1 36 0
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	kill
.LVL5:
.L10:
	.loc 1 37 0
	leave
.LCFI11:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	sys_kill, .-sys_kill
	.globl	sys_getpid
	.type	sys_getpid, @function
sys_getpid:
.LFB24:
	.loc 1 41 0
	.cfi_startproc
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI13:
	.cfi_def_cfa_register 5
	.loc 1 42 0
	movl	%gs:4, %eax
	movl	16(%eax), %eax
	.loc 1 43 0
	popl	%ebp
.LCFI14:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	sys_getpid, .-sys_getpid
	.globl	sys_sbrk
	.type	sys_sbrk, @function
sys_sbrk:
.LFB25:
	.loc 1 47 0
	.cfi_startproc
	pushl	%ebp
.LCFI15:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI16:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 51 0
	leal	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	argint
.LVL6:
	testl	%eax, %eax
	jns	.L14
	.loc 1 52 0
	movl	$-1, %eax
	jmp	.L17
.L14:
	.loc 1 53 0
	movl	%gs:4, %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
.LVL7:
	.loc 1 54 0
	movl	-16(%ebp), %eax
.LVL8:
	movl	%eax, (%esp)
	call	growproc
.LVL9:
	testl	%eax, %eax
	jns	.L16
	.loc 1 55 0
	movl	$-1, %eax
	jmp	.L17
.L16:
	.loc 1 56 0
	movl	-12(%ebp), %eax
.LVL10:
.L17:
	.loc 1 57 0
	leave
.LCFI17:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	sys_sbrk, .-sys_sbrk
	.globl	sys_sleep
	.type	sys_sleep, @function
sys_sleep:
.LFB26:
	.loc 1 61 0
	.cfi_startproc
	pushl	%ebp
.LCFI18:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI19:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 65 0
	leal	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	argint
.LVL11:
	testl	%eax, %eax
	jns	.L19
	.loc 1 66 0
	movl	$-1, %eax
	jmp	.L24
.L19:
	.loc 1 67 0
	movl	$tickslock, (%esp)
	call	acquire
.LVL12:
	.loc 1 68 0
	movl	ticks, %eax
	movl	%eax, -12(%ebp)
.LVL13:
	.loc 1 69 0
	jmp	.L21
.LVL14:
.L23:
	.loc 1 70 0
	movl	%gs:4, %eax
	movl	36(%eax), %eax
	testl	%eax, %eax
	je	.L22
	.loc 1 71 0
	movl	$tickslock, (%esp)
	call	release
.LVL15:
	.loc 1 72 0
	movl	$-1, %eax
	jmp	.L24
.L22:
	.loc 1 74 0
	movl	$tickslock, 4(%esp)
	movl	$ticks, (%esp)
	call	sleep
.LVL16:
.L21:
	.loc 1 69 0 discriminator 1
	movl	ticks, %eax
	movl	%eax, %edx
	subl	-12(%ebp), %edx
	movl	-16(%ebp), %eax
	cmpl	%eax, %edx
	jb	.L23
	.loc 1 76 0
	movl	$tickslock, (%esp)
	call	release
.LVL17:
	.loc 1 77 0
	movl	$0, %eax
.LVL18:
.L24:
	.loc 1 78 0
	leave
.LCFI20:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	sys_sleep, .-sys_sleep
	.globl	sys_uptime
	.type	sys_uptime, @function
sys_uptime:
.LFB27:
	.loc 1 84 0
	.cfi_startproc
	pushl	%ebp
.LCFI21:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI22:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 87 0
	movl	$tickslock, (%esp)
	call	acquire
.LVL19:
	.loc 1 88 0
	movl	ticks, %eax
	movl	%eax, -12(%ebp)
.LVL20:
	.loc 1 89 0
	movl	$tickslock, (%esp)
	call	release
.LVL21:
	.loc 1 90 0
	movl	-12(%ebp), %eax
	.loc 1 91 0
	leave
.LCFI23:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE27:
	.size	sys_uptime, .-sys_uptime
	.globl	sys_date
	.type	sys_date, @function
sys_date:
.LFB28:
	.loc 1 95 0
	.cfi_startproc
	pushl	%ebp
.LCFI24:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI25:
	.cfi_def_cfa_register 5
	subl	$40, %esp
	.loc 1 97 0
	movl	$24, 8(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	argptr
.LVL22:
	testl	%eax, %eax
	jns	.L28
	.loc 1 98 0
	movl	$-1, %eax
	jmp	.L30
.L28:
.LVL23:
	.loc 1 99 0
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	cmostime
.LVL24:
	.loc 1 100 0
	movl	$0, %eax
.L30:
	.loc 1 101 0
	leave
.LCFI26:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE28:
	.size	sys_date, .-sys_date
	.globl	sys_ls_call01
	.type	sys_ls_call01, @function
sys_ls_call01:
.LFB29:
	.loc 1 104 0
	.cfi_startproc
	pushl	%ebp
.LCFI27:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI28:
	.cfi_def_cfa_register 5
	.loc 1 105 0
	movl	$1, %eax
	.loc 1 106 0
	popl	%ebp
.LCFI29:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE29:
	.size	sys_ls_call01, .-sys_ls_call01
	.globl	sys_ls_call02
	.type	sys_ls_call02, @function
sys_ls_call02:
.LFB30:
	.loc 1 109 0
	.cfi_startproc
	pushl	%ebp
.LCFI30:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI31:
	.cfi_def_cfa_register 5
	.loc 1 110 0
	movl	$2, %eax
	.loc 1 111 0
	popl	%ebp
.LCFI32:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE30:
	.size	sys_ls_call02, .-sys_ls_call02
	.globl	sys_ls_call03
	.type	sys_ls_call03, @function
sys_ls_call03:
.LFB31:
	.loc 1 114 0
	.cfi_startproc
	pushl	%ebp
.LCFI33:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI34:
	.cfi_def_cfa_register 5
	.loc 1 115 0
	movl	$3, %eax
	.loc 1 116 0
	popl	%ebp
.LCFI35:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE31:
	.size	sys_ls_call03, .-sys_ls_call03
	.globl	sys_ls_call04
	.type	sys_ls_call04, @function
sys_ls_call04:
.LFB32:
	.loc 1 119 0
	.cfi_startproc
	pushl	%ebp
.LCFI36:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI37:
	.cfi_def_cfa_register 5
	.loc 1 120 0
	movl	$4, %eax
	.loc 1 121 0
	popl	%ebp
.LCFI38:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE32:
	.size	sys_ls_call04, .-sys_ls_call04
	.globl	sys_ls_call05
	.type	sys_ls_call05, @function
sys_ls_call05:
.LFB33:
	.loc 1 124 0
	.cfi_startproc
	pushl	%ebp
.LCFI39:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI40:
	.cfi_def_cfa_register 5
	.loc 1 125 0
	movl	$5, %eax
	.loc 1 126 0
	popl	%ebp
.LCFI41:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE33:
	.size	sys_ls_call05, .-sys_ls_call05
	.globl	sys_ls_call06
	.type	sys_ls_call06, @function
sys_ls_call06:
.LFB34:
	.loc 1 129 0
	.cfi_startproc
	pushl	%ebp
.LCFI42:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI43:
	.cfi_def_cfa_register 5
	.loc 1 130 0
	movl	$6, %eax
	.loc 1 131 0
	popl	%ebp
.LCFI44:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE34:
	.size	sys_ls_call06, .-sys_ls_call06
	.globl	sys_ls_call07
	.type	sys_ls_call07, @function
sys_ls_call07:
.LFB35:
	.loc 1 134 0
	.cfi_startproc
	pushl	%ebp
.LCFI45:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI46:
	.cfi_def_cfa_register 5
	.loc 1 135 0
	movl	$7, %eax
	.loc 1 136 0
	popl	%ebp
.LCFI47:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE35:
	.size	sys_ls_call07, .-sys_ls_call07
	.globl	sys_ls_call08
	.type	sys_ls_call08, @function
sys_ls_call08:
.LFB36:
	.loc 1 139 0
	.cfi_startproc
	pushl	%ebp
.LCFI48:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI49:
	.cfi_def_cfa_register 5
	.loc 1 140 0
	movl	$8, %eax
	.loc 1 141 0
	popl	%ebp
.LCFI50:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE36:
	.size	sys_ls_call08, .-sys_ls_call08
	.globl	sys_ls_call09
	.type	sys_ls_call09, @function
sys_ls_call09:
.LFB37:
	.loc 1 144 0
	.cfi_startproc
	pushl	%ebp
.LCFI51:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI52:
	.cfi_def_cfa_register 5
	.loc 1 145 0
	movl	$9, %eax
	.loc 1 146 0
	popl	%ebp
.LCFI53:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE37:
	.size	sys_ls_call09, .-sys_ls_call09
	.globl	sys_ls_call10
	.type	sys_ls_call10, @function
sys_ls_call10:
.LFB38:
	.loc 1 149 0
	.cfi_startproc
	pushl	%ebp
.LCFI54:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI55:
	.cfi_def_cfa_register 5
	.loc 1 150 0
	movl	$10, %eax
	.loc 1 151 0
	popl	%ebp
.LCFI56:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE38:
	.size	sys_ls_call10, .-sys_ls_call10
	.globl	sys_ls_call11
	.type	sys_ls_call11, @function
sys_ls_call11:
.LFB39:
	.loc 1 154 0
	.cfi_startproc
	pushl	%ebp
.LCFI57:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI58:
	.cfi_def_cfa_register 5
	.loc 1 155 0
	movl	$11, %eax
	.loc 1 156 0
	popl	%ebp
.LCFI59:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE39:
	.size	sys_ls_call11, .-sys_ls_call11
	.globl	sys_ls_call12
	.type	sys_ls_call12, @function
sys_ls_call12:
.LFB40:
	.loc 1 159 0
	.cfi_startproc
	pushl	%ebp
.LCFI60:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI61:
	.cfi_def_cfa_register 5
	.loc 1 160 0
	movl	$12, %eax
	.loc 1 161 0
	popl	%ebp
.LCFI62:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE40:
	.size	sys_ls_call12, .-sys_ls_call12
	.globl	sys_ls_call13
	.type	sys_ls_call13, @function
sys_ls_call13:
.LFB41:
	.loc 1 164 0
	.cfi_startproc
	pushl	%ebp
.LCFI63:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI64:
	.cfi_def_cfa_register 5
	.loc 1 165 0
	movl	$13, %eax
	.loc 1 166 0
	popl	%ebp
.LCFI65:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE41:
	.size	sys_ls_call13, .-sys_ls_call13
	.globl	sys_ls_call14
	.type	sys_ls_call14, @function
sys_ls_call14:
.LFB42:
	.loc 1 169 0
	.cfi_startproc
	pushl	%ebp
.LCFI66:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI67:
	.cfi_def_cfa_register 5
	.loc 1 170 0
	movl	$14, %eax
	.loc 1 171 0
	popl	%ebp
.LCFI68:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE42:
	.size	sys_ls_call14, .-sys_ls_call14
	.globl	sys_ls_call15
	.type	sys_ls_call15, @function
sys_ls_call15:
.LFB43:
	.loc 1 174 0
	.cfi_startproc
	pushl	%ebp
.LCFI69:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI70:
	.cfi_def_cfa_register 5
	.loc 1 175 0
	movl	$15, %eax
	.loc 1 176 0
	popl	%ebp
.LCFI71:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE43:
	.size	sys_ls_call15, .-sys_ls_call15
	.globl	sys_ls_call16
	.type	sys_ls_call16, @function
sys_ls_call16:
.LFB44:
	.loc 1 179 0
	.cfi_startproc
	pushl	%ebp
.LCFI72:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI73:
	.cfi_def_cfa_register 5
	.loc 1 180 0
	movl	$16, %eax
	.loc 1 181 0
	popl	%ebp
.LCFI74:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE44:
	.size	sys_ls_call16, .-sys_ls_call16
	.globl	sys_ls_call17
	.type	sys_ls_call17, @function
sys_ls_call17:
.LFB45:
	.loc 1 184 0
	.cfi_startproc
	pushl	%ebp
.LCFI75:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI76:
	.cfi_def_cfa_register 5
	.loc 1 185 0
	movl	$17, %eax
	.loc 1 186 0
	popl	%ebp
.LCFI77:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE45:
	.size	sys_ls_call17, .-sys_ls_call17
	.globl	sys_ls_call18
	.type	sys_ls_call18, @function
sys_ls_call18:
.LFB46:
	.loc 1 189 0
	.cfi_startproc
	pushl	%ebp
.LCFI78:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI79:
	.cfi_def_cfa_register 5
	.loc 1 190 0
	movl	$18, %eax
	.loc 1 191 0
	popl	%ebp
.LCFI80:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE46:
	.size	sys_ls_call18, .-sys_ls_call18
	.globl	sys_ls_call19
	.type	sys_ls_call19, @function
sys_ls_call19:
.LFB47:
	.loc 1 194 0
	.cfi_startproc
	pushl	%ebp
.LCFI81:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI82:
	.cfi_def_cfa_register 5
	.loc 1 195 0
	movl	$19, %eax
	.loc 1 196 0
	popl	%ebp
.LCFI83:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE47:
	.size	sys_ls_call19, .-sys_ls_call19
	.globl	sys_ls_call20
	.type	sys_ls_call20, @function
sys_ls_call20:
.LFB48:
	.loc 1 199 0
	.cfi_startproc
	pushl	%ebp
.LCFI84:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI85:
	.cfi_def_cfa_register 5
	.loc 1 200 0
	movl	$20, %eax
	.loc 1 201 0
	popl	%ebp
.LCFI86:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE48:
	.size	sys_ls_call20, .-sys_ls_call20
	.globl	sys_ls_call21
	.type	sys_ls_call21, @function
sys_ls_call21:
.LFB49:
	.loc 1 204 0
	.cfi_startproc
	pushl	%ebp
.LCFI87:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI88:
	.cfi_def_cfa_register 5
	.loc 1 205 0
	movl	$21, %eax
	.loc 1 206 0
	popl	%ebp
.LCFI89:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE49:
	.size	sys_ls_call21, .-sys_ls_call21
	.globl	sys_ls_call22
	.type	sys_ls_call22, @function
sys_ls_call22:
.LFB50:
	.loc 1 209 0
	.cfi_startproc
	pushl	%ebp
.LCFI90:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI91:
	.cfi_def_cfa_register 5
	.loc 1 210 0
	movl	$22, %eax
	.loc 1 211 0
	popl	%ebp
.LCFI92:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE50:
	.size	sys_ls_call22, .-sys_ls_call22
	.globl	sys_ls_call23
	.type	sys_ls_call23, @function
sys_ls_call23:
.LFB51:
	.loc 1 214 0
	.cfi_startproc
	pushl	%ebp
.LCFI93:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI94:
	.cfi_def_cfa_register 5
	.loc 1 215 0
	movl	$23, %eax
	.loc 1 216 0
	popl	%ebp
.LCFI95:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE51:
	.size	sys_ls_call23, .-sys_ls_call23
	.globl	sys_ls_call24
	.type	sys_ls_call24, @function
sys_ls_call24:
.LFB52:
	.loc 1 219 0
	.cfi_startproc
	pushl	%ebp
.LCFI96:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI97:
	.cfi_def_cfa_register 5
	.loc 1 220 0
	movl	$24, %eax
	.loc 1 221 0
	popl	%ebp
.LCFI98:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE52:
	.size	sys_ls_call24, .-sys_ls_call24
	.globl	sys_ls_call25
	.type	sys_ls_call25, @function
sys_ls_call25:
.LFB53:
	.loc 1 224 0
	.cfi_startproc
	pushl	%ebp
.LCFI99:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI100:
	.cfi_def_cfa_register 5
	.loc 1 225 0
	movl	$25, %eax
	.loc 1 226 0
	popl	%ebp
.LCFI101:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE53:
	.size	sys_ls_call25, .-sys_ls_call25
	.globl	sys_ls_call26
	.type	sys_ls_call26, @function
sys_ls_call26:
.LFB54:
	.loc 1 229 0
	.cfi_startproc
	pushl	%ebp
.LCFI102:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI103:
	.cfi_def_cfa_register 5
	.loc 1 230 0
	movl	$26, %eax
	.loc 1 231 0
	popl	%ebp
.LCFI104:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE54:
	.size	sys_ls_call26, .-sys_ls_call26
	.globl	sys_ls_call27
	.type	sys_ls_call27, @function
sys_ls_call27:
.LFB55:
	.loc 1 234 0
	.cfi_startproc
	pushl	%ebp
.LCFI105:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI106:
	.cfi_def_cfa_register 5
	.loc 1 235 0
	movl	$27, %eax
	.loc 1 236 0
	popl	%ebp
.LCFI107:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE55:
	.size	sys_ls_call27, .-sys_ls_call27
	.globl	sys_ls_call28
	.type	sys_ls_call28, @function
sys_ls_call28:
.LFB56:
	.loc 1 239 0
	.cfi_startproc
	pushl	%ebp
.LCFI108:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI109:
	.cfi_def_cfa_register 5
	.loc 1 240 0
	movl	$28, %eax
	.loc 1 241 0
	popl	%ebp
.LCFI110:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE56:
	.size	sys_ls_call28, .-sys_ls_call28
	.globl	sys_ls_call29
	.type	sys_ls_call29, @function
sys_ls_call29:
.LFB57:
	.loc 1 244 0
	.cfi_startproc
	pushl	%ebp
.LCFI111:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI112:
	.cfi_def_cfa_register 5
	.loc 1 245 0
	movl	$29, %eax
	.loc 1 246 0
	popl	%ebp
.LCFI113:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE57:
	.size	sys_ls_call29, .-sys_ls_call29
	.globl	sys_ls_call30
	.type	sys_ls_call30, @function
sys_ls_call30:
.LFB58:
	.loc 1 249 0
	.cfi_startproc
	pushl	%ebp
.LCFI114:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI115:
	.cfi_def_cfa_register 5
	.loc 1 250 0
	movl	$30, %eax
	.loc 1 251 0
	popl	%ebp
.LCFI116:
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE58:
	.size	sys_ls_call30, .-sys_ls_call30
.Letext0:
	.file 2 "types.h"
	.file 3 "x86.h"
	.file 4 "date.h"
	.file 5 "proc.h"
	.file 6 "defs.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xa5a
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF96
	.byte	0x1
	.long	.LASF97
	.long	.LASF98
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF0
	.byte	0x2
	.byte	0x1
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.long	.LASF1
	.byte	0x2
	.byte	0x2
	.long	0x42
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x2
	.long	.LASF5
	.byte	0x2
	.byte	0x4
	.long	0x25
	.uleb128 0x4
	.long	.LASF15
	.byte	0x4c
	.byte	0x3
	.byte	0x9c
	.long	0x1c0
	.uleb128 0x5
	.string	"edi"
	.byte	0x3
	.byte	0x9e
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.string	"esi"
	.byte	0x3
	.byte	0x9f
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.string	"ebp"
	.byte	0x3
	.byte	0xa0
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.long	.LASF6
	.byte	0x3
	.byte	0xa1
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.string	"ebx"
	.byte	0x3
	.byte	0xa2
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x5
	.string	"edx"
	.byte	0x3
	.byte	0xa3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x5
	.string	"ecx"
	.byte	0x3
	.byte	0xa4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x5
	.string	"eax"
	.byte	0x3
	.byte	0xa5
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x5
	.string	"gs"
	.byte	0x3
	.byte	0xa8
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x6
	.long	.LASF7
	.byte	0x3
	.byte	0xa9
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x22
	.uleb128 0x5
	.string	"fs"
	.byte	0x3
	.byte	0xaa
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x6
	.long	.LASF8
	.byte	0x3
	.byte	0xab
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x26
	.uleb128 0x5
	.string	"es"
	.byte	0x3
	.byte	0xac
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x6
	.long	.LASF9
	.byte	0x3
	.byte	0xad
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x2a
	.uleb128 0x5
	.string	"ds"
	.byte	0x3
	.byte	0xae
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.uleb128 0x6
	.long	.LASF10
	.byte	0x3
	.byte	0xaf
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x2e
	.uleb128 0x6
	.long	.LASF11
	.byte	0x3
	.byte	0xb0
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x5
	.string	"err"
	.byte	0x3
	.byte	0xb3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0x5
	.string	"eip"
	.byte	0x3
	.byte	0xb4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x5
	.string	"cs"
	.byte	0x3
	.byte	0xb5
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x3c
	.uleb128 0x6
	.long	.LASF12
	.byte	0x3
	.byte	0xb6
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x3e
	.uleb128 0x6
	.long	.LASF13
	.byte	0x3
	.byte	0xb7
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0x5
	.string	"esp"
	.byte	0x3
	.byte	0xba
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x44
	.uleb128 0x5
	.string	"ss"
	.byte	0x3
	.byte	0xbb
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x6
	.long	.LASF14
	.byte	0x3
	.byte	0xbc
	.long	0x37
	.byte	0x2
	.byte	0x23
	.uleb128 0x4a
	.byte	0
	.uleb128 0x4
	.long	.LASF16
	.byte	0x18
	.byte	0x4
	.byte	0x1
	.long	0x221
	.uleb128 0x6
	.long	.LASF17
	.byte	0x4
	.byte	0x2
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.long	.LASF18
	.byte	0x4
	.byte	0x3
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.long	.LASF19
	.byte	0x4
	.byte	0x4
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.string	"day"
	.byte	0x4
	.byte	0x5
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.long	.LASF20
	.byte	0x4
	.byte	0x6
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x6
	.long	.LASF21
	.byte	0x4
	.byte	0x7
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.uleb128 0x4
	.long	.LASF22
	.byte	0x14
	.byte	0x5
	.byte	0x2c
	.long	0x276
	.uleb128 0x5
	.string	"edi"
	.byte	0x5
	.byte	0x2d
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x5
	.string	"esi"
	.byte	0x5
	.byte	0x2e
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x5
	.string	"ebx"
	.byte	0x5
	.byte	0x2f
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x5
	.string	"ebp"
	.byte	0x5
	.byte	0x30
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.string	"eip"
	.byte	0x5
	.byte	0x31
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x223
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF23
	.uleb128 0x9
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x4
	.long	.LASF24
	.byte	0x7c
	.byte	0x5
	.byte	0x37
	.long	0x34b
	.uleb128 0x5
	.string	"sz"
	.byte	0x5
	.byte	0x38
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x6
	.long	.LASF25
	.byte	0x5
	.byte	0x39
	.long	0x382
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.long	.LASF26
	.byte	0x5
	.byte	0x3a
	.long	0x388
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.long	.LASF27
	.byte	0x5
	.byte	0x3b
	.long	0x351
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x5
	.string	"pid"
	.byte	0x5
	.byte	0x3c
	.long	0x283
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x6
	.long	.LASF28
	.byte	0x5
	.byte	0x3d
	.long	0x34b
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x5
	.string	"tf"
	.byte	0x5
	.byte	0x3e
	.long	0x395
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x6
	.long	.LASF22
	.byte	0x5
	.byte	0x3f
	.long	0x276
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x6
	.long	.LASF29
	.byte	0x5
	.byte	0x40
	.long	0x221
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x6
	.long	.LASF30
	.byte	0x5
	.byte	0x41
	.long	0x283
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x6
	.long	.LASF31
	.byte	0x5
	.byte	0x42
	.long	0x39b
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x5
	.string	"cwd"
	.byte	0x5
	.byte	0x43
	.long	0x3bd
	.byte	0x2
	.byte	0x23
	.uleb128 0x68
	.uleb128 0x6
	.long	.LASF32
	.byte	0x5
	.byte	0x44
	.long	0x3c3
	.byte	0x2
	.byte	0x23
	.uleb128 0x6c
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x28a
	.uleb128 0xa
	.long	.LASF99
	.byte	0x4
	.byte	0x5
	.byte	0x34
	.long	0x382
	.uleb128 0xb
	.long	.LASF33
	.sleb128 0
	.uleb128 0xb
	.long	.LASF34
	.sleb128 1
	.uleb128 0xb
	.long	.LASF35
	.sleb128 2
	.uleb128 0xb
	.long	.LASF36
	.sleb128 3
	.uleb128 0xb
	.long	.LASF37
	.sleb128 4
	.uleb128 0xb
	.long	.LASF38
	.sleb128 5
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x50
	.uleb128 0x8
	.byte	0x4
	.long	0x38e
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF39
	.uleb128 0x8
	.byte	0x4
	.long	0x5b
	.uleb128 0xc
	.long	0x3b1
	.long	0x3ab
	.uleb128 0xd
	.long	0x27c
	.byte	0xf
	.byte	0
	.uleb128 0xe
	.long	.LASF40
	.byte	0x1
	.uleb128 0x8
	.byte	0x4
	.long	0x3ab
	.uleb128 0xe
	.long	.LASF41
	.byte	0x1
	.uleb128 0x8
	.byte	0x4
	.long	0x3b7
	.uleb128 0xc
	.long	0x38e
	.long	0x3d3
	.uleb128 0xd
	.long	0x27c
	.byte	0xf
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF42
	.byte	0x1
	.byte	0xb
	.byte	0x1
	.long	0x283
	.long	.LFB20
	.long	.LFE20
	.long	.LLST0
	.byte	0x1
	.long	0x3fb
	.uleb128 0x10
	.long	.LVL0
	.long	0x965
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF43
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.long	0x283
	.long	.LFB21
	.long	.LFE21
	.long	.LLST1
	.byte	0x1
	.long	0x423
	.uleb128 0x10
	.long	.LVL1
	.long	0x973
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF44
	.byte	0x1
	.byte	0x18
	.byte	0x1
	.long	0x283
	.long	.LFB22
	.long	.LFE22
	.long	.LLST2
	.byte	0x1
	.long	0x44b
	.uleb128 0x10
	.long	.LVL2
	.long	0x97d
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF45
	.byte	0x1
	.byte	0x1e
	.byte	0x1
	.long	0x283
	.long	.LFB23
	.long	.LFE23
	.long	.LLST3
	.byte	0x1
	.long	0x49c
	.uleb128 0x11
	.string	"pid"
	.byte	0x1
	.byte	0x20
	.long	0x283
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x12
	.long	.LVL3
	.long	0x98b
	.long	0x492
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x30
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x10
	.long	.LVL5
	.long	0x9ae
	.byte	0
	.uleb128 0x14
	.byte	0x1
	.long	.LASF53
	.byte	0x1
	.byte	0x28
	.byte	0x1
	.long	0x283
	.long	.LFB24
	.long	.LFE24
	.long	.LLST4
	.byte	0x1
	.uleb128 0xf
	.byte	0x1
	.long	.LASF46
	.byte	0x1
	.byte	0x2e
	.byte	0x1
	.long	0x283
	.long	.LFB25
	.long	.LFE25
	.long	.LLST5
	.byte	0x1
	.long	0x514
	.uleb128 0x15
	.long	.LASF47
	.byte	0x1
	.byte	0x30
	.long	0x283
	.long	.LLST6
	.uleb128 0x11
	.string	"n"
	.byte	0x1
	.byte	0x31
	.long	0x283
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.long	.LVL6
	.long	0x98b
	.long	0x50a
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x30
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x10
	.long	.LVL9
	.long	0x9c6
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF48
	.byte	0x1
	.byte	0x3c
	.byte	0x1
	.long	0x283
	.long	.LFB26
	.long	.LFE26
	.long	.LLST7
	.byte	0x1
	.long	0x58d
	.uleb128 0x11
	.string	"n"
	.byte	0x1
	.byte	0x3e
	.long	0x283
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x15
	.long	.LASF49
	.byte	0x1
	.byte	0x3f
	.long	0x25
	.long	.LLST8
	.uleb128 0x12
	.long	.LVL11
	.long	0x98b
	.long	0x568
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x30
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x10
	.long	.LVL12
	.long	0x9de
	.uleb128 0x10
	.long	.LVL15
	.long	0x9f8
	.uleb128 0x10
	.long	.LVL16
	.long	0xa0c
	.uleb128 0x10
	.long	.LVL17
	.long	0x9f8
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF50
	.byte	0x1
	.byte	0x53
	.byte	0x1
	.long	0x283
	.long	.LFB27
	.long	.LFE27
	.long	.LLST9
	.byte	0x1
	.long	0x5cd
	.uleb128 0x15
	.long	.LASF51
	.byte	0x1
	.byte	0x55
	.long	0x25
	.long	.LLST10
	.uleb128 0x10
	.long	.LVL19
	.long	0x9de
	.uleb128 0x10
	.long	.LVL21
	.long	0x9f8
	.byte	0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF52
	.byte	0x1
	.byte	0x5e
	.byte	0x1
	.long	0x283
	.long	.LFB28
	.long	.LFE28
	.long	.LLST11
	.byte	0x1
	.long	0x622
	.uleb128 0x11
	.string	"r"
	.byte	0x1
	.byte	0x60
	.long	0x622
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x12
	.long	.LVL22
	.long	0xa25
	.long	0x618
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 0
	.byte	0x1
	.byte	0x30
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 4
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x13
	.byte	0x2
	.byte	0x74
	.sleb128 8
	.byte	0x1
	.byte	0x48
	.byte	0
	.uleb128 0x10
	.long	.LVL24
	.long	0xa4d
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x1c0
	.uleb128 0x14
	.byte	0x1
	.long	.LASF54
	.byte	0x1
	.byte	0x67
	.byte	0x1
	.long	0x283
	.long	.LFB29
	.long	.LFE29
	.long	.LLST12
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF55
	.byte	0x1
	.byte	0x6c
	.byte	0x1
	.long	0x283
	.long	.LFB30
	.long	.LFE30
	.long	.LLST13
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF56
	.byte	0x1
	.byte	0x71
	.byte	0x1
	.long	0x283
	.long	.LFB31
	.long	.LFE31
	.long	.LLST14
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF57
	.byte	0x1
	.byte	0x76
	.byte	0x1
	.long	0x283
	.long	.LFB32
	.long	.LFE32
	.long	.LLST15
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF58
	.byte	0x1
	.byte	0x7b
	.byte	0x1
	.long	0x283
	.long	.LFB33
	.long	.LFE33
	.long	.LLST16
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF59
	.byte	0x1
	.byte	0x80
	.byte	0x1
	.long	0x283
	.long	.LFB34
	.long	.LFE34
	.long	.LLST17
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF60
	.byte	0x1
	.byte	0x85
	.byte	0x1
	.long	0x283
	.long	.LFB35
	.long	.LFE35
	.long	.LLST18
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF61
	.byte	0x1
	.byte	0x8a
	.byte	0x1
	.long	0x283
	.long	.LFB36
	.long	.LFE36
	.long	.LLST19
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF62
	.byte	0x1
	.byte	0x8f
	.byte	0x1
	.long	0x283
	.long	.LFB37
	.long	.LFE37
	.long	.LLST20
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF63
	.byte	0x1
	.byte	0x94
	.byte	0x1
	.long	0x283
	.long	.LFB38
	.long	.LFE38
	.long	.LLST21
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF64
	.byte	0x1
	.byte	0x99
	.byte	0x1
	.long	0x283
	.long	.LFB39
	.long	.LFE39
	.long	.LLST22
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF65
	.byte	0x1
	.byte	0x9e
	.byte	0x1
	.long	0x283
	.long	.LFB40
	.long	.LFE40
	.long	.LLST23
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF66
	.byte	0x1
	.byte	0xa3
	.byte	0x1
	.long	0x283
	.long	.LFB41
	.long	.LFE41
	.long	.LLST24
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF67
	.byte	0x1
	.byte	0xa8
	.byte	0x1
	.long	0x283
	.long	.LFB42
	.long	.LFE42
	.long	.LLST25
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF68
	.byte	0x1
	.byte	0xad
	.byte	0x1
	.long	0x283
	.long	.LFB43
	.long	.LFE43
	.long	.LLST26
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF69
	.byte	0x1
	.byte	0xb2
	.byte	0x1
	.long	0x283
	.long	.LFB44
	.long	.LFE44
	.long	.LLST27
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF70
	.byte	0x1
	.byte	0xb7
	.byte	0x1
	.long	0x283
	.long	.LFB45
	.long	.LFE45
	.long	.LLST28
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF71
	.byte	0x1
	.byte	0xbc
	.byte	0x1
	.long	0x283
	.long	.LFB46
	.long	.LFE46
	.long	.LLST29
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF72
	.byte	0x1
	.byte	0xc1
	.byte	0x1
	.long	0x283
	.long	.LFB47
	.long	.LFE47
	.long	.LLST30
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF73
	.byte	0x1
	.byte	0xc6
	.byte	0x1
	.long	0x283
	.long	.LFB48
	.long	.LFE48
	.long	.LLST31
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF74
	.byte	0x1
	.byte	0xcb
	.byte	0x1
	.long	0x283
	.long	.LFB49
	.long	.LFE49
	.long	.LLST32
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF75
	.byte	0x1
	.byte	0xd0
	.byte	0x1
	.long	0x283
	.long	.LFB50
	.long	.LFE50
	.long	.LLST33
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF76
	.byte	0x1
	.byte	0xd5
	.byte	0x1
	.long	0x283
	.long	.LFB51
	.long	.LFE51
	.long	.LLST34
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF77
	.byte	0x1
	.byte	0xda
	.byte	0x1
	.long	0x283
	.long	.LFB52
	.long	.LFE52
	.long	.LLST35
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF78
	.byte	0x1
	.byte	0xdf
	.byte	0x1
	.long	0x283
	.long	.LFB53
	.long	.LFE53
	.long	.LLST36
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF79
	.byte	0x1
	.byte	0xe4
	.byte	0x1
	.long	0x283
	.long	.LFB54
	.long	.LFE54
	.long	.LLST37
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF80
	.byte	0x1
	.byte	0xe9
	.byte	0x1
	.long	0x283
	.long	.LFB55
	.long	.LFE55
	.long	.LLST38
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF81
	.byte	0x1
	.byte	0xee
	.byte	0x1
	.long	0x283
	.long	.LFB56
	.long	.LFE56
	.long	.LLST39
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF82
	.byte	0x1
	.byte	0xf3
	.byte	0x1
	.long	0x283
	.long	.LFB57
	.long	.LFE57
	.long	.LLST40
	.byte	0x1
	.uleb128 0x14
	.byte	0x1
	.long	.LASF83
	.byte	0x1
	.byte	0xf8
	.byte	0x1
	.long	0x283
	.long	.LFB58
	.long	.LFE58
	.long	.LLST41
	.byte	0x1
	.uleb128 0xe
	.long	.LASF84
	.byte	0x1
	.uleb128 0x16
	.long	.LASF85
	.byte	0x6
	.byte	0x9d
	.long	0x25
	.byte	0x1
	.byte	0x1
	.uleb128 0x16
	.long	.LASF86
	.byte	0x6
	.byte	0x9f
	.long	0x934
	.byte	0x1
	.byte	0x1
	.uleb128 0x17
	.long	.LASF24
	.byte	0x5
	.byte	0x1f
	.long	.LASF100
	.long	0x34b
	.byte	0x1
	.byte	0x1
	.uleb128 0x18
	.byte	0x1
	.long	.LASF87
	.byte	0x6
	.byte	0x6d
	.byte	0x1
	.long	0x283
	.byte	0x1
	.uleb128 0x19
	.byte	0x1
	.long	.LASF101
	.byte	0x6
	.byte	0x6c
	.byte	0x1
	.byte	0x1
	.uleb128 0x18
	.byte	0x1
	.long	.LASF88
	.byte	0x6
	.byte	0x76
	.byte	0x1
	.long	0x283
	.byte	0x1
	.uleb128 0x1a
	.byte	0x1
	.long	.LASF89
	.byte	0x6
	.byte	0x90
	.byte	0x1
	.long	0x283
	.byte	0x1
	.long	0x9a8
	.uleb128 0x1b
	.long	0x283
	.uleb128 0x1b
	.long	0x9a8
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x283
	.uleb128 0x1a
	.byte	0x1
	.long	.LASF90
	.byte	0x6
	.byte	0x6f
	.byte	0x1
	.long	0x283
	.byte	0x1
	.long	0x9c6
	.uleb128 0x1b
	.long	0x283
	.byte	0
	.uleb128 0x1a
	.byte	0x1
	.long	.LASF91
	.byte	0x6
	.byte	0x6e
	.byte	0x1
	.long	0x283
	.byte	0x1
	.long	0x9de
	.uleb128 0x1b
	.long	0x283
	.byte	0
	.uleb128 0x1c
	.byte	0x1
	.long	.LASF92
	.byte	0x6
	.byte	0x7e
	.byte	0x1
	.byte	0x1
	.long	0x9f2
	.uleb128 0x1b
	.long	0x9f2
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x934
	.uleb128 0x1c
	.byte	0x1
	.long	.LASF93
	.byte	0x6
	.byte	0x82
	.byte	0x1
	.byte	0x1
	.long	0xa0c
	.uleb128 0x1b
	.long	0x9f2
	.byte	0
	.uleb128 0x1c
	.byte	0x1
	.long	.LASF94
	.byte	0x6
	.byte	0x74
	.byte	0x1
	.byte	0x1
	.long	0xa25
	.uleb128 0x1b
	.long	0x221
	.uleb128 0x1b
	.long	0x9f2
	.byte	0
	.uleb128 0x1a
	.byte	0x1
	.long	.LASF95
	.byte	0x6
	.byte	0x91
	.byte	0x1
	.long	0x283
	.byte	0x1
	.long	0xa47
	.uleb128 0x1b
	.long	0x283
	.uleb128 0x1b
	.long	0xa47
	.uleb128 0x1b
	.long	0x283
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x388
	.uleb128 0x1d
	.byte	0x1
	.long	.LASF102
	.byte	0x6
	.byte	0x4b
	.byte	0x1
	.byte	0x1
	.uleb128 0x1b
	.long	0x622
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xb
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
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
	.uleb128 0x15
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x1b
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB20-.Ltext0
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
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST1:
	.long	.LFB21-.Ltext0
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
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST2:
	.long	.LFB22-.Ltext0
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
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST3:
	.long	.LFB23-.Ltext0
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
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST4:
	.long	.LFB24-.Ltext0
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
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST5:
	.long	.LFB25-.Ltext0
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
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST6:
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL9-1-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST7:
	.long	.LFB26-.Ltext0
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
	.long	.LFE26-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST8:
	.long	.LVL13-.Ltext0
	.long	.LVL14-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL14-.Ltext0
	.long	.LVL18-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST9:
	.long	.LFB27-.Ltext0
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
	.long	.LFE27-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST10:
	.long	.LVL20-.Ltext0
	.long	.LVL21-1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL21-1-.Ltext0
	.long	.LFE27-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 -20
	.long	0
	.long	0
.LLST11:
	.long	.LFB28-.Ltext0
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
	.long	.LFE28-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST12:
	.long	.LFB29-.Ltext0
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
	.long	.LFE29-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST13:
	.long	.LFB30-.Ltext0
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
	.long	.LFE30-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST14:
	.long	.LFB31-.Ltext0
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
	.long	.LFE31-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST15:
	.long	.LFB32-.Ltext0
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
	.long	.LFE32-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST16:
	.long	.LFB33-.Ltext0
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
	.long	.LFE33-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST17:
	.long	.LFB34-.Ltext0
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
	.long	.LFE34-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST18:
	.long	.LFB35-.Ltext0
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
	.long	.LFE35-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST19:
	.long	.LFB36-.Ltext0
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
	.long	.LFE36-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST20:
	.long	.LFB37-.Ltext0
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
	.long	.LFE37-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST21:
	.long	.LFB38-.Ltext0
	.long	.LCFI54-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI54-.Ltext0
	.long	.LCFI55-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI55-.Ltext0
	.long	.LCFI56-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI56-.Ltext0
	.long	.LFE38-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST22:
	.long	.LFB39-.Ltext0
	.long	.LCFI57-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI57-.Ltext0
	.long	.LCFI58-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI58-.Ltext0
	.long	.LCFI59-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI59-.Ltext0
	.long	.LFE39-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST23:
	.long	.LFB40-.Ltext0
	.long	.LCFI60-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI60-.Ltext0
	.long	.LCFI61-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI61-.Ltext0
	.long	.LCFI62-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI62-.Ltext0
	.long	.LFE40-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST24:
	.long	.LFB41-.Ltext0
	.long	.LCFI63-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI63-.Ltext0
	.long	.LCFI64-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI64-.Ltext0
	.long	.LCFI65-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI65-.Ltext0
	.long	.LFE41-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST25:
	.long	.LFB42-.Ltext0
	.long	.LCFI66-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI66-.Ltext0
	.long	.LCFI67-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI67-.Ltext0
	.long	.LCFI68-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI68-.Ltext0
	.long	.LFE42-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST26:
	.long	.LFB43-.Ltext0
	.long	.LCFI69-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI69-.Ltext0
	.long	.LCFI70-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI70-.Ltext0
	.long	.LCFI71-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI71-.Ltext0
	.long	.LFE43-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST27:
	.long	.LFB44-.Ltext0
	.long	.LCFI72-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI72-.Ltext0
	.long	.LCFI73-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI73-.Ltext0
	.long	.LCFI74-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI74-.Ltext0
	.long	.LFE44-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST28:
	.long	.LFB45-.Ltext0
	.long	.LCFI75-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI75-.Ltext0
	.long	.LCFI76-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI76-.Ltext0
	.long	.LCFI77-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI77-.Ltext0
	.long	.LFE45-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST29:
	.long	.LFB46-.Ltext0
	.long	.LCFI78-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI78-.Ltext0
	.long	.LCFI79-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI79-.Ltext0
	.long	.LCFI80-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI80-.Ltext0
	.long	.LFE46-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST30:
	.long	.LFB47-.Ltext0
	.long	.LCFI81-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI81-.Ltext0
	.long	.LCFI82-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI82-.Ltext0
	.long	.LCFI83-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI83-.Ltext0
	.long	.LFE47-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST31:
	.long	.LFB48-.Ltext0
	.long	.LCFI84-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI84-.Ltext0
	.long	.LCFI85-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI85-.Ltext0
	.long	.LCFI86-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI86-.Ltext0
	.long	.LFE48-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST32:
	.long	.LFB49-.Ltext0
	.long	.LCFI87-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI87-.Ltext0
	.long	.LCFI88-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI88-.Ltext0
	.long	.LCFI89-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI89-.Ltext0
	.long	.LFE49-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST33:
	.long	.LFB50-.Ltext0
	.long	.LCFI90-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI90-.Ltext0
	.long	.LCFI91-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI91-.Ltext0
	.long	.LCFI92-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI92-.Ltext0
	.long	.LFE50-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST34:
	.long	.LFB51-.Ltext0
	.long	.LCFI93-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI93-.Ltext0
	.long	.LCFI94-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI94-.Ltext0
	.long	.LCFI95-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI95-.Ltext0
	.long	.LFE51-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST35:
	.long	.LFB52-.Ltext0
	.long	.LCFI96-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI96-.Ltext0
	.long	.LCFI97-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI97-.Ltext0
	.long	.LCFI98-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI98-.Ltext0
	.long	.LFE52-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST36:
	.long	.LFB53-.Ltext0
	.long	.LCFI99-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI99-.Ltext0
	.long	.LCFI100-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI100-.Ltext0
	.long	.LCFI101-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI101-.Ltext0
	.long	.LFE53-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST37:
	.long	.LFB54-.Ltext0
	.long	.LCFI102-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI102-.Ltext0
	.long	.LCFI103-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI103-.Ltext0
	.long	.LCFI104-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI104-.Ltext0
	.long	.LFE54-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST38:
	.long	.LFB55-.Ltext0
	.long	.LCFI105-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI105-.Ltext0
	.long	.LCFI106-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI106-.Ltext0
	.long	.LCFI107-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI107-.Ltext0
	.long	.LFE55-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST39:
	.long	.LFB56-.Ltext0
	.long	.LCFI108-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI108-.Ltext0
	.long	.LCFI109-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI109-.Ltext0
	.long	.LCFI110-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI110-.Ltext0
	.long	.LFE56-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST40:
	.long	.LFB57-.Ltext0
	.long	.LCFI111-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI111-.Ltext0
	.long	.LCFI112-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI112-.Ltext0
	.long	.LCFI113-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI113-.Ltext0
	.long	.LFE57-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST41:
	.long	.LFB58-.Ltext0
	.long	.LCFI114-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI114-.Ltext0
	.long	.LCFI115-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI115-.Ltext0
	.long	.LCFI116-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI116-.Ltext0
	.long	.LFE58-.Ltext0
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
.LASF49:
	.string	"ticks0"
.LASF65:
	.string	"sys_ls_call12"
.LASF34:
	.string	"EMBRYO"
.LASF63:
	.string	"sys_ls_call10"
.LASF64:
	.string	"sys_ls_call11"
.LASF35:
	.string	"SLEEPING"
.LASF66:
	.string	"sys_ls_call13"
.LASF41:
	.string	"inode"
.LASF36:
	.string	"RUNNABLE"
.LASF67:
	.string	"sys_ls_call14"
.LASF53:
	.string	"sys_getpid"
.LASF68:
	.string	"sys_ls_call15"
.LASF27:
	.string	"state"
.LASF69:
	.string	"sys_ls_call16"
.LASF70:
	.string	"sys_ls_call17"
.LASF93:
	.string	"release"
.LASF71:
	.string	"sys_ls_call18"
.LASF23:
	.string	"sizetype"
.LASF13:
	.string	"eflags"
.LASF38:
	.string	"ZOMBIE"
.LASF98:
	.string	"/home/supadhy2/cs550/cs550_assignment2/xv6-cs550-2016,1s-p1-baseline"
.LASF43:
	.string	"sys_exit"
.LASF72:
	.string	"sys_ls_call19"
.LASF0:
	.string	"uint"
.LASF40:
	.string	"file"
.LASF21:
	.string	"year"
.LASF45:
	.string	"sys_kill"
.LASF50:
	.string	"sys_uptime"
.LASF87:
	.string	"fork"
.LASF28:
	.string	"parent"
.LASF91:
	.string	"growproc"
.LASF30:
	.string	"killed"
.LASF88:
	.string	"wait"
.LASF73:
	.string	"sys_ls_call20"
.LASF74:
	.string	"sys_ls_call21"
.LASF75:
	.string	"sys_ls_call22"
.LASF76:
	.string	"sys_ls_call23"
.LASF77:
	.string	"sys_ls_call24"
.LASF78:
	.string	"sys_ls_call25"
.LASF79:
	.string	"sys_ls_call26"
.LASF16:
	.string	"rtcdate"
.LASF81:
	.string	"sys_ls_call28"
.LASF82:
	.string	"sys_ls_call29"
.LASF1:
	.string	"ushort"
.LASF8:
	.string	"padding2"
.LASF9:
	.string	"padding3"
.LASF10:
	.string	"padding4"
.LASF5:
	.string	"pde_t"
.LASF14:
	.string	"padding6"
.LASF47:
	.string	"addr"
.LASF7:
	.string	"padding1"
.LASF15:
	.string	"trapframe"
.LASF12:
	.string	"padding5"
.LASF32:
	.string	"name"
.LASF101:
	.string	"exit"
.LASF51:
	.string	"xticks"
.LASF19:
	.string	"hour"
.LASF44:
	.string	"sys_wait"
.LASF31:
	.string	"ofile"
.LASF4:
	.string	"unsigned char"
.LASF90:
	.string	"kill"
.LASF17:
	.string	"second"
.LASF2:
	.string	"unsigned int"
.LASF96:
	.string	"GNU C 4.7.2"
.LASF22:
	.string	"context"
.LASF83:
	.string	"sys_ls_call30"
.LASF94:
	.string	"sleep"
.LASF92:
	.string	"acquire"
.LASF26:
	.string	"kstack"
.LASF3:
	.string	"short unsigned int"
.LASF85:
	.string	"ticks"
.LASF29:
	.string	"chan"
.LASF39:
	.string	"char"
.LASF37:
	.string	"RUNNING"
.LASF86:
	.string	"tickslock"
.LASF20:
	.string	"month"
.LASF46:
	.string	"sys_sbrk"
.LASF102:
	.string	"cmostime"
.LASF33:
	.string	"UNUSED"
.LASF24:
	.string	"proc"
.LASF18:
	.string	"minute"
.LASF52:
	.string	"sys_date"
.LASF54:
	.string	"sys_ls_call01"
.LASF55:
	.string	"sys_ls_call02"
.LASF56:
	.string	"sys_ls_call03"
.LASF57:
	.string	"sys_ls_call04"
.LASF58:
	.string	"sys_ls_call05"
.LASF59:
	.string	"sys_ls_call06"
.LASF60:
	.string	"sys_ls_call07"
.LASF61:
	.string	"sys_ls_call08"
.LASF62:
	.string	"sys_ls_call09"
.LASF84:
	.string	"spinlock"
.LASF42:
	.string	"sys_fork"
.LASF48:
	.string	"sys_sleep"
.LASF95:
	.string	"argptr"
.LASF6:
	.string	"oesp"
.LASF99:
	.string	"procstate"
.LASF80:
	.string	"sys_ls_call27"
.LASF97:
	.string	"sysproc.c"
.LASF25:
	.string	"pgdir"
.LASF100:
	.string	"%gs:4"
.LASF11:
	.string	"trapno"
.LASF89:
	.string	"argint"
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
