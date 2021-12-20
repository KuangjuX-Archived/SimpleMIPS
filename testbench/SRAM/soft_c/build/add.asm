
build/add:     file format elf32-tradbigmips
build/add


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de8110 	addiu	s8,s8,-32496
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf0005e 	j	bfc00178 <main>
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

bfc00138 <add>:
add():
bfc00138:	27bdfff0 	addiu	sp,sp,-16
bfc0013c:	afbe000c 	sw	s8,12(sp)
bfc00140:	03a0f021 	move	s8,sp
bfc00144:	afc40010 	sw	a0,16(s8)
bfc00148:	afc50014 	sw	a1,20(s8)
bfc0014c:	8fc30010 	lw	v1,16(s8)
bfc00150:	8fc20014 	lw	v0,20(s8)
bfc00154:	00000000 	nop
bfc00158:	00621021 	addu	v0,v1,v0
bfc0015c:	afc20000 	sw	v0,0(s8)
bfc00160:	8fc20000 	lw	v0,0(s8)
bfc00164:	03c0e821 	move	sp,s8
bfc00168:	8fbe000c 	lw	s8,12(sp)
bfc0016c:	27bd0010 	addiu	sp,sp,16
bfc00170:	03e00008 	jr	ra
bfc00174:	00000000 	nop

bfc00178 <main>:
main():
bfc00178:	27bdffd0 	addiu	sp,sp,-48
bfc0017c:	afbf002c 	sw	ra,44(sp)
bfc00180:	afbe0028 	sw	s8,40(sp)
bfc00184:	03a0f021 	move	s8,sp
bfc00188:	0ff00023 	jal	bfc0008c <init>
bfc0018c:	00000000 	nop
bfc00190:	afc00018 	sw	zero,24(s8)
bfc00194:	afc0001c 	sw	zero,28(s8)
bfc00198:	afc00020 	sw	zero,32(s8)
bfc0019c:	afc00010 	sw	zero,16(s8)
bfc001a0:	10000048 	b	bfc002c4 <main+0x14c>
bfc001a4:	00000000 	nop
bfc001a8:	afc00014 	sw	zero,20(s8)
bfc001ac:	10000035 	b	bfc00284 <main+0x10c>
bfc001b0:	00000000 	nop
bfc001b4:	3c028000 	lui	v0,0x8000
bfc001b8:	8fc30010 	lw	v1,16(s8)
bfc001bc:	00000000 	nop
bfc001c0:	00031880 	sll	v1,v1,0x2
bfc001c4:	24420000 	addiu	v0,v0,0
bfc001c8:	00621021 	addu	v0,v1,v0
bfc001cc:	8c430000 	lw	v1,0(v0)
bfc001d0:	3c028000 	lui	v0,0x8000
bfc001d4:	8fc40014 	lw	a0,20(s8)
bfc001d8:	00000000 	nop
bfc001dc:	00042080 	sll	a0,a0,0x2
bfc001e0:	24420000 	addiu	v0,v0,0
bfc001e4:	00821021 	addu	v0,a0,v0
bfc001e8:	8c420000 	lw	v0,0(v0)
bfc001ec:	00602021 	move	a0,v1
bfc001f0:	00402821 	move	a1,v0
bfc001f4:	0ff0004e 	jal	bfc00138 <add>
bfc001f8:	00000000 	nop
bfc001fc:	00401821 	move	v1,v0
bfc00200:	3c028000 	lui	v0,0x8000
bfc00204:	8fc40018 	lw	a0,24(s8)
bfc00208:	00000000 	nop
bfc0020c:	00042080 	sll	a0,a0,0x2
bfc00210:	24420020 	addiu	v0,v0,32
bfc00214:	00821021 	addu	v0,a0,v0
bfc00218:	8c420000 	lw	v0,0(v0)
bfc0021c:	00000000 	nop
bfc00220:	00621026 	xor	v0,v1,v0
bfc00224:	2c420001 	sltiu	v0,v0,1
bfc00228:	304200ff 	andi	v0,v0,0xff
bfc0022c:	8fc30018 	lw	v1,24(s8)
bfc00230:	00000000 	nop
bfc00234:	24630001 	addiu	v1,v1,1
bfc00238:	afc30018 	sw	v1,24(s8)
bfc0023c:	10400007 	beqz	v0,bfc0025c <main+0xe4>
bfc00240:	00000000 	nop
bfc00244:	8fc2001c 	lw	v0,28(s8)
bfc00248:	00000000 	nop
bfc0024c:	24420001 	addiu	v0,v0,1
bfc00250:	afc2001c 	sw	v0,28(s8)
bfc00254:	10000003 	b	bfc00264 <main+0xec>
bfc00258:	00000000 	nop
bfc0025c:	24020001 	li	v0,1
bfc00260:	afc20020 	sw	v0,32(s8)
bfc00264:	8fc20020 	lw	v0,32(s8)
bfc00268:	00000000 	nop
bfc0026c:	1440000c 	bnez	v0,bfc002a0 <main+0x128>
bfc00270:	00000000 	nop
bfc00274:	8fc20014 	lw	v0,20(s8)
bfc00278:	00000000 	nop
bfc0027c:	24420001 	addiu	v0,v0,1
bfc00280:	afc20014 	sw	v0,20(s8)
bfc00284:	8fc20014 	lw	v0,20(s8)
bfc00288:	00000000 	nop
bfc0028c:	2c420008 	sltiu	v0,v0,8
bfc00290:	1440ffc8 	bnez	v0,bfc001b4 <main+0x3c>
bfc00294:	00000000 	nop
bfc00298:	10000002 	b	bfc002a4 <main+0x12c>
bfc0029c:	00000000 	nop
bfc002a0:	00000000 	nop
bfc002a4:	8fc20020 	lw	v0,32(s8)
bfc002a8:	00000000 	nop
bfc002ac:	1440000c 	bnez	v0,bfc002e0 <main+0x168>
bfc002b0:	00000000 	nop
bfc002b4:	8fc20010 	lw	v0,16(s8)
bfc002b8:	00000000 	nop
bfc002bc:	24420001 	addiu	v0,v0,1
bfc002c0:	afc20010 	sw	v0,16(s8)
bfc002c4:	8fc20010 	lw	v0,16(s8)
bfc002c8:	00000000 	nop
bfc002cc:	2c420008 	sltiu	v0,v0,8
bfc002d0:	1440ffb5 	bnez	v0,bfc001a8 <main+0x30>
bfc002d4:	00000000 	nop
bfc002d8:	10000002 	b	bfc002e4 <main+0x16c>
bfc002dc:	00000000 	nop
bfc002e0:	00000000 	nop
bfc002e4:	8fc2001c 	lw	v0,28(s8)
bfc002e8:	00000000 	nop
bfc002ec:	38420040 	xori	v0,v0,0x40
bfc002f0:	2c420001 	sltiu	v0,v0,1
bfc002f4:	304200ff 	andi	v0,v0,0xff
bfc002f8:	00402021 	move	a0,v0
bfc002fc:	0ff00033 	jal	bfc000cc <print_result>
bfc00300:	00000000 	nop
bfc00304:	1000ffff 	b	bfc00304 <main+0x18c>
bfc00308:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	00000000 	nop
80000004:	00000001 	0x1
80000008:	00000002 	srl	zero,zero,0x0
8000000c:	7fffffff 	0x7fffffff
80000010:	80000000 	lb	zero,0(zero)
80000014:	80000001 	lb	zero,1(zero)
80000018:	fffffffe 	0xfffffffe
8000001c:	ffffffff 	0xffffffff

80000020 <ans>:
80000020:	00000000 	nop
80000024:	00000001 	0x1
80000028:	00000002 	srl	zero,zero,0x0
8000002c:	7fffffff 	0x7fffffff
80000030:	80000000 	lb	zero,0(zero)
80000034:	80000001 	lb	zero,1(zero)
80000038:	fffffffe 	0xfffffffe
8000003c:	ffffffff 	0xffffffff
80000040:	00000001 	0x1
80000044:	00000002 	srl	zero,zero,0x0
80000048:	00000003 	sra	zero,zero,0x0
8000004c:	80000000 	lb	zero,0(zero)
80000050:	80000001 	lb	zero,1(zero)
80000054:	80000002 	lb	zero,2(zero)
80000058:	ffffffff 	0xffffffff
8000005c:	00000000 	nop
80000060:	00000002 	srl	zero,zero,0x0
80000064:	00000003 	sra	zero,zero,0x0
80000068:	00000004 	sllv	zero,zero,zero
8000006c:	80000001 	lb	zero,1(zero)
80000070:	80000002 	lb	zero,2(zero)
80000074:	80000003 	lb	zero,3(zero)
80000078:	00000000 	nop
8000007c:	00000001 	0x1
80000080:	7fffffff 	0x7fffffff
80000084:	80000000 	lb	zero,0(zero)
80000088:	80000001 	lb	zero,1(zero)
8000008c:	fffffffe 	0xfffffffe
80000090:	ffffffff 	0xffffffff
80000094:	00000000 	nop
80000098:	7ffffffd 	0x7ffffffd
8000009c:	7ffffffe 	0x7ffffffe
800000a0:	80000000 	lb	zero,0(zero)
800000a4:	80000001 	lb	zero,1(zero)
800000a8:	80000002 	lb	zero,2(zero)
800000ac:	ffffffff 	0xffffffff
800000b0:	00000000 	nop
800000b4:	00000001 	0x1
800000b8:	7ffffffe 	0x7ffffffe
800000bc:	7fffffff 	0x7fffffff
800000c0:	80000001 	lb	zero,1(zero)
800000c4:	80000002 	lb	zero,2(zero)
800000c8:	80000003 	lb	zero,3(zero)
800000cc:	00000000 	nop
800000d0:	00000001 	0x1
800000d4:	00000002 	srl	zero,zero,0x0
800000d8:	7fffffff 	0x7fffffff
800000dc:	80000000 	lb	zero,0(zero)
800000e0:	fffffffe 	0xfffffffe
800000e4:	ffffffff 	0xffffffff
800000e8:	00000000 	nop
800000ec:	7ffffffd 	0x7ffffffd
800000f0:	7ffffffe 	0x7ffffffe
800000f4:	7fffffff 	0x7fffffff
800000f8:	fffffffc 	0xfffffffc
800000fc:	fffffffd 	0xfffffffd
80000100:	ffffffff 	0xffffffff
80000104:	00000000 	nop
80000108:	00000001 	0x1
8000010c:	7ffffffe 	0x7ffffffe
80000110:	7fffffff 	0x7fffffff
80000114:	80000000 	lb	zero,0(zero)
80000118:	fffffffd 	0xfffffffd
8000011c:	fffffffe 	0xfffffffe

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	80008110 	lb	zero,-32496(zero)

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
  74:	00000010 	mfhi	zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc00178 	0xbfc00178
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
