	.set	noreorder
	.globl	_start
	.globl	start
	.globl	__main
_start:
start:
	lui $6,0x1000
	mtc0	$6, $12
	mtc0	$0, $13
	la	$29, _stack
	la	$30, _gp
    ori $7,$0,0x0000
    mtlo $7
    ori $24,$0,0x0000
    mthi $24

	j	main
	nop
	
exit:
	j exit
	nop