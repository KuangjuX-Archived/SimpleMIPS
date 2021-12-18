
build/add:     file format elf32-tradbigmips
build/add


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1dbfc0 	lui	sp,0xbfc0
bfc00010:	27bd430c 	addiu	sp,sp,17164
bfc00014:	3c1ebfc1 	lui	s8,0xbfc1
bfc00018:	27de8440 	addiu	s8,s8,-31680
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf00066 	j	bfc00198 <main>
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
bfc000e8:	1462000d 	bne	v1,v0,bfc00120 <print_result+0x54>
bfc000ec:	00000000 	nop
bfc000f0:	0ff0000f 	jal	bfc0003c <delay>
bfc000f4:	00000000 	nop
bfc000f8:	3c02bfaf 	lui	v0,0xbfaf
bfc000fc:	3442f000 	ori	v0,v0,0xf000
bfc00100:	2403000f 	li	v1,15
bfc00104:	ac430000 	sw	v1,0(v0)
bfc00108:	3c02bfaf 	lui	v0,0xbfaf
bfc0010c:	3442f010 	ori	v0,v0,0xf010
bfc00110:	3403ff00 	li	v1,0xff00
bfc00114:	ac430000 	sw	v1,0(v0)
bfc00118:	1000fff5 	b	bfc000f0 <print_result+0x24>
bfc0011c:	00000000 	nop
bfc00120:	3c02bfaf 	lui	v0,0xbfaf
bfc00124:	3442f000 	ori	v0,v0,0xf000
bfc00128:	240300f0 	li	v1,240
bfc0012c:	ac430000 	sw	v1,0(v0)
bfc00130:	3c02bfaf 	lui	v0,0xbfaf
bfc00134:	3442f010 	ori	v0,v0,0xf010
bfc00138:	240300ff 	li	v1,255
bfc0013c:	ac430000 	sw	v1,0(v0)
bfc00140:	03c0e821 	move	sp,s8
bfc00144:	8fbf0014 	lw	ra,20(sp)
bfc00148:	8fbe0010 	lw	s8,16(sp)
bfc0014c:	27bd0018 	addiu	sp,sp,24
bfc00150:	03e00008 	jr	ra
bfc00154:	00000000 	nop

bfc00158 <add>:
add():
bfc00158:	27bdfff0 	addiu	sp,sp,-16
bfc0015c:	afbe000c 	sw	s8,12(sp)
bfc00160:	03a0f021 	move	s8,sp
bfc00164:	afc40010 	sw	a0,16(s8)
bfc00168:	afc50014 	sw	a1,20(s8)
bfc0016c:	8fc30010 	lw	v1,16(s8)
bfc00170:	8fc20014 	lw	v0,20(s8)
bfc00174:	00000000 	nop
bfc00178:	00621021 	addu	v0,v1,v0
bfc0017c:	afc20000 	sw	v0,0(s8)
bfc00180:	8fc20000 	lw	v0,0(s8)
bfc00184:	03c0e821 	move	sp,s8
bfc00188:	8fbe000c 	lw	s8,12(sp)
bfc0018c:	27bd0010 	addiu	sp,sp,16
bfc00190:	03e00008 	jr	ra
bfc00194:	00000000 	nop

bfc00198 <main>:
main():
bfc00198:	27bdffd0 	addiu	sp,sp,-48
bfc0019c:	afbf002c 	sw	ra,44(sp)
bfc001a0:	afbe0028 	sw	s8,40(sp)
bfc001a4:	03a0f021 	move	s8,sp
bfc001a8:	0ff00023 	jal	bfc0008c <init>
bfc001ac:	00000000 	nop
bfc001b0:	afc00018 	sw	zero,24(s8)
bfc001b4:	afc0001c 	sw	zero,28(s8)
bfc001b8:	afc00020 	sw	zero,32(s8)
bfc001bc:	afc00010 	sw	zero,16(s8)
bfc001c0:	10000048 	b	bfc002e4 <main+0x14c>
bfc001c4:	00000000 	nop
bfc001c8:	afc00014 	sw	zero,20(s8)
bfc001cc:	10000035 	b	bfc002a4 <main+0x10c>
bfc001d0:	00000000 	nop
bfc001d4:	3c02bfc0 	lui	v0,0xbfc0
bfc001d8:	8fc30010 	lw	v1,16(s8)
bfc001dc:	00000000 	nop
bfc001e0:	00031880 	sll	v1,v1,0x2
bfc001e4:	2442032c 	addiu	v0,v0,812
bfc001e8:	00621021 	addu	v0,v1,v0
bfc001ec:	8c430000 	lw	v1,0(v0)
bfc001f0:	3c02bfc0 	lui	v0,0xbfc0
bfc001f4:	8fc40014 	lw	a0,20(s8)
bfc001f8:	00000000 	nop
bfc001fc:	00042080 	sll	a0,a0,0x2
bfc00200:	2442032c 	addiu	v0,v0,812
bfc00204:	00821021 	addu	v0,a0,v0
bfc00208:	8c420000 	lw	v0,0(v0)
bfc0020c:	00602021 	move	a0,v1
bfc00210:	00402821 	move	a1,v0
bfc00214:	0ff00056 	jal	bfc00158 <add>
bfc00218:	00000000 	nop
bfc0021c:	00401821 	move	v1,v0
bfc00220:	3c02bfc0 	lui	v0,0xbfc0
bfc00224:	8fc40018 	lw	a0,24(s8)
bfc00228:	00000000 	nop
bfc0022c:	00042080 	sll	a0,a0,0x2
bfc00230:	2442034c 	addiu	v0,v0,844
bfc00234:	00821021 	addu	v0,a0,v0
bfc00238:	8c420000 	lw	v0,0(v0)
bfc0023c:	00000000 	nop
bfc00240:	00621026 	xor	v0,v1,v0
bfc00244:	2c420001 	sltiu	v0,v0,1
bfc00248:	304200ff 	andi	v0,v0,0xff
bfc0024c:	8fc30018 	lw	v1,24(s8)
bfc00250:	00000000 	nop
bfc00254:	24630001 	addiu	v1,v1,1
bfc00258:	afc30018 	sw	v1,24(s8)
bfc0025c:	10400007 	beqz	v0,bfc0027c <main+0xe4>
bfc00260:	00000000 	nop
bfc00264:	8fc2001c 	lw	v0,28(s8)
bfc00268:	00000000 	nop
bfc0026c:	24420001 	addiu	v0,v0,1
bfc00270:	afc2001c 	sw	v0,28(s8)
bfc00274:	10000003 	b	bfc00284 <main+0xec>
bfc00278:	00000000 	nop
bfc0027c:	24020001 	li	v0,1
bfc00280:	afc20020 	sw	v0,32(s8)
bfc00284:	8fc20020 	lw	v0,32(s8)
bfc00288:	00000000 	nop
bfc0028c:	1440000c 	bnez	v0,bfc002c0 <main+0x128>
bfc00290:	00000000 	nop
bfc00294:	8fc20014 	lw	v0,20(s8)
bfc00298:	00000000 	nop
bfc0029c:	24420001 	addiu	v0,v0,1
bfc002a0:	afc20014 	sw	v0,20(s8)
bfc002a4:	8fc20014 	lw	v0,20(s8)
bfc002a8:	00000000 	nop
bfc002ac:	2c420008 	sltiu	v0,v0,8
bfc002b0:	1440ffc8 	bnez	v0,bfc001d4 <main+0x3c>
bfc002b4:	00000000 	nop
bfc002b8:	10000002 	b	bfc002c4 <main+0x12c>
bfc002bc:	00000000 	nop
bfc002c0:	00000000 	nop
bfc002c4:	8fc20020 	lw	v0,32(s8)
bfc002c8:	00000000 	nop
bfc002cc:	1440000c 	bnez	v0,bfc00300 <main+0x168>
bfc002d0:	00000000 	nop
bfc002d4:	8fc20010 	lw	v0,16(s8)
bfc002d8:	00000000 	nop
bfc002dc:	24420001 	addiu	v0,v0,1
bfc002e0:	afc20010 	sw	v0,16(s8)
bfc002e4:	8fc20010 	lw	v0,16(s8)
bfc002e8:	00000000 	nop
bfc002ec:	2c420008 	sltiu	v0,v0,8
bfc002f0:	1440ffb5 	bnez	v0,bfc001c8 <main+0x30>
bfc002f4:	00000000 	nop
bfc002f8:	10000002 	b	bfc00304 <main+0x16c>
bfc002fc:	00000000 	nop
bfc00300:	00000000 	nop
bfc00304:	8fc2001c 	lw	v0,28(s8)
bfc00308:	00000000 	nop
bfc0030c:	38420040 	xori	v0,v0,0x40
bfc00310:	2c420001 	sltiu	v0,v0,1
bfc00314:	304200ff 	andi	v0,v0,0xff
bfc00318:	00402021 	move	a0,v0
bfc0031c:	0ff00033 	jal	bfc000cc <print_result>
bfc00320:	00000000 	nop
bfc00324:	1000ffff 	b	bfc00324 <main+0x18c>
bfc00328:	00000000 	nop

Disassembly of section .data:

bfc0032c <_fdata>:
_fdata():
bfc0032c:	00000000 	nop
bfc00330:	00000001 	0x1
bfc00334:	00000002 	srl	zero,zero,0x0
bfc00338:	7fffffff 	0x7fffffff
bfc0033c:	80000000 	lb	zero,0(zero)
bfc00340:	80000001 	lb	zero,1(zero)
bfc00344:	fffffffe 	0xfffffffe
bfc00348:	ffffffff 	0xffffffff

bfc0034c <ans>:
bfc0034c:	00000000 	nop
bfc00350:	00000001 	0x1
bfc00354:	00000002 	srl	zero,zero,0x0
bfc00358:	7fffffff 	0x7fffffff
bfc0035c:	80000000 	lb	zero,0(zero)
bfc00360:	80000001 	lb	zero,1(zero)
bfc00364:	fffffffe 	0xfffffffe
bfc00368:	ffffffff 	0xffffffff
bfc0036c:	00000001 	0x1
bfc00370:	00000002 	srl	zero,zero,0x0
bfc00374:	00000003 	sra	zero,zero,0x0
bfc00378:	80000000 	lb	zero,0(zero)
bfc0037c:	80000001 	lb	zero,1(zero)
bfc00380:	80000002 	lb	zero,2(zero)
bfc00384:	ffffffff 	0xffffffff
bfc00388:	00000000 	nop
bfc0038c:	00000002 	srl	zero,zero,0x0
bfc00390:	00000003 	sra	zero,zero,0x0
bfc00394:	00000004 	sllv	zero,zero,zero
bfc00398:	80000001 	lb	zero,1(zero)
bfc0039c:	80000002 	lb	zero,2(zero)
bfc003a0:	80000003 	lb	zero,3(zero)
bfc003a4:	00000000 	nop
bfc003a8:	00000001 	0x1
bfc003ac:	7fffffff 	0x7fffffff
bfc003b0:	80000000 	lb	zero,0(zero)
bfc003b4:	80000001 	lb	zero,1(zero)
bfc003b8:	fffffffe 	0xfffffffe
bfc003bc:	ffffffff 	0xffffffff
bfc003c0:	00000000 	nop
bfc003c4:	7ffffffd 	0x7ffffffd
bfc003c8:	7ffffffe 	0x7ffffffe
bfc003cc:	80000000 	lb	zero,0(zero)
bfc003d0:	80000001 	lb	zero,1(zero)
bfc003d4:	80000002 	lb	zero,2(zero)
bfc003d8:	ffffffff 	0xffffffff
bfc003dc:	00000000 	nop
bfc003e0:	00000001 	0x1
bfc003e4:	7ffffffe 	0x7ffffffe
bfc003e8:	7fffffff 	0x7fffffff
bfc003ec:	80000001 	lb	zero,1(zero)
bfc003f0:	80000002 	lb	zero,2(zero)
bfc003f4:	80000003 	lb	zero,3(zero)
bfc003f8:	00000000 	nop
bfc003fc:	00000001 	0x1
bfc00400:	00000002 	srl	zero,zero,0x0
bfc00404:	7fffffff 	0x7fffffff
bfc00408:	80000000 	lb	zero,0(zero)
bfc0040c:	fffffffe 	0xfffffffe
bfc00410:	ffffffff 	0xffffffff
bfc00414:	00000000 	nop
bfc00418:	7ffffffd 	0x7ffffffd
bfc0041c:	7ffffffe 	0x7ffffffe
bfc00420:	7fffffff 	0x7fffffff
bfc00424:	fffffffc 	0xfffffffc
bfc00428:	fffffffd 	0xfffffffd
bfc0042c:	ffffffff 	0xffffffff
bfc00430:	00000000 	nop
bfc00434:	00000001 	0x1
bfc00438:	7ffffffe 	0x7ffffffe
bfc0043c:	7fffffff 	0x7fffffff
bfc00440:	80000000 	lb	zero,0(zero)
bfc00444:	fffffffd 	0xfffffffd
bfc00448:	fffffffe 	0xfffffffe

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	bfc08440 	0xbfc08440

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
  60:	bfc00158 	0xbfc00158
  64:	40000000 	mfc0	zero,c0_index
  68:	fffffffc 	0xfffffffc
	...
  74:	00000010 	mfhi	zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc00198 	0xbfc00198
  84:	c0000000 	lwc0	$0,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000030 	0x30
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
