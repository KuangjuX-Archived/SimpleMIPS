
build/fib:     file format elf32-tradbigmips
build/fib


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de8130 	addiu	s8,s8,-32464
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
bfc00138:	27bdffe0 	addiu	sp,sp,-32
bfc0013c:	afbf001c 	sw	ra,28(sp)
bfc00140:	afbe0018 	sw	s8,24(sp)
bfc00144:	03a0f021 	move	s8,sp
bfc00148:	0ff00023 	jal	bfc0008c <init>
bfc0014c:	00000000 	nop
bfc00150:	24020001 	li	v0,1
bfc00154:	afc20010 	sw	v0,16(s8)
bfc00158:	24020002 	li	v0,2
bfc0015c:	afc20014 	sw	v0,20(s8)
bfc00160:	10000032 	b	bfc0022c <main+0xf4>
bfc00164:	00000000 	nop
bfc00168:	8fc20014 	lw	v0,20(s8)
bfc0016c:	00000000 	nop
bfc00170:	2443ffff 	addiu	v1,v0,-1
bfc00174:	3c028000 	lui	v0,0x8000
bfc00178:	00031880 	sll	v1,v1,0x2
bfc0017c:	24420000 	addiu	v0,v0,0
bfc00180:	00621021 	addu	v0,v1,v0
bfc00184:	8c430000 	lw	v1,0(v0)
bfc00188:	8fc20014 	lw	v0,20(s8)
bfc0018c:	00000000 	nop
bfc00190:	2444fffe 	addiu	a0,v0,-2
bfc00194:	3c028000 	lui	v0,0x8000
bfc00198:	00042080 	sll	a0,a0,0x2
bfc0019c:	24420000 	addiu	v0,v0,0
bfc001a0:	00821021 	addu	v0,a0,v0
bfc001a4:	8c420000 	lw	v0,0(v0)
bfc001a8:	00000000 	nop
bfc001ac:	00621821 	addu	v1,v1,v0
bfc001b0:	3c028000 	lui	v0,0x8000
bfc001b4:	8fc40014 	lw	a0,20(s8)
bfc001b8:	00000000 	nop
bfc001bc:	00042080 	sll	a0,a0,0x2
bfc001c0:	24420000 	addiu	v0,v0,0
bfc001c4:	00821021 	addu	v0,a0,v0
bfc001c8:	ac430000 	sw	v1,0(v0)
bfc001cc:	3c028000 	lui	v0,0x8000
bfc001d0:	8fc30014 	lw	v1,20(s8)
bfc001d4:	00000000 	nop
bfc001d8:	00031880 	sll	v1,v1,0x2
bfc001dc:	24420000 	addiu	v0,v0,0
bfc001e0:	00621021 	addu	v0,v1,v0
bfc001e4:	8c430000 	lw	v1,0(v0)
bfc001e8:	3c028000 	lui	v0,0x8000
bfc001ec:	8fc40014 	lw	a0,20(s8)
bfc001f0:	00000000 	nop
bfc001f4:	00042080 	sll	a0,a0,0x2
bfc001f8:	244200a0 	addiu	v0,v0,160
bfc001fc:	00821021 	addu	v0,a0,v0
bfc00200:	8c420000 	lw	v0,0(v0)
bfc00204:	00000000 	nop
bfc00208:	10620004 	beq	v1,v0,bfc0021c <main+0xe4>
bfc0020c:	00000000 	nop
bfc00210:	afc00010 	sw	zero,16(s8)
bfc00214:	10000009 	b	bfc0023c <main+0x104>
bfc00218:	00000000 	nop
bfc0021c:	8fc20014 	lw	v0,20(s8)
bfc00220:	00000000 	nop
bfc00224:	24420001 	addiu	v0,v0,1
bfc00228:	afc20014 	sw	v0,20(s8)
bfc0022c:	8fc30014 	lw	v1,20(s8)
bfc00230:	24020028 	li	v0,40
bfc00234:	1462ffcc 	bne	v1,v0,bfc00168 <main+0x30>
bfc00238:	00000000 	nop
bfc0023c:	8fc30014 	lw	v1,20(s8)
bfc00240:	24020028 	li	v0,40
bfc00244:	10620002 	beq	v1,v0,bfc00250 <main+0x118>
bfc00248:	00000000 	nop
bfc0024c:	afc00010 	sw	zero,16(s8)
bfc00250:	8fc40010 	lw	a0,16(s8)
bfc00254:	0ff00033 	jal	bfc000cc <print_result>
bfc00258:	00000000 	nop
bfc0025c:	1000ffff 	b	bfc0025c <main+0x124>
bfc00260:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	00000001 	0x1
80000004:	00000001 	0x1
	...

800000a0 <ans>:
800000a0:	00000001 	0x1
800000a4:	00000001 	0x1
800000a8:	00000002 	srl	zero,zero,0x0
800000ac:	00000003 	sra	zero,zero,0x0
800000b0:	00000005 	0x5
800000b4:	00000008 	jr	zero
800000b8:	0000000d 	break
800000bc:	00000015 	0x15
800000c0:	00000022 	neg	zero,zero
800000c4:	00000037 	0x37
800000c8:	00000059 	0x59
800000cc:	00000090 	0x90
800000d0:	000000e9 	0xe9
800000d4:	00000179 	0x179
800000d8:	00000262 	0x262
800000dc:	000003db 	0x3db
800000e0:	0000063d 	0x63d
800000e4:	00000a18 	0xa18
800000e8:	00001055 	0x1055
800000ec:	00001a6d 	0x1a6d
800000f0:	00002ac2 	srl	a1,zero,0xb
800000f4:	0000452f 	0x452f
800000f8:	00006ff1 	0x6ff1
800000fc:	0000b520 	0xb520
80000100:	00012511 	0x12511
80000104:	0001da31 	0x1da31
80000108:	0002ff42 	srl	ra,v0,0x1d
8000010c:	0004d973 	0x4d973
80000110:	0007d8b5 	0x7d8b5
80000114:	000cb228 	0xcb228
80000118:	00148add 	0x148add
8000011c:	00213d05 	0x213d05
80000120:	0035c7e2 	0x35c7e2
80000124:	005704e7 	0x5704e7
80000128:	008cccc9 	0x8cccc9
8000012c:	00e3d1b0 	0xe3d1b0
80000130:	01709e79 	0x1709e79
80000134:	02547029 	0x2547029
80000138:	03c50ea2 	0x3c50ea2
8000013c:	06197ecb 	0x6197ecb

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	80008130 	lb	zero,-32464(zero)

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
  74:	00000020 	add	zero,zero,zero
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
