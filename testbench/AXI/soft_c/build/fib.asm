
build/fib:     file format elf32-tradbigmips
build/fib


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1dbfc0 	lui	sp,0xbfc0
bfc00010:	27bd4274 	addiu	sp,sp,17012
bfc00014:	3c1ebfc1 	lui	s8,0xbfc1
bfc00018:	27de83d0 	addiu	s8,s8,-31792
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
bfc00168:	27bdffe0 	addiu	sp,sp,-32
bfc0016c:	afbf001c 	sw	ra,28(sp)
bfc00170:	afbe0018 	sw	s8,24(sp)
bfc00174:	03a0f021 	move	s8,sp
bfc00178:	0ff00023 	jal	bfc0008c <init>
bfc0017c:	00000000 	nop
bfc00180:	24020001 	li	v0,1
bfc00184:	afc20010 	sw	v0,16(s8)
bfc00188:	24020002 	li	v0,2
bfc0018c:	afc20014 	sw	v0,20(s8)
bfc00190:	10000032 	b	bfc0025c <main+0xf4>
bfc00194:	00000000 	nop
bfc00198:	8fc20014 	lw	v0,20(s8)
bfc0019c:	00000000 	nop
bfc001a0:	2443ffff 	addiu	v1,v0,-1
bfc001a4:	3c02bfc0 	lui	v0,0xbfc0
bfc001a8:	00031880 	sll	v1,v1,0x2
bfc001ac:	24420294 	addiu	v0,v0,660
bfc001b0:	00621021 	addu	v0,v1,v0
bfc001b4:	8c430000 	lw	v1,0(v0)
bfc001b8:	8fc20014 	lw	v0,20(s8)
bfc001bc:	00000000 	nop
bfc001c0:	2444fffe 	addiu	a0,v0,-2
bfc001c4:	3c02bfc0 	lui	v0,0xbfc0
bfc001c8:	00042080 	sll	a0,a0,0x2
bfc001cc:	24420294 	addiu	v0,v0,660
bfc001d0:	00821021 	addu	v0,a0,v0
bfc001d4:	8c420000 	lw	v0,0(v0)
bfc001d8:	00000000 	nop
bfc001dc:	00621821 	addu	v1,v1,v0
bfc001e0:	3c02bfc0 	lui	v0,0xbfc0
bfc001e4:	8fc40014 	lw	a0,20(s8)
bfc001e8:	00000000 	nop
bfc001ec:	00042080 	sll	a0,a0,0x2
bfc001f0:	24420294 	addiu	v0,v0,660
bfc001f4:	00821021 	addu	v0,a0,v0
bfc001f8:	ac430000 	sw	v1,0(v0)
bfc001fc:	3c02bfc0 	lui	v0,0xbfc0
bfc00200:	8fc30014 	lw	v1,20(s8)
bfc00204:	00000000 	nop
bfc00208:	00031880 	sll	v1,v1,0x2
bfc0020c:	24420294 	addiu	v0,v0,660
bfc00210:	00621021 	addu	v0,v1,v0
bfc00214:	8c430000 	lw	v1,0(v0)
bfc00218:	3c02bfc0 	lui	v0,0xbfc0
bfc0021c:	8fc40014 	lw	a0,20(s8)
bfc00220:	00000000 	nop
bfc00224:	00042080 	sll	a0,a0,0x2
bfc00228:	24420334 	addiu	v0,v0,820
bfc0022c:	00821021 	addu	v0,a0,v0
bfc00230:	8c420000 	lw	v0,0(v0)
bfc00234:	00000000 	nop
bfc00238:	10620004 	beq	v1,v0,bfc0024c <main+0xe4>
bfc0023c:	00000000 	nop
bfc00240:	afc00010 	sw	zero,16(s8)
bfc00244:	10000009 	b	bfc0026c <main+0x104>
bfc00248:	00000000 	nop
bfc0024c:	8fc20014 	lw	v0,20(s8)
bfc00250:	00000000 	nop
bfc00254:	24420001 	addiu	v0,v0,1
bfc00258:	afc20014 	sw	v0,20(s8)
bfc0025c:	8fc30014 	lw	v1,20(s8)
bfc00260:	24020028 	li	v0,40
bfc00264:	1462ffcc 	bne	v1,v0,bfc00198 <main+0x30>
bfc00268:	00000000 	nop
bfc0026c:	8fc30014 	lw	v1,20(s8)
bfc00270:	24020028 	li	v0,40
bfc00274:	10620002 	beq	v1,v0,bfc00280 <main+0x118>
bfc00278:	00000000 	nop
bfc0027c:	afc00010 	sw	zero,16(s8)
bfc00280:	8fc40010 	lw	a0,16(s8)
bfc00284:	0ff00037 	jal	bfc000dc <print_result>
bfc00288:	00000000 	nop
bfc0028c:	1000ffff 	b	bfc0028c <main+0x124>
bfc00290:	00000000 	nop

Disassembly of section .data:

bfc00294 <_fdata>:
_fdata():
bfc00294:	00000001 	0x1
bfc00298:	00000001 	0x1
	...

bfc00334 <ans>:
bfc00334:	00000001 	0x1
bfc00338:	00000001 	0x1
bfc0033c:	00000002 	srl	zero,zero,0x0
bfc00340:	00000003 	sra	zero,zero,0x0
bfc00344:	00000005 	0x5
bfc00348:	00000008 	jr	zero
bfc0034c:	0000000d 	break
bfc00350:	00000015 	0x15
bfc00354:	00000022 	neg	zero,zero
bfc00358:	00000037 	0x37
bfc0035c:	00000059 	0x59
bfc00360:	00000090 	0x90
bfc00364:	000000e9 	0xe9
bfc00368:	00000179 	0x179
bfc0036c:	00000262 	0x262
bfc00370:	000003db 	0x3db
bfc00374:	0000063d 	0x63d
bfc00378:	00000a18 	0xa18
bfc0037c:	00001055 	0x1055
bfc00380:	00001a6d 	0x1a6d
bfc00384:	00002ac2 	srl	a1,zero,0xb
bfc00388:	0000452f 	0x452f
bfc0038c:	00006ff1 	0x6ff1
bfc00390:	0000b520 	0xb520
bfc00394:	00012511 	0x12511
bfc00398:	0001da31 	0x1da31
bfc0039c:	0002ff42 	srl	ra,v0,0x1d
bfc003a0:	0004d973 	0x4d973
bfc003a4:	0007d8b5 	0x7d8b5
bfc003a8:	000cb228 	0xcb228
bfc003ac:	00148add 	0x148add
bfc003b0:	00213d05 	0x213d05
bfc003b4:	0035c7e2 	0x35c7e2
bfc003b8:	005704e7 	0x5704e7
bfc003bc:	008cccc9 	0x8cccc9
bfc003c0:	00e3d1b0 	0xe3d1b0
bfc003c4:	01709e79 	0x1709e79
bfc003c8:	02547029 	0x2547029
bfc003cc:	03c50ea2 	0x3c50ea2
bfc003d0:	06197ecb 	0x6197ecb

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	bfc083d0 	0xbfc083d0

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
  74:	00000020 	add	zero,zero,zero
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
