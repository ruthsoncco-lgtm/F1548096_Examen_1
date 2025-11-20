	.cpu cortex-m3
	.arch armv7-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"pregunta_2.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"---------------------------------------------------"
	.ascii	"-------------\012\000"
	.align	2
.LC1:
	.ascii	"El arreglo es: \000"
	.align	2
.LC2:
	.ascii	"%i\000"
	.align	2
.LC3:
	.ascii	",\000"
	.align	2
.LC4:
	.ascii	"\012-----------------------------------------------"
	.ascii	"-----------------\012\000"
	.align	2
.LC5:
	.ascii	"%d - \000"
	.align	2
.LC6:
	.ascii	"Deficiente\012\000"
	.align	2
.LC7:
	.ascii	"Perfecto\012\000"
	.align	2
.LC8:
	.ascii	"Abundante\012\000"
	.align	2
.LC9:
	.ascii	"examen_p_2\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #80
	add	r7, sp, #0
	movs	r0, #0
	bl	time
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	mov	r0, r3
	bl	srand
	ldr	r0, .L14
	bl	printf
	ldr	r0, .L14+4
	bl	printf
	movs	r3, #0
	str	r3, [r7, #76]
	b	.L2
.L4:
	bl	rand
	mov	r1, r0
	ldr	r3, .L14+8
	smull	r2, r3, r3, r1
	asrs	r2, r3, #3
	asrs	r3, r1, #31
	subs	r2, r2, r3
	mov	r3, r2
	lsls	r3, r3, #3
	add	r3, r3, r2
	lsls	r2, r3, #3
	add	r3, r3, r2
	subs	r2, r1, r3
	adds	r2, r2, #1
	ldr	r3, [r7, #76]
	lsls	r3, r3, #2
	adds	r3, r3, #80
	add	r3, r3, r7
	str	r2, [r3, #-80]
	ldr	r3, [r7, #76]
	lsls	r3, r3, #2
	adds	r3, r3, #80
	add	r3, r3, r7
	ldr	r3, [r3, #-80]
	mov	r1, r3
	ldr	r0, .L14+12
	bl	printf
	ldr	r3, [r7, #76]
	cmp	r3, #13
	bgt	.L3
	ldr	r0, .L14+16
	bl	printf
.L3:
	ldr	r3, [r7, #76]
	adds	r3, r3, #1
	str	r3, [r7, #76]
.L2:
	ldr	r3, [r7, #76]
	cmp	r3, #14
	ble	.L4
	ldr	r0, .L14+20
	bl	printf
	movs	r3, #0
	str	r3, [r7, #72]
	b	.L5
.L12:
	ldr	r3, [r7, #72]
	lsls	r3, r3, #2
	adds	r3, r3, #80
	add	r3, r3, r7
	ldr	r3, [r3, #-80]
	str	r3, [r7, #60]
	movs	r3, #0
	str	r3, [r7, #68]
	ldr	r1, [r7, #60]
	ldr	r0, .L14+24
	bl	printf
	movs	r3, #1
	str	r3, [r7, #64]
	b	.L6
.L8:
	ldr	r3, [r7, #60]
	ldr	r2, [r7, #64]
	sdiv	r2, r3, r2
	ldr	r1, [r7, #64]
	mul	r2, r1, r2
	subs	r3, r3, r2
	cmp	r3, #0
	bne	.L7
	ldr	r2, [r7, #68]
	ldr	r3, [r7, #64]
	add	r3, r3, r2
	str	r3, [r7, #68]
.L7:
	ldr	r3, [r7, #64]
	adds	r3, r3, #1
	str	r3, [r7, #64]
.L6:
	ldr	r2, [r7, #64]
	ldr	r3, [r7, #60]
	cmp	r2, r3
	blt	.L8
	ldr	r2, [r7, #68]
	ldr	r3, [r7, #60]
	cmp	r2, r3
	bge	.L9
	ldr	r0, .L14+28
	bl	printf
	b	.L10
.L9:
	ldr	r2, [r7, #68]
	ldr	r3, [r7, #60]
	cmp	r2, r3
	bne	.L11
	ldr	r0, .L14+32
	bl	printf
	b	.L10
.L11:
	ldr	r2, [r7, #68]
	ldr	r3, [r7, #60]
	cmp	r2, r3
	ble	.L10
	ldr	r0, .L14+36
	bl	printf
.L10:
	ldr	r3, [r7, #72]
	adds	r3, r3, #1
	str	r3, [r7, #72]
.L5:
	ldr	r3, [r7, #72]
	cmp	r3, #14
	ble	.L12
	ldr	r0, .L14+40
	bl	printf
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #80
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L15:
	.align	2
.L14:
	.word	.LC0
	.word	.LC1
	.word	424194301
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
