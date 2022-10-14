@ Day Night System {Palette Calculation}
@ By Mastermind_X
@ Version:
@ ----------------------------------------------
.code 16
.thumb

	push {r3, r4, r6, r7}
	mov r3, r8

	push {r3}
	
	add r4, r4, #0x8
	ldrb r1, [r4]
	lsr r5, r1, #0x7
	mov r8, r5
	mov r0, #0x7F
	and r0, r0, r1
	strb r0, [r4]

	ldr r3, .DayNightFlag
	ldrb r3, [r3]
	cmp r3, #0x0
	bne .NightPaletteChange

	ldr r0, .PaletteDay
	b .NoPaletteChange

.NightPaletteChange:
	ldr r4, .PaletteNight
	ldr r0, .PaletteDay
	mov r3, #0x2
	lsl r3, r3, #0x8 @ r3 = 0x200
	mov r2, #0x0

.Loop:	
	ldrh r1, [r0]
	mov r5, #0x1E
	lsl r6, r5, #0x5 @ r6 = 0x3C
	lsl r7, r6, #0x5 @ r7 = 0x780
	and r5, r5, r1
	and r6, r6, r1
	and r7, r7, r1
	lsr r5, r5, #0x1
	lsr r6, r6, #0x1
	lsl r0, r0, #0x0
	orr r5, r6
	orr r5, r7
	strh r5, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Loop

	ldr r0, .PaletteNight

.NoPaletteChange:
	mov r5, r8
	pop {r3}

	mov r8, r3
	pop {r3, r4, r6, r7}
	
	ldr r1, .CPUSETReturn
	bx r1 @ Return to the calling routine

@ ----------------------------------------------
.align 2
.DayNightFlag:
.word 0x0203E000
.PaletteDay:
.word 0x0202EEC8
.PaletteNight:
.word 0x0203E004
.CPUSETReturn:
.word 0x08073CE9
