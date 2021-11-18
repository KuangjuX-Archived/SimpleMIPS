
build/prime:     file format elf32-tradbigmips
build/prime


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de8050 	addiu	s8,s8,-32688
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf0004e 	j	bfc00138 <main>
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

bfc00138 <main>:
main():
bfc00138:	27bdffd0 	addiu	sp,sp,-48
bfc0013c:	afbf002c 	sw	ra,44(sp)
bfc00140:	afbe0028 	sw	s8,40(sp)
bfc00144:	03a0f021 	move	s8,sp
bfc00148:	0ff00023 	jal	bfc0008c <init>
bfc0014c:	00000000 	nop
bfc00150:	afc00010 	sw	zero,16(s8)
bfc00154:	afc0001c 	sw	zero,28(s8)
bfc00158:	24020065 	li	v0,101
bfc0015c:	afc20014 	sw	v0,20(s8)
bfc00160:	10000038 	b	bfc00244 <main+0x10c>
bfc00164:	00000000 	nop
bfc00168:	24020001 	li	v0,1
bfc0016c:	afc20020 	sw	v0,32(s8)
bfc00170:	24020002 	li	v0,2
bfc00174:	afc20018 	sw	v0,24(s8)
bfc00178:	10000011 	b	bfc001c0 <main+0x88>
bfc0017c:	00000000 	nop
bfc00180:	8fc30014 	lw	v1,20(s8)
bfc00184:	8fc20018 	lw	v0,24(s8)
bfc00188:	00000000 	nop
bfc0018c:	14400002 	bnez	v0,bfc00198 <main+0x60>
bfc00190:	0062001a 	div	zero,v1,v0
bfc00194:	0007000d 	break	0x7
bfc00198:	00001010 	mfhi	v0
bfc0019c:	14400004 	bnez	v0,bfc001b0 <main+0x78>
bfc001a0:	00000000 	nop
bfc001a4:	afc00020 	sw	zero,32(s8)
bfc001a8:	1000000b 	b	bfc001d8 <main+0xa0>
bfc001ac:	00000000 	nop
bfc001b0:	8fc20018 	lw	v0,24(s8)
bfc001b4:	00000000 	nop
bfc001b8:	24420001 	addiu	v0,v0,1
bfc001bc:	afc20018 	sw	v0,24(s8)
bfc001c0:	8fc30018 	lw	v1,24(s8)
bfc001c4:	8fc20014 	lw	v0,20(s8)
bfc001c8:	00000000 	nop
bfc001cc:	0062102a 	slt	v0,v1,v0
bfc001d0:	1440ffeb 	bnez	v0,bfc00180 <main+0x48>
bfc001d4:	00000000 	nop
bfc001d8:	8fc20020 	lw	v0,32(s8)
bfc001dc:	00000000 	nop
bfc001e0:	10400014 	beqz	v0,bfc00234 <main+0xfc>
bfc001e4:	00000000 	nop
bfc001e8:	3c028000 	lui	v0,0x8000
bfc001ec:	8fc3001c 	lw	v1,28(s8)
bfc001f0:	00000000 	nop
bfc001f4:	00031880 	sll	v1,v1,0x2
bfc001f8:	24420000 	addiu	v0,v0,0
bfc001fc:	00621021 	addu	v0,v1,v0
bfc00200:	8c430000 	lw	v1,0(v0)
bfc00204:	8fc20018 	lw	v0,24(s8)
bfc00208:	00000000 	nop
bfc0020c:	10620005 	beq	v1,v0,bfc00224 <main+0xec>
bfc00210:	00000000 	nop
bfc00214:	24020001 	li	v0,1
bfc00218:	afc20010 	sw	v0,16(s8)
bfc0021c:	1000000e 	b	bfc00258 <main+0x120>
bfc00220:	00000000 	nop
bfc00224:	8fc2001c 	lw	v0,28(s8)
bfc00228:	00000000 	nop
bfc0022c:	24420001 	addiu	v0,v0,1
bfc00230:	afc2001c 	sw	v0,28(s8)
bfc00234:	8fc20014 	lw	v0,20(s8)
bfc00238:	00000000 	nop
bfc0023c:	24420002 	addiu	v0,v0,2
bfc00240:	afc20014 	sw	v0,20(s8)
bfc00244:	8fc20014 	lw	v0,20(s8)
bfc00248:	00000000 	nop
bfc0024c:	284200c9 	slti	v0,v0,201
bfc00250:	1440ffc5 	bnez	v0,bfc00168 <main+0x30>
bfc00254:	00000000 	nop
bfc00258:	8fc30014 	lw	v1,20(s8)
bfc0025c:	240200c9 	li	v0,201
bfc00260:	10620003 	beq	v1,v0,bfc00270 <main+0x138>
bfc00264:	00000000 	nop
bfc00268:	24020001 	li	v0,1
bfc0026c:	afc20010 	sw	v0,16(s8)
bfc00270:	8fc3001c 	lw	v1,28(s8)
bfc00274:	24020015 	li	v0,21
bfc00278:	10620003 	beq	v1,v0,bfc00288 <main+0x150>
bfc0027c:	00000000 	nop
bfc00280:	24020001 	li	v0,1
bfc00284:	afc20010 	sw	v0,16(s8)
bfc00288:	8fc20010 	lw	v0,16(s8)
bfc0028c:	00000000 	nop
bfc00290:	2c420001 	sltiu	v0,v0,1
bfc00294:	304200ff 	andi	v0,v0,0xff
bfc00298:	00402021 	move	a0,v0
bfc0029c:	0ff00033 	jal	bfc000cc <print_result>
bfc002a0:	00000000 	nop
bfc002a4:	1000ffff 	b	bfc002a4 <main+0x16c>
bfc002a8:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	00000065 	0x65
80000004:	00000067 	0x67
80000008:	0000006b 	0x6b
8000000c:	0000006d 	0x6d
80000010:	00000071 	0x71
80000014:	0000007f 	0x7f
80000018:	00000083 	sra	zero,zero,0x2
8000001c:	00000089 	0x89
80000020:	0000008b 	0x8b
80000024:	00000095 	0x95
80000028:	00000097 	0x97
8000002c:	0000009d 	0x9d
80000030:	000000a3 	0xa3
80000034:	000000a7 	0xa7
80000038:	000000ad 	0xad
8000003c:	000000b3 	0xb3
80000040:	000000b5 	0xb5
80000044:	000000bf 	0xbf
80000048:	000000c1 	0xc1
8000004c:	000000c5 	0xc5
80000050:	000000c7 	0xc7

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	80008050 	lb	zero,-32688(zero)

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
  64:	c0000000 	lwc0	$0,0(zero)
  68:	fffffffc 	0xfffffffc
	...
  74:	00000030 	0x30
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f

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
