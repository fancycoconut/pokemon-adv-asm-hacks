@ ROM Protection System {Main Routine}
@ By HackMew and ZodiacDaGreat
@ Version: 1.0.4
@ ----------------------------------------------
.code 16
.thumb

@ Loading Tilemap
	ldr r0, .Tilemap
	ldr r1, .VRAMMapBase
	ldr r2, .h3FF
	swi 0xB @ CpuSet

@ Setting Up Screen
	ldr r0, .REG_DISPCNT
	mov r1, #0x1
	lsl r1, r1, #0x8
	strh r1, [r0]

@ Setting Up Background 0
	ldr r0, .REG_BG0CNT
	mov r1, #0xF
	lsl r1, r1, #0x9
	add r1, r1, #0x5
	strh r1, [r0]

@ ----------------------------------------------
@ Checking ROM
.CheckROM:
	ldr r0, .HeaderAddress @ initialize address
	mov r1, #0x0 @ initialize checksum
	mov r2, #0xA0 @ initialize loop counter

.ChecksumLoop:
	cmp r2, #0xBC @ check if we reached the end
	bhi .ChecksumFinish @ exit the loop
	ldrb r3, [r0] @ load the current header byte
	sub r1, r1, r3 @ checksum = checksum - r3
	add r0, r0, #0x1 @ increment address
	add r2, r2, #0x1 @ increment counter
	b .ChecksumLoop

.ChecksumFinish:
	sub r1, r1, #0x19 @ checksum = checksum - 0x19
	lsl r1, r1, #0x18 @ checksum = checksum AND 0xFF
	lsr r1, r1, #0x18
	ldrb r2, [r0] @ load the checksum stored in the header
	cmp r1, r2 @ check if the checksum is correct
	bne .LoadErrorScreen @ not equal then show error screen
	
.SecondCheck:
	cmp r1, #0x68 @ check if the checksum matches the expected value
	bne .LoadErrorScreen

.ThirdCheck:
	ldr r0, .MapHack
	ldrb r1, [r0]
	cmp r1, #0x0B
	bne .LoadErrorScreen
	add r0, r0, #0x6
	ldrb r1, [r0]
	cmp r1, #0x89
	bne .LoadErrorScreen
	add r0, r0, #0x1
	ldrb r1, [r0] 
	cmp r1, #0x0B
	bne .LoadErrorScreen
	add r0, r0, #0x1
	ldrb r1, [r0]
	cmp r1, #0x00
	bne .LoadErrorScreen
	add r0, #0x1
	ldrb r1, [r0]
	cmp r1, #0x68
	bne .LoadErrorScreen

@ ----------------------------------------------
.LoadWarningScreen:
@ Loading Tileset
	ldr r0, .WarningTileset
	ldr r1, .VRAMCharBase
	swi 0x12 @ LZ77UnCompVram

@ Loading Palette
	ldr r0, .WarningPalette
	ldr r1, .PALRAM
	mov r2, #0x10
	swi 0xB @ Cpuset
	add r1, r1, #0x20
	swi 0xB @ Cpuset

@ Setting Up Timer 0
	ldr r0, .REG_TMOCNT
	mov r1, #0xC1
	strh r1, [r0]

@ Setting Up Interrupts
	ldr r0, .InterruptServiceHandler
	ldr r1, .InterruptRoutine
	str r1, [r0]

	ldr r0, .REG_IE
	mov r1, #0x8
	strb r1, [r0] @ Set interrupt control

	ldr r0, .REG_IME
	mov r1, #0x1
	strb r1, [r0] @ Fire interrupts

@ Detecting key press
	ldr r1, .h3FF
.Loop:
	ldr r0, .REG_KEYINPUT
	ldrh r0, [r0]
	cmp r0, r1
	beq .Loop

@ ----------------------------------------------
@ Booting ROM
.BootROM:
	ldr r0, .BootLoader
	bx r0

@ ----------------------------------------------
.LoadErrorScreen:
@ Loading Tileset
	ldr r0, .ErrorTileset
	ldr r1, .VRAMCharBase
	swi 0x12 @ LZ77UnCompVram

@ Loading Palette
	ldr r0, .ErrorPalette
	ldr r1, .PALRAM
	mov r2, #0x10
	swi 0xB @ Cpuset
	add r1, r1, #0x20
	swi 0xB @ Cputset

@ Infinite Loop
.Infinity:
	b .Infinity

@ ----------------------------------------------
.align 2

.h3FF:
	.word 0x000003FF
.REG_DISPCNT:
	.word 0x04000000
.REG_BG0CNT:
	.word 0x04000008
.REG_KEYINPUT:
	.word 0x04000130
.REG_TMOCNT:
	.word 0x04000102
.REG_IME:
	.word 0x04000208
.REG_IE:
	.word 0x04000200
.InterruptRoutine:
	.word 0x08800500
.InterruptServiceHandler:
	.word 0x03007FFC
.PALRAM:
	.word 0x05000000
.VRAMCharBase:
	.word 0x06004000
.VRAMMapBase:
	.word 0x0600F000
.WarningTileset:
	.word 0x08900000
.WarningPalette:
	.word 0x08910000
.Tilemap:
	.word 0x08A00000
.ErrorTileset:
	.word 0x08920000
.ErrorPalette:
	.word 0x08910100
.BootLoader:
	.word 0x080003A5 @ Ruby = 0x0800024D, Fire Red = 0x080003A5, Emerald = 0x080003A5
.HeaderAddress:
	.word 0x080000A0d
.MapHack:
	.word 0x0805523C @ Ruby = 0x08053314, Fire Red = 0x0805523C, Emerald = 0x08084A94

@ ----------------------------------------------
@ > Default checksums
@ Ruby = 0x41, Fire Red = 0x68, Emerald = 0x72

@ ----------------------------------------------a
@ > Map Hack
@ Put 0B at offset .MapHack
@ Put 89 0B 00 68 at offset .MapHack + 0x06
@ Put C0 00 00 08 at offset .MapHack + 0x10
@ Put FF F7 E9 FF 02 BC 08 47 00 00 at offset .MapHack + 0x26
@ Put A8 26 35 08 at offset .MapHack + 0x30
@ Ruby = 88 85 30 08, Fire Red = A8 26 35 08,  Emerald = 78 65 48 08
