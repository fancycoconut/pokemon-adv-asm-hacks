@ Day Night System {DMA3 Copying}
@ By Mastermind_X
@ Version:
@ ----------------------------------------------
.code 16
.thumb

	push {r3, r4, r6, r7}
	
	ldr r3, .DayNightFlag
	ldrb r3, [r3]
	cmp r3, #0x2

.Infinity:
	beq .Infinity @ If Different Value then infinite loop

	cmp r3, #0x0
	bne .NightSettings

	ldr r1, .PaletteDay
	b .WriteToDMA3

.NightSettings:
	ldr r4, .PaletteNight
	ldr r0, .PaletteDay
	mov r3, #0x2
	lsl r3, r3, #0x8 @ r3 = 0x200
	mov r2, #0x0

.Label4:
	ldrh r1, [r0]
	ldr r6, =0xFFFF0FFF
	lsr r7, r2, #0x4
	asr r6, r7
	mov r7, #0x1
	and r6, r6, r7
	cmp r6, #0x0
	bne .Label3
	strh r1, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Label4

	ldr r1, .PaletteNight
	b .WriteToDMA3

.Label3:
	mov r5, #0x1E
	lsl r6, r5, #0x5
	lsl r7, r6, #0x5
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
	blt .Label4

	ldr r1, .PaletteNight

.WriteToDMA3:
	mov r2, #0xA0
	lsl r2, r2, #0x13 @ r2 = 0x05000000
	ldr r0, .REG_DMA3SAD @ Write Palette Source
	str r1, [r0]
	add r0, r0, #0x4
	str r2, [r0] @ Write Palette Destination
	ldr r1, =0x80000200
	add r0, r0, #0x4
	str r1, [r0]
	ldr r0, [r0]
	ldr r0, [r0]
	
	pop {r3, r4, r6, r7}

	ldr r0, .DMA3ReturnAddress
	bx r0 @ Return to the calling routine
	lsl r0, r0, #0x0

@ ----------------------------------------------
.align 2
.DayNightFlag:
.word 0x0203E000
.PaletteDay:
.word 0x0202EEC8
.PaletteNight:
.word 0x0203E004
.REG_DMA3SAD:
.word 0x040000D4
.DMA3ReturnAddress:
.word 0x08073B07
