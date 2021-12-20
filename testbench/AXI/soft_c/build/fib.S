	.file	1 "fib.c"
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
	.globl	fib
	.data
	.align	2
	.type	fib, @object
	.size	fib, 160
fib:
	.word	1
	.word	1
	.space	152
	.globl	ans
	.align	2
	.type	ans, @object
	.size	ans, 160
ans:
	.word	1
	.word	1
	.word	2
	.word	3
	.word	5
	.word	8
	.word	13
	.word	21
	.word	34
	.word	55
	.word	89
	.word	144
	.word	233
	.word	377
	.word	610
	.word	987
	.word	1597
	.word	2584
	.word	4181
	.word	6765
	.word	10946
	.word	17711
	.word	28657
	.word	46368
	.word	75025
	.word	121393
	.word	196418
	.word	317811
	.word	514229
	.word	832040
	.word	1346269
	.word	2178309
	.word	3524578
	.word	5702887
	.word	9227465
	.word	14930352
	.word	24157817
	.word	39088169
	.word	63245986
	.word	102334155
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

	li	$2,1			# 0x1
	sw	$2,16($fp)
	li	$2,2			# 0x2
	sw	$2,20($fp)
	b	.L9
	nop

.L12:
	lw	$2,20($fp)
	nop
	addiu	$3,$2,-1
	lui	$2,%hi(fib)
	sll	$3,$3,2
	addiu	$2,$2,%lo(fib)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,20($fp)
	nop
	addiu	$4,$2,-2
	lui	$2,%hi(fib)
	sll	$4,$4,2
	addiu	$2,$2,%lo(fib)
	addu	$2,$4,$2
	lw	$2,0($2)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(fib)
	lw	$4,20($fp)
	nop
	sll	$4,$4,2
	addiu	$2,$2,%lo(fib)
	addu	$2,$4,$2
	sw	$3,0($2)
	lui	$2,%hi(fib)
	lw	$3,20($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(fib)
	addu	$2,$3,$2
	lw	$3,0($2)
	lui	$2,%hi(ans)
	lw	$4,20($fp)
	nop
	sll	$4,$4,2
	addiu	$2,$2,%lo(ans)
	addu	$2,$4,$2
	lw	$2,0($2)
	nop
	beq	$3,$2,.L10
	nop

	sw	$0,16($fp)
	b	.L11
	nop

.L10:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
.L9:
	lw	$3,20($fp)
	li	$2,40			# 0x28
	bne	$3,$2,.L12
	nop

.L11:
	lw	$3,20($fp)
	li	$2,40			# 0x28
	beq	$3,$2,.L13
	nop

	sw	$0,16($fp)
.L13:
	lw	$4,16($fp)
	jal	print_result
	nop

.L14:
	b	.L14
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2013.05-65) 4.7.3"
