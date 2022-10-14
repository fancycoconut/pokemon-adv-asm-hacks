@ ROM Protection System {Interrupt Routine}
@ By HackMew and ZodiacDaGreat
@ Version: 1.0.3
@ ----------------------------------------------
.code 16

.org 0x000000
.arm
	ldr r5, =0x880050F
	bx r5

.org 0x000000E
.thumb
	push {r0, r1, r2}
	ldr r0, .PAL
	ldrh r0, [r0]

	ldr r1, .PAL
	sub r1, r1, #0x2
	ldrh r1, [r1]

	cmp r0, r1
	beq .Copy

.Erase:
	ldr r0, .PAL
	mov r2, #0x0
.Loop:
	strh r1, [r0]
	add r2, r2, #0x2
	add r0, r0, #0x2
	cmp r2, #0x20
	bne .Loop
	b .EndMe

.Copy:
	ldr r0, .PAL
	sub r0, r0, #0x20
	ldr r1, .PAL
	mov r2, #0x10
	swi 0xB

.EndMe:
	ldr r0, .REG_IF
	mov r1, #0x8
	strb r1, [r0]
	pop {r0, r1, r2}
	bx lr

.align 2
.PAL:
	.word 0x05000020
.REG_IF:
	.word 0x04000202
