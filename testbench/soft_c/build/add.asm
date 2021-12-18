
build/add:     file format elf32-tradbigmips
build/add


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1dbfc0 	lui	sp,0xbfc0
bfc00010:	27bd431c 	addiu	sp,sp,17180
bfc00014:	3c1ebfc1 	lui	s8,0xbfc1
bfc00018:	27de8450 	addiu	s8,s8,-31664
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf0006a 	j	bfc001a8 <main>
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

bfc00168 <add>:
add():
bfc00168:	27bdfff0 	addiu	sp,sp,-16
bfc0016c:	afbe000c 	sw	s8,12(sp)
bfc00170:	03a0f021 	move	s8,sp
bfc00174:	afc40010 	sw	a0,16(s8)
bfc00178:	afc50014 	sw	a1,20(s8)
bfc0017c:	8fc30010 	lw	v1,16(s8)
bfc00180:	8fc20014 	lw	v0,20(s8)
bfc00184:	00000000 	nop
bfc00188:	00621021 	addu	v0,v1,v0
bfc0018c:	afc20000 	sw	v0,0(s8)
bfc00190:	8fc20000 	lw	v0,0(s8)
bfc00194:	03c0e821 	move	sp,s8
bfc00198:	8fbe000c 	lw	s8,12(sp)
bfc0019c:	27bd0010 	addiu	sp,sp,16
bfc001a0:	03e00008 	jr	ra
bfc001a4:	00000000 	nop

bfc001a8 <main>:
main():
bfc001a8:	27bdffd0 	addiu	sp,sp,-48
bfc001ac:	afbf002c 	sw	ra,44(sp)
bfc001b0:	afbe0028 	sw	s8,40(sp)
bfc001b4:	03a0f021 	move	s8,sp
bfc001b8:	0ff00023 	jal	bfc0008c <init>
bfc001bc:	00000000 	nop
bfc001c0:	afc00018 	sw	zero,24(s8)
bfc001c4:	afc0001c 	sw	zero,28(s8)
bfc001c8:	afc00020 	sw	zero,32(s8)
bfc001cc:	afc00010 	sw	zero,16(s8)
bfc001d0:	10000048 	b	bfc002f4 <main+0x14c>
bfc001d4:	00000000 	nop
bfc001d8:	afc00014 	sw	zero,20(s8)
bfc001dc:	10000035 	b	bfc002b4 <main+0x10c>
bfc001e0:	00000000 	nop
bfc001e4:	3c02bfc0 	lui	v0,0xbfc0
bfc001e8:	8fc30010 	lw	v1,16(s8)
bfc001ec:	00000000 	nop
bfc001f0:	00031880 	sll	v1,v1,0x2
bfc001f4:	2442033c 	addiu	v0,v0,828
bfc001f8:	00621021 	addu	v0,v1,v0
bfc001fc:	8c430000 	lw	v1,0(v0)
bfc00200:	3c02bfc0 	lui	v0,0xbfc0
bfc00204:	8fc40014 	lw	a0,20(s8)
bfc00208:	00000000 	nop
bfc0020c:	00042080 	sll	a0,a0,0x2
bfc00210:	2442033c 	addiu	v0,v0,828
bfc00214:	00821021 	addu	v0,a0,v0
bfc00218:	8c420000 	lw	v0,0(v0)
bfc0021c:	00602021 	move	a0,v1
bfc00220:	00402821 	move	a1,v0
bfc00224:	0ff0005a 	jal	bfc00168 <add>
bfc00228:	00000000 	nop
bfc0022c:	00401821 	move	v1,v0
bfc00230:	3c02bfc0 	lui	v0,0xbfc0
bfc00234:	8fc40018 	lw	a0,24(s8)
bfc00238:	00000000 	nop
bfc0023c:	00042080 	sll	a0,a0,0x2
bfc00240:	2442035c 	addiu	v0,v0,860
bfc00244:	00821021 	addu	v0,a0,v0
bfc00248:	8c420000 	lw	v0,0(v0)
bfc0024c:	00000000 	nop
bfc00250:	00621026 	xor	v0,v1,v0
bfc00254:	2c420001 	sltiu	v0,v0,1
bfc00258:	304200ff 	andi	v0,v0,0xff
bfc0025c:	8fc30018 	lw	v1,24(s8)
bfc00260:	00000000 	nop
bfc00264:	24630001 	addiu	v1,v1,1
bfc00268:	afc30018 	sw	v1,24(s8)
bfc0026c:	10400007 	beqz	v0,bfc0028c <main+0xe4>
bfc00270:	00000000 	nop
bfc00274:	8fc2001c 	lw	v0,28(s8)
bfc00278:	00000000 	nop
bfc0027c:	24420001 	addiu	v0,v0,1
bfc00280:	afc2001c 	sw	v0,28(s8)
bfc00284:	10000003 	b	bfc00294 <main+0xec>
bfc00288:	00000000 	nop
bfc0028c:	24020001 	li	v0,1
bfc00290:	afc20020 	sw	v0,32(s8)
bfc00294:	8fc20020 	lw	v0,32(s8)
bfc00298:	00000000 	nop
bfc0029c:	1440000c 	bnez	v0,bfc002d0 <main+0x128>
bfc002a0:	00000000 	nop
bfc002a4:	8fc20014 	lw	v0,20(s8)
bfc002a8:	00000000 	nop
bfc002ac:	24420001 	addiu	v0,v0,1
bfc002b0:	afc20014 	sw	v0,20(s8)
bfc002b4:	8fc20014 	lw	v0,20(s8)
bfc002b8:	00000000 	nop
bfc002bc:	2c420008 	sltiu	v0,v0,8
bfc002c0:	1440ffc8 	bnez	v0,bfc001e4 <main+0x3c>
bfc002c4:	00000000 	nop
bfc002c8:	10000002 	b	bfc002d4 <main+0x12c>
bfc002cc:	00000000 	nop
bfc002d0:	00000000 	nop
bfc002d4:	8fc20020 	lw	v0,32(s8)
bfc002d8:	00000000 	nop
bfc002dc:	1440000c 	bnez	v0,bfc00310 <main+0x168>
bfc002e0:	00000000 	nop
bfc002e4:	8fc20010 	lw	v0,16(s8)
bfc002e8:	00000000 	nop
bfc002ec:	24420001 	addiu	v0,v0,1
bfc002f0:	afc20010 	sw	v0,16(s8)
bfc002f4:	8fc20010 	lw	v0,16(s8)
bfc002f8:	00000000 	nop
bfc002fc:	2c420008 	sltiu	v0,v0,8
bfc00300:	1440ffb5 	bnez	v0,bfc001d8 <main+0x30>
bfc00304:	00000000 	nop
bfc00308:	10000002 	b	bfc00314 <main+0x16c>
bfc0030c:	00000000 	nop
bfc00310:	00000000 	nop
bfc00314:	8fc2001c 	lw	v0,28(s8)
bfc00318:	00000000 	nop
bfc0031c:	38420040 	xori	v0,v0,0x40
bfc00320:	2c420001 	sltiu	v0,v0,1
bfc00324:	304200ff 	andi	v0,v0,0xff
bfc00328:	00402021 	move	a0,v0
bfc0032c:	0ff00037 	jal	bfc000dc <print_result>
bfc00330:	00000000 	nop
bfc00334:	1000ffff 	b	bfc00334 <main+0x18c>
bfc00338:	00000000 	nop

Disassembly of section .data:

bfc0033c <_fdata>:
_fdata():
bfc0033c:	00000000 	nop
bfc00340:	00000001 	0x1
bfc00344:	00000002 	srl	zero,zero,0x0
bfc00348:	7fffffff 	0x7fffffff
bfc0034c:	80000000 	lb	zero,0(zero)
bfc00350:	80000001 	lb	zero,1(zero)
bfc00354:	fffffffe 	0xfffffffe
bfc00358:	ffffffff 	0xffffffff

bfc0035c <ans>:
bfc0035c:	00000000 	nop
bfc00360:	00000001 	0x1
bfc00364:	00000002 	srl	zero,zero,0x0
bfc00368:	7fffffff 	0x7fffffff
bfc0036c:	80000000 	lb	zero,0(zero)
bfc00370:	80000001 	lb	zero,1(zero)
bfc00374:	fffffffe 	0xfffffffe
bfc00378:	ffffffff 	0xffffffff
bfc0037c:	00000001 	0x1
bfc00380:	00000002 	srl	zero,zero,0x0
bfc00384:	00000003 	sra	zero,zero,0x0
bfc00388:	80000000 	lb	zero,0(zero)
bfc0038c:	80000001 	lb	zero,1(zero)
bfc00390:	80000002 	lb	zero,2(zero)
bfc00394:	ffffffff 	0xffffffff
bfc00398:	00000000 	nop
bfc0039c:	00000002 	srl	zero,zero,0x0
bfc003a0:	00000003 	sra	zero,zero,0x0
bfc003a4:	00000004 	sllv	zero,zero,zero
bfc003a8:	80000001 	lb	zero,1(zero)
bfc003ac:	80000002 	lb	zero,2(zero)
bfc003b0:	80000003 	lb	zero,3(zero)
bfc003b4:	00000000 	nop
bfc003b8:	00000001 	0x1
bfc003bc:	7fffffff 	0x7fffffff
bfc003c0:	80000000 	lb	zero,0(zero)
bfc003c4:	80000001 	lb	zero,1(zero)
bfc003c8:	fffffffe 	0xfffffffe
bfc003cc:	ffffffff 	0xffffffff
bfc003d0:	00000000 	nop
bfc003d4:	7ffffffd 	0x7ffffffd
bfc003d8:	7ffffffe 	0x7ffffffe
bfc003dc:	80000000 	lb	zero,0(zero)
bfc003e0:	80000001 	lb	zero,1(zero)
bfc003e4:	80000002 	lb	zero,2(zero)
bfc003e8:	ffffffff 	0xffffffff
bfc003ec:	00000000 	nop
bfc003f0:	00000001 	0x1
bfc003f4:	7ffffffe 	0x7ffffffe
bfc003f8:	7fffffff 	0x7fffffff
bfc003fc:	80000001 	lb	zero,1(zero)
bfc00400:	80000002 	lb	zero,2(zero)
bfc00404:	80000003 	lb	zero,3(zero)
bfc00408:	00000000 	nop
bfc0040c:	00000001 	0x1
bfc00410:	00000002 	srl	zero,zero,0x0
bfc00414:	7fffffff 	0x7fffffff
bfc00418:	80000000 	lb	zero,0(zero)
bfc0041c:	fffffffe 	0xfffffffe
bfc00420:	ffffffff 	0xffffffff
bfc00424:	00000000 	nop
bfc00428:	7ffffffd 	0x7ffffffd
bfc0042c:	7ffffffe 	0x7ffffffe
bfc00430:	7fffffff 	0x7fffffff
bfc00434:	fffffffc 	0xfffffffc
bfc00438:	fffffffd 	0xfffffffd
bfc0043c:	ffffffff 	0xffffffff
bfc00440:	00000000 	nop
bfc00444:	00000001 	0x1
bfc00448:	7ffffffe 	0x7ffffffe
bfc0044c:	7fffffff 	0x7fffffff
bfc00450:	80000000 	lb	zero,0(zero)
bfc00454:	fffffffd 	0xfffffffd
bfc00458:	fffffffe 	0xfffffffe

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	bfc08450 	0xbfc08450

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
  74:	00000010 	mfhi	zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc001a8 	0xbfc001a8
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
