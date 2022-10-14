@ Textbox Hack (Loading Routine)
@ By ZodiacDaGreat
@ Version: 1.0.2
@ -------------------------------------------------------------------
.code 16
.thumb

	push {lr}
	ldr r0, .Flag
	ldr r1, .GetFlagAddressFunc
	bl .BranchLink

@ Checkflag part
	ldr r2, .Flag
	ldrb r0, [r0]
	mov r1, #0x7
	and r1, r1, r2
	asr r0, r1
	mov r1, #0x1
	and r0, r1
 
	cmp r0, #0x1
	beq .SignPost

.Dialog:
	ldr r0, .DialogTxtboxPalette
	ldr r1, .PaletteLocation
	mov r2, #0x10
	swi 0xB

	ldr r0, .ImportantPointer
	ldr r0, [r0, #0x2C]
	ldr r1, [r0, #0x10]
	ldr r0, .DialogTxtboxGraphics
	ldr r2, .ImportantPointer2
	ldrh r2, [r2]
	lsl r2, r2, #0x5
	add r1, r1, r2
	mov r2, #0x98
	swi 0xC
	b .EndMe

.SignPost:
	ldr r0, .SignPostTxtboxPalette
	ldr r1, .PaletteLocation
	mov r2, #0x10
	swi 0xB

	ldr r0, .ImportantPointer
	ldr r0, [r0, #0x2C]
	ldr r1, [r0, #0x10]
	ldr r0, .SignPostTxtboxGraphics
	ldr r2, .ImportantPointer2
	ldrh r2, [r2]
	lsl r2, r2, #0x5
	add r1, r1, r2
	mov r2, #0x98
	swi 0xC

.EndMe:
	pop {r0}

	ldr r0, .ReturnAdress
	bx r0

.BranchLink:
	bx r1

@ -------------------------------------------------------------------
.align 2
.Flag:				.word 0x00001044
.GetFlagAddressFunc:		.word 0x080692AD

.PaletteLocation:		.word 0x0202F0A8
.DialogTxtboxPalette:		.word 0x081E66B2
.SignPostTxtboxPalette:		.word 0x088090A8

.DialogTxtboxGraphics:		.word 0x086DC73C
.SignPostTxtboxGraphics:	.word 0x086DC9A0

.ImportantPointer:		.word 0x0202E87C
.ImportantPointer2:		.word 0x030005AE
.ReturnAdress:			.word 0x08064AD5

@ -------------------------------------------------------------------
@ Version Changes
@ 1.0.0 - Basic Version
@ 1.0.1 - Added Checkflag
@ 1.0.2 - Palette Loading for specific textboxes
