@ Textbox Hack (Loading Routine)
@ By ZodiacDaGreat
@ Version: 1.0.0
@ ----------------------------------------------
.code 16
.thumb

	push {lr}
	ldr r0, .Flag
	ldr r1, .GetFlagAddressFunc
	bl .BranchLink

	ldrb r1, [r0]
	cmp r1, #0x1 @ Read "Footer Note"
	beq .SignPost

.Dialog:
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

@ ----------------------------------------------
.align 2
.Flag:
.word 0x00001000
.GetFlagAddressFunc:
.word 0x080692AD
.ImportantPointer:
.word 0x0202E87C
.DialogTxtboxGraphics:
.word 0x08900000
.ImportantPointer2:
.word 0x030005AE
.SignPostTxtboxGraphics:
.word 0x08900400
.ReturnAdress:
.word 0x08064AD5
@ Footer Note
@ The value (must be calculated manually) will change depending on what the set value for the flag is
