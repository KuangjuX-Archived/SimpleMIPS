
build/prime:     file format elf32-tradbigmips
build/prime


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1dbfc0 	lui	sp,0xbfc0
bfc00010:	27bd42bc 	addiu	sp,sp,17084
bfc00014:	3c1ebfc1 	lui	s8,0xbfc1
bfc00018:	27de8320 	addiu	s8,s8,-31968
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf0005a 	j	bfc00168 <main>
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

bfc00168 <main>:
main():
bfc00168:	27bdffd0 	addiu	sp,sp,-48
bfc0016c:	afbf002c 	sw	ra,44(sp)
bfc00170:	afbe0028 	sw	s8,40(sp)
bfc00174:	03a0f021 	move	s8,sp
bfc00178:	0ff00023 	jal	bfc0008c <init>
bfc0017c:	00000000 	nop
bfc00180:	afc00010 	sw	zero,16(s8)
bfc00184:	afc0001c 	sw	zero,28(s8)
bfc00188:	24020065 	li	v0,101
bfc0018c:	afc20014 	sw	v0,20(s8)
bfc00190:	10000038 	b	bfc00274 <main+0x10c>
bfc00194:	00000000 	nop
bfc00198:	24020001 	li	v0,1
bfc0019c:	afc20020 	sw	v0,32(s8)
bfc001a0:	24020002 	li	v0,2
bfc001a4:	afc20018 	sw	v0,24(s8)
bfc001a8:	10000011 	b	bfc001f0 <main+0x88>
bfc001ac:	00000000 	nop
bfc001b0:	8fc30014 	lw	v1,20(s8)
bfc001b4:	8fc20018 	lw	v0,24(s8)
bfc001b8:	00000000 	nop
bfc001bc:	14400002 	bnez	v0,bfc001c8 <main+0x60>
bfc001c0:	0062001a 	div	zero,v1,v0
bfc001c4:	0007000d 	break	0x7
bfc001c8:	00001010 	mfhi	v0
bfc001cc:	14400004 	bnez	v0,bfc001e0 <main+0x78>
bfc001d0:	00000000 	nop
bfc001d4:	afc00020 	sw	zero,32(s8)
bfc001d8:	1000000b 	b	bfc00208 <main+0xa0>
bfc001dc:	00000000 	nop
bfc001e0:	8fc20018 	lw	v0,24(s8)
bfc001e4:	00000000 	nop
bfc001e8:	24420001 	addiu	v0,v0,1
bfc001ec:	afc20018 	sw	v0,24(s8)
bfc001f0:	8fc30018 	lw	v1,24(s8)
bfc001f4:	8fc20014 	lw	v0,20(s8)
bfc001f8:	00000000 	nop
bfc001fc:	0062102a 	slt	v0,v1,v0
bfc00200:	1440ffeb 	bnez	v0,bfc001b0 <main+0x48>
bfc00204:	00000000 	nop
bfc00208:	8fc20020 	lw	v0,32(s8)
bfc0020c:	00000000 	nop
bfc00210:	10400014 	beqz	v0,bfc00264 <main+0xfc>
bfc00214:	00000000 	nop
bfc00218:	3c02bfc0 	lui	v0,0xbfc0
bfc0021c:	8fc3001c 	lw	v1,28(s8)
bfc00220:	00000000 	nop
bfc00224:	00031880 	sll	v1,v1,0x2
bfc00228:	244202dc 	addiu	v0,v0,732
bfc0022c:	00621021 	addu	v0,v1,v0
bfc00230:	8c430000 	lw	v1,0(v0)
bfc00234:	8fc20018 	lw	v0,24(s8)
bfc00238:	00000000 	nop
bfc0023c:	10620005 	beq	v1,v0,bfc00254 <main+0xec>
bfc00240:	00000000 	nop
bfc00244:	24020001 	li	v0,1
bfc00248:	afc20010 	sw	v0,16(s8)
bfc0024c:	1000000e 	b	bfc00288 <main+0x120>
bfc00250:	00000000 	nop
bfc00254:	8fc2001c 	lw	v0,28(s8)
bfc00258:	00000000 	nop
bfc0025c:	24420001 	addiu	v0,v0,1
bfc00260:	afc2001c 	sw	v0,28(s8)
bfc00264:	8fc20014 	lw	v0,20(s8)
bfc00268:	00000000 	nop
bfc0026c:	24420002 	addiu	v0,v0,2
bfc00270:	afc20014 	sw	v0,20(s8)
bfc00274:	8fc20014 	lw	v0,20(s8)
bfc00278:	00000000 	nop
bfc0027c:	284200c9 	slti	v0,v0,201
bfc00280:	1440ffc5 	bnez	v0,bfc00198 <main+0x30>
bfc00284:	00000000 	nop
bfc00288:	8fc30014 	lw	v1,20(s8)
bfc0028c:	240200c9 	li	v0,201
bfc00290:	10620003 	beq	v1,v0,bfc002a0 <main+0x138>
bfc00294:	00000000 	nop
bfc00298:	24020001 	li	v0,1
bfc0029c:	afc20010 	sw	v0,16(s8)
bfc002a0:	8fc3001c 	lw	v1,28(s8)
bfc002a4:	24020015 	li	v0,21
bfc002a8:	10620003 	beq	v1,v0,bfc002b8 <main+0x150>
bfc002ac:	00000000 	nop
bfc002b0:	24020001 	li	v0,1
bfc002b4:	afc20010 	sw	v0,16(s8)
bfc002b8:	8fc20010 	lw	v0,16(s8)
bfc002bc:	00000000 	nop
bfc002c0:	2c420001 	sltiu	v0,v0,1
bfc002c4:	304200ff 	andi	v0,v0,0xff
bfc002c8:	00402021 	move	a0,v0
bfc002cc:	0ff00037 	jal	bfc000dc <print_result>
bfc002d0:	00000000 	nop
bfc002d4:	1000ffff 	b	bfc002d4 <main+0x16c>
bfc002d8:	00000000 	nop

Disassembly of section .data:

bfc002dc <_fdata>:
_fdata():
bfc002dc:	00000065 	0x65
bfc002e0:	00000067 	0x67
bfc002e4:	0000006b 	0x6b
bfc002e8:	0000006d 	0x6d
bfc002ec:	00000071 	0x71
bfc002f0:	0000007f 	0x7f
bfc002f4:	00000083 	sra	zero,zero,0x2
bfc002f8:	00000089 	0x89
bfc002fc:	0000008b 	0x8b
bfc00300:	00000095 	0x95
bfc00304:	00000097 	0x97
bfc00308:	0000009d 	0x9d
bfc0030c:	000000a3 	0xa3
bfc00310:	000000a7 	0xa7
bfc00314:	000000ad 	0xad
bfc00318:	000000b3 	0xb3
bfc0031c:	000000b5 	0xb5
bfc00320:	000000bf 	0xbf
bfc00324:	000000c1 	0xc1
bfc00328:	000000c5 	0xc5
bfc0032c:	000000c7 	0xc7

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	bfc08320 	0xbfc08320

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
