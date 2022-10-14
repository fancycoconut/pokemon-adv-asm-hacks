@ Day Night System {DMA3 Copying}
@ By Mastermind_X
@ Version:
@ ----------------------------------------------
.code 16
.thumb

	push {r3, r4, r6, r7}
	
	ldr r3, .DayNightFlag
	ldrb r3, [r3]

	cmp r3, #0x0
	bne .PaletteChange

	ldr r1, .PaletteOriginal
	b .WriteToDMA3

.PaletteChange:
	ldr r4, .PaletteOtherPeriods
	ldr r0, .PaletteOriginal
	mov r2, #0x0

	ldr r3, .DayNightFlag
	ldrb r3, [r3]
	cmp r3, #0x1
	beq .Morning
	cmp r3, #0x2
	beq .Afternoon
	cmp r3, #0x3
	beq .Evening
	cmp r3, #0x4
	beq .Night

.Morning:
	mov r3, #0x2
	lsl r3, r3, #0x8 @ r3 = 0x200

	ldrh r1, [r0]
	ldr r6, .hFFFF0FFF
	lsr r7, r2, #0x4
	asr r6, r7
	mov r7, #0x1
	and r6, r6, r7
	cmp r6, #0x0
	bne .NextMorning
	strh r1, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Morning

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.NextMorning:
	mov r5, #0x1E
	lsl r6, r5, #0x5
	lsl r7, r6, #0x5
	and r5, r5, r1
	and r6, r6, r1
	and r7, r7, r1
	lsl r0, r0, #0x0
	lsl r0, r0, #0x0
	lsr r7, r7, #0x1
	orr r5, r6
	orr r5, r7
	strh r5, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Morning

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.Afternoon:
	mov r3, #0x2
	lsl r3, r3, #0x8 @ r3 = 0x200

	ldrh r1, [r0]
	ldr r6, .hFFFF0FFF
	lsr r7, r2, #0x4
	asr r6, r7
	mov r7, #0x1
	and r6, r6, r7
	cmp r6, #0x0
	bne .NextAfternoon
	strh r1, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Afternoon

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.NextAfternoon:
	mov r5, #0x1E
	lsl r6, r5, #0x5
	lsl r7, r6, #0x5
	and r5, r5, r1
	and r6, r6, r1
	and r7, r7, r1
	lsl r0, r0, #0x0
	lsr r6, r6, #0x1
	lsr r7, r7, #0x1
	orr r5, r6
	orr r5, r7
	strh r5, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Afternoon

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.Evening:
	mov r3, #0x2
	lsl r3, r3, #0x8 @ r3 = 0x200

	ldrh r1, [r0]
	ldr r6, .hFFFF0FFF
	lsr r7, r2, #0x4
	asr r6, r7
	mov r7, #0x1
	and r6, r6, r7
	cmp r6, #0x0
	bne .NextEvening
	strh r1, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Evening

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.NextEvening:
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
	blt .Evening

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.Night:
	mov r3, #0x2
	lsl r3, r3, #0x8 @ r3 = 0x200

	ldrh r1, [r0]
	ldr r6, .hFFFF0FFF
	lsr r7, r2, #0x4
	asr r6, r7
	mov r7, #0x1
	and r6, r6, r7
	cmp r6, #0x0
	bne .NextNight
	strh r1, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Night

	ldr r1, .PaletteOtherPeriods
	b .WriteToDMA3

.NextNight:
	mov r5, #0x1E
	lsl r6, r5, #0x5
	lsl r7, r6, #0x5
	and r5, r5, r1
	and r6, r6, r1
	and r7, r7, r1
	lsr r5, r5, #0x1
	lsr r6, r6, #0x1
	lsr r7, r7, #0x1
	orr r5, r6
	orr r5, r7
	strh r5, [r4]
	add r0, r0, #0x2
	add r4, r4, #0x2
	add r2, r2, #0x1
	cmp r2, r3
	blt .Night

	ldr r1, .PaletteOtherPeriods

.WriteToDMA3:
	mov r2, #0xA0
	lsl r2, r2, #0x13 @ r2 = 0x05000000
	ldr r0, .REG_DMA3SAD @ Write Palette Source
	str r1, [r0]
	add r0, r0, #0x4
	str r2, [r0] @ Write Palette Destination
	ldr r1, .DMA3Para
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
.PaletteOriginal:
.word 0x0202EEC8
.PaletteOtherPeriods:
.word 0x0203E004
.REG_DMA3SAD:
.word 0x040000D4
.DMA3ReturnAddress:
.word 0x08073B07
.hFFFF0FFF:
.word 0xFFFF0FFF
.DMA3Para:
.word 0x80000200
