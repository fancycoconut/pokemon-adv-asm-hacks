# RS Clothes System Hack

Finally got it to work on the 12th Sept 2009 ^^

```asm
0805be80  b510 push {r4,lr}
0805be82  1c0c add r4, r1, #0x0
0805be84  0400 lsl r0, r0, #0x10
0805be86  0c00 lsr r0, r0, #0x10
0805be88  0624 lsl r4, r4, #0x18
0805be8a  0e24 lsr r4, r4, #0x18
0805be8c  f000 bl $0805bee4
0805be90  0600 lsl r0, r0, #0x18 @ This part onwards can be hacked
0805be92  4908 ldr r1, [$0805beb4] (=$0837377c)
0805be94  0d40 lsr r0, r0, #0x15
0805be96  1840 add r0, r0, r1
0805be98  6800 ldr r0, [r0, #0x0]
0805be9a  0524 lsl r4, r4, #0x14
0805be9c  2180 mov r1, #0x80
0805be9e  0449 lsl r1, r1, #0x11
0805bea0  1864 add r4, r4, r1
0805bea2  0c24 lsr r4, r4, #0x10
0805bea4  1c21 add r1, r4, #0x0
0805bea6  2220 mov r2, #0x20
0805bea8  f017 bl $08073a58 @ Palette Loader Function
0805beac  bc10 pop {r4}
0805beae  bc01 pop {r0}
0805beb0  4700 bx r0
0805beb2  0000 lsl r0, r0, #0x00
```

We will call a function that does the pointer loading and then branch link to 08073a58 (Palette Loader). The registers must contain the following before the call ^^

* R0 - **Palette Source Pointer**: pointer that points to palette data
* R1 - **Position**: the amount of bytes from 0x0202EEC8 (Base Palette)
* R2 - **Amount**: amount of bytes to load

To hack it, place `08B4 014B 1847 0000 [Offset to routine +1] 0000 0000 0000 0000 0000 0000 0000 08BC` at *0x5be90*.

## Extended Routine

```asm
@ RS Clothes System Hack (Professional Version)
@ By ZodiacDaGreat
@ Version 1.0.0
@ ----------------------------------------------
.code 16
.thumb

.Main:
  lsl r0, r0, #0x18
  ldr r1, .UnknownTable
  lsr r0, r0, #0x15
  add r0, r0, r1
  ldr r0, [r0]
  lsl r4, r4, #0x14
  mov r1, #0x80
  lsl r1, r1, #0x11
  add r4, r4, r1
  lsr r4, r4, #0x10
  add r1, r4, #0x0
  mov r2, #0x20

  ldr r3, .PaletteLoader
  bl .BranchLink

.ClothesPart:
  push {r0}

  ldr r0, .Var
  ldr r3, .GetVarAddressFunc
  bl .BranchLink

  mov r2, #0x4
  ldrb r0, [r0]

  mul r2, r0

  ldr r1, .GenderLocation
  ldrb r1, [r1, #0x8]

  cmp r1, #0x0
  bne .Female

.Male:
  ldr r1, .BoyPalTable
  b .ReadTable

.Female:
  ldr r1, .GirlPalTable

.ReadTable:
  add r1, r1, r2
  ldr r0, [r1]

  mov r2, #0x40
  mov r1, #0x1
  lsl r1, r1, #0x8
  ldr r3, .PaletteLoader
  bl .BranchLink

  pop {r0}

  ldr r3, .ReturnAddress

.BranchLink:
  bx r3

@ ----------------------------------------------
.align 2
.UnknownTable:
.word 0x0837377C
.PaletteLoader:
.word 0x08073a59
.GenderLocation:
.word 0x02024EA4
.Var:
.word 0x00004050
.GetVarAddressFunc:
.word 0x08069211
.BoyPalTable:
.word 0x08A00000
.GirlPalTable:
.word 0x08A00000
.ReturnAddress:
.word 0x0805bEAB
```

## How it works

This hack loads the player's overworld palette from a table of pointers to the palettes consisting of the sprite and the sprite's reflection hence a total of 0x40 bytes. To use this system, we must create a table - two tables one for male and female respectively. The table is in this format:

[Pointer to Palette0/Clothes0] [Pointer to Palette1/Clothes1] ...and so on

At the pointers we have two palette data, the sprite's palette and reflection palette. To use the clothes we set a variable to the clothes/palette index in the table. Just don't set it past the table limit as it can cause glitches.

## What's left?

* A instant palette loading routine to be called in a script after the `setvar` to make it look instantaneous.
* A hack for the trainer card as well.
