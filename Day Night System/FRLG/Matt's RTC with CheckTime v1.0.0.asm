@ RS PokéGear
@ By ZodiacDaGreat
@ Version 1.0.0
@ -------------------------------------------------------------------
.code 16
.thumb

	push {r4-r5, lr}

	mov r0, #0x0
	mov r1, #0x0
	ldr r2, =0x0890000B
	ldr r5, .DisplayTextFunc
	bl .BranchLink

	pop {r4-r5}
	pop {r0}
	bx r0

.BranchLink:
	bx r5

@ -------------------------------------------------------------------
.align 2
.DisplayTextFunc:				.word 0x080C9099

@ -------------------------------------------------------------------
@ This hack replaces the PokéNav for the PokéGear
@ To hack replace the pointer at 0xEBBD8 to the location
@ where this routine is.
@ -------------------------------------------------------------------
