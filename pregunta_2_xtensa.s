	.file	"pregunta_2.c"
	.text
	.section	.rodata
	.align	4
.LC0:
	.string	"----------------------------------------------------------------\n"
	.align	4
.LC2:
	.string	"El arreglo es: "
	.align	4
.LC5:
	.string	"%i"
	.align	4
.LC7:
	.string	","
	.align	4
.LC9:
	.string	"\n----------------------------------------------------------------\n"
	.align	4
.LC11:
	.string	"%d - "
	.align	4
.LC13:
	.string	"Deficiente\n"
	.align	4
.LC15:
	.string	"Perfecto\n"
	.align	4
.LC17:
	.string	"Abundante\n"
	.align	4
.LC19:
	.string	"examen_p_2"
	.text
	.literal_position
	.literal .LC1, .LC0
	.literal .LC3, .LC2
	.literal .LC4, 424194301
	.literal .LC6, .LC5
	.literal .LC8, .LC7
	.literal .LC10, .LC9
	.literal .LC12, .LC11
	.literal .LC14, .LC13
	.literal .LC16, .LC15
	.literal .LC18, .LC17
	.literal .LC20, .LC19
	.align	4
	.global	main
	.type	main, @function
main:
	entry	sp, 128
	mov.n	a7, sp
	movi.n	a10, 0
	call8	time
	mov.n	a2, a10
	mov.n	a10, a2
	call8	srand
	l32r	a2, .LC1
	mov.n	a10, a2
	call8	printf
	l32r	a2, .LC3
	mov.n	a10, a2
	call8	printf
	movi.n	a2, 0
	s32i.n	a2, a7, 0
	j	.L2
.L4:
	call8	rand
	mov.n	a4, a10
	l32r	a2, .LC4
	mull	a3, a4, a2
	mulsh	a2, a4, a2
	s32i	a2, a7, 84
	s32i	a3, a7, 80
	l32i	a8, a7, 84
	srai	a3, a8, 3
	srai	a2, a4, 31
	sub	a3, a3, a2
	mov.n	a2, a3
	slli	a2, a2, 3
	add.n	a2, a2, a3
	slli	a3, a2, 3
	add.n	a2, a2, a3
	sub	a3, a4, a2
	addi.n	a3, a3, 1
	l32i.n	a2, a7, 0
	slli	a2, a2, 2
	add.n	a2, a7, a2
	addi	a2, a2, 20
	s32i.n	a3, a2, 0
	l32i.n	a2, a7, 0
	slli	a2, a2, 2
	add.n	a2, a7, a2
	addi	a2, a2, 20
	l32i.n	a3, a2, 0
	l32r	a2, .LC6
	mov.n	a11, a3
	mov.n	a10, a2
	call8	printf
	l32i.n	a2, a7, 0
	movi.n	a3, 0xd
	blt	a3, a2, .L3
	l32r	a2, .LC8
	mov.n	a10, a2
	call8	printf
.L3:
	l32i.n	a2, a7, 0
	addi.n	a2, a2, 1
	s32i.n	a2, a7, 0
.L2:
	l32i.n	a2, a7, 0
	movi.n	a3, 0xe
	bge	a3, a2, .L4
	l32r	a2, .LC10
	mov.n	a10, a2
	call8	printf
	movi.n	a2, 0
	s32i.n	a2, a7, 4
	j	.L5
.L12:
	l32i.n	a2, a7, 4
	slli	a2, a2, 2
	add.n	a2, a7, a2
	addi	a2, a2, 20
	l32i.n	a2, a2, 0
	s32i.n	a2, a7, 16
	movi.n	a2, 0
	s32i.n	a2, a7, 8
	l32r	a2, .LC12
	l32i.n	a11, a7, 16
	mov.n	a10, a2
	call8	printf
	movi.n	a2, 1
	s32i.n	a2, a7, 12
	j	.L6
.L8:
	l32i.n	a3, a7, 16
	l32i.n	a2, a7, 12
	rems	a2, a3, a2
	bnez.n	a2, .L7
	l32i.n	a3, a7, 8
	l32i.n	a2, a7, 12
	add.n	a2, a3, a2
	s32i.n	a2, a7, 8
.L7:
	l32i.n	a2, a7, 12
	addi.n	a2, a2, 1
	s32i.n	a2, a7, 12
.L6:
	l32i.n	a3, a7, 12
	l32i.n	a2, a7, 16
	blt	a3, a2, .L8
	l32i.n	a3, a7, 8
	l32i.n	a2, a7, 16
	bge	a3, a2, .L9
	l32r	a2, .LC14
	mov.n	a10, a2
	call8	printf
	j	.L10
.L9:
	l32i.n	a3, a7, 8
	l32i.n	a2, a7, 16
	bne	a3, a2, .L11
	l32r	a2, .LC16
	mov.n	a10, a2
	call8	printf
	j	.L10
.L11:
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 16
	bge	a3, a2, .L10
	l32r	a2, .LC18
	mov.n	a10, a2
	call8	printf
.L10:
	l32i.n	a2, a7, 4
	addi.n	a2, a2, 1
	s32i.n	a2, a7, 4
.L5:
	l32i.n	a2, a7, 4
	movi.n	a3, 0xe
	bge	a3, a2, .L12
	l32r	a2, .LC20
	mov.n	a10, a2
	call8	printf
	nop.n
	retw.n
	.size	main, .-main
	.ident	"GCC: (crosstool-NG esp-2021r2) 8.4.0"
