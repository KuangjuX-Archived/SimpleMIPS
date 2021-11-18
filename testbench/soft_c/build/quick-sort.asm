
build/quick-sort:     file format elf32-tradbigmips
build/quick-sort


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de8180 	addiu	s8,s8,-32384
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf000f2 	j	bfc003c8 <main>
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

bfc00138 <partition>:
partition():
bfc00138:	27bdffe8 	addiu	sp,sp,-24
bfc0013c:	afbe0014 	sw	s8,20(sp)
bfc00140:	03a0f021 	move	s8,sp
bfc00144:	afc40018 	sw	a0,24(s8)
bfc00148:	afc5001c 	sw	a1,28(s8)
bfc0014c:	afc60020 	sw	a2,32(s8)
bfc00150:	8fc2001c 	lw	v0,28(s8)
bfc00154:	00000000 	nop
bfc00158:	00021080 	sll	v0,v0,0x2
bfc0015c:	8fc30018 	lw	v1,24(s8)
bfc00160:	00000000 	nop
bfc00164:	00621021 	addu	v0,v1,v0
bfc00168:	8c420000 	lw	v0,0(v0)
bfc0016c:	00000000 	nop
bfc00170:	afc20008 	sw	v0,8(s8)
bfc00174:	8fc2001c 	lw	v0,28(s8)
bfc00178:	00000000 	nop
bfc0017c:	afc20000 	sw	v0,0(s8)
bfc00180:	8fc20020 	lw	v0,32(s8)
bfc00184:	00000000 	nop
bfc00188:	afc20004 	sw	v0,4(s8)
bfc0018c:	1000004d 	b	bfc002c4 <partition+0x18c>
bfc00190:	00000000 	nop
bfc00194:	8fc20004 	lw	v0,4(s8)
bfc00198:	00000000 	nop
bfc0019c:	2442ffff 	addiu	v0,v0,-1
bfc001a0:	afc20004 	sw	v0,4(s8)
bfc001a4:	8fc30000 	lw	v1,0(s8)
bfc001a8:	8fc20004 	lw	v0,4(s8)
bfc001ac:	00000000 	nop
bfc001b0:	0062102a 	slt	v0,v1,v0
bfc001b4:	1040000d 	beqz	v0,bfc001ec <partition+0xb4>
bfc001b8:	00000000 	nop
bfc001bc:	8fc20004 	lw	v0,4(s8)
bfc001c0:	00000000 	nop
bfc001c4:	00021080 	sll	v0,v0,0x2
bfc001c8:	8fc30018 	lw	v1,24(s8)
bfc001cc:	00000000 	nop
bfc001d0:	00621021 	addu	v0,v1,v0
bfc001d4:	8c430000 	lw	v1,0(v0)
bfc001d8:	8fc20008 	lw	v0,8(s8)
bfc001dc:	00000000 	nop
bfc001e0:	0043102a 	slt	v0,v0,v1
bfc001e4:	1440ffeb 	bnez	v0,bfc00194 <partition+0x5c>
bfc001e8:	00000000 	nop
bfc001ec:	8fc20000 	lw	v0,0(s8)
bfc001f0:	00000000 	nop
bfc001f4:	00021080 	sll	v0,v0,0x2
bfc001f8:	8fc30018 	lw	v1,24(s8)
bfc001fc:	00000000 	nop
bfc00200:	00621021 	addu	v0,v1,v0
bfc00204:	8fc30004 	lw	v1,4(s8)
bfc00208:	00000000 	nop
bfc0020c:	00031880 	sll	v1,v1,0x2
bfc00210:	8fc40018 	lw	a0,24(s8)
bfc00214:	00000000 	nop
bfc00218:	00831821 	addu	v1,a0,v1
bfc0021c:	8c630000 	lw	v1,0(v1)
bfc00220:	00000000 	nop
bfc00224:	ac430000 	sw	v1,0(v0)
bfc00228:	10000005 	b	bfc00240 <partition+0x108>
bfc0022c:	00000000 	nop
bfc00230:	8fc20000 	lw	v0,0(s8)
bfc00234:	00000000 	nop
bfc00238:	24420001 	addiu	v0,v0,1
bfc0023c:	afc20000 	sw	v0,0(s8)
bfc00240:	8fc30000 	lw	v1,0(s8)
bfc00244:	8fc20004 	lw	v0,4(s8)
bfc00248:	00000000 	nop
bfc0024c:	0062102a 	slt	v0,v1,v0
bfc00250:	1040000d 	beqz	v0,bfc00288 <partition+0x150>
bfc00254:	00000000 	nop
bfc00258:	8fc20000 	lw	v0,0(s8)
bfc0025c:	00000000 	nop
bfc00260:	00021080 	sll	v0,v0,0x2
bfc00264:	8fc30018 	lw	v1,24(s8)
bfc00268:	00000000 	nop
bfc0026c:	00621021 	addu	v0,v1,v0
bfc00270:	8c430000 	lw	v1,0(v0)
bfc00274:	8fc20008 	lw	v0,8(s8)
bfc00278:	00000000 	nop
bfc0027c:	0043102a 	slt	v0,v0,v1
bfc00280:	1040ffeb 	beqz	v0,bfc00230 <partition+0xf8>
bfc00284:	00000000 	nop
bfc00288:	8fc20004 	lw	v0,4(s8)
bfc0028c:	00000000 	nop
bfc00290:	00021080 	sll	v0,v0,0x2
bfc00294:	8fc30018 	lw	v1,24(s8)
bfc00298:	00000000 	nop
bfc0029c:	00621021 	addu	v0,v1,v0
bfc002a0:	8fc30000 	lw	v1,0(s8)
bfc002a4:	00000000 	nop
bfc002a8:	00031880 	sll	v1,v1,0x2
bfc002ac:	8fc40018 	lw	a0,24(s8)
bfc002b0:	00000000 	nop
bfc002b4:	00831821 	addu	v1,a0,v1
bfc002b8:	8c630000 	lw	v1,0(v1)
bfc002bc:	00000000 	nop
bfc002c0:	ac430000 	sw	v1,0(v0)
bfc002c4:	8fc30000 	lw	v1,0(s8)
bfc002c8:	8fc20004 	lw	v0,4(s8)
bfc002cc:	00000000 	nop
bfc002d0:	0062102a 	slt	v0,v1,v0
bfc002d4:	1440ffb3 	bnez	v0,bfc001a4 <partition+0x6c>
bfc002d8:	00000000 	nop
bfc002dc:	8fc20000 	lw	v0,0(s8)
bfc002e0:	00000000 	nop
bfc002e4:	00021080 	sll	v0,v0,0x2
bfc002e8:	8fc30018 	lw	v1,24(s8)
bfc002ec:	00000000 	nop
bfc002f0:	00621021 	addu	v0,v1,v0
bfc002f4:	8fc30008 	lw	v1,8(s8)
bfc002f8:	00000000 	nop
bfc002fc:	ac430000 	sw	v1,0(v0)
bfc00300:	8fc20000 	lw	v0,0(s8)
bfc00304:	03c0e821 	move	sp,s8
bfc00308:	8fbe0014 	lw	s8,20(sp)
bfc0030c:	27bd0018 	addiu	sp,sp,24
bfc00310:	03e00008 	jr	ra
bfc00314:	00000000 	nop

bfc00318 <quick_sort>:
quick_sort():
bfc00318:	27bdffe0 	addiu	sp,sp,-32
bfc0031c:	afbf001c 	sw	ra,28(sp)
bfc00320:	afbe0018 	sw	s8,24(sp)
bfc00324:	03a0f021 	move	s8,sp
bfc00328:	afc40020 	sw	a0,32(s8)
bfc0032c:	afc50024 	sw	a1,36(s8)
bfc00330:	afc60028 	sw	a2,40(s8)
bfc00334:	8fc30024 	lw	v1,36(s8)
bfc00338:	8fc20028 	lw	v0,40(s8)
bfc0033c:	00000000 	nop
bfc00340:	0062102a 	slt	v0,v1,v0
bfc00344:	10400019 	beqz	v0,bfc003ac <quick_sort+0x94>
bfc00348:	00000000 	nop
bfc0034c:	8fc40020 	lw	a0,32(s8)
bfc00350:	8fc50024 	lw	a1,36(s8)
bfc00354:	8fc60028 	lw	a2,40(s8)
bfc00358:	0ff0004e 	jal	bfc00138 <partition>
bfc0035c:	00000000 	nop
bfc00360:	afc20010 	sw	v0,16(s8)
bfc00364:	8fc20010 	lw	v0,16(s8)
bfc00368:	00000000 	nop
bfc0036c:	2442ffff 	addiu	v0,v0,-1
bfc00370:	8fc40020 	lw	a0,32(s8)
bfc00374:	8fc50024 	lw	a1,36(s8)
bfc00378:	00403021 	move	a2,v0
bfc0037c:	0ff000c6 	jal	bfc00318 <quick_sort>
bfc00380:	00000000 	nop
bfc00384:	8fc20010 	lw	v0,16(s8)
bfc00388:	00000000 	nop
bfc0038c:	24420001 	addiu	v0,v0,1
bfc00390:	8fc40020 	lw	a0,32(s8)
bfc00394:	00402821 	move	a1,v0
bfc00398:	8fc60028 	lw	a2,40(s8)
bfc0039c:	0ff000c6 	jal	bfc00318 <quick_sort>
bfc003a0:	00000000 	nop
bfc003a4:	10000002 	b	bfc003b0 <quick_sort+0x98>
bfc003a8:	00000000 	nop
bfc003ac:	00000000 	nop
bfc003b0:	03c0e821 	move	sp,s8
bfc003b4:	8fbf001c 	lw	ra,28(sp)
bfc003b8:	8fbe0018 	lw	s8,24(sp)
bfc003bc:	27bd0020 	addiu	sp,sp,32
bfc003c0:	03e00008 	jr	ra
bfc003c4:	00000000 	nop

bfc003c8 <main>:
main():
bfc003c8:	27bdffe0 	addiu	sp,sp,-32
bfc003cc:	afbf001c 	sw	ra,28(sp)
bfc003d0:	afbe0018 	sw	s8,24(sp)
bfc003d4:	03a0f021 	move	s8,sp
bfc003d8:	0ff00023 	jal	bfc0008c <init>
bfc003dc:	00000000 	nop
bfc003e0:	afc00010 	sw	zero,16(s8)
bfc003e4:	3c028000 	lui	v0,0x8000
bfc003e8:	24440000 	addiu	a0,v0,0
bfc003ec:	00002821 	move	a1,zero
bfc003f0:	24060063 	li	a2,99
bfc003f4:	0ff000c6 	jal	bfc00318 <quick_sort>
bfc003f8:	00000000 	nop
bfc003fc:	afc00014 	sw	zero,20(s8)
bfc00400:	10000014 	b	bfc00454 <main+0x8c>
bfc00404:	00000000 	nop
bfc00408:	3c028000 	lui	v0,0x8000
bfc0040c:	8fc30014 	lw	v1,20(s8)
bfc00410:	00000000 	nop
bfc00414:	00031880 	sll	v1,v1,0x2
bfc00418:	24420000 	addiu	v0,v0,0
bfc0041c:	00621021 	addu	v0,v1,v0
bfc00420:	8c430000 	lw	v1,0(v0)
bfc00424:	8fc20014 	lw	v0,20(s8)
bfc00428:	00000000 	nop
bfc0042c:	10620005 	beq	v1,v0,bfc00444 <main+0x7c>
bfc00430:	00000000 	nop
bfc00434:	24020001 	li	v0,1
bfc00438:	afc20010 	sw	v0,16(s8)
bfc0043c:	1000000a 	b	bfc00468 <main+0xa0>
bfc00440:	00000000 	nop
bfc00444:	8fc20014 	lw	v0,20(s8)
bfc00448:	00000000 	nop
bfc0044c:	24420001 	addiu	v0,v0,1
bfc00450:	afc20014 	sw	v0,20(s8)
bfc00454:	8fc20014 	lw	v0,20(s8)
bfc00458:	00000000 	nop
bfc0045c:	28420064 	slti	v0,v0,100
bfc00460:	1440ffe9 	bnez	v0,bfc00408 <main+0x40>
bfc00464:	00000000 	nop
bfc00468:	8fc30014 	lw	v1,20(s8)
bfc0046c:	24020064 	li	v0,100
bfc00470:	10620003 	beq	v1,v0,bfc00480 <main+0xb8>
bfc00474:	00000000 	nop
bfc00478:	24020001 	li	v0,1
bfc0047c:	afc20010 	sw	v0,16(s8)
bfc00480:	3c028000 	lui	v0,0x8000
bfc00484:	24440000 	addiu	a0,v0,0
bfc00488:	00002821 	move	a1,zero
bfc0048c:	24060063 	li	a2,99
bfc00490:	0ff000c6 	jal	bfc00318 <quick_sort>
bfc00494:	00000000 	nop
bfc00498:	afc00014 	sw	zero,20(s8)
bfc0049c:	10000014 	b	bfc004f0 <main+0x128>
bfc004a0:	00000000 	nop
bfc004a4:	3c028000 	lui	v0,0x8000
bfc004a8:	8fc30014 	lw	v1,20(s8)
bfc004ac:	00000000 	nop
bfc004b0:	00031880 	sll	v1,v1,0x2
bfc004b4:	24420000 	addiu	v0,v0,0
bfc004b8:	00621021 	addu	v0,v1,v0
bfc004bc:	8c430000 	lw	v1,0(v0)
bfc004c0:	8fc20014 	lw	v0,20(s8)
bfc004c4:	00000000 	nop
bfc004c8:	10620005 	beq	v1,v0,bfc004e0 <main+0x118>
bfc004cc:	00000000 	nop
bfc004d0:	24020001 	li	v0,1
bfc004d4:	afc20010 	sw	v0,16(s8)
bfc004d8:	1000000a 	b	bfc00504 <main+0x13c>
bfc004dc:	00000000 	nop
bfc004e0:	8fc20014 	lw	v0,20(s8)
bfc004e4:	00000000 	nop
bfc004e8:	24420001 	addiu	v0,v0,1
bfc004ec:	afc20014 	sw	v0,20(s8)
bfc004f0:	8fc20014 	lw	v0,20(s8)
bfc004f4:	00000000 	nop
bfc004f8:	28420064 	slti	v0,v0,100
bfc004fc:	1440ffe9 	bnez	v0,bfc004a4 <main+0xdc>
bfc00500:	00000000 	nop
bfc00504:	8fc30014 	lw	v1,20(s8)
bfc00508:	24020064 	li	v0,100
bfc0050c:	10620003 	beq	v1,v0,bfc0051c <main+0x154>
bfc00510:	00000000 	nop
bfc00514:	24020001 	li	v0,1
bfc00518:	afc20010 	sw	v0,16(s8)
bfc0051c:	8fc20010 	lw	v0,16(s8)
bfc00520:	00000000 	nop
bfc00524:	2c420001 	sltiu	v0,v0,1
bfc00528:	304200ff 	andi	v0,v0,0xff
bfc0052c:	00402021 	move	a0,v0
bfc00530:	0ff00033 	jal	bfc000cc <print_result>
bfc00534:	00000000 	nop
bfc00538:	1000ffff 	b	bfc00538 <main+0x170>
bfc0053c:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	00000051 	0x51
80000004:	00000025 	move	zero,zero
80000008:	00000040 	ssnop
8000000c:	00000017 	0x17
80000010:	00000026 	xor	zero,zero,zero
80000014:	00000041 	0x41
80000018:	00000038 	0x38
8000001c:	0000000f 	0xf
80000020:	00000008 	jr	zero
80000024:	00000021 	move	zero,zero
80000028:	00000055 	0x55
8000002c:	00000027 	nor	zero,zero,zero
80000030:	00000047 	0x47
80000034:	0000000c 	syscall
80000038:	0000004d 	break	0x0,0x1
8000003c:	00000006 	srlv	zero,zero,zero
80000040:	00000052 	0x52
80000044:	00000059 	0x59
80000048:	00000050 	0x50
8000004c:	00000023 	negu	zero,zero
80000050:	00000000 	nop
80000054:	0000003b 	0x3b
80000058:	00000049 	0x49
8000005c:	00000004 	sllv	zero,zero,zero
80000060:	0000003d 	0x3d
80000064:	0000001e 	0x1e
80000068:	0000004a 	0x4a
8000006c:	00000045 	0x45
80000070:	0000000d 	break
80000074:	0000002a 	slt	zero,zero,zero
80000078:	00000044 	0x44
8000007c:	0000003f 	0x3f
80000080:	00000009 	jalr	zero,zero
80000084:	0000001d 	0x1d
80000088:	0000002f 	0x2f
8000008c:	00000024 	and	zero,zero,zero
80000090:	00000063 	0x63
80000094:	00000019 	multu	zero,zero
80000098:	00000015 	0x15
8000009c:	0000000e 	0xe
800000a0:	0000003c 	0x3c
800000a4:	00000003 	sra	zero,zero,0x0
800000a8:	00000002 	srl	zero,zero,0x0
800000ac:	00000012 	mflo	zero
800000b0:	0000001a 	div	zero,zero,zero
800000b4:	00000053 	0x53
800000b8:	00000035 	0x35
800000bc:	00000005 	0x5
800000c0:	0000002b 	sltu	zero,zero,zero
800000c4:	00000043 	sra	zero,zero,0x1
800000c8:	00000058 	0x58
800000cc:	00000046 	0x46
800000d0:	0000004c 	syscall	0x1
800000d4:	0000005c 	0x5c
800000d8:	0000005e 	0x5e
800000dc:	00000030 	0x30
800000e0:	00000022 	neg	zero,zero
800000e4:	00000031 	0x31
800000e8:	00000042 	srl	zero,zero,0x1
800000ec:	0000005f 	0x5f
800000f0:	0000004e 	0x4e
800000f4:	0000003e 	0x3e
800000f8:	00000020 	add	zero,zero,zero
800000fc:	00000034 	0x34
80000100:	00000010 	mfhi	zero
80000104:	00000048 	0x48
80000108:	0000001b 	divu	zero,zero,zero
8000010c:	0000001c 	0x1c
80000110:	00000016 	0x16
80000114:	00000028 	0x28
80000118:	00000054 	0x54
8000011c:	0000005b 	0x5b
80000120:	00000060 	0x60
80000124:	00000039 	0x39
80000128:	00000057 	0x57
8000012c:	00000033 	0x33
80000130:	00000062 	0x62
80000134:	00000001 	0x1
80000138:	0000000a 	0xa
8000013c:	0000000b 	0xb
80000140:	00000018 	mult	zero,zero
80000144:	00000014 	0x14
80000148:	00000013 	mtlo	zero
8000014c:	0000001f 	0x1f
80000150:	00000007 	srav	zero,zero,zero
80000154:	00000061 	0x61
80000158:	00000032 	0x32
8000015c:	00000056 	0x56
80000160:	0000004f 	0x4f
80000164:	00000011 	mthi	zero
80000168:	0000004b 	0x4b
8000016c:	00000037 	0x37
80000170:	0000005d 	0x5d
80000174:	0000002c 	0x2c
80000178:	0000003a 	0x3a
8000017c:	00000036 	0x36
80000180:	0000002d 	0x2d
80000184:	00000029 	0x29
80000188:	0000005a 	0x5a
8000018c:	0000002e 	0x2e

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	80008180 	lb	zero,-32384(zero)

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
  74:	00000018 	mult	zero,zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc00318 	0xbfc00318
  84:	c0000000 	lwc0	$0,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000020 	add	zero,zero,zero
  98:	0000001e 	0x1e
  9c:	0000001f 	0x1f
  a0:	bfc003c8 	0xbfc003c8
  a4:	c0000000 	lwc0	$0,0(zero)
  a8:	fffffffc 	0xfffffffc
	...
  b4:	00000020 	add	zero,zero,zero
  b8:	0000001e 	0x1e
  bc:	0000001f 	0x1f

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
