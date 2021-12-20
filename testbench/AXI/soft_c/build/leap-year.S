	.file	1 "leap-year.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 1
	.text
	.align	2
	.globl	delay
	.set	nomips16
	.set	nomicromips
	.ent	delay
	.type	delay, @function
delay:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$0,0($fp)
	b	.L2
	nop

.L3:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
.L2:
	lw	$3,0($fp)
	li	$2,4980736			# 0x4c0000
	ori	$2,$2,0x4b40
	bne	$3,$2,.L3
	nop

	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	delay
	.size	delay, .-delay
	.align	2
	.globl	init
	.set	nomips16
	.set	nomicromips
	.ent	init
	.type	init, @function
init:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,240			# 0xf0
	sw	$3,0($2)
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf010
	li	$3,255			# 0xff
	sw	$3,0($2)
	jal	delay
	nop

	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	init
	.size	init, .-init
	.align	2
	.globl	print_result
	.set	nomips16
	.set	nomicromips
	.ent	print_result
	.type	print_result, @function
print_result:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	lw	$3,24($fp)
	li	$2,1			# 0x1
	bne	$3,$2,.L6
	nop

.L7:
	jal	delay
	nop

	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,15			# 0xf
	sw	$3,0($2)
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf010
	li	$3,65280			# 0xff00
	sw	$3,0($2)
	b	.L7
	nop

.L6:
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,240			# 0xf0
	sw	$3,0($2)
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf010
	li	$3,255			# 0xff
	sw	$3,0($2)
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	print_result
	.size	print_result, .-print_result
	.align	2
	.globl	is_leap_year
	.set	nomips16
	.set	nomicromips
	.ent	is_leap_year
	.type	is_leap_year, @function
is_leap_year:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	nop
	andi	$2,$2,0x3
	bne	$2,$0,.L9
	nop

	lw	$3,8($fp)
	li	$2,100			# 0x64
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	bne	$2,$0,.L10
	nop

.L9:
	lw	$3,8($fp)
	li	$2,400			# 0x190
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	bne	$2,$0,.L11
	nop

.L10:
	li	$2,1			# 0x1
	b	.L12
	nop

.L11:
	move	$2,$0
.L12:
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	is_leap_year
	.size	is_leap_year, .-is_leap_year
	.globl	ans
	.data
	.align	2
	.type	ans, @object
	.size	ans, 500
ans:
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	jal	init
	nop

	sw	$0,16($fp)
	sw	$0,20($fp)
	b	.L15
	nop

.L18:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1890
	move	$4,$2
	jal	is_leap_year
	nop

	move	$3,$2
	lui	$2,%hi(ans)
	lw	$4,20($fp)
	nop
	sll	$4,$4,2
	addiu	$2,$2,%lo(ans)
	addu	$2,$4,$2
	lw	$2,0($2)
	nop
	beq	$3,$2,.L16
	nop

	li	$2,1			# 0x1
	sw	$2,16($fp)
	b	.L17
	nop

.L16:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
.L15:
	lw	$2,20($fp)
	nop
	sltu	$2,$2,125
	bne	$2,$0,.L18
	nop

.L17:
	lw	$3,20($fp)
	li	$2,125			# 0x7d
	beq	$3,$2,.L19
	nop

	li	$2,1			# 0x1
	sw	$2,16($fp)
.L19:
	lw	$2,16($fp)
	nop
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	move	$4,$2
	jal	print_result
	nop

.L20:
	b	.L20
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2013.05-65) 4.7.3"
