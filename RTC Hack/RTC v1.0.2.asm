@ Fire Red RTC Hack
@ Version 1.0.2
@ By ZodiacDaGreat
@ ----------------------------------------------------------------
.code 16
.thumb

.org 0x000000
.Main:
	push {r4}

@ RTC Part
	bl .SetupRTC
	ldr r0, .IWRAMRTC
	bl .ManipulateRTC

@ Part of the original routine
	ldr r4, .UnkFunc1
	bl .BranchLink
	lsl r0, r0, #0x18
	cmp r0, #0x0
	bne .Endme

	ldr r4, .UnkFunc2
	bl .BranchLink

.Endme:
	ldr r4, .Return

.BranchLink:
	bx r4

@ ----------------------------------------------------------------
@ Seting Up RTC
.SetupRTC:
	push {r4, r5, lr}
	ldr r3, .IOPORTCNT
	mov r2, #0x1
	strh r2, [r3] @ Enable RTC

	mov r5, #0x5
	sub r3, r3, #0x4 @ r3 = IOPORTDATA
	strh r2, [r3]
	strh r5, [r3]

	ldr r4, .IOPORTDIRECTION
	mov r3, #0x7
	strh r3, [r4]

	mov r0, #0x63
	bl .RTCFunc1

	strh r5, [r4]
	bl .RTCFunc2

	ldr r3, .Temp
	strh r0, [r3]
	pop {r4, r5, pc}

@ ----------------------------------------------------------------
.RTCFunc1:
	push {r4-r7, lr}
	ldr r1, .IOPORTDATA
	lsl r4, r0, #0x1 @ r4 = 0xC6
	mov r7, #0x2
	mov r0, #0x7 @ Counter
	mov r6, #0x4
	mov r5, #0x5
.Loop1:
	mov r2, r4
	asr r2, r0
	and r2, r7
	mov r3, r2
	orr r3, r6
	orr r2, r5

	lsl r3, r3, #0x10 @ Prevents overflow
	lsl r2, r2, #0x10
	lsr r3, r3, #0x10
	lsr r2, r2, #0x10

	strh r3, [r1]
	strh r3, [r1]
	strh r3, [r1]
	strh r2, [r1]

	sub r0, r0, #0x1
	bcs .Loop1
	pop {r4-r7, pc}

@ ----------------------------------------------------------------
.RTCFunc2:
	push {r4-r6, lr}
	ldr r2, .IOPORTDATA
	mov r0, #0x0
	mov r4, #0x0
	mov r1, #0x4
	mov r6, #0x5
	mov r5, #0x2
.Loop2:
	strh r1, [r2]
	strh r1, [r2]
	strh r1, [r2]
	strh r1, [r2]
	strh r1, [r2]
	strh r6, [r2]

	ldrh r3, [r2]
	and r3, r3, r5
	lsl r3, r0
	add r0, r0, #0x1
	orr r4, r3
	cmp r0, #0x8
	bne .Loop2
	asr r0, r4, #0x1
	pop {r4-r6, pc}

@ ----------------------------------------------------------------
.ManipulateRTC:
	push {r4-r6, lr}
	ldr r2, .IOPORTDATA
	ldr r5, .IOPORTDIRECTION
	mov r1, #0x1
	mov r3, #0x7
	mov r4, #0x5
	strh r1, [r2]
	mov r6, r0
	strh r3, [r5]
	strh r1, [r2]
	strh r4, [r2]

	mov r0, #0x65
	bl .RTCFunc1

	strh r4, [r5]
	mov r5, #0x0

.Loop3:
	bl .RTCFunc2
	add r4, r6, r5
	add r5, r5, #0x1
	strb r0, [r4]
	cmp r5, #0x4
	bne .Loop3

	ldr r3, .IOPORTDIRECTION
	mov r2, #0x5
	strh r2, [r3]

.Loop4:
	bl .RTCFunc2
	add r4, r6, r5
	add r5, r5, #0x1
	strb r0, [r4]
	cmp r5, #0x7
	bne .Loop4
	
	mov r0, #0x0
	pop {r4-r6, pc}

@ ----------------------------------------------------------------
.align 2
.UnkFunc1:		.word 0x0800B179
.UnkFunc2:		.word 0x08000511
.Return:		.word 0x080004bF

.Temp:			.word 0x03007E5C
.IWRAMRTC:		.word 0x03004038
.IOPORTDATA:		.word 0x080000C4
.IOPORTDIRECTION:	.word 0x080000C6
.IOPORTCNT:		.word 0x080000C8

@ ----------------------------------------------------------------
@ Put 00B5 0148 0047 0000 [Reverse Address+1] 0000 10BC at 0x4B0
