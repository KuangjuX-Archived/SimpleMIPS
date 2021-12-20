
build/quick-sort:     file format elf32-tradbigmips
build/quick-sort


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1dbfc0 	lui	sp,0xbfc0
bfc00010:	27bd4550 	addiu	sp,sp,17744
bfc00014:	3c1ebfc1 	lui	s8,0xbfc1
bfc00018:	27de86f0 	addiu	s8,s8,-30992
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf000fe 	j	bfc003f8 <main>
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

bfc00168 <partition>:
partition():
bfc00168:	27bdffe8 	addiu	sp,sp,-24
bfc0016c:	afbe0014 	sw	s8,20(sp)
bfc00170:	03a0f021 	move	s8,sp
bfc00174:	afc40018 	sw	a0,24(s8)
bfc00178:	afc5001c 	sw	a1,28(s8)
bfc0017c:	afc60020 	sw	a2,32(s8)
bfc00180:	8fc2001c 	lw	v0,28(s8)
bfc00184:	00000000 	nop
bfc00188:	00021080 	sll	v0,v0,0x2
bfc0018c:	8fc30018 	lw	v1,24(s8)
bfc00190:	00000000 	nop
bfc00194:	00621021 	addu	v0,v1,v0
bfc00198:	8c420000 	lw	v0,0(v0)
bfc0019c:	00000000 	nop
bfc001a0:	afc20008 	sw	v0,8(s8)
bfc001a4:	8fc2001c 	lw	v0,28(s8)
bfc001a8:	00000000 	nop
bfc001ac:	afc20000 	sw	v0,0(s8)
bfc001b0:	8fc20020 	lw	v0,32(s8)
bfc001b4:	00000000 	nop
bfc001b8:	afc20004 	sw	v0,4(s8)
bfc001bc:	1000004d 	b	bfc002f4 <partition+0x18c>
bfc001c0:	00000000 	nop
bfc001c4:	8fc20004 	lw	v0,4(s8)
bfc001c8:	00000000 	nop
bfc001cc:	2442ffff 	addiu	v0,v0,-1
bfc001d0:	afc20004 	sw	v0,4(s8)
bfc001d4:	8fc30000 	lw	v1,0(s8)
bfc001d8:	8fc20004 	lw	v0,4(s8)
bfc001dc:	00000000 	nop
bfc001e0:	0062102a 	slt	v0,v1,v0
bfc001e4:	1040000d 	beqz	v0,bfc0021c <partition+0xb4>
bfc001e8:	00000000 	nop
bfc001ec:	8fc20004 	lw	v0,4(s8)
bfc001f0:	00000000 	nop
bfc001f4:	00021080 	sll	v0,v0,0x2
bfc001f8:	8fc30018 	lw	v1,24(s8)
bfc001fc:	00000000 	nop
bfc00200:	00621021 	addu	v0,v1,v0
bfc00204:	8c430000 	lw	v1,0(v0)
bfc00208:	8fc20008 	lw	v0,8(s8)
bfc0020c:	00000000 	nop
bfc00210:	0043102a 	slt	v0,v0,v1
bfc00214:	1440ffeb 	bnez	v0,bfc001c4 <partition+0x5c>
bfc00218:	00000000 	nop
bfc0021c:	8fc20000 	lw	v0,0(s8)
bfc00220:	00000000 	nop
bfc00224:	00021080 	sll	v0,v0,0x2
bfc00228:	8fc30018 	lw	v1,24(s8)
bfc0022c:	00000000 	nop
bfc00230:	00621021 	addu	v0,v1,v0
bfc00234:	8fc30004 	lw	v1,4(s8)
bfc00238:	00000000 	nop
bfc0023c:	00031880 	sll	v1,v1,0x2
bfc00240:	8fc40018 	lw	a0,24(s8)
bfc00244:	00000000 	nop
bfc00248:	00831821 	addu	v1,a0,v1
bfc0024c:	8c630000 	lw	v1,0(v1)
bfc00250:	00000000 	nop
bfc00254:	ac430000 	sw	v1,0(v0)
bfc00258:	10000005 	b	bfc00270 <partition+0x108>
bfc0025c:	00000000 	nop
bfc00260:	8fc20000 	lw	v0,0(s8)
bfc00264:	00000000 	nop
bfc00268:	24420001 	addiu	v0,v0,1
bfc0026c:	afc20000 	sw	v0,0(s8)
bfc00270:	8fc30000 	lw	v1,0(s8)
bfc00274:	8fc20004 	lw	v0,4(s8)
bfc00278:	00000000 	nop
bfc0027c:	0062102a 	slt	v0,v1,v0
bfc00280:	1040000d 	beqz	v0,bfc002b8 <partition+0x150>
bfc00284:	00000000 	nop
bfc00288:	8fc20000 	lw	v0,0(s8)
bfc0028c:	00000000 	nop
bfc00290:	00021080 	sll	v0,v0,0x2
bfc00294:	8fc30018 	lw	v1,24(s8)
bfc00298:	00000000 	nop
bfc0029c:	00621021 	addu	v0,v1,v0
bfc002a0:	8c430000 	lw	v1,0(v0)
bfc002a4:	8fc20008 	lw	v0,8(s8)
bfc002a8:	00000000 	nop
bfc002ac:	0043102a 	slt	v0,v0,v1
bfc002b0:	1040ffeb 	beqz	v0,bfc00260 <partition+0xf8>
bfc002b4:	00000000 	nop
bfc002b8:	8fc20004 	lw	v0,4(s8)
bfc002bc:	00000000 	nop
bfc002c0:	00021080 	sll	v0,v0,0x2
bfc002c4:	8fc30018 	lw	v1,24(s8)
bfc002c8:	00000000 	nop
bfc002cc:	00621021 	addu	v0,v1,v0
bfc002d0:	8fc30000 	lw	v1,0(s8)
bfc002d4:	00000000 	nop
bfc002d8:	00031880 	sll	v1,v1,0x2
bfc002dc:	8fc40018 	lw	a0,24(s8)
bfc002e0:	00000000 	nop
bfc002e4:	00831821 	addu	v1,a0,v1
bfc002e8:	8c630000 	lw	v1,0(v1)
bfc002ec:	00000000 	nop
bfc002f0:	ac430000 	sw	v1,0(v0)
bfc002f4:	8fc30000 	lw	v1,0(s8)
bfc002f8:	8fc20004 	lw	v0,4(s8)
bfc002fc:	00000000 	nop
bfc00300:	0062102a 	slt	v0,v1,v0
bfc00304:	1440ffb3 	bnez	v0,bfc001d4 <partition+0x6c>
bfc00308:	00000000 	nop
bfc0030c:	8fc20000 	lw	v0,0(s8)
bfc00310:	00000000 	nop
bfc00314:	00021080 	sll	v0,v0,0x2
bfc00318:	8fc30018 	lw	v1,24(s8)
bfc0031c:	00000000 	nop
bfc00320:	00621021 	addu	v0,v1,v0
bfc00324:	8fc30008 	lw	v1,8(s8)
bfc00328:	00000000 	nop
bfc0032c:	ac430000 	sw	v1,0(v0)
bfc00330:	8fc20000 	lw	v0,0(s8)
bfc00334:	03c0e821 	move	sp,s8
bfc00338:	8fbe0014 	lw	s8,20(sp)
bfc0033c:	27bd0018 	addiu	sp,sp,24
bfc00340:	03e00008 	jr	ra
bfc00344:	00000000 	nop

bfc00348 <quick_sort>:
quick_sort():
bfc00348:	27bdffe0 	addiu	sp,sp,-32
bfc0034c:	afbf001c 	sw	ra,28(sp)
bfc00350:	afbe0018 	sw	s8,24(sp)
bfc00354:	03a0f021 	move	s8,sp
bfc00358:	afc40020 	sw	a0,32(s8)
bfc0035c:	afc50024 	sw	a1,36(s8)
bfc00360:	afc60028 	sw	a2,40(s8)
bfc00364:	8fc30024 	lw	v1,36(s8)
bfc00368:	8fc20028 	lw	v0,40(s8)
bfc0036c:	00000000 	nop
bfc00370:	0062102a 	slt	v0,v1,v0
bfc00374:	10400019 	beqz	v0,bfc003dc <quick_sort+0x94>
bfc00378:	00000000 	nop
bfc0037c:	8fc40020 	lw	a0,32(s8)
bfc00380:	8fc50024 	lw	a1,36(s8)
bfc00384:	8fc60028 	lw	a2,40(s8)
bfc00388:	0ff0005a 	jal	bfc00168 <partition>
bfc0038c:	00000000 	nop
bfc00390:	afc20010 	sw	v0,16(s8)
bfc00394:	8fc20010 	lw	v0,16(s8)
bfc00398:	00000000 	nop
bfc0039c:	2442ffff 	addiu	v0,v0,-1
bfc003a0:	8fc40020 	lw	a0,32(s8)
bfc003a4:	8fc50024 	lw	a1,36(s8)
bfc003a8:	00403021 	move	a2,v0
bfc003ac:	0ff000d2 	jal	bfc00348 <quick_sort>
bfc003b0:	00000000 	nop
bfc003b4:	8fc20010 	lw	v0,16(s8)
bfc003b8:	00000000 	nop
bfc003bc:	24420001 	addiu	v0,v0,1
bfc003c0:	8fc40020 	lw	a0,32(s8)
bfc003c4:	00402821 	move	a1,v0
bfc003c8:	8fc60028 	lw	a2,40(s8)
bfc003cc:	0ff000d2 	jal	bfc00348 <quick_sort>
bfc003d0:	00000000 	nop
bfc003d4:	10000002 	b	bfc003e0 <quick_sort+0x98>
bfc003d8:	00000000 	nop
bfc003dc:	00000000 	nop
bfc003e0:	03c0e821 	move	sp,s8
bfc003e4:	8fbf001c 	lw	ra,28(sp)
bfc003e8:	8fbe0018 	lw	s8,24(sp)
bfc003ec:	27bd0020 	addiu	sp,sp,32
bfc003f0:	03e00008 	jr	ra
bfc003f4:	00000000 	nop

bfc003f8 <main>:
main():
bfc003f8:	27bdffe0 	addiu	sp,sp,-32
bfc003fc:	afbf001c 	sw	ra,28(sp)
bfc00400:	afbe0018 	sw	s8,24(sp)
bfc00404:	03a0f021 	move	s8,sp
bfc00408:	0ff00023 	jal	bfc0008c <init>
bfc0040c:	00000000 	nop
bfc00410:	afc00010 	sw	zero,16(s8)
bfc00414:	3c02bfc0 	lui	v0,0xbfc0
bfc00418:	24440570 	addiu	a0,v0,1392
bfc0041c:	00002821 	move	a1,zero
bfc00420:	24060063 	li	a2,99
bfc00424:	0ff000d2 	jal	bfc00348 <quick_sort>
bfc00428:	00000000 	nop
bfc0042c:	afc00014 	sw	zero,20(s8)
bfc00430:	10000014 	b	bfc00484 <main+0x8c>
bfc00434:	00000000 	nop
bfc00438:	3c02bfc0 	lui	v0,0xbfc0
bfc0043c:	8fc30014 	lw	v1,20(s8)
bfc00440:	00000000 	nop
bfc00444:	00031880 	sll	v1,v1,0x2
bfc00448:	24420570 	addiu	v0,v0,1392
bfc0044c:	00621021 	addu	v0,v1,v0
bfc00450:	8c430000 	lw	v1,0(v0)
bfc00454:	8fc20014 	lw	v0,20(s8)
bfc00458:	00000000 	nop
bfc0045c:	10620005 	beq	v1,v0,bfc00474 <main+0x7c>
bfc00460:	00000000 	nop
bfc00464:	24020001 	li	v0,1
bfc00468:	afc20010 	sw	v0,16(s8)
bfc0046c:	1000000a 	b	bfc00498 <main+0xa0>
bfc00470:	00000000 	nop
bfc00474:	8fc20014 	lw	v0,20(s8)
bfc00478:	00000000 	nop
bfc0047c:	24420001 	addiu	v0,v0,1
bfc00480:	afc20014 	sw	v0,20(s8)
bfc00484:	8fc20014 	lw	v0,20(s8)
bfc00488:	00000000 	nop
bfc0048c:	28420064 	slti	v0,v0,100
bfc00490:	1440ffe9 	bnez	v0,bfc00438 <main+0x40>
bfc00494:	00000000 	nop
bfc00498:	8fc30014 	lw	v1,20(s8)
bfc0049c:	24020064 	li	v0,100
bfc004a0:	10620003 	beq	v1,v0,bfc004b0 <main+0xb8>
bfc004a4:	00000000 	nop
bfc004a8:	24020001 	li	v0,1
bfc004ac:	afc20010 	sw	v0,16(s8)
bfc004b0:	3c02bfc0 	lui	v0,0xbfc0
bfc004b4:	24440570 	addiu	a0,v0,1392
bfc004b8:	00002821 	move	a1,zero
bfc004bc:	24060063 	li	a2,99
bfc004c0:	0ff000d2 	jal	bfc00348 <quick_sort>
bfc004c4:	00000000 	nop
bfc004c8:	afc00014 	sw	zero,20(s8)
bfc004cc:	10000014 	b	bfc00520 <main+0x128>
bfc004d0:	00000000 	nop
bfc004d4:	3c02bfc0 	lui	v0,0xbfc0
bfc004d8:	8fc30014 	lw	v1,20(s8)
bfc004dc:	00000000 	nop
bfc004e0:	00031880 	sll	v1,v1,0x2
bfc004e4:	24420570 	addiu	v0,v0,1392
bfc004e8:	00621021 	addu	v0,v1,v0
bfc004ec:	8c430000 	lw	v1,0(v0)
bfc004f0:	8fc20014 	lw	v0,20(s8)
bfc004f4:	00000000 	nop
bfc004f8:	10620005 	beq	v1,v0,bfc00510 <main+0x118>
bfc004fc:	00000000 	nop
bfc00500:	24020001 	li	v0,1
bfc00504:	afc20010 	sw	v0,16(s8)
bfc00508:	1000000a 	b	bfc00534 <main+0x13c>
bfc0050c:	00000000 	nop
bfc00510:	8fc20014 	lw	v0,20(s8)
bfc00514:	00000000 	nop
bfc00518:	24420001 	addiu	v0,v0,1
bfc0051c:	afc20014 	sw	v0,20(s8)
bfc00520:	8fc20014 	lw	v0,20(s8)
bfc00524:	00000000 	nop
bfc00528:	28420064 	slti	v0,v0,100
bfc0052c:	1440ffe9 	bnez	v0,bfc004d4 <main+0xdc>
bfc00530:	00000000 	nop
bfc00534:	8fc30014 	lw	v1,20(s8)
bfc00538:	24020064 	li	v0,100
bfc0053c:	10620003 	beq	v1,v0,bfc0054c <main+0x154>
bfc00540:	00000000 	nop
bfc00544:	24020001 	li	v0,1
bfc00548:	afc20010 	sw	v0,16(s8)
bfc0054c:	8fc20010 	lw	v0,16(s8)
bfc00550:	00000000 	nop
bfc00554:	2c420001 	sltiu	v0,v0,1
bfc00558:	304200ff 	andi	v0,v0,0xff
bfc0055c:	00402021 	move	a0,v0
bfc00560:	0ff00037 	jal	bfc000dc <print_result>
bfc00564:	00000000 	nop
bfc00568:	1000ffff 	b	bfc00568 <main+0x170>
bfc0056c:	00000000 	nop

Disassembly of section .data:

bfc00570 <_fdata>:
_fdata():
bfc00570:	00000051 	0x51
bfc00574:	00000025 	move	zero,zero
bfc00578:	00000040 	ssnop
bfc0057c:	00000017 	0x17
bfc00580:	00000026 	xor	zero,zero,zero
bfc00584:	00000041 	0x41
bfc00588:	00000038 	0x38
bfc0058c:	0000000f 	0xf
bfc00590:	00000008 	jr	zero
bfc00594:	00000021 	move	zero,zero
bfc00598:	00000055 	0x55
bfc0059c:	00000027 	nor	zero,zero,zero
bfc005a0:	00000047 	0x47
bfc005a4:	0000000c 	syscall
bfc005a8:	0000004d 	break	0x0,0x1
bfc005ac:	00000006 	srlv	zero,zero,zero
bfc005b0:	00000052 	0x52
bfc005b4:	00000059 	0x59
bfc005b8:	00000050 	0x50
bfc005bc:	00000023 	negu	zero,zero
bfc005c0:	00000000 	nop
bfc005c4:	0000003b 	0x3b
bfc005c8:	00000049 	0x49
bfc005cc:	00000004 	sllv	zero,zero,zero
bfc005d0:	0000003d 	0x3d
bfc005d4:	0000001e 	0x1e
bfc005d8:	0000004a 	0x4a
bfc005dc:	00000045 	0x45
bfc005e0:	0000000d 	break
bfc005e4:	0000002a 	slt	zero,zero,zero
bfc005e8:	00000044 	0x44
bfc005ec:	0000003f 	0x3f
bfc005f0:	00000009 	jalr	zero,zero
bfc005f4:	0000001d 	0x1d
bfc005f8:	0000002f 	0x2f
bfc005fc:	00000024 	and	zero,zero,zero
bfc00600:	00000063 	0x63
bfc00604:	00000019 	multu	zero,zero
bfc00608:	00000015 	0x15
bfc0060c:	0000000e 	0xe
bfc00610:	0000003c 	0x3c
bfc00614:	00000003 	sra	zero,zero,0x0
bfc00618:	00000002 	srl	zero,zero,0x0
bfc0061c:	00000012 	mflo	zero
bfc00620:	0000001a 	div	zero,zero,zero
bfc00624:	00000053 	0x53
bfc00628:	00000035 	0x35
bfc0062c:	00000005 	0x5
bfc00630:	0000002b 	sltu	zero,zero,zero
bfc00634:	00000043 	sra	zero,zero,0x1
bfc00638:	00000058 	0x58
bfc0063c:	00000046 	0x46
bfc00640:	0000004c 	syscall	0x1
bfc00644:	0000005c 	0x5c
bfc00648:	0000005e 	0x5e
bfc0064c:	00000030 	0x30
bfc00650:	00000022 	neg	zero,zero
bfc00654:	00000031 	0x31
bfc00658:	00000042 	srl	zero,zero,0x1
bfc0065c:	0000005f 	0x5f
bfc00660:	0000004e 	0x4e
bfc00664:	0000003e 	0x3e
bfc00668:	00000020 	add	zero,zero,zero
bfc0066c:	00000034 	0x34
bfc00670:	00000010 	mfhi	zero
bfc00674:	00000048 	0x48
bfc00678:	0000001b 	divu	zero,zero,zero
bfc0067c:	0000001c 	0x1c
bfc00680:	00000016 	0x16
bfc00684:	00000028 	0x28
bfc00688:	00000054 	0x54
bfc0068c:	0000005b 	0x5b
bfc00690:	00000060 	0x60
bfc00694:	00000039 	0x39
bfc00698:	00000057 	0x57
bfc0069c:	00000033 	0x33
bfc006a0:	00000062 	0x62
bfc006a4:	00000001 	0x1
bfc006a8:	0000000a 	0xa
bfc006ac:	0000000b 	0xb
bfc006b0:	00000018 	mult	zero,zero
bfc006b4:	00000014 	0x14
bfc006b8:	00000013 	mtlo	zero
bfc006bc:	0000001f 	0x1f
bfc006c0:	00000007 	srav	zero,zero,zero
bfc006c4:	00000061 	0x61
bfc006c8:	00000032 	0x32
bfc006cc:	00000056 	0x56
bfc006d0:	0000004f 	0x4f
bfc006d4:	00000011 	mthi	zero
bfc006d8:	0000004b 	0x4b
bfc006dc:	00000037 	0x37
bfc006e0:	0000005d 	0x5d
bfc006e4:	0000002c 	0x2c
bfc006e8:	0000003a 	0x3a
bfc006ec:	00000036 	0x36
bfc006f0:	0000002d 	0x2d
bfc006f4:	00000029 	0x29
bfc006f8:	0000005a 	0x5a
bfc006fc:	0000002e 	0x2e

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	bfc086f0 	0xbfc086f0

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
  74:	00000018 	mult	zero,zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc00348 	0xbfc00348
  84:	c0000000 	lwc0	$0,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000020 	add	zero,zero,zero
  98:	0000001e 	0x1e
  9c:	0000001f 	0x1f
  a0:	bfc003f8 	0xbfc003f8
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
