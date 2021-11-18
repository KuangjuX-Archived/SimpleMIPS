	.file	1 "add.c"
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
	.align	2
	.globl	add
	.set	nomips16
	.set	nomicromips
	.ent	add
	.type	add, @function
add:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$5,20($fp)
	lw	$3,16($fp)
	lw	$2,20($fp)
	nop
	addu	$2,$3,$2
	sw	$2,0($fp)
	lw	$2,0($fp)
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	add
	.size	add, .-add
	.globl	test_data
	.data
	.align	2
	.type	test_data, @object
	.size	test_data, 32
test_data:
	.word	0
	.word	1
	.word	2
	.word	2147483647
	.word	-2147483648
	.word	-2147483647
	.word	-2
	.word	-1
	.globl	ans
	.align	2
	.type	ans, @object
	.size	ans, 256
ans:
	.word	0
	.word	1
	.word	2
	.word	2147483647
	.word	-2147483648
	.word	-2147483647
	.word	-2
	.word	-1
	.word	1
	.word	2
	.word	3
	.word	-2147483648
	.word	-2147483647
	.word	-2147483646
	.word	-1
	.word	0
	.word	2
	.word	3
	.word	4
	.word	-2147483647
	.word	-2147483646
	.word	-2147483645
	.word	0
	.word	1
	.word	2147483647
	.word	-2147483648
	.word	-2147483647
	.word	-2
	.word	-1
	.word	0
	.word	2147483645
	.word	2147483646
	.word	-2147483648
	.word	-2147483647
	.word	-2147483646
	.word	-1
	.word	0
	.word	1
	.word	2147483646
	.word	2147483647
	.word	-2147483647
	.word	-2147483646
	.word	-2147483645
	.word	0
	.word	1
	.word	2
	.word	2147483647
	.word	-2147483648
	.word	-2
	.word	-1
	.word	0
	.word	2147483645
	.word	2147483646
	.word	2147483647
	.word	-4
	.word	-3
	.word	-1
	.word	0
	.word	1
	.word	2147483646
	.word	2147483647
	.word	-2147483648
	.word	-3
	.word	-2
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

	sw	$0,24($fp)
	sw	$0,28($fp)
	sw	$0,32($fp)
	sw	$0,16($fp)
	b	.L11
	nop

.L20:
	sw	$0,20($fp)
	b	.L12
	nop

.L17:
	lui	$2,%hi(test_data)
	lw	$3,16($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(test_data)
	addu	$2,$3,$2
	lw	$3,0($2)
	lui	$2,%hi(test_data)
	lw	$4,20($fp)
	nop
	sll	$4,$4,2
	addiu	$2,$2,%lo(test_data)
	addu	$2,$4,$2
	lw	$2,0($2)
	move	$4,$3
	move	$5,$2
	jal	add
	nop

	move	$3,$2
	lui	$2,%hi(ans)
	lw	$4,24($fp)
	nop
	sll	$4,$4,2
	addiu	$2,$2,%lo(ans)
	addu	$2,$4,$2
	lw	$2,0($2)
	nop
	xor	$2,$3,$2
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	lw	$3,24($fp)
	nop
	addiu	$3,$3,1
	sw	$3,24($fp)
	beq	$2,$0,.L13
	nop

	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
	b	.L14
	nop

.L13:
	li	$2,1			# 0x1
	sw	$2,32($fp)
.L14:
	lw	$2,32($fp)
	nop
	bne	$2,$0,.L22
	nop

.L15:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
.L12:
	lw	$2,20($fp)
	nop
	sltu	$2,$2,8
	bne	$2,$0,.L17
	nop

	b	.L16
	nop

.L22:
	nop
.L16:
	lw	$2,32($fp)
	nop
	bne	$2,$0,.L23
	nop

.L18:
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
.L11:
	lw	$2,16($fp)
	nop
	sltu	$2,$2,8
	bne	$2,$0,.L20
	nop

	b	.L19
	nop

.L23:
	nop
.L19:
	lw	$2,28($fp)
	nop
	xori	$2,$2,0x40
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	move	$4,$2
	jal	print_result
	nop

.L21:
	b	.L21
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2013.05-65) 4.7.3"
