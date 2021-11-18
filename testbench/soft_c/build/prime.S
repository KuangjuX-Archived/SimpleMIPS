	.file	1 "prime.c"
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
	b	.L7
	nop

.L6:
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,240			# 0xf0
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
	.globl	ans
	.data
	.align	2
	.type	ans, @object
	.size	ans, 84
ans:
	.word	101
	.word	103
	.word	107
	.word	109
	.word	113
	.word	127
	.word	131
	.word	137
	.word	139
	.word	149
	.word	151
	.word	157
	.word	163
	.word	167
	.word	173
	.word	179
	.word	181
	.word	191
	.word	193
	.word	197
	.word	199
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,48,$31		# vars= 24, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$fp,40($sp)
	move	$fp,$sp
	jal	init
	nop

	sw	$0,16($fp)
	sw	$0,28($fp)
	li	$2,101			# 0x65
	sw	$2,20($fp)
	b	.L9
	nop

.L17:
	li	$2,1			# 0x1
	sw	$2,32($fp)
	li	$2,2			# 0x2
	sw	$2,24($fp)
	b	.L10
	nop

.L13:
	lw	$3,20($fp)
	lw	$2,24($fp)
	nop
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	bne	$2,$0,.L11
	nop

	sw	$0,32($fp)
	b	.L12
	nop

.L11:
	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
.L10:
	lw	$3,24($fp)
	lw	$2,20($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,.L13
	nop

.L12:
	lw	$2,32($fp)
	nop
	beq	$2,$0,.L14
	nop

	lui	$2,%hi(ans)
	lw	$3,28($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(ans)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,24($fp)
	nop
	beq	$3,$2,.L15
	nop

	li	$2,1			# 0x1
	sw	$2,16($fp)
	b	.L16
	nop

.L15:
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
.L14:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,2
	sw	$2,20($fp)
.L9:
	lw	$2,20($fp)
	nop
	slt	$2,$2,201
	bne	$2,$0,.L17
	nop

.L16:
	lw	$3,20($fp)
	li	$2,201			# 0xc9
	beq	$3,$2,.L18
	nop

	li	$2,1			# 0x1
	sw	$2,16($fp)
.L18:
	lw	$3,28($fp)
	li	$2,21			# 0x15
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
