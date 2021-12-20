
build/leap-year:     file format elf32-tradbigmips
build/leap-year


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1dbfc0 	lui	sp,0xbfc0
bfc00010:	27bd42ac 	addiu	sp,sp,17068
bfc00014:	3c1ebfc1 	lui	s8,0xbfc1
bfc00018:	27de84b0 	addiu	s8,s8,-31568
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf0007c 	j	bfc001f0 <main>
bfc00030:	00000000 	nop

bfc00034 <exit>:
exit():
bfc00034:	0bf0000d 	j	bfc00034 <exit>
bfc00038:	00000000 	nop

bfc0003c <delay>:
delay():
bfc0003c:	27bdfff0 	addiu	sp,sp,-16
bfc00040:	afbe000c 	sw	s8,12(sp)
bfc00044:	03a0f021 	move	s8,sp
bfc00048:	afc00000 	sw	zero,0(s8)
bfc0004c:	10000005 	b	bfc00064 <delay+0x28>
bfc00050:	00000000 	nop
bfc00054:	8fc20000 	lw	v0,0(s8)
bfc00058:	00000000 	nop
bfc0005c:	24420001 	addiu	v0,v0,1
bfc00060:	afc20000 	sw	v0,0(s8)
bfc00064:	8fc30000 	lw	v1,0(s8)
bfc00068:	3c02004c 	lui	v0,0x4c
bfc0006c:	34424b40 	ori	v0,v0,0x4b40
bfc00070:	1462fff8 	bne	v1,v0,bfc00054 <delay+0x18>
bfc00074:	00000000 	nop
bfc00078:	03c0e821 	move	sp,s8
bfc0007c:	8fbe000c 	lw	s8,12(sp)
bfc00080:	27bd0010 	addiu	sp,sp,16
bfc00084:	03e00008 	jr	ra
bfc00088:	00000000 	nop

bfc0008c <init>:
init():
bfc0008c:	27bdffe8 	addiu	sp,sp,-24
bfc00090:	afbf0014 	sw	ra,20(sp)
bfc00094:	afbe0010 	sw	s8,16(sp)
bfc00098:	03a0f021 	move	s8,sp
bfc0009c:	3c02bfaf 	lui	v0,0xbfaf
bfc000a0:	3442f000 	ori	v0,v0,0xf000
bfc000a4:	240300f0 	li	v1,240
bfc000a8:	ac430000 	sw	v1,0(v0)
bfc000ac:	3c02bfaf 	lui	v0,0xbfaf
bfc000b0:	3442f010 	ori	v0,v0,0xf010
bfc000b4:	240300ff 	li	v1,255
bfc000b8:	ac430000 	sw	v1,0(v0)
bfc000bc:	0ff0000f 	jal	bfc0003c <delay>
bfc000c0:	00000000 	nop
bfc000c4:	03c0e821 	move	sp,s8
bfc000c8:	8fbf0014 	lw	ra,20(sp)
bfc000cc:	8fbe0010 	lw	s8,16(sp)
bfc000d0:	27bd0018 	addiu	sp,sp,24
bfc000d4:	03e00008 	jr	ra
bfc000d8:	00000000 	nop

bfc000dc <print_result>:
print_result():
bfc000dc:	27bdffe8 	addiu	sp,sp,-24
bfc000e0:	afbf0014 	sw	ra,20(sp)
bfc000e4:	afbe0010 	sw	s8,16(sp)
bfc000e8:	03a0f021 	move	s8,sp
bfc000ec:	afc40018 	sw	a0,24(s8)
bfc000f0:	8fc30018 	lw	v1,24(s8)
bfc000f4:	24020001 	li	v0,1
bfc000f8:	1462000d 	bne	v1,v0,bfc00130 <print_result+0x54>
bfc000fc:	00000000 	nop
bfc00100:	0ff0000f 	jal	bfc0003c <delay>
bfc00104:	00000000 	nop
bfc00108:	3c02bfaf 	lui	v0,0xbfaf
bfc0010c:	3442f000 	ori	v0,v0,0xf000
bfc00110:	2403000f 	li	v1,15
bfc00114:	ac430000 	sw	v1,0(v0)
bfc00118:	3c02bfaf 	lui	v0,0xbfaf
bfc0011c:	3442f010 	ori	v0,v0,0xf010
bfc00120:	3403ff00 	li	v1,0xff00
bfc00124:	ac430000 	sw	v1,0(v0)
bfc00128:	1000fff5 	b	bfc00100 <print_result+0x24>
bfc0012c:	00000000 	nop
bfc00130:	3c02bfaf 	lui	v0,0xbfaf
bfc00134:	3442f000 	ori	v0,v0,0xf000
bfc00138:	240300f0 	li	v1,240
bfc0013c:	ac430000 	sw	v1,0(v0)
bfc00140:	3c02bfaf 	lui	v0,0xbfaf
bfc00144:	3442f010 	ori	v0,v0,0xf010
bfc00148:	240300ff 	li	v1,255
bfc0014c:	ac430000 	sw	v1,0(v0)
bfc00150:	03c0e821 	move	sp,s8
bfc00154:	8fbf0014 	lw	ra,20(sp)
bfc00158:	8fbe0010 	lw	s8,16(sp)
bfc0015c:	27bd0018 	addiu	sp,sp,24
bfc00160:	03e00008 	jr	ra
bfc00164:	00000000 	nop

bfc00168 <is_leap_year>:
is_leap_year():
bfc00168:	27bdfff8 	addiu	sp,sp,-8
bfc0016c:	afbe0004 	sw	s8,4(sp)
bfc00170:	03a0f021 	move	s8,sp
bfc00174:	afc40008 	sw	a0,8(s8)
bfc00178:	8fc20008 	lw	v0,8(s8)
bfc0017c:	00000000 	nop
bfc00180:	30420003 	andi	v0,v0,0x3
bfc00184:	14400009 	bnez	v0,bfc001ac <is_leap_year+0x44>
bfc00188:	00000000 	nop
bfc0018c:	8fc30008 	lw	v1,8(s8)
bfc00190:	24020064 	li	v0,100
bfc00194:	14400002 	bnez	v0,bfc001a0 <is_leap_year+0x38>
bfc00198:	0062001a 	div	zero,v1,v0
bfc0019c:	0007000d 	break	0x7
bfc001a0:	00001010 	mfhi	v0
bfc001a4:	14400009 	bnez	v0,bfc001cc <is_leap_year+0x64>
bfc001a8:	00000000 	nop
bfc001ac:	8fc30008 	lw	v1,8(s8)
bfc001b0:	24020190 	li	v0,400
bfc001b4:	14400002 	bnez	v0,bfc001c0 <is_leap_year+0x58>
bfc001b8:	0062001a 	div	zero,v1,v0
bfc001bc:	0007000d 	break	0x7
bfc001c0:	00001010 	mfhi	v0
bfc001c4:	14400004 	bnez	v0,bfc001d8 <is_leap_year+0x70>
bfc001c8:	00000000 	nop
bfc001cc:	24020001 	li	v0,1
bfc001d0:	10000002 	b	bfc001dc <is_leap_year+0x74>
bfc001d4:	00000000 	nop
bfc001d8:	00001021 	move	v0,zero
bfc001dc:	03c0e821 	move	sp,s8
bfc001e0:	8fbe0004 	lw	s8,4(sp)
bfc001e4:	27bd0008 	addiu	sp,sp,8
bfc001e8:	03e00008 	jr	ra
bfc001ec:	00000000 	nop

bfc001f0 <main>:
main():
bfc001f0:	27bdffe0 	addiu	sp,sp,-32
bfc001f4:	afbf001c 	sw	ra,28(sp)
bfc001f8:	afbe0018 	sw	s8,24(sp)
bfc001fc:	03a0f021 	move	s8,sp
bfc00200:	0ff00023 	jal	bfc0008c <init>
bfc00204:	00000000 	nop
bfc00208:	afc00010 	sw	zero,16(s8)
bfc0020c:	afc00014 	sw	zero,20(s8)
bfc00210:	1000001a 	b	bfc0027c <main+0x8c>
bfc00214:	00000000 	nop
bfc00218:	8fc20014 	lw	v0,20(s8)
bfc0021c:	00000000 	nop
bfc00220:	24420762 	addiu	v0,v0,1890
bfc00224:	00402021 	move	a0,v0
bfc00228:	0ff0005a 	jal	bfc00168 <is_leap_year>
bfc0022c:	00000000 	nop
bfc00230:	00401821 	move	v1,v0
bfc00234:	3c02bfc0 	lui	v0,0xbfc0
bfc00238:	8fc40014 	lw	a0,20(s8)
bfc0023c:	00000000 	nop
bfc00240:	00042080 	sll	a0,a0,0x2
bfc00244:	244202cc 	addiu	v0,v0,716
bfc00248:	00821021 	addu	v0,a0,v0
bfc0024c:	8c420000 	lw	v0,0(v0)
bfc00250:	00000000 	nop
bfc00254:	10620005 	beq	v1,v0,bfc0026c <main+0x7c>
bfc00258:	00000000 	nop
bfc0025c:	24020001 	li	v0,1
bfc00260:	afc20010 	sw	v0,16(s8)
bfc00264:	1000000a 	b	bfc00290 <main+0xa0>
bfc00268:	00000000 	nop
bfc0026c:	8fc20014 	lw	v0,20(s8)
bfc00270:	00000000 	nop
bfc00274:	24420001 	addiu	v0,v0,1
bfc00278:	afc20014 	sw	v0,20(s8)
bfc0027c:	8fc20014 	lw	v0,20(s8)
bfc00280:	00000000 	nop
bfc00284:	2c42007d 	sltiu	v0,v0,125
bfc00288:	1440ffe3 	bnez	v0,bfc00218 <main+0x28>
bfc0028c:	00000000 	nop
bfc00290:	8fc30014 	lw	v1,20(s8)
bfc00294:	2402007d 	li	v0,125
bfc00298:	10620003 	beq	v1,v0,bfc002a8 <main+0xb8>
bfc0029c:	00000000 	nop
bfc002a0:	24020001 	li	v0,1
bfc002a4:	afc20010 	sw	v0,16(s8)
bfc002a8:	8fc20010 	lw	v0,16(s8)
bfc002ac:	00000000 	nop
bfc002b0:	2c420001 	sltiu	v0,v0,1
bfc002b4:	304200ff 	andi	v0,v0,0xff
bfc002b8:	00402021 	move	a0,v0
bfc002bc:	0ff00037 	jal	bfc000dc <print_result>
bfc002c0:	00000000 	nop
bfc002c4:	1000ffff 	b	bfc002c4 <main+0xd4>
bfc002c8:	00000000 	nop

Disassembly of section .data:

bfc002cc <_fdata>:
	...
_fdata():
bfc002d4:	00000001 	0x1
	...
bfc002e4:	00000001 	0x1
	...
bfc00304:	00000001 	0x1
	...
bfc00314:	00000001 	0x1
	...
bfc00324:	00000001 	0x1
	...
bfc00334:	00000001 	0x1
	...
bfc00344:	00000001 	0x1
	...
bfc00354:	00000001 	0x1
	...
bfc00364:	00000001 	0x1
	...
bfc00374:	00000001 	0x1
	...
bfc00384:	00000001 	0x1
	...
bfc00394:	00000001 	0x1
	...
bfc003a4:	00000001 	0x1
	...
bfc003b4:	00000001 	0x1
	...
bfc003c4:	00000001 	0x1
	...
bfc003d4:	00000001 	0x1
	...
bfc003e4:	00000001 	0x1
	...
bfc003f4:	00000001 	0x1
	...
bfc00404:	00000001 	0x1
	...
bfc00414:	00000001 	0x1
	...
bfc00424:	00000001 	0x1
	...
bfc00434:	00000001 	0x1
	...
bfc00444:	00000001 	0x1
	...
bfc00454:	00000001 	0x1
	...
bfc00464:	00000001 	0x1
	...
bfc00474:	00000001 	0x1
	...
bfc00484:	00000001 	0x1
	...
bfc00494:	00000001 	0x1
	...
bfc004a4:	00000001 	0x1
	...
bfc004b4:	00000001 	0x1
	...

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	bfc084b0 	0xbfc084b0

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	bfc0003c 	0xbfc0003c
   4:	40000000 	mfc0	zero,c0_index
   8:	fffffffc 	0xfffffffc
	...
  14:	00000010 	mfhi	zero
  18:	0000001e 	0x1e
  1c:	0000001f 	0x1f
  20:	bfc0008c 	0xbfc0008c
  24:	c0000000 	lwc0	$0,0(zero)
  28:	fffffffc 	0xfffffffc
	...
  34:	00000018 	mult	zero,zero
  38:	0000001e 	0x1e
  3c:	0000001f 	0x1f
  40:	bfc000dc 	0xbfc000dc
  44:	c0000000 	lwc0	$0,0(zero)
  48:	fffffffc 	0xfffffffc
	...
  54:	00000018 	mult	zero,zero
  58:	0000001e 	0x1e
  5c:	0000001f 	0x1f
  60:	bfc00168 	0xbfc00168
  64:	40000000 	mfc0	zero,c0_index
  68:	fffffffc 	0xfffffffc
	...
  74:	00000008 	jr	zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc001f0 	0xbfc001f0
  84:	c0000000 	lwc0	$0,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000020 	add	zero,zero,zero
  98:	0000001e 	0x1e
  9c:	0000001f 	0x1f

Disassembly of section .comment:

00000000 <.comment>:
   0:	4743433a 	c1	0x143433a
   4:	2028536f 	addi	t0,at,21359
   8:	75726365 	jalx	5c98d94 <_start-0xb9f6726c>
   c:	72792043 	0x72792043
  10:	6f646542 	0x6f646542
  14:	656e6368 	0x656e6368
  18:	204c6974 	addi	t4,v0,26996
  1c:	65203230 	0x65203230
  20:	31332e30 	andi	s3,t1,0x2e30
  24:	352d3635 	ori	t5,t1,0x3635
  28:	2920342e 	slti	zero,t1,13358
  2c:	372e3300 	ori	t6,t9,0x3300

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	41000000 	bc0f	4 <_start-0xbfbffffc>
   4:	0f676e75 	jal	d9db9d4 <_start-0xb222462c>
   8:	00010000 	sll	zero,at,0x0
   c:	00070401 	0x70401
