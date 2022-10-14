@ Day Night System {CheckTime}
@ By Mastermind_X
@ Version:
@ ----------------------------------------------
.code 16
.thumb

	push {r2, r3}

	ldr r3, .RTC
	ldrb r0, [r3] @ Hours to r0
	add r3, r3, #0x1
	ldrb r1, [r3] @ Minutes to r1
	add r3, r3, #0x1
	ldrb r2, [r3] @ Seconds to r2

	lsl r0, r0, #0x10
	lsl r1, r1, #0x8
	orr r0, r1
	orr r0, r2
	
	ldr r1, =0x00060000 @ Time limit
	cmp r0, r1
	blt .Exceptions

	ldr r1, =0x00120000 @ Time limit
	cmp r0, r1
	bgt .Exceptions

	mov r0, #0x0
	b .Branch

.Exceptions:
	mov r0, #0x0

	ldr r3, .BattleFlag
	ldrh r3, [r3]
	cmp r3, #0x0
	bne .Branch
	
	ldr r3, .MenuFlag
	ldrb r3, [r3]
	cmp r3, #0x37
	bne .Branch

	ldr r3, .IndoorFlag
	ldrb r3, [r3]
	cmp r3, #0x4 @ Caves
	beq .Branch

	ldr r3, .IndoorFlag
	ldrb r3, [r3]
	cmp r3, #0x8 @ Indoors
	beq .Branch

	ldr r3, .IndoorFlag
	ldrb r3, [r3]
	cmp r3, #0x9 @ Secret Bases
	beq .Branch
	cmp r3, #0x0 @ Null?
	beq .Branch

	mov r0, #0x1

.Branch:
	ldr r1, .DayNightFlag @ Write Day/Night Flag
	strb r0, [r1]

	ldr r0, .Special1
	ldrb r0, [r0]
	cmp r0, #0x0
	bne .Label2

	ldr r0, .Special2
	ldr r1, .Special3
	add r0, r0, r1
	ldrb r0, [r0]
	b .EndMe

.Label2:
	ldr r0, .Special4
	ldr r1, .Special5
	add r0, r0, r1
	ldrb r0, [r0]

.EndMe:
	pop {r2, r3}

	ldr r1, .RTCReturnAddress
	bx r1 @ Return to the calling routine
	lsl r0, r0, #0x0

@ ----------------------------------------------
.align 2
.RTC:
.word 0x0300403A
.RTCReturnAddress:
.word 0x080542F3
.Special1:
.word 0x030030FC
.Special2:
.word 0x03003170
.Special3:
.word 0x00000339
.Special4:
.word 0x03005000
.Special5:
.word 0x00000C1A
.IndoorFlag:
.word 0x0202E83F
.MenuFlag:
.word 0x0202000E
.BattleFlag:
.word 0x03004DCB
.DayNightFlag:
.word 0x0203E000
