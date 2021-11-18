
build/leap-year:     file format elf32-tradbigmips
build/leap-year


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de81f0 	addiu	s8,s8,-32272
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf00070 	j	bfc001c0 <main>
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
bfc000ac:	0ff0000f 	jal	bfc0003c <delay>
bfc000b0:	00000000 	nop
bfc000b4:	03c0e821 	move	sp,s8
bfc000b8:	8fbf0014 	lw	ra,20(sp)
bfc000bc:	8fbe0010 	lw	s8,16(sp)
bfc000c0:	27bd0018 	addiu	sp,sp,24
bfc000c4:	03e00008 	jr	ra
bfc000c8:	00000000 	nop

bfc000cc <print_result>:
print_result():
bfc000cc:	27bdffe8 	addiu	sp,sp,-24
bfc000d0:	afbf0014 	sw	ra,20(sp)
bfc000d4:	afbe0010 	sw	s8,16(sp)
bfc000d8:	03a0f021 	move	s8,sp
bfc000dc:	afc40018 	sw	a0,24(s8)
bfc000e0:	8fc30018 	lw	v1,24(s8)
bfc000e4:	24020001 	li	v0,1
bfc000e8:	14620009 	bne	v1,v0,bfc00110 <print_result+0x44>
bfc000ec:	00000000 	nop
bfc000f0:	0ff0000f 	jal	bfc0003c <delay>
bfc000f4:	00000000 	nop
bfc000f8:	3c02bfaf 	lui	v0,0xbfaf
bfc000fc:	3442f000 	ori	v0,v0,0xf000
bfc00100:	2403000f 	li	v1,15
bfc00104:	ac430000 	sw	v1,0(v0)
bfc00108:	1000fff9 	b	bfc000f0 <print_result+0x24>
bfc0010c:	00000000 	nop
bfc00110:	3c02bfaf 	lui	v0,0xbfaf
bfc00114:	3442f000 	ori	v0,v0,0xf000
bfc00118:	240300f0 	li	v1,240
bfc0011c:	ac430000 	sw	v1,0(v0)
bfc00120:	03c0e821 	move	sp,s8
bfc00124:	8fbf0014 	lw	ra,20(sp)
bfc00128:	8fbe0010 	lw	s8,16(sp)
bfc0012c:	27bd0018 	addiu	sp,sp,24
bfc00130:	03e00008 	jr	ra
bfc00134:	00000000 	nop

bfc00138 <is_leap_year>:
is_leap_year():
bfc00138:	27bdfff8 	addiu	sp,sp,-8
bfc0013c:	afbe0004 	sw	s8,4(sp)
bfc00140:	03a0f021 	move	s8,sp
bfc00144:	afc40008 	sw	a0,8(s8)
bfc00148:	8fc20008 	lw	v0,8(s8)
bfc0014c:	00000000 	nop
bfc00150:	30420003 	andi	v0,v0,0x3
bfc00154:	14400009 	bnez	v0,bfc0017c <is_leap_year+0x44>
bfc00158:	00000000 	nop
bfc0015c:	8fc30008 	lw	v1,8(s8)
bfc00160:	24020064 	li	v0,100
bfc00164:	14400002 	bnez	v0,bfc00170 <is_leap_year+0x38>
bfc00168:	0062001a 	div	zero,v1,v0
bfc0016c:	0007000d 	break	0x7
bfc00170:	00001010 	mfhi	v0
bfc00174:	14400009 	bnez	v0,bfc0019c <is_leap_year+0x64>
bfc00178:	00000000 	nop
bfc0017c:	8fc30008 	lw	v1,8(s8)
bfc00180:	24020190 	li	v0,400
bfc00184:	14400002 	bnez	v0,bfc00190 <is_leap_year+0x58>
bfc00188:	0062001a 	div	zero,v1,v0
bfc0018c:	0007000d 	break	0x7
bfc00190:	00001010 	mfhi	v0
bfc00194:	14400004 	bnez	v0,bfc001a8 <is_leap_year+0x70>
bfc00198:	00000000 	nop
bfc0019c:	24020001 	li	v0,1
bfc001a0:	10000002 	b	bfc001ac <is_leap_year+0x74>
bfc001a4:	00000000 	nop
bfc001a8:	00001021 	move	v0,zero
bfc001ac:	03c0e821 	move	sp,s8
bfc001b0:	8fbe0004 	lw	s8,4(sp)
bfc001b4:	27bd0008 	addiu	sp,sp,8
bfc001b8:	03e00008 	jr	ra
bfc001bc:	00000000 	nop

bfc001c0 <main>:
main():
bfc001c0:	27bdffe0 	addiu	sp,sp,-32
bfc001c4:	afbf001c 	sw	ra,28(sp)
bfc001c8:	afbe0018 	sw	s8,24(sp)
bfc001cc:	03a0f021 	move	s8,sp
bfc001d0:	0ff00023 	jal	bfc0008c <init>
bfc001d4:	00000000 	nop
bfc001d8:	afc00010 	sw	zero,16(s8)
bfc001dc:	afc00014 	sw	zero,20(s8)
bfc001e0:	1000001a 	b	bfc0024c <main+0x8c>
bfc001e4:	00000000 	nop
bfc001e8:	8fc20014 	lw	v0,20(s8)
bfc001ec:	00000000 	nop
bfc001f0:	24420762 	addiu	v0,v0,1890
bfc001f4:	00402021 	move	a0,v0
bfc001f8:	0ff0004e 	jal	bfc00138 <is_leap_year>
bfc001fc:	00000000 	nop
bfc00200:	00401821 	move	v1,v0
bfc00204:	3c028000 	lui	v0,0x8000
bfc00208:	8fc40014 	lw	a0,20(s8)
bfc0020c:	00000000 	nop
bfc00210:	00042080 	sll	a0,a0,0x2
bfc00214:	24420000 	addiu	v0,v0,0
bfc00218:	00821021 	addu	v0,a0,v0
bfc0021c:	8c420000 	lw	v0,0(v0)
bfc00220:	00000000 	nop
bfc00224:	10620005 	beq	v1,v0,bfc0023c <main+0x7c>
bfc00228:	00000000 	nop
bfc0022c:	24020001 	li	v0,1
bfc00230:	afc20010 	sw	v0,16(s8)
bfc00234:	1000000a 	b	bfc00260 <main+0xa0>
bfc00238:	00000000 	nop
bfc0023c:	8fc20014 	lw	v0,20(s8)
bfc00240:	00000000 	nop
bfc00244:	24420001 	addiu	v0,v0,1
bfc00248:	afc20014 	sw	v0,20(s8)
bfc0024c:	8fc20014 	lw	v0,20(s8)
bfc00250:	00000000 	nop
bfc00254:	2c42007d 	sltiu	v0,v0,125
bfc00258:	1440ffe3 	bnez	v0,bfc001e8 <main+0x28>
bfc0025c:	00000000 	nop
bfc00260:	8fc30014 	lw	v1,20(s8)
bfc00264:	2402007d 	li	v0,125
bfc00268:	10620003 	beq	v1,v0,bfc00278 <main+0xb8>
bfc0026c:	00000000 	nop
bfc00270:	24020001 	li	v0,1
bfc00274:	afc20010 	sw	v0,16(s8)
bfc00278:	8fc20010 	lw	v0,16(s8)
bfc0027c:	00000000 	nop
bfc00280:	2c420001 	sltiu	v0,v0,1
bfc00284:	304200ff 	andi	v0,v0,0xff
bfc00288:	00402021 	move	a0,v0
bfc0028c:	0ff00033 	jal	bfc000cc <print_result>
bfc00290:	00000000 	nop
bfc00294:	1000ffff 	b	bfc00294 <main+0xd4>
bfc00298:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
	...
_fdata():
80000008:	00000001 	0x1
	...
80000018:	00000001 	0x1
	...
80000038:	00000001 	0x1
	...
80000048:	00000001 	0x1
	...
80000058:	00000001 	0x1
	...
80000068:	00000001 	0x1
	...
80000078:	00000001 	0x1
	...
80000088:	00000001 	0x1
	...
80000098:	00000001 	0x1
	...
800000a8:	00000001 	0x1
	...
800000b8:	00000001 	0x1
	...
800000c8:	00000001 	0x1
	...
800000d8:	00000001 	0x1
	...
800000e8:	00000001 	0x1
	...
800000f8:	00000001 	0x1
	...
80000108:	00000001 	0x1
	...
80000118:	00000001 	0x1
	...
80000128:	00000001 	0x1
	...
80000138:	00000001 	0x1
	...
80000148:	00000001 	0x1
	...
80000158:	00000001 	0x1
	...
80000168:	00000001 	0x1
	...
80000178:	00000001 	0x1
	...
80000188:	00000001 	0x1
	...
80000198:	00000001 	0x1
	...
800001a8:	00000001 	0x1
	...
800001b8:	00000001 	0x1
	...
800001c8:	00000001 	0x1
	...
800001d8:	00000001 	0x1
	...
800001e8:	00000001 	0x1
	...

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	800081f0 	lb	zero,-32272(zero)

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
  40:	bfc000cc 	0xbfc000cc
  44:	c0000000 	lwc0	$0,0(zero)
  48:	fffffffc 	0xfffffffc
	...
  54:	00000018 	mult	zero,zero
  58:	0000001e 	0x1e
  5c:	0000001f 	0x1f
  60:	bfc00138 	0xbfc00138
  64:	40000000 	mfc0	zero,c0_index
  68:	fffffffc 	0xfffffffc
	...
  74:	00000008 	jr	zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc001c0 	0xbfc001c0
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
   8:	75726365 	jalx	5c98d94 <_fdata-0x7a36726c>
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
   0:	41000000 	bc0f	4 <_fdata-0x7ffffffc>
   4:	0f676e75 	jal	d9db9d4 <_fdata-0x7262462c>
   8:	00010000 	sll	zero,at,0x0
   c:	00070401 	0x70401
